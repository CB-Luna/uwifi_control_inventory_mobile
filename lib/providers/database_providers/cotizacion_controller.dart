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

  Future<void> acceptCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    double montoPagarYSaldoInicial = 0.0;
    //Se actualiza es el estado de los prod Cotizados
    final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
    if (inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
            dataBase.statusSyncBox.put(statusSync);
            dataBase.productosCotBox.put(updateProdCotizado);
            print("Prod Cotizado updated succesfully");
          }
          //Se suma el total del Prod Cotizado al monto a pagar y saldo
          montoPagarYSaldoInicial += updateProdCotizado.costoTotal;
        }
      }
    }
    //Se actualiza el estado de la inversión
    final inversion = dataBase.inversionesBox.get(idInversion);
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
            //Se asigna monto a Pagar y el Saldo inicial
            updateInversion.montoPagar = double.parse(((montoPagarYSaldoInicial * updateInversion.porcentajePago)/100).toStringAsFixed(2));
            updateInversion.saldo = double.parse(((montoPagarYSaldoInicial * updateInversion.porcentajePago)/100).toStringAsFixed(2));
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
  }

  Future<void> cancelCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión
    final inversion = dataBase.inversionesBox.get(idInversion);
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
    //Se actualiza es el estado de los prod Cotizados
    final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
    if (inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
            dataBase.statusSyncBox.put(statusSync);
            dataBase.productosCotBox.put(updateProdCotizado);
            print("Prod Cotizado updated succesfully");
          }
        }
      }
    }
  }

  Future<void> buscarOtraCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión y se agrega un nuevo inversion x prod Cotizados
    final inversion = dataBase.inversionesBox.get(idInversion);
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Buscar Otra Cotización")).build().findFirst();
    if (newEstadoInversion != null && inversion != null) {
      final nuevaInversionXprodCotizados = InversionesXProdCotizados(); //Se crea la instancia inversion x prod Cotizados
      final nuevoSyncInversionXprodCotizados = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaInversionXprodCotizados.statusSync.target = nuevoSyncInversionXprodCotizados;
      final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
      }); 
      if (record.id.isNotEmpty) {
      print("Inversion updated succesfully");
      var updateInversion = dataBase.inversionesBox.get(inversion.id);
      if (updateInversion != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la inversión
            dataBase.statusSyncBox.put(statusSync);
            updateInversion.estadoInversion.target = newEstadoInversion;
            nuevaInversionXprodCotizados.inversion.target = updateInversion;
            updateInversion.bitacora.add(nuevaInstruccion);
            updateInversion.inversionXprodCotizados.add(nuevaInversionXprodCotizados);
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
    //Se actualiza es el estado de los prod Cotizados
    final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
    if (inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        print("Prod Cotizado updated succesfully");
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
            dataBase.statusSyncBox.put(statusSync);
            dataBase.productosCotBox.put(updateProdCotizado);
          }
        }
      }
    }
  }

  Future<void> estadoEnCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión
    final inversion = dataBase.inversionesBox.get(idInversion);
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findFirst();
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
    notifyListeners();
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