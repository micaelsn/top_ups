import 'package:top_ups/core/database/localstorage.dart';

import '../../../../core/api/api_client.dart';

abstract class GetBeneficiariesDataSource {
  Future<Map<String, dynamic>?> call();
}

class ApiGetBeneficiariesDataSource implements GetBeneficiariesDataSource {
  ApiClient apiClient;
  final LocalStorage localStorage;
  ApiGetBeneficiariesDataSource({
    required this.apiClient,
    required this.localStorage,
  });

  @override
  Future<Map<String, dynamic>?> call() async {
    await Future.delayed(const Duration(seconds: 2));

    final result = await localStorage.get('beneficiaries');
    final response =
        await apiClient.request('/endpoint', mock: {'data': result ?? []});
    return response;
  }
}
