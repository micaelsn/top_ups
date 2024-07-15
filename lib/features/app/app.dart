import 'package:top_ups/core/api/api_client.dart';
import 'package:top_ups/core/database/localstorage.dart';
import 'package:top_ups/core/injection/injection.dart';

import 'presentation/controllers/app_controller.dart';

void appInjection() {
  _apiInjection();
  _controllers();
  _dataBase();
}

void _apiInjection() {
  Injection().registerSingleton<ApiClient>(TopUpsApiClient(baseUrl: 'baseUrl'));
}

void _dataBase() {
  Injection().registerSingleton<LocalStorage>(HiveLocalStorage());
}

void _controllers() {
  Injection().registerSingleton<AppController>(AppController());
}
