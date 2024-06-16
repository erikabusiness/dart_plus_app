import 'package:dart_plus_app/domain/interfaces/services/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl implements HttpClientInterface {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return http.get(url, headers: headers);
  }
}
