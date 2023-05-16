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

  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
