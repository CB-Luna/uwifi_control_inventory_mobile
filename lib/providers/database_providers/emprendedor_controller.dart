import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendedorController extends ChangeNotifier {

  List<Emprendedores> emprendedores = [];

  GlobalKey<FormState> emprendedorFormKey = GlobalKey<FormState>();

  //Emprendedor
  String imagen = '';
  String nombre = '';
  String apellidos = '';
  DateTime? nacimiento = DateTime.parse("2000-02-27 13:27:00");
  String curp = '';
  String integrantesFamilia = '';
  String telefono = '';
  String comentarios = '';

  bool validateForm(GlobalKey<FormState> emprendedorKey) {
    return emprendedorKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    apellidos = '';
    nacimiento = null;
    curp = '';
    integrantesFamilia = '';
    telefono = '';
    comentarios = '';
    notifyListeners();
  }

  void add(int idEmprendimiento) {
    final nuevoEmprendedor = Emprendedores(
      imagen: imagen,
      nombre: nombre, 
      apellidos: apellidos,
      nacimiento: nacimiento!, 
      curp: curp, 
      integrantesFamilia: integrantesFamilia, 
      telefono: telefono, 
      comentarios: comentarios,  
      );

      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        nuevoEmprendedor.comunidades.target = emprendimiento.comunidades.target;
        nuevoEmprendedor.statusSync.target = nuevoSync;
        emprendimiento.emprendedor.target = nuevoEmprendedor;
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        emprendedores.add(nuevoEmprendedor);
        print('Emprendedor agregado exitosamente');
        notifyListeners();
      }

      // dataBase.emprendedoresBox.put(nuevoEmprendedor);
      // emprendedores.add(nuevoEmprendedor);
  }

  void remove(Emprendedores emprendedor) {
    dataBase.emprendedoresBox.remove(emprendedor.id);
    // emprendedores.remove(emprendedor);
    notifyListeners(); 
  }

  getAll() {
    emprendedores = dataBase.emprendedoresBox.getAll();
    notifyListeners();
  }

  void getEmprendedoresActualUser(List<Emprendimientos> emprendimientos) {
    emprendedores = [];
    emprendimientos.forEach((element) {
      if (element.emprendedor.target != null) {
        emprendedores.add(element.emprendedor.target!);
      }
    });
  }

  void getEmprendedoresByEmprendimiento(Emprendimientos emprendimiento) {
    emprendedores = [];
     if (emprendimiento.emprendedor.target != null) {
        emprendedores.add(emprendimiento.emprendedor.target!);
      }
  }
  
}