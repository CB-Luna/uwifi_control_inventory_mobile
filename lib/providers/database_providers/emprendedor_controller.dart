import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendedorController extends ChangeNotifier {

  List<Emprendedores> emprendedores = [];

  GlobalKey<FormState> emprendedorFormKey = GlobalKey<FormState>();

  //Emprendedor
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  DateTime? nacimiento = DateTime.now();
  String curp = '';
  String integrantesFamilia = '';
  String telefono = '';
  String comentarios = '';

  bool validateForm() {
    return emprendedorFormKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    nombre = '';
    apellidoP = '';
    apellidoM = '';
    nacimiento = null;
    curp = '';
    integrantesFamilia = '';
    telefono = '';
    comentarios = '';
    notifyListeners();
  }

  void add() {
    final nuevoEmprendedor = Emprendedores(
      nombre: nombre, 
      apellidoP: apellidoP, 
      apellidoM: apellidoM, 
      nacimiento: nacimiento!, 
      curp: curp, 
      integrantesFamilia: integrantesFamilia, 
      telefono: telefono, 
      comentarios: comentarios,  
      );
      dataBase.emprendedoresBox.put(nuevoEmprendedor);
      emprendedores.add(nuevoEmprendedor);
      print('Emprendedor agregado exitosamente');
      notifyListeners();
  }

  void remove(Emprendedores emprendedor) {
    dataBase.emprendedoresBox.remove(emprendedor.id);
    emprendedores.remove(emprendedor);
    notifyListeners(); 
  }

  getAll() {
    emprendedores = dataBase.emprendedoresBox.getAll();
    notifyListeners();
  }
  
}