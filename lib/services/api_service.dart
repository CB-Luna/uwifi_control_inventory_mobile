import 'package:taller_alex_app_asesor/services/api_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

abstract class ApiService {
  static Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  void dispose() {
    client.close();
  }
}
