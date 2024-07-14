abstract class ApiClient {
  Future<Map<String, dynamic>?> request(String endpoint,
      {required Map<String, dynamic> mock});
}

class TopUpsApiClient implements ApiClient {
  final String baseUrl;
  TopUpsApiClient({
    required this.baseUrl,
  });

  @override
  Future<Map<String, dynamic>> request(String endpoint,
      {required Map<String, dynamic> mock}) async {
    return mock;
  }
}
