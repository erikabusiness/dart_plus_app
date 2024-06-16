import 'package:http/http.dart' as http;

abstract class HttpClientInterface {
  Future<http.Response> get(Uri url, {Map<String, String>? headers});
}
