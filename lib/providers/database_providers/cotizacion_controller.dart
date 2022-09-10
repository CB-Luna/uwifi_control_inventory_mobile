import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class CotizacionController extends ChangeNotifier {

  List<ProdCotizados> productosCot= [];

  GlobalKey<FormState> productoCotFormKey = GlobalKey<FormState>();
 
  //ProductoCot
  String producto = '';
  double costo = 0.00;
  int cantidad = 0;
  String estado = '';


  bool validateForm(GlobalKey<FormState> productoCotKey) {
    return productoCotKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    producto = '';
    costo = 0.00;
    cantidad = 0;
    estado = '';
    notifyListeners();
  }

  void add(int idEmprendimiento, int idInversion) {
    final nuevoProductoCot = ProdCotizados(
      producto: producto,
      cantidad: cantidad,
      costo: costo,
      estado: estado,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final inversion = dataBase.inversionesBox.get(idInversion);
      if (emprendimiento != null && inversion != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncRecoverCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoCot.statusSync.target = nuevoSync;
        nuevoProductoCot.inversion.target = inversion;
        nuevoProductoCot.bitacora.add(nuevaInstruccion);
        inversion.prodCotizados.add(nuevoProductoCot);
        dataBase.inversionesBox.put(inversion);
        print('ProductoCot agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void remove(ProdCotizados productosCot) {
    dataBase.productosCotBox.remove(productosCot.id); //Se elimina de bitacora la instruccion creada anteriormente
    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}