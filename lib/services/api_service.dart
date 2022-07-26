import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/models/emi_user.dart';
import 'package:bizpro_app/services/api_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

abstract class ApiService {
  static Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  static Future<EmiUser?> getEmiUser(String id) async {
    try {
      var myProfileUri = Uri.parse(
          "$baseUrl/api/collections/emi_users/records/?filter=(user='$id')");
      final res = await client.get(myProfileUri);

      switch (res.statusCode) {
        case 200:
          final emiUser = EmiUser.fromJson(res.body);
          return emiUser;
        case 403:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Solo administradores pueden acceder a esta función"),
          ));
          break;
        case 404:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("El recurso solicitado no fue encontrado"),
          ));
          break;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Error al realizar la petición"),
          ));
          break;
      }
      return null;
    } catch (e) {
      snackbarKey.currentState?.showSnackBar(const SnackBar(
        content: Text("Error al realizar la petición"),
      ));
      return null;
    }
  }

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
