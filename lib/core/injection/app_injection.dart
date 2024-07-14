import 'package:top_ups/core/api/api_client.dart';
import 'package:top_ups/core/injection/injection.dart';

void appInjection() {
  apiInjection();
}

void apiInjection() {
  Injection().registerSingleton(TopUpsApiClient(baseUrl: 'baseUrl'));
}
