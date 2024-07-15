import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/domain/types/signatures.dart';
import 'package:top_ups/features/recharge_mobile/domain/usecases/get_beneficiaries_usecase.dart';
import 'package:top_ups/features/recharge_mobile/domain/usecases/recharge_usecase.dart';
import 'package:top_ups/features/recharge_mobile/presentation/controllers/recharge_mobile_controller.dart';
import 'package:top_ups/features/recharge_mobile/presentation/controllers/recharge_mobile_state.dart';

class MockBeneficiariesUsecase extends Mock implements BeneficiariesUsecase {}

class MockRechargeUsecase extends Mock implements RechargeUsecase {}

void main() {
  late RechargeMobileController sut;
  late BeneficiariesUsecase useCase;
  late RechargeUsecase rechargeUsecase;

  setUp(() {
    useCase = MockBeneficiariesUsecase();
    rechargeUsecase = MockRechargeUsecase();
    sut = RechargeMobileController(
      useCase,
      rechargeUsecase,
    );
  });

  group(RechargeMobileController, () {
    final mockBeneficiaries = [
      BeneficiaryDTO(id: '1', name: 'Amit Pahandit', phone: '+9193933939229'),
      BeneficiaryDTO(id: '2', name: 'Kumar Suresh', phone: '+909303039393'),
    ];
    test(
        'change state to RechargeMobileStateSuccess when calls init with success',
        () async {
      // arange
      when(() => useCase()).thenAnswer(
        (_) => Future.value(
          BeneficiaryResult.right(mockBeneficiaries),
        ),
      );
      // act
      await sut.init();

      // assert
      expect(
        sut.value,
        isA<RechargeMobileStateSuccess>(),
      );
      verify(() => useCase()).called(1);
    });
    test('change state to RechargeMobileStateError when calls init with error',
        () async {
      // arange
      when(() => useCase()).thenAnswer(
        (_) => Future.value(
          BeneficiaryResult.left(const ServerFailure()),
        ),
      );
      // act
      await sut.init();

      // assert
      expect(
        sut.value,
        isA<RechargeMobileStateError>(),
      );
      verify(() => useCase()).called(1);
    });

    test(
        'change state to RechargeMobileStateError when calls recharge with error',
        () async {
      // arange
      when(() => rechargeUsecase(any(), any())).thenAnswer(
        (_) => Future.value(
          RechargeResult.left(const RechargeFailure()),
        ),
      );
      // act
      await sut.recharge(100, '1');

      // assert
      expect(
        sut.value,
        isA<RechargeMobileStateError>(),
      );
      verify(() => rechargeUsecase(any(), any())).called(1);
    });
  });
}
