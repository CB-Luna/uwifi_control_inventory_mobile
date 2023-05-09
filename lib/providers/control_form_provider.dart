import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
class ControlFormProvider extends ChangeNotifier {

  GlobalKey<FormState> controlFormFormKey = GlobalKey<FormState>();

  //Data about Control Form
  bool accept = false;
  // int idCliente = -1;
  // int idVehiculo = -1;
  // int idFormaPago = -1;
  String gas = "";
  String mileage = "";

  bool validateForm(GlobalKey<FormState> ordenTrabajoKey) {
    return ordenTrabajoKey.currentState!.validate() ? true : false;
  }


  void cleanData()
  {
    // idCliente = -1;
    // idVehiculo = -1; 
    // idFormaPago = -1;
    accept = false;
    notifyListeners();
  }

  void updateDataSelected(bool boolean) {
    accept = boolean;
    notifyListeners();
  }
  
  bool add(Usuarios usuario, String medida) {
    notifyListeners();
    return true;
  }

  // void addImagen(int idEmprendimiento) {
  //   final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  //   if (emprendimiento != null) {
  //     final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
  //     imagenLocal!.bitacora.add(nuevaInstruccion);
  //     emprendimiento.emprendedor.target!.imagen.target = imagenLocal;
  //     dataBase.imagenesBox.put(imagenLocal!);
  //     dataBase.emprendedoresBox.put(emprendimiento.emprendedor.target!);
  //     //print('Imagen Emprendedor agregada exitosamente');
  //     notifyListeners();
  //   } 
  // }





  
}