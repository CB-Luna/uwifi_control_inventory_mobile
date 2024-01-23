import 'dart:convert';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/get_user_supabase.dart';
import 'package:uwifi_control_inventory_mobile/models/response_login_supabase.dart';

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
      print("Error at 'ResponseLoginSupabase': $e");
      return null;
    }
  }

  static Future<GetUserSupabase?> getUserByUserIDSupabase(String userId) async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) return null;

      final res = await supabase
          .from('users')
          .select()
          .eq('user_profile_id', userId);

      if (res[0] != null) {
        final userProfile = res[0];
        // final userProfileString = jsonEncode(userProfile).toString();
        userProfile['id'] = currentUser.id;
        userProfile['email'] = currentUser.email!;
        //Existen datos del Usuario en Supabase
        final user = GetUserSupabase.fromJson(jsonEncode(userProfile));
        return user;
      } else {
        //No existe el Usuario en Supabase
        return null;
      }
    } catch (e) {
      print("Error at 'GetUserSupabase': $e");
      return null;
    }
  }


}
