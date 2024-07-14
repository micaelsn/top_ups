import '../../../../core/api/api_client.dart';

abstract class GetBeneficiariesDataSource {
  Future<Map<String, dynamic>?> call();
}

class ApiGetBeneficiariesDataSource implements GetBeneficiariesDataSource {
  ApiClient apiClient;
  ApiGetBeneficiariesDataSource({
    required this.apiClient,
  });

  @override
  Future<Map<String, dynamic>?> call() async {
    final response = await apiClient.request('/endpoint', mock: {
      'data': [
        {'id': '1', 'name': 'Amit Pahandit', 'phone': '+9193933939229'},
        {'id': '2', 'name': 'Amit Suresh', 'phone': '+939494949222'},
        {'id': '3', 'name': 'Amit Kumar', 'phone': '+909303039393'}
      ]
    });
    return response;
  }
}
