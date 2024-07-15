import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/add_beneficiary/data/repositories/add_beneficiaries_repository.dart';
import 'package:top_ups/features/add_beneficiary/domain/types/signatures.dart';
import 'package:top_ups/features/add_beneficiary/domain/usecases/add_beneficiaries_usecase.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';

class MockAddBeneficiariesRepository extends Mock
    implements AddBeneficiariesRepository {}

void main() {
  late AddBeneficiariesUsecase useCase;
  late AddBeneficiariesRepository repository;
  final mockBeneficiary =
      BeneficiaryDTO(id: '1', name: 'Amit Pahandit', phone: '+9193933939229');
  setUpAll(() {
    registerFallbackValue(mockBeneficiary);
  });

  setUp(() {
    repository = MockAddBeneficiariesRepository();
    useCase = AddLocalBeneficiariesUsecase(repository: repository);
  });

  group(AddLocalBeneficiariesUsecase, () {
    test('return true when calls save beneficiary with success', () async {
      // arange
      when(() => repository(mockBeneficiary)).thenAnswer(
        (_) async => AddBeneficiaryResult.right(true),
      );
      // act
      final result = await useCase(mockBeneficiary);

      // assert
      expect(
        result.match((l) => l, (r) => r),
        true,
      );
      verify(() => repository(mockBeneficiary)).called(1);
    });

    test('return AddFailure when the call failed', () async {
      // arange
      when(() => repository(any())).thenAnswer(
        (_) async => AddBeneficiaryResult.left(
          const AddFailure(),
        ),
      );

      // act
      final result = await useCase(mockBeneficiary);

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<AddFailure>(),
      );
      verify(() => repository(any())).called(1);
    });
  });
}
