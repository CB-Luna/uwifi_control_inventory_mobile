import 'dart:convert';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/services/apiinterceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class ApiService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  // Future<Response> getMyProfile() async {
  //   var myProfileUri = Uri.parse('${Constants.BASE_URL}/auth/user/me');
  //   final res = await client.get(myProfileUri);
  //   return res;
  // }

  // Future<Response> getUserList() async {
  //   var userUrl = Uri.parse('${Constants.BASE_URL}/users');
  //   final res = await client.get(userUrl);
  //   return res;
  // }

  // Future<Response> getUserById(String id) async {
  //   var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
  //   final res = await client.get(userUrl);
  //   return res;
  // }

  // Future<Response> addUser(int roleId, String email, String password,
  //     String fullname, String phone) async {
  //   var userUrl = Uri.parse('${Constants.BASE_URL}/users');
  //   final res = await client.post(userUrl, body: {
  //     "role_id": roleId.toString(),
  //     "email": email,
  //     "password": password,
  //     "fullname": fullname,
  //     "phone": phone
  //   });
  //   return res;
  // }

  // Future<Response> updateUser(
  //     int? id, int roleId, String email, String fullname, String phone) async {
  //   var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
  //   final res = await client.put(userUrl, body: {
  //     "role_id": roleId.toString(),
  //     "email": email,
  //     "fullname": fullname,
  //     "phone": phone
  //   });
  //   return res;
  // }

  // Future<Response> deleteUser(String id) async {
  //   var userUrl = Uri.parse('${Constants.BASE_URL}/users/$id');
  //   final res = await client.delete(userUrl);
  //   return res;
  // }

  void dispose() {
    client.close();
  }
}
