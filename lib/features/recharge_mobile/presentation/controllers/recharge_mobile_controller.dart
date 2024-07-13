import '../../../../core/database/localstorage.dart';
import '../../domain/entities/beneficiary_entity.dart';

class RechargeMobileController {
  final LocalStorage localStorage;

  RechargeMobileController({required this.localStorage});

  late List<BeneficiaryEntity> beneficiaries;

  Future<void> init() async {}
}
