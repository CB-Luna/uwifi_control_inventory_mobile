import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_token_emi_web.dart';
import 'package:taller_alex_app_asesor/screens/screens.dart';
import 'package:taller_alex_app_asesor/services/navigation_service.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:jwt_decode/jwt_decode.dart';


class UserState extends ChangeNotifier {

  String tokenGlobal = "";
  GlobalKey<FormState> contrasenaFormKey = GlobalKey<FormState>();

  bool validateForm(GlobalKey<FormState> contrasenaKey) {
    return contrasenaKey.currentState!.validate() ? true : false;
  }

  //EMAIL
  String _email = '';
  //Almacenar email
  String get email => _email;
  Future<void> setEmail() async {
    _email = emailController.text;
    await prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD TODO: eliminar?
  String _password = '';
  //Almacenar password
  String get password => _password;
  Future<void> setPassword() async {
    _password = passwordController.text;
    await prefs.setString('password', passwordController.text);
  }
  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  //Variables autenticacion
  List<String> tokenPocketbase = [];
  String tokenEmiWeb = "";
  //Constructor de provider
  UserState() {
    recuerdame = prefs.getBool('recuerdame') ?? false;

    if (recuerdame == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

  void updateRecuerdame() async {
    recuerdame = !recuerdame;
    await prefs.setBool('recuerdame', recuerdame);
    notifyListeners();
  }

  //Funciones GraphQL
  //Funcion que revisa si un jwt ha expirado
  bool isTokenExpired(String jwt) {
    DateTime? expiryDate = Jwt.getExpiryDate(jwt);
    if (expiryDate == null) return false;
    return expiryDate.isBefore(DateTime.now());
  }

  //Funciones de autenticacion
  Future<void> setTokenPocketbase(String jwt) async {
    tokenPocketbase.clear();
    tokenPocketbase.add(jwt);
    await storage.write(key: 'tokenPocketbase', value: jwt);
    notifyListeners();
  }

  Future<void> setTokenEmiWeb(String jwt) async {
    tokenEmiWeb = "";
    tokenEmiWeb = jwt;
    await storage.write(key: 'tokenEmiWeb', value: jwt);
    notifyListeners();
  }

  Future<String> readTokenPocketbase() async {
    final jwt = await storage.read(key: 'tokenPocketbase') ?? '';
    if (jwt != '') {
      if (isTokenExpired(jwt)) {
        await logout(false);
        return '';
      }
      tokenPocketbase.add(jwt);
    }
    return jwt;
  }

  Future<String?> readTokenEmiWeb() async {
    final jwt = await storage.read(key: 'tokenEmiWeb');
    if (jwt != null) {
      return jwt;
    } else
    {
      return null;
    }
  }

  Future<void> logout([bool remove = true]) async {
    await storage.delete(key: 'tokenPocketbase');
    await storage.delete(key: 'tokenEmiWeb');
    tokenEmiWeb = "";
    tokenPocketbase.clear();
    if (remove) {
      await NavigationService.removeTo(MaterialPageRoute(
        builder: (context) => const SplashScreen(
          splashTimer: 0,
        ),
      ));
    }
  }

  //Función inicial para recuperar el Token para la actualización de password
  Future<bool> updatePassword(Usuarios usuario, String actualPasswordEncrypted, String newPasswordEncrypted) async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": prefs.getString("userId"),
          "password": actualPasswordEncrypted,
        });
      
      var response = await post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      switch (response.statusCode) {
        case 200:
          final responseTokenEmiWeb = getTokenEmiWebFromMap(
          response.body);
          tokenGlobal = responseTokenEmiWeb.accessToken;
          //Se actualiza la contraseña en Pocketbase
          await client.admins.authViaEmail('uzziel.palma@cbluna.com', 'cbluna2021\$');
          //Verificamos que el usuario no exista en Pocketbase
          final recordUsuario = await client.users.getFullList(
            batch: 200, 
            filter: "email='${prefs.getString("userId")}'");
          if (recordUsuario.isNotEmpty) {
            final usuarioUpdated = await client.users.update(
              recordUsuario.first.id,
              body: {
                'password': newPasswordEncrypted,
                'passwordConfirm': newPasswordEncrypted,
            });
            if(usuarioUpdated.id.isNotEmpty) {
              var urlUpdateContrasenaUsuario = Uri.parse("$baseUrlEmiWebServices/usuarios/actualizar/contrasena");
              final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
              var responseUpdateContrasenaUsuario = await put(
                urlUpdateContrasenaUsuario,
                headers: headers,
                body: jsonEncode({
                  "id": usuario.idEmiWeb,
                  "contrasenaActual": actualPasswordEncrypted,
                  "contrasenaNueva": newPasswordEncrypted
                })
              );
              switch (responseUpdateContrasenaUsuario.statusCode) {
                case 200: //Caso éxitoso
                  //print("Caso exitoso 200 en put Contraseña Usuario");
                  usuario.password = newPasswordEncrypted;
                  dataBase.usuariosBox.put(usuario);
                  prefs.setString("passEncrypted", newPasswordEncrypted);
                  return true;
                default:
                  snackbarKey.currentState?.showSnackBar(const SnackBar(
                    content: Text("No se actualizó con éxito la contraseña en Emi Web."),
                  ));
                  return false;
              } 
            } else {
              snackbarKey.currentState?.showSnackBar(const SnackBar(
                content: Text("No se actualizó con éxito la contraseña de forma local."),
              ));
              return false;
            }
          } else {
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("No se encontró al usuario actual en el servidor."),
            ));
            return false;
          }
        case 400:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Contraseña actual incorrecta, verifíque la información ingresada."),
          ));
          return false;
        case 401:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("El usuario se encuentra archivado, comuníquese con el Administrador."),
          ));
          return false;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Falló al conectarse con el servidor Emi Web."),
          ));
          return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
