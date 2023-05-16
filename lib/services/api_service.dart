import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/emi_user.dart';
import 'package:taller_alex_app_asesor/services/api_interceptor.dart';
import 'package:flutter/material.dart';
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
