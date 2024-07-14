import '../../domain/entities/beneficiary_entity.dart';

class RechargeMobileState {}

class RechargeMobileStateInitial extends RechargeMobileState {}

class RechargeMobileStateSuccess extends RechargeMobileState {
  final List<BeneficiaryEntity> beneficiaries;
  RechargeMobileStateSuccess(this.beneficiaries);
}

class RechargeMobileStateError extends RechargeMobileState {}
