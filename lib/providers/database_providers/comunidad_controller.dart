import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class LocalidadController extends ChangeNotifier {

  // List<Comunidades> comunidades = [];

  GlobalKey<FormState> localidadFormKey = GlobalKey<FormState>();
 
  //Localidad
  String nombreComunidad = '';
  String nombreMunicipio = '';
  String nombreEstado = '';

  TextEditingController textControllerNombre = TextEditingController();

  bool validateForm() {
    return localidadFormKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    nombreComunidad = '';
    nombreMunicipio = '';
    nombreEstado = '';
  }

  void changeComunidad(String nuevaComunidad) {
    nombreComunidad = nuevaComunidad;
    notifyListeners();
  }

  void changeMunicipio(String nuevoMunicipio) {
    nombreMunicipio = nuevoMunicipio;
    notifyListeners();
  }
  
  void changeEstado(String nuevoEstado) {
    nombreEstado = nuevoEstado;
    notifyListeners();
  }

  
}