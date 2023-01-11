import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';

class VentaController extends ChangeNotifier {

  List<Ventas> venta = [];

  GlobalKey<FormState> ventasFormKey = GlobalKey<FormState>();
 
  //ProductoSol
  DateTime fechaInicio = DateTime.now();
  DateTime? fechaTermino;
  String total = "";

  bool validateForm(GlobalKey<FormState> ventasKey) {
    return ventasKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    fechaInicio = DateTime.now();
    fechaTermino = null;
    total = "";
    notifyListeners();
  }

  int add(int idEmprendimiento) {
    print(total);
    int idVenta = -1;
      final nuevaVenta = Ventas(
      fechaInicio: fechaInicio,
      fechaTermino: fechaTermino!,
      total: double.parse(total), 
      idEmprendimiento: idEmprendimiento,
    );
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncAddVenta', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      nuevaVenta.emprendimiento.target = emprendimiento;
      nuevaVenta.bitacora.add(nuevaInstruccion);
      idVenta = dataBase.ventasBox.put(nuevaVenta);
      emprendimiento.ventas.add(nuevaVenta);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Venta agregada exitosamente');
      clearInformation();
      notifyListeners();
    }
    return idVenta;
  }


void update(int id, DateTime newFechaInicio, DateTime newFechaTermino, double newTotal, int idEmprendimiento) {
    var updateVenta = dataBase.ventasBox.get(id);
    if (updateVenta !=  null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateVenta', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateVenta.fechaInicio = newFechaInicio;
      updateVenta.fechaTermino = newFechaTermino;
      updateVenta.total = newTotal;
      updateVenta.bitacora.add(nuevaInstruccion);
      dataBase.ventasBox.put(updateVenta);
      notifyListeners();
      print('Venta actualizada exitosamente');
    }
}
  void remove(Ventas ventas) {
    print("Tamaño ventas antes de remover: ${dataBase.ventasBox.getAll().length}");
    dataBase.ventasBox.remove(ventas.id); //Se elimina de bitacora la instruccion creada anteriormente
    print("Tamaño ventas después de remover: ${dataBase.ventasBox.getAll().length}");
    notifyListeners(); 
  }

}