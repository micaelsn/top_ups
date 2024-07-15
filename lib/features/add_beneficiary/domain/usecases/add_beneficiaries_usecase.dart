import '../../../recharge_mobile/domain/entities/beneficiary_entity.dart';
import '../../data/repositories/add_beneficiaries_repository.dart';
import '../types/signatures.dart';

abstract class AddBeneficiariesUsecase {
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity);
}

class AddLocalBeneficiariesUsecase implements AddBeneficiariesUsecase {
  AddBeneficiariesRepository repository;

  AddLocalBeneficiariesUsecase({
    required this.repository,
  });

  @override
  Future<AddBeneficiaryResult> call(BeneficiaryEntity entity) =>
      repository(entity);
}
