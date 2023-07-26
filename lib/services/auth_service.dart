import 'dart:convert';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/modelsSupabase/get_usuario_supabase.dart';
import 'package:fleet_management_tool_rta/modelsSupabase/response_login_supabase.dart';

// https://www.djamware.com/post/618d094c5b9095915c5621c6/flutter-tutorial-login-role-and-permissions
// https://mundanecode.com/posts/flutter-restapi-login/
// https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1

abstract class AuthService {
  // final registerUri = Uri.parse('$baseUrl/auth/signup');

  static Future<ResponseLoginSupabase?> loginSupabase(String email, String password) async {
    try {
      //Se recupera la información del usuario desde Supabase
      final responseSupabase = await supabase.auth.signInWithPassword(email: email, password: password);
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
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final res = await supabase
          .from('users')
          .select()
          .eq('user_profile_id', userId);

      if (res[0] != null) {
        final userProfile = res[0];
        // final userProfileString = jsonEncode(userProfile).toString();
        userProfile['id'] = user.id;
        userProfile['email'] = user.email!;
        //Existen datos del Usuario en Supabase
        final usuario = GetUsuarioSupabase.fromJson(jsonEncode(userProfile));
        return usuario;
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
