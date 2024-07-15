import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/features/app/presentation/controllers/app_controller.dart';
import 'package:top_ups/features/recharge_mobile/data/dto/beneficiary_dto.dart';
import 'package:top_ups/features/recharge_mobile/domain/usecases/recharge_usecase.dart';

class MockAppController extends Mock implements AppController {}

void main() {
  late RechargeUsecase useCase;
  late AppController controller;

  final mockBeneficiary =
      BeneficiaryDTO(id: '1', name: 'Amit Pahandit', phone: '+9193933939229');
  setUpAll(() {
    registerFallbackValue(mockBeneficiary);
  });

  setUp(() {
    controller = MockAppController();
    useCase = AppRechargeUsecase(appController: controller);
  });

  group(AppRechargeUsecase, () {
    test(
        'return RechargeFailure when calls recharge with max transitions per month achieved',
        () async {
      // arange
      when(() => controller.allTransitionsAmountMonth).thenAnswer(
        (_) => 3000,
      );

      // act
      final result = await useCase('1', 100.0);

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<RechargeFailure>(),
      );
    });
    group('verified', () {
      test('return true when calls recharge with rules valid', () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 1000,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => true,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 4000.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 100.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((l) => l, (r) => r),
          true,
        );
      });
      test('return true when calls recharge with sufficient balance', () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 1000,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => true,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 101.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 100.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((l) => l, (r) => r),
          true,
        );
      });
      test(
          'return failure when calls recharge with no sufficient topup per beneficiary',
          () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 500.0,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => true,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 1000.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 500.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((failure) => failure, (value) => value),
          isA<RechargeFailure>(),
        );
      });
    });
    group('not verified', () {
      test('return true when calls recharge with rules valid', () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 1000,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => false,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 4000.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 100.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((l) => l, (r) => r),
          true,
        );
      });
      test('return true when calls recharge with sufficient balance', () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 1000,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => false,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 101.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 100.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((l) => l, (r) => r),
          true,
        );
      });

      test(
          'return failure when calls recharge with no sufficient topup per beneficiary',
          () async {
        // arange
        when(() => controller.allTransitionsAmountMonth).thenAnswer(
          (_) => 1000.0,
        );
        when(() => controller.userVerified).thenAnswer(
          (_) => false,
        );
        when(() => controller.userBalance).thenAnswer(
          (_) => 1100.0,
        );
        when(() => controller.transitionsAmountMonth('1')).thenAnswer(
          (_) => 1000.0,
        );

        // act
        final result = await useCase('1', 100.0);

        // assert
        expect(
          result.match((failure) => failure, (value) => value),
          isA<RechargeFailure>(),
        );
      });
    });
  });
}
