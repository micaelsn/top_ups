import 'package:top_ups/core/injection/injection.dart';

import '../../core/database/localstorage.dart';
import 'data/repositories/add_beneficiaries_repository.dart';
import 'domain/usecases/add_beneficiaries_usecase.dart';
import 'presentation/controllers/add_beneficiary_controller.dart';

void addBeneficiaryInjection() {
  _repositories();
  _usecases();
  _controllers();
}

void _repositories() {
  Injection().registerFactory<AddBeneficiariesRepository>(() =>
      LocalStorageAddBeneficiariesRepository(
          localStorage: Injection().get<LocalStorage>()));
}

void _usecases() {
  Injection().registerFactory<AddBeneficiariesUsecase>(() =>
      AddLocalBeneficiariesUsecase(
          repository: Injection().get<AddBeneficiariesRepository>()));
}

void _controllers() {
  Injection().registerFactory<AddBeneficiaryController>(
    () => AddBeneficiaryController(
        addUseCase: Injection().get<AddBeneficiariesUsecase>()),
  );
}
