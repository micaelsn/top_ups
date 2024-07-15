import 'package:top_ups/core/api/api_client.dart';
import 'package:top_ups/core/injection/injection.dart';

import '../../core/database/localstorage.dart';
import '../app/presentation/controllers/app_controller.dart';
import 'data/data_source/get_beneficiaries_data_source.dart';
import 'data/repositories/get_beneficiaries_repository.dart';
import 'domain/usecases/get_beneficiaries_usecase.dart';
import 'domain/usecases/recharge_usecase.dart';
import 'presentation/controllers/recharge_mobile_controller.dart';

void rechargeMobileInjection() {
  _dataSources();
  _repositories();
  _usecases();
  _controllers();
}

void _dataSources() {
  Injection().registerFactory<GetBeneficiariesDataSource>(
      () => ApiGetBeneficiariesDataSource(
            apiClient: Injection().get<ApiClient>(),
            localStorage: Injection().get<LocalStorage>(),
          ));
}

void _repositories() {
  Injection().registerFactory<GetBeneficiariesRepository>(() =>
      ApiGetBeneficiariesRepository(
          dataSource: Injection().get<GetBeneficiariesDataSource>()));
}

void _usecases() {
  Injection().registerFactory<BeneficiariesUsecase>(() =>
      GetBeneficiariesUsecase(
          repository: Injection().get<GetBeneficiariesRepository>()));
  Injection().registerFactory<RechargeUsecase>(() =>
      AppRechargeUsecase(appController: Injection().get<AppController>()));
}

void _controllers() {
  Injection().registerSingleton<RechargeMobileController>(
      RechargeMobileController(Injection().get<BeneficiariesUsecase>(),
          Injection().get<RechargeUsecase>()));
}
