import 'package:bizpro_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:bizpro_app/const.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:jwt_decode/jwt_decode.dart';

//TODO: agregar roles
enum Role { administrador, publico }

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
      //TODO: await?
      logout();
      return ValueNotifier(_publicClient);
    }

    //Hay un token valido
    if (_authenticatedClient == null) initClient();
    return ValueNotifier(_authenticatedClient!);
  }

  //Variables autenticacion
  List<String> token = [];

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
  //TODO: restarle un dia?
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
              NavigationService.replaceTo('/');
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

  Future<String> readToken() async {
    final jwt = await storage.read(key: 'token') ?? '';
    if (jwt != '') {
      token.add(jwt);
      initClient();
    }
    notifyListeners();
    return jwt;
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    token.clear();
    _authenticatedClient = null;
    notifyListeners();
  }

  // void setRole(String role) {
  //   switch (role) {
  //     case 'Administrador':
  //       this.role = Role.administrador;
  //       break;
  //     case 'Asistente':
  //       this.role = Role.asistente;
  //       break;
  //     case 'Public':
  //       this.role = Role.publico;
  //       break;
  //     default:
  //       this.role = Role.asistente;
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
