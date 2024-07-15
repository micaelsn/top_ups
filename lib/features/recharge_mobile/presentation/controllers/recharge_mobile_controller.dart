import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_beneficiaries_usecase.dart';
import '../../domain/usecases/recharge_usecase.dart';
import 'recharge_mobile_state.dart';

class RechargeMobileController extends ValueNotifier<RechargeMobileState> {
  RechargeMobileController(this.usecase, this.rechargeUsecase)
      : super(RechargeMobileStateInitial());
  final BeneficiariesUsecase usecase;
  final RechargeUsecase rechargeUsecase;

  Future<void> init() async {
    value = RechargeMobileStateInitial();
    final result = await usecase();
    result.fold(
      (l) => value = RechargeMobileStateError(),
      (r) => value = RechargeMobileStateSuccess(r),
    );
  }

  Future<void> recharge(double amount, String id) async {
    final result = await rechargeUsecase(id, amount);
    result.fold(
      (l) => value = RechargeMobileStateError(),
      (_) => _,
    );
  }
}
