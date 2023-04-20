import 'dart:convert';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_token_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_imagen_usuario.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/login_response.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_usuario_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/response_login_supabase.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// https://www.djamware.com/post/618d094c5b9095915c5621c6/flutter-tutorial-login-role-and-permissions
// https://mundanecode.com/posts/flutter-restapi-login/
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

abstract class AuthService {
  static final loginUri = Uri.parse('$baseUrl/api/users/auth-via-email');
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

      switch (response.statusCode) {
          case 200:
            //print("Es 200 en getTokenOAuthEmiWeb");
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
              response.body);
            storage.write(key: "tokenEmiWeb", value: responseTokenEmiWeb.accessToken);
            return responseTokenEmiWeb;
          case 400:
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("Correo electrónico y/o contraseña incorrectos."),
            ));
            return null;
          case 401:
            //Se actualiza Usuario archivado en Pocketbase y objectBox
            final updateUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(email)).build().findUnique();
            if (updateUsuario != null) {
              final recordUsuario = await client.records.
                getFullList('emi_users', batch: 200,
                filter: "id='${updateUsuario.idDBR}'");
              if (recordUsuario.isNotEmpty) {
                // Se actualiza el usuario con éxito
                dataBase.usuariosBox.put(updateUsuario); 
              }
            }
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("El usuario se encuentra archivado, comuníquese con el Administrador."),
            ));
            return null;
          default:
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("Falló al conectarse con el servidor Emi Web."),
            ));
            return null;
        }
    } catch (e) {
      return null;
    }
  }

  static Future<ResponseLoginSupabase?> loginSupabase(String email, String password) async {
    try {
      //Se recupera la información del usuario desde Supabase
      final responseSupabase = await supabaseClient.auth.signInWithPassword(email: email, password: password);
      if (responseSupabase.session?.expiresIn != null) {
        print("Response Supabase: ${jsonEncode(responseSupabase.session)}");
          final responseUsuarioSupabase = responseLoginSupabaseFromMap(
          jsonEncode(responseSupabase.session));
          return responseUsuarioSupabase;
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  static Future<GetUsuarioSupabase?> getUserByUserIDSupabase(String userId) async {
    String queryGetUserByUserID = """
      query Query {
        perfil_usuarioCollection (filter: { perfil_usuario_id: { eq: "$userId"} }){
          edges {
            node {
              created_at
              perfil_usuario_id
              nombre
              apellido_p
              apellido_m
              rfc
              domicilio
              telefono
              celular
              imagen
              roles {
                id
                rol
              }
            }
          }
        }
      }
      """;
    try {
      //Se recupera la información del Usuario en Supabase
      final record = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetUserByUserID),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
      if (record.data != null) {
        //Existen datos del Usuario en Supabase
        print("***Usuario: ${jsonEncode(record.data).toString()}");
        final responseUsuario = GetUsuarioSupabase.fromJson(jsonEncode(record.data).toString());
        return responseUsuario;
      } else {
        //No existen el Usuario en Supabase
        return null;
      }
    } catch (e) {
      print("Error en GetUsuarioSupabase: $e");
      return null;
    }
  }

  static Future<GetImagenUsuario?> imagenUsuarioByID(String? idImagenUsuario) async {
    try {
      //Obtenemos la imagen del Usuario por id
      final recordsImagenUsuario = await client.records.
      getFullList('imagenes', 
      batch: 200, 
      filter: "id='$idImagenUsuario'",
      sort: "-created");
      if (recordsImagenUsuario.isNotEmpty) {
        //print("Se retorna Imagen de imagenUsuarioById");
        //print(recordsImagenUsuario[0].toString());
      return getImagenUsuarioFromMap(recordsImagenUsuario[0].toString());
      } else{
        //print("No se retorna Imagen de imagenUsuarioById");
        return null;
      }
    } catch (e) {
      //print('ERROR - function userEMIByID(): $e');
      return null;
    }
  }

  static Future<bool> requestPasswordReset(
    String email,
  ) async {
    try {
      //Se recupera la información del password del usuario desde Emi Web
      var url = Uri.parse("$baseUrlEmiWebNonSecure/usuarios/recuperar?correo=$email");
      final headers = ({
          "Content-Type": "application/json",
        });
      var response = await get(
        url,
        headers: headers
      );

      switch (response.statusCode) {
        case 200:
          return true;
        case 202:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("El Usuario aún no tiene una contraseña asignada, comuníquese con el Administrador."),
          ));
          break;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Ocurrió un error."),
          ));
          break;
      }
      return false;
    } catch (e) {
      snackbarKey.currentState?.showSnackBar(const SnackBar(
        content: Text("Error al realizar la petición."),
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
