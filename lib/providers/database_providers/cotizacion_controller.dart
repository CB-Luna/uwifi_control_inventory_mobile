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

  // void add(int idEmprendimiento, int idInversion, int idProductoProv) {
  //   final nuevoProductoCot = ProdCotizados(
  //     cantidad: cantidad,
  //     costoTotal: costoTotal,
  //     );
  //     final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  //     final inversion = dataBase.inversionesBox.get(idInversion);
  //     final productoProv = dataBase.productosProvBox.get(idProductoProv);
  //     if (emprendimiento != null && inversion != null && productoProv != null) {
  //       final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
  //       final nuevaInstruccion = Bitacora(instrucciones: 'syncRecoverCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
  //       nuevoProductoCot.statusSync.target = nuevoSync;
  //       nuevoProductoCot.inversion.target = inversion;
  //       nuevoProductoCot.productosProv.target = productoProv;
  //       nuevoProductoCot.bitacora.add(nuevaInstruccion);
  //       inversion.prodCotizados.add(nuevoProductoCot);
  //       dataBase.inversionesBox.put(inversion);
  //       print('ProductoCot agregado exitosamente');
  //       clearInformation();
  //       notifyListeners();
  //     }
  // }

  Future<void> acceptCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    double montoPagarYSaldoInicial = 0.0;
    //Se actualiza es el estado de los prod Cotizados
    final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
    final newEstadoProdCotizado = dataBase.estadosProductoCotizadosBox.query(EstadoProdCotizado_.estado.equals("Aceptado")).build().findFirst();
    if (newEstadoProdCotizado != null && inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        final record = await client.records.update('productos_cotizados', listProdCotizados[i].idDBR.toString(), body: {
        "id_estado_prod_cotizado_fk": newEstadoProdCotizado.idDBR,
        }); 
        if (record.id.isNotEmpty) {
        print("Prod Cotizado updated succesfully");
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
              dataBase.statusSyncBox.put(statusSync);
              updateProdCotizado.estadoProdCotizado.target = newEstadoProdCotizado;
              dataBase.productosCotBox.put(updateProdCotizado);
            }
            //Se suma el total del Prod Cotizado al monto a pagar y saldo
            montoPagarYSaldoInicial += updateProdCotizado.costoTotal;
          }
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
    final newEstadoProdCotizado = dataBase.estadosProductoCotizadosBox.query(EstadoProdCotizado_.estado.equals("Rechazado")).build().findFirst();
    if (newEstadoProdCotizado != null && inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        final record = await client.records.update('productos_cotizados', listProdCotizados[i].idDBR.toString(), body: {
        "id_estado_prod_cotizado_fk": newEstadoProdCotizado.idDBR,
        }); 
        if (record.id.isNotEmpty) {
        print("Prod Cotizado updated succesfully");
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
              dataBase.statusSyncBox.put(statusSync);
              updateProdCotizado.estadoProdCotizado.target = newEstadoProdCotizado;
              dataBase.productosCotBox.put(updateProdCotizado);
            }
          }
        }
      }
    }
  }

  Future<void> buscarOtraCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión y se agrega un nuevo inversion x prod Cotizados
    final inversion = dataBase.inversionesBox.get(idInversion);
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Buscar otra cotización")).build().findFirst();
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
    final newEstadoProdCotizado = dataBase.estadosProductoCotizadosBox.query(EstadoProdCotizado_.estado.equals("Solicitar Otra Cotización")).build().findFirst();
    if (newEstadoProdCotizado != null && inversionXprodCotizados != null) {
      final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
      for (var i = 0; i < listProdCotizados.length; i++) {
        final record = await client.records.update('productos_cotizados', listProdCotizados[i].idDBR.toString(), body: {
        "id_estado_prod_cotizado_fk": newEstadoProdCotizado.idDBR,
        }); 
        if (record.id.isNotEmpty) {
        print("Prod Cotizado updated succesfully");
        var updateProdCotizado = dataBase.productosCotBox.get(listProdCotizados[i].id);
        if (updateProdCotizado != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
              dataBase.statusSyncBox.put(statusSync);
              updateProdCotizado.estadoProdCotizado.target = newEstadoProdCotizado;
              dataBase.productosCotBox.put(updateProdCotizado);
            }
          }
        }
      }
    }
  }

   Future<void> estadoCotizada(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión
    final inversion = dataBase.inversionesBox.get(idInversion);
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Cotizada")).build().findFirst();
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

  Future<void> estadoEnCotizacion(int idInversion, int idInversionesXProdCotizados) async {
    //Se actualiza el estado de la inversión
    final inversion = dataBase.inversionesBox.get(idInversion);
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En cotización")).build().findFirst();
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