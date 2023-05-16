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
  // final registerUri = Uri.parse('$baseUrl/auth/signup');

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


}
