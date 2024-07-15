import 'package:top_ups/core/errors/failure.dart';
import 'package:top_ups/core/helpers/rules.dart';

import '../../../app/presentation/controllers/app_controller.dart';
import '../types/signatures.dart';

abstract class RechargeUsecase {
  Future<RechargeResult> call(String id, double value);
}

class AppRechargeUsecase implements RechargeUsecase {
  AppRechargeUsecase({
    required this.appController,
  });
  final AppController appController;
  @override
  Future<RechargeResult> call(String id, double value) async {
    if ((appController.allTransitionsAmountMonth + value) >
        userBeneficiariesLimiteTotalValue) {
      return RechargeResult.left(const RechargeFailure());
    }

    final verified = appController.userVerified;
    final userBalance = appController.userBalance;
    final sufficientBalance = value <= userBalance;

    if (verified) {
      if (sufficientBalance &&
          (appController.transitionsAmountMonth(id) + value) <=
              userVerifiedTotalValue) {
        appController.rechargeMobile(value, id);
        return RechargeResult.right(true);
      }
    } else {
      if (sufficientBalance &&
          (appController.transitionsAmountMonth(id) + value) <=
              userNotVerifiedTotalValue) {
        appController.rechargeMobile(value, id);
        return RechargeResult.right(true);
      }
    }
    return RechargeResult.left(const RechargeFailure());
  }
}
