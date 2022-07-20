import 'package:bizpro_app/models/usuario_activo.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:bizpro_app/const.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

enum Rol {
  emprendedor,
  promotor,
  staffLogistica,
  staffDireccion,
  administrador,
  amigoDelCambio,
  voluntarioEstrategico,
  publico,
}

class UserState extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  //EMAIL
  String _email = '';

  String get email => _email;
  void setEmail() {
    _email = emailController.text;
    prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD TODO: eliminar?
  String _password = '';

  String get password => _password;
  void setPassword() {
    _password = passwordController.text;
    prefs.setString('password', passwordController.text);
  }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  //Variables GraphQL
  final HttpLink httpLink = HttpLink('$strapiServer/graphql');

  final GraphQLClient _publicClient = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink('$strapiServer/graphql'),
  );

  GraphQLClient? _authenticatedClient;

  ValueNotifier<GraphQLClient> get client {
    //Revisar si provider tiene token
    if (token.isEmpty) return ValueNotifier(_publicClient);

    //Hay un token
    final String jwt = token[0];

    //Revisar su expiracion
    if (isTokenExpired(jwt)) {
      //TODO: await?, revisar navegacion
      logout();
      return ValueNotifier(_publicClient);
    }

    //Hay un token valido
    if (_authenticatedClient == null) initClient();
    return ValueNotifier(_authenticatedClient!);
  }

  //Variables autenticacion
  List<String> token = [];

  //Objeto con informacion del usuario activo
  UsuarioActivo? usuarioActivo;
  Rol rol = Rol.administrador;

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

  //Funciones Login Screen
  void clearEmail() {
    emailController.clear;
    notifyListeners();
  }

  void clearPassword() {
    passwordController.clear();
    notifyListeners();
  }

  void updateRecuerdame() {
    recuerdame = !recuerdame;
    prefs.setBool('recuerdame', recuerdame);
    notifyListeners();
  }

  //Funciones GraphQL
  //Funcion que revisa si un jwt ha expirado
  bool isTokenExpired(String jwt) {
    DateTime? expiryDate = Jwt.getExpiryDate(jwt);
    if (expiryDate == null) return false;
    return expiryDate.isBefore(DateTime.now());
  }

  //Funcion que inicializa el cliente
  void initClient() {
    if (token.isNotEmpty) {
      //Get jwt from provider (should have been updated in login() or register())
      final String jwt = token[0];

      //Create authlink with token
      final AuthLink authLink = AuthLink(getToken: () => 'Bearer $jwt');

      //Se usa un ErrorLink para cachar la expiracion del token mientras se
      //usa la aplicacion
      //TODO: como manejar await?
      final ErrorLink errorLink = ErrorLink(
        onException: (_, __, LinkException exception) {
          if (exception is HttpLinkServerException) {
            if (exception.response.statusCode == 401) {
              logout();
            }
          }
          return null;
        },
      );

      //Join all links
      final Link link = errorLink.concat(authLink.concat(httpLink));

      //Initialize client
      _authenticatedClient = GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: link,
      );
    }
  }

  //Funciones de autenticacion
  Future<void> setToken(String jwt) async {
    token.clear();
    token.add(jwt);
    await storage.write(key: 'token', value: jwt);
    notifyListeners();
  }
  //TDOD: Quitar user Activo == null
  Future<String> readToken() async {
    final jwt = await storage.read(key: 'token') ?? '';
    if (jwt != '') {
      if (isTokenExpired(jwt)) {
        await logout(false);
        return '';
      }
      token.add(jwt);
      initClient();
    }
    notifyListeners();
    return jwt;
  }

  void setActiveUser(Map<String, dynamic> userData) {
    usuarioActivo = UsuarioActivo.fromJson(userData.toString());
    setRole(usuarioActivo!.role);
  }

  void saveActiveUser() {
    prefs.setString('activeUser', usuarioActivo!.toJson());
  }

  Future<void> logout([bool remove = true]) async {
    await storage.delete(key: 'token');
    token.clear();
    _authenticatedClient = null;
    notifyListeners();
    if (remove) {
      await NavigationService.removeTo(MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ));
    }
  }

  void setRole(String rol) {
    switch (rol) {
      case 'Emprendedor':
        this.rol = Rol.emprendedor;
        break;
      case 'Promotor':
        this.rol = Rol.promotor;
        break;
      case 'Staff Logistica':
        this.rol = Rol.staffLogistica;
        break;
      case 'Staff Direccion':
        this.rol = Rol.staffDireccion;
        break;
      case 'Administrador':
        this.rol = Rol.administrador;
        break;
      case 'Amigo Del Cambio':
        this.rol = Rol.amigoDelCambio;
        break;
      case 'Voluntario Estrategico':
        this.rol = Rol.voluntarioEstrategico;
        break;
      default:
        this.rol = Rol.publico;
    }
  }

  int getRole(String rol) {
    switch (rol) {
      case 'Emprendedor':
        return 0;
      case 'Promotor':
        return 1;
      case 'Staff Logistica':
        return 2;
      case 'Staff Direccion':
        return 3;
      case 'Administrador':
        return 4;
      case 'Amigo Del Cambio':
        return 5;
      case 'Voluntario Estrategico':
        return 6;
      default:
        return 7;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
