import '../../data/repositories/get_beneficiaries_repository.dart';
import '../types/signatures.dart';

abstract class BeneficiariesUsecase {
  Future<BeneficiaryResult> call();
}

class GetBeneficiariesUsecase implements BeneficiariesUsecase {
  GetBeneficiariesRepository repository;

  GetBeneficiariesUsecase({
    required this.repository,
  });

  @override
  Future<BeneficiaryResult> call() => repository();
}
