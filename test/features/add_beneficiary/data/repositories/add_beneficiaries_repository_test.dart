import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/add_beneficiary/data/repositories/add_beneficiaries_repository.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late AddBeneficiariesRepository repository;
  late LocalStorage localStorage;

  setUp(() {
    localStorage = MockLocalStorage();
    repository =
        LocalStorageAddBeneficiariesRepository(localStorage: localStorage);
  });

  group(LocalStorageAddBeneficiariesRepository, () {
    final mockEntity =
        BeneficiaryDTO(id: '1', name: 'Amit Pahandit', phone: '+9193933939229');
    test('return list of beneficiaries when is called with success', () async {
      // arrange
      when(() => localStorage.get(any())).thenAnswer(
        (_) async => null,
      );
      when(() => localStorage.insert(any(), any())).thenAnswer(
        (_) async => Future.value(),
      );

      // act
      final result = await repository(mockEntity);

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        true,
      );
      verify(() => localStorage.get(any())).called(1);
      verify(() => localStorage.insert(any(), any())).called(1);
    });

    test('return AddFailure when max number of beneficiaries is reached',
        () async {
      // arrange
      final mockMap = {
        'id': '1',
        'name': 'Amit Pahandit',
        'phone': '+9193933939229'
      };
      final expectedResponse = [
        mockMap,
        mockMap,
        mockMap,
        mockMap,
        mockMap,
      ];
      when(() => localStorage.get(any())).thenAnswer(
        (_) async => expectedResponse,
      );
      when(() => localStorage.insert(any(), any())).thenAnswer(
        (_) async => Future.value(),
      );
      // act
      final result = await repository(mockEntity);

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<AddFailure>(),
      );
      verify(() => localStorage.get(any())).called(1);
      verifyNever(() => localStorage.insert(any(), any()));
    });

    test('return AddFailure when request failed', () async {
      // arrange
      when(() => localStorage.get(any())).thenThrow(
        Exception(),
      );

      // act
      final result = await repository(mockEntity);

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<AddFailure>(),
      );
      verify(() => localStorage.get(any())).called(1);
    });
  });
}
