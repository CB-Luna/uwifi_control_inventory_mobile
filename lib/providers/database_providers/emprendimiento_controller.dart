import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendimientoController extends ChangeNotifier {

  List<Emprendimientos> emprendimientos = [];

  GlobalKey<FormState> emprendimientoFormKey = GlobalKey<FormState>();
 
  //Emprendimiento
  String imagen = '';
  String nombre = '';
  String descripcion = '';

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm() {
    return emprendimientoFormKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    descripcion = '';
    notifyListeners();
  }

  void add(int idComunidad) {
    final nuevoEmprendimiento = Emprendimientos(
      imagen: imagen, 
      nombre: nombre,
      descripcion: descripcion,
      );
      nuevoEmprendimiento.comunidades.target = dataBase.comunidadesBox.get(idComunidad);
      dataBase.emprendimientosBox.put(nuevoEmprendimiento);
      emprendimientos.add(nuevoEmprendimiento);
      print('Emprendimiento agregado exitosamente');
      notifyListeners();
  }

  void remove(Emprendimientos emprendimiento) {
    dataBase.emprendimientosBox.remove(emprendimiento.id);
    emprendimientos.remove(emprendimiento);

    notifyListeners(); 
  }

  getAll() {
    emprendimientos = dataBase.emprendimientosBox.getAll();
    notifyListeners();
  }
  
}