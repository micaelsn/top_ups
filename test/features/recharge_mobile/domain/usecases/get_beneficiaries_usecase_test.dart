import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/data/repositories/get_beneficiaries_repository.dart';
import 'package:top_ups/features/recharge_mobile/domain/types/signatures.dart';
import 'package:top_ups/features/recharge_mobile/domain/usecases/get_beneficiaries_usecase.dart';

class MockGetBeneficiariesRepository extends Mock
    implements GetBeneficiariesRepository {}

void main() {
  late BeneficiariesUsecase useCase;
  late GetBeneficiariesRepository repository;

  setUp(() {
    repository = MockGetBeneficiariesRepository();
    useCase = GetBeneficiariesUsecase(repository: repository);
  });

  group(GetBeneficiariesUsecase, () {
    final mockBeneficiaries = [
      BeneficiaryDTO(id: '1', name: 'Amit Pahandit', phone: '+9193933939229'),
      BeneficiaryDTO(id: '2', name: 'Kumar Suresh', phone: '+909303039393'),
    ];
    test('return list of beneficiaries when calls with success', () async {
      // arange
      when(() => repository()).thenAnswer(
        (_) => Future.value(
          BeneficiaryResult.right(mockBeneficiaries),
        ),
      );
      // act
      final result = await useCase();

      // assert
      expect(
        result.match((l) => l, (r) => r),
        mockBeneficiaries,
      );
      verify(() => repository()).called(1);
    });
    test('return failure when the call failed', () async {
      // arange
      when(() => repository()).thenAnswer(
        (_) async => BeneficiaryResult.left(
          const ServerFailure(),
        ),
      );

      // act
      final result = await useCase();

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => repository()).called(1);
    });
  });
}
