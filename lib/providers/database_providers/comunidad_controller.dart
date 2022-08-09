import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class ComunidadController extends ChangeNotifier {

  List<Comunidades> comunidades = [];

  GlobalKey<FormState> comunidadFormKey = GlobalKey<FormState>();
 
  //Comunidad
  String nombre = '';

  TextEditingController textControllerNombre = TextEditingController();

  bool validateForm() {
    return comunidadFormKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    nombre = '';
    notifyListeners();
  }

  void add() {
    final nuevaComunidad = Comunidades(
      nombre: nombre, 
      );
      dataBase.comunidadesBox.put(nuevaComunidad);
      comunidades.add(nuevaComunidad);
      print('Comunidad agregada exitosamente');
      notifyListeners();
  }

  void update(int id, String newNombre) {
    var updateComunidad = dataBase.comunidadesBox.get(id);
    if (updateComunidad != null) {
      updateComunidad.nombre = newNombre;
      dataBase.comunidadesBox.put(updateComunidad);
      print('Comunidad actualizada exitosamente');
    }
    notifyListeners();
  }

  void remove(Comunidades comunidad) {
    dataBase.comunidadesBox.remove(comunidad.id);
    comunidades.remove(comunidad);

    notifyListeners(); 
  }

  getAll() {
    comunidades = dataBase.comunidadesBox.getAll();
    notifyListeners();
  }
  
}