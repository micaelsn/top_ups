import 'package:flutter/foundation.dart';

import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/usecases/get_beneficiaries_usecase.dart';
import 'recharge_mobile_state.dart';

class RechargeMobileController extends ValueNotifier<RechargeMobileState> {
  RechargeMobileController(this.usecase) : super(RechargeMobileStateInitial());
  final BeneficiariesUsecase usecase;

  late List<BeneficiaryEntity> beneficiaries;

  Future<void> init() async {
    value = RechargeMobileStateInitial();
    final result = await usecase();
    result.fold(
      (l) => value = RechargeMobileStateError(),
      (r) => value = RechargeMobileStateSuccess(r),
    );
  }
}
