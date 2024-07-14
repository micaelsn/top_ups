import 'package:top_ups/core/api/api_client.dart';
import 'package:top_ups/core/injection/injection.dart';

import 'data/data_source/get_beneficiaries_data_source.dart';
import 'data/repositories/get_beneficiaries_repository.dart';
import 'domain/usecases/get_beneficiaries_usecase.dart';
import 'presentation/controllers/recharge_mobile_controller.dart';

void rechargeMobileInjection() {
  _dataSources();
  _repositories();
  _usecases();
  _controllers();
}

void _dataSources() {
  Injection().registerFactory(() =>
      ApiGetBeneficiariesDataSource(apiClient: Injection().get<ApiClient>()));
}

void _repositories() {
  Injection().registerFactory(() => ApiGetBeneficiariesRepository(
      dataSource: Injection().get<GetBeneficiariesDataSource>()));
}

void _usecases() {
  Injection().registerFactory(() => GetBeneficiariesUsecase(
      repository: Injection().get<GetBeneficiariesRepository>()));
}

void _controllers() {
  Injection().registerSingleton<RechargeMobileController>(
      RechargeMobileController(Injection().get<BeneficiariesUsecase>()));
}