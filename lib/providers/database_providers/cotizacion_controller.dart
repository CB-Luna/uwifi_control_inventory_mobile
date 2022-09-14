import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class CotizacionController extends ChangeNotifier {

  List<ProdCotizados> productosCot= [];

  GlobalKey<FormState> productoCotFormKey = GlobalKey<FormState>();
 
  //ProductoCot
  String producto = '';
  double costoTotal = 0.00;
  int cantidad = 0;
  String estado = '';


  bool validateForm(GlobalKey<FormState> productoCotKey) {
    return productoCotKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    producto = '';
    costoTotal = 0.00;
    cantidad = 0;
    estado = '';
    notifyListeners();
  }

  void add(int idEmprendimiento, int idInversion, int idProductoProv) {
    final nuevoProductoCot = ProdCotizados(
      cantidad: cantidad,
      costoTotal: costoTotal,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final inversion = dataBase.inversionesBox.get(idInversion);
      final productoProv = dataBase.productosProvBox.get(idProductoProv);
      if (emprendimiento != null && inversion != null && productoProv != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncRecoverCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoCot.statusSync.target = nuevoSync;
        nuevoProductoCot.inversion.target = inversion;
        nuevoProductoCot.productosProv.target = productoProv;
        nuevoProductoCot.bitacora.add(nuevaInstruccion);
        inversion.prodCotizados.add(nuevoProductoCot);
        dataBase.inversionesBox.put(inversion);
        print('ProductoCot agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  Future<void> acceptCotizacion(int idInversion) async {
    final inversion = dataBase.inversionesBox.get(idInversion);
    //Se actualiza el estado de la inversión
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Autorizada")).build().findFirst();
    if (newEstadoInversion != null && inversion != null) {
      final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
      }); 
      if (record.id.isNotEmpty) {
      print("Inversion updated succesfully");
      var updateInversion = dataBase.inversionesBox.get(inversion.id);
      if (updateInversion != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
  }

  Future<void> cancelCotizacion(int idInversion) async {
    final inversion = dataBase.inversionesBox.get(idInversion);
    //Se actualiza el estado de la inversión
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Cancelada")).build().findFirst();
    if (newEstadoInversion != null && inversion != null) {
      final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
      }); 
      if (record.id.isNotEmpty) {
      print("Inversion updated succesfully");
      var updateInversion = dataBase.inversionesBox.get(inversion.id);
      if (updateInversion != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
  }

  Future<void> buscarOtraCotizacion(int idInversion) async {
    final inversion = dataBase.inversionesBox.get(idInversion);
    //Se actualiza el estado de la inversión
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Buscar otra cotización")).build().findFirst();
    if (newEstadoInversion != null && inversion != null) {
      //Se eliminan los productos cotizados de la inversión
      final prodCotizados = inversion.prodCotizados.toList();
      for (var i = 0; i < prodCotizados.length; i++) {
        dataBase.productosCotBox.remove(prodCotizados[i].id);
        //Eliminación en el backend
        // await client.records.delete(
        //   'productos_cotizados', prodCotizados[i].idDBR.toString()
        //   ); 
      }
      final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
      }); 
      if (record.id.isNotEmpty) {
      print("Inversion updated succesfully");
      var updateInversion = dataBase.inversionesBox.get(inversion.id);
      if (updateInversion != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
  }

  void remove(ProdCotizados productosCot) {
    dataBase.productosCotBox.remove(productosCot.id); //Se elimina de bitacora la instruccion creada anteriormente
    notifyListeners(); 
  }

  solicitarOtraCotizacion(int id) {}

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}