import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class AuthService {
  static final loginUri = Uri.parse('$baseUrl/api/users/auth-via-email');
  static final requestPasswordResetUri =
      Uri.parse('$baseUrl/api/users/request-password-reset');
  // final registerUri = Uri.parse('$baseUrl/auth/signup');

  static Future<LoginResponse?> login(String email, String password) async {
    //TODO: wrap in try catch
    final res = await post(loginUri, body: {
      "email": email,
      "password": password,
    });

    switch (res.statusCode) {
      case 200:
        final loginResponse = LoginResponse.fromJson(res.body);
        storage.write(key: "token", value: loginResponse.token);
        return loginResponse;
      default:
        snackbarKey.currentState?.showSnackBar(const SnackBar(
          content: Text("Correo o contraseña incorrectos"),
        ));
        break;
    }
    return null;
  }

  static Future<bool> requestPasswordReset(
    String email,
  ) async {
    //TODO: wrap in try catch
    final res = await post(loginUri, body: {
      "email": email,
    });

    switch (res.statusCode) {
      case 204:
        return true;
      default:
        snackbarKey.currentState?.showSnackBar(const SnackBar(
          content: Text("Ocurrió un error"),
        ));
        break;
    }
    return false;
  }

  // Future<Response?> register(
  //   String username,
  //   String password,
  //   String fullname,
  //   String phone,
  // ) async {
  //   var res = await post(registerUri, body: {
  //     "email": username,
  //     "password": password,
  //     "fullname": fullname,
  //     "phone": phone
  //   });
  //   return res;
  // }
}
