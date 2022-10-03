import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:jwt_decode/jwt_decode.dart';

enum Rol {
  emprendedor,
  promotor,
  administrador,
  amigoDelCambio,
  voluntarioEstrategico,
  publico,
}

class UserState extends ChangeNotifier {
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
  //ROL ACTUAL
  // String _rol = '';
  // //Almacenar rol
  // String get rol => _rol;
  // Future<void> setRol(String rol) async {
  //   _rol = rol;
  //   await prefs.setString('rol', rol);
  // }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  //Variables autenticacion
  List<String> token = [];

  Rol rolActual = Rol.administrador;

  //Constructor de provider
  UserState() {
    recuerdame = prefs.getBool('recuerdame') ?? false;

    if (recuerdame == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;

    //TODO Inicializar usuario activo
    // final String? posibleUsuario = prefs.getString('usuarioActivo');
    // if (posibleUsuario == null) return;
    // usuarioActivo = UsuarioActivo.fromJson(posibleUsuario);
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
  Future<void> setToken(String jwt) async {
    token.clear();
    token.add(jwt);
    await storage.write(key: 'token', value: jwt);
    notifyListeners();
  }

  Future<String> readToken() async {
    final jwt = await storage.read(key: 'token') ?? '';
    if (jwt != '') {
      if (isTokenExpired(jwt)) {
        await logout(false);
        return '';
      }
      token.add(jwt);
    }
    return jwt;
  }

  Future<void> logout([bool remove = true]) async {
    await storage.delete(key: 'token');
    token.clear();
    if (remove) {
      await NavigationService.removeTo(MaterialPageRoute(
        builder: (context) => const SplashScreen(
          splashTimer: 0,
        ),
      ));
    }
  }

  void setRolActual(String rol) {
    switch (rol) {
      case 'Emprendedor':
        rolActual = Rol.emprendedor;
        break;
      case 'Promotor':
        rolActual = Rol.promotor;
        break;
      case 'Administrador':
        rolActual = Rol.administrador;
        break;
      case 'Amigo Del Cambio':
        rolActual = Rol.amigoDelCambio;
        break;
      case 'Voluntario Estrategico':
        rolActual = Rol.voluntarioEstrategico;
        break;
      default:
        rolActual = Rol.publico;
        break;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
