import 'package:top_ups/core/api/api_client.dart';
import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/injection/injection.dart';

import 'data/repositories/get_transitions_repository.dart';
import 'data/repositories/save_transitions_repository.dart';
import 'domain/usecases/get_transitions_usecase.dart';
import 'domain/usecases/save_transitions_usecase.dart';
import 'presentation/controllers/app_controller.dart';

void appInjection() {
  _apiInjection();
  _dataBase();
  _repositories();
  _usecases();
  _controllers();
}

void _apiInjection() {
  Injection().registerSingleton<ApiClient>(TopUpsApiClient(baseUrl: 'baseUrl'));
}

void _dataBase() {
  Injection().registerSingleton<LocalStorage>(HiveLocalStorage());
}

void _controllers() {
  Injection().registerSingleton<AppController>(AppController(
    getTransitionsUsecase: Injection().get<GetTransitionsUsecase>(),
    saveTransitionsUsecase: Injection().get<SaveTransitionsUsecase>(),
  ));
}

void _repositories() {
  Injection().registerFactory<GetTransitionsRepository>(() =>
      LocalGetTransitionsRepository(
          localStorage: Injection().get<LocalStorage>()));
  Injection().registerFactory<SaveTransitionsRepository>(() =>
      LocalSaveTransitionsRepository(
          localStorage: Injection().get<LocalStorage>()));
}

void _usecases() {
  Injection().registerFactory<GetTransitionsUsecase>(() =>
      LocalGetTransitionsUsecase(
          repository: Injection().get<GetTransitionsRepository>()));
  Injection().registerFactory<SaveTransitionsUsecase>(() =>
      LocalSaveTransitionsUsecase(
          repository: Injection().get<SaveTransitionsRepository>()));
}
