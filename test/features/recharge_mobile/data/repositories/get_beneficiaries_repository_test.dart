import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/recharge_mobile/data/data_source/get_beneficiaries_data_source.dart';
import 'package:top_ups/features/recharge_mobile/data/repositories/get_beneficiaries_repository.dart';
import 'package:top_ups/features/recharge_mobile/domain/entities/beneficiary_entity.dart';

class MockGetBeneficiariesDataSource extends Mock
    implements GetBeneficiariesDataSource {}

void main() {
  late GetBeneficiariesRepository repository;
  late GetBeneficiariesDataSource dataSource;

  setUp(() {
    dataSource = MockGetBeneficiariesDataSource();
    repository = ApiGetBeneficiariesRepository(dataSource: dataSource);
  });

  group(ApiGetBeneficiariesRepository, () {
    test('return list of beneficiaries when is called with success', () async {
      // arrange
      final expectedResponse = {
        'data': [
          {'id': '1', 'name': 'Amit Pahandit', 'phone': '+9193933939229'},
        ]
      };
      when(() => dataSource()).thenAnswer(
        (_) async => expectedResponse,
      );

      // act
      final result = await repository();

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<List<BeneficiaryEntity>>(),
      );
      verify(() => dataSource()).called(1);
    });
    test('return ServerFailure when request failed', () async {
      // arrange
      when(() => dataSource()).thenThrow(
        Exception(),
      );

      // act
      final result = await repository();

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<ServerFailure>(),
      );
      verify(() => dataSource()).called(1);
    });
  });
}
