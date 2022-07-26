import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// https://www.djamware.com/post/618d094c5b9095915c5621c6/flutter-tutorial-login-role-and-permissions
// https://mundanecode.com/posts/flutter-restapi-login/
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

abstract class AuthService {
  static final loginUri = Uri.parse('$baseUrl/api/users/auth-via-email');
  static final requestPasswordResetUri =
      Uri.parse('$baseUrl/api/users/request-password-reset');
  static final confirmPasswordRequestUri =
      Uri.parse('$baseUrl/api/users/confirm-password-reset');
  // final registerUri = Uri.parse('$baseUrl/auth/signup');

  static Future<LoginResponse?> login(String email, String password) async {
    try {
      final res = await post(loginUri, body: {
        "email": email,
        "password": password,
      });

      print("Se hace el post");
      switch (res.statusCode) {
        case 200:
        print("Entra al case 200");
          final loginResponse = LoginResponse.fromJson(res.body);
          print("Se transforma el login");
          storage.write(key: "token", value: loginResponse.token);
          return loginResponse;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Usuario y/o contraseña incorrectos"),
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

  static Future<bool> requestPasswordReset(
    String email,
  ) async {
    try {
      final res = await post(requestPasswordResetUri, body: {
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
    } catch (e) {
      snackbarKey.currentState?.showSnackBar(const SnackBar(
        content: Text("Error al realizar la petición"),
      ));
      return false;
    }
  }

  static Future<bool> confirmPasswordReset(
    String token,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final res = await post(confirmPasswordRequestUri, body: {
        "token": token,
        "password": password,
        "passwordConfirm": passwordConfirm,
      });

      //TODO: guardar token y hacer login, o solo mandar a pantalla de login?

      switch (res.statusCode) {
        case 200:
          return true;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Ocurrió un error"),
          ));
          return false;
      }
    } catch (e) {
      snackbarKey.currentState?.showSnackBar(const SnackBar(
        content: Text("Error al realizar la petición"),
      ));
      return false;
    }
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
