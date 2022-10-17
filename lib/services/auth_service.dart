import 'dart:convert';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_usuario_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_usuario_roles_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/emi_user_by_id.dart';
import 'package:bizpro_app/modelsPocketbase/login_response.dart';
import 'package:bizpro_app/objectbox.g.dart';
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

  static Future<LoginResponse?> loginPocketbase(String email, String password) async {
    try {
      //Primero verificamos las credenciales en Pocketbase
      final res = await post(loginUri, body: {
        "email": email,
        "password": password,
      });

      switch (res.statusCode) {
        case 200:
          final loginResponse = LoginResponse.fromJson(res.body);
          storage.write(key: "tokenPocketbase", value: loginResponse.token);
          return loginResponse;
        default:
          //No se encontraron las credenciales en Pocketbase
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

//Función inicial para recuperar el Token para la sincronización/posteo de datos
  static Future<GetTokenEmiWeb?> getTokenOAuthEmiWeb(String email, String password) async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": email,
          "password": password
        });
      
      var response = await post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      print(response.body);

      switch (response.statusCode) {
          case 200:
            print("Es 200 en getTokenOAuthEmiWeb");
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
              response.body);
            storage.write(key: "tokenEmiWeb", value: responseTokenEmiWeb.accessToken);
            return responseTokenEmiWeb;
          case 401:
            print("Es null en 401 getTokenOAuthEmiWeb");
            return null;
          case 404:
            print("Es null en 404 getTokenOAuthEmiWeb");
            return null;
          default:
            print("Default en getTokenOAuthEmiWeb");
            return null;
        }
    } catch (e) {
      return null;
    }
  }

  static Future<GetUsuarioEmiWeb?> loginEmiWeb(String email, String password) async {
    try {
      final responseTokenEmiWeb = await getTokenOAuthEmiWeb(email, password);
      if(responseTokenEmiWeb != null) {
            //Se recupera la información del usuario desde Emi Web
            var url = Uri.parse("$baseUrlEmiWebServices/usuarios?correo=$email");
            var tokenActual = await storage.read(key: "tokenEmiWeb");
            print("Token Actual: $tokenActual");
            final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenActual',
              });
            var responseUsuarioData = await get(
              url,
              headers: headers
            );
            switch (responseUsuarioData.statusCode) {
              case 200: //Caso éxitoso
                print("Es 200 en loginEmiWeb");
                final responseUsuarioEmiWeb = getUsuarioEmiWebFromMap(
                const Utf8Decoder().convert(responseUsuarioData.bodyBytes));
                return responseUsuarioEmiWeb;
              case 401: //Error de Token incorrecto
                print("Es 401 en loginEmiWeb");
                loginEmiWeb(email, password);
                return null;
              case 404: //Error de ruta incorrecta
                print("Es 404 en loginEmiWeb");
                return null;
              default:
                return null;
            }
        } else{
          return null;
        }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> postUsuarioPocketbase(GetUsuarioEmiWeb responseUsuarioEmiWeb, String email, String password) async {
    try {
      print("Entramos a crear el Usuario en postUsuarioPocketbase");
      var url = Uri.parse("$baseUrlEmiWebServices/usuarios/${responseUsuarioEmiWeb.payload!.idUsuario}/roles");
      var tokenActual = await storage.read(key: "tokenEmiWeb");
      final headers = ({
          "Content-Type": "application/json",
          'Authorization': 'Bearer $tokenActual',
        });
      var responseUsuarioRoles = await get(
        url,
        headers: headers
      );
      switch (responseUsuarioRoles.statusCode) {
        case 200: //Caso éxitoso
        print("Caso éxitoso 200 en postUsuarioPocketbase");
          final responseUsuarioRolesEmiWeb = getUsuarioRolesEmiWebFromMap(
            const Utf8Decoder().convert(responseUsuarioRoles.bodyBytes));
          List<String> listRoles = [];
          //Se recuperan los id Emi Web de los roles del Usuario
          for (var i = 0; i < responseUsuarioRolesEmiWeb.payload!.length; i++) {
            final rol = dataBase.rolesBox.query(Roles_.idEmiWeb.equals(responseUsuarioRolesEmiWeb.payload![i].idCatRoles.toString())).build().findUnique();
            if (rol != null) {
              print("Se recupera el rol tipo: '${rol.rol}' del usuario a registrar con id: '${rol.idDBR}'");
              if (rol.rol != "Staff Logística" && rol.rol != "Staff Dirección") {
                listRoles.add(rol.idDBR!);
              }
            } 
          }
          //Se crea Usuario nuevo en Pocketbase
          final nuevoUsuario = await client.users.create(body: {
              'email': email,
              'password': password,
              'passwordConfirm': password,
          });
          if(nuevoUsuario.id.isNotEmpty) {
            print("Se crea el Uusuario en Pocketbase");
            //Se crea Usuario emi_users nuevo en colección de pocketbase
            final newRecordEmiUser = await client.records.create('emi_users', body: {
              "nombre_usuario": responseUsuarioEmiWeb.payload!.nombre,
              "apellido_p": responseUsuarioEmiWeb.payload!.apellidoPaterno,
              "apellido_m": responseUsuarioEmiWeb.payload!.apellidoMaterno,
              "telefono": responseUsuarioEmiWeb.payload!.telefono,
              "celular": "",
              "id_roles_fk": listRoles,
              "id_status_sync_fk": "xx5X7zjT7DhRA8a",
              "archivado": false,
              "user": nuevoUsuario.id,
              "id_emi_web": responseUsuarioEmiWeb.payload!.idUsuario.toString(),
            });
            if (newRecordEmiUser.id.isNotEmpty) {
              print('Usuario Emi Web agregado éxitosamente en Pocketbase');
            } else {
              print('Usuario Emi Web no agregado éxitosamente en Pocketbase');
              return false;
            }
            return true;
          } else {
            print("No se crea el Uusuario en Pocketbase");
            return false;
          }
        case 401: //Error de Token incorrecto
          print("Caso 401 en postUsuarioPocketbase");
          if(await getTokenOAuthEmiWeb(email, password) != null) {
            postUsuarioPocketbase(responseUsuarioEmiWeb, email, password);
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          print("Caso 404 en postUsuarioPocketbase");
          return false;
        default:
          print("Caso default en postUsuarioPocketbase");
          return false;
      }
    } catch (e) {
      print("Catch en postUsuarioPocketbase");
      print("Error: ${e}");
      return false;
    }
  }

  static Future<String?> userEMIByID(String idUser) async {
    try {

      print("User ID: $idUser");
      var url = Uri.parse("$baseUrl/api/collections/emi_users/records/?filter=(user='$idUser')");

      var response = await get(url);

      print(response.body);

      final reverseUserEMIById = emiUserByIdFromMap(
          response.body);

      print("Resultado del userEMIByID: ${reverseUserEMIById.items?[0].id}");

      if (reverseUserEMIById.items == null) {
        print('Items not Found');
      } else {
        return reverseUserEMIById.items?[0].id;
      }
    } catch (e) {
      print('ERROR - function userEMIByID(): $e');
      return null;
    }
    return null;
  
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
}
