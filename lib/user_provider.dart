import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';

//TODO: agregar roles
enum Role { administrador, publico }

class UserState extends ChangeNotifier {
  String _email = '';

  String get email => _email;
  set email(String value) {
    _email = value;
    prefs.setString('email', value);
  }

  String _password = '';

  String get password => _password;
  set password(String value) {
    _password = value;
    prefs.setString('password', value);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool recuerdame = false;

  UserState() {
    recuerdame = prefs.getBool('recuerdame') ?? false;

    if (recuerdame == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

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
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
