import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';

class RecepcionYEntregaController extends ChangeNotifier {

  List<ProdCotizados> prodCotizadosTemp = [];
  InversionesXProdCotizados? inversionXProdCotizadosTemp;

  GlobalKey<FormState> recepcionYentregaInversionFormKey = GlobalKey<FormState>();

  //Recepcion y Entrega Inversion
  // String numJornada = '';
  // DateTime? fechaRevision = DateTime.now();
  // DateTime? fechaRegistro = DateTime.now();
  // String tarea = "";
  // String observacion = "";
  // String descripcion = "";
  // List<String> imagenes = [];
  // bool activo = true;

  bool validateForm(GlobalKey<FormState> recepcionYentregaInversionKey) {
    return recepcionYentregaInversionKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    prodCotizadosTemp.clear();
    inversionXProdCotizadosTemp = null;
    // numJornada = '';
    // fechaRevision = null;
    // fechaRegistro = null;
    // tarea = "";
    // observacion = "";
    // descripcion = "";
    // imagenes = [];
    // activo = true;
  }

  double getProdCotizadosEinversionXprodCotizados(List<ProdCotizados> actualProdCotizados, InversionesXProdCotizados actualInversionXprodCotizados) {
    double totalProyecto = 0.0;
    prodCotizadosTemp = actualProdCotizados;
    inversionXProdCotizadosTemp = actualInversionXprodCotizados;
    for (var i = 0; i < actualProdCotizados.length; i++) {
      totalProyecto += actualProdCotizados[i].costoTotal;
    }
    return totalProyecto;
  }

  void updateRecepcionInversion() {
    for (var i = 0; i < prodCotizadosTemp.length; i++) {
      final updateProdCotizado = dataBase.productosCotBox.get(prodCotizadosTemp[i].id);
       if (updateProdCotizado != null) {
        final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProdCotizado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        updateProdCotizado.aceptado = prodCotizadosTemp[i].aceptado;
        final statusSyncProdcotizado = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
        if (statusSyncProdcotizado != null) {
          statusSyncProdcotizado.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Cotizado
          dataBase.statusSyncBox.put(statusSyncProdcotizado);
        }
        updateProdCotizado.bitacora.add(nuevaInstruccion);
        dataBase.productosCotBox.put(updateProdCotizado);
        print('Prod Cotizado actualizado exitosamente');
      }
    }
  }

   void finishRecepcionInversion(InversionesXProdCotizados inversionXProdCotizados) {
    for (var i = 0; i < prodCotizadosTemp.length; i++) {
      final updateProdCotizado = dataBase.productosCotBox.get(prodCotizadosTemp[i].id);
       if (updateProdCotizado != null) {
        final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProdCotizado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        updateProdCotizado.aceptado = prodCotizadosTemp[i].aceptado;
        final statusSyncProdcotizado = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdCotizado.statusSync.target!.id)).build().findUnique();
        if (statusSyncProdcotizado != null) {
          statusSyncProdcotizado.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Cotizado
          dataBase.statusSyncBox.put(statusSyncProdcotizado);
        }
        updateProdCotizado.bitacora.add(nuevaInstruccion);
        dataBase.productosCotBox.put(updateProdCotizado);
        print('Prod Cotizado actualizado exitosamente');
      }
    }

    final updateInversionXprodCotizado = dataBase.inversionesXprodCotizadosBox.get(inversionXProdCotizados.id);
       if (updateInversionXprodCotizado != null) {
        final nuevaInstruccionInversionXprodCotizado = Bitacora(instruccion: 'syncUpdateInversionXProdCotizado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        updateInversionXprodCotizado.aceptado = inversionXProdCotizados.aceptado;
        final statusSyncInversionXProdCotizados = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversionXprodCotizado.statusSync.target!.id)).build().findUnique();
        if (statusSyncInversionXProdCotizados != null) {
          statusSyncInversionXProdCotizados.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Cotizado X Inversion
          dataBase.statusSyncBox.put(statusSyncInversionXProdCotizados);
        }
        updateInversionXprodCotizado.bitacora.add(nuevaInstruccionInversionXprodCotizado);
        dataBase.inversionesXprodCotizadosBox.put(updateInversionXprodCotizado);
        print('Inversion X Prod Cotizado actualizado exitosamente');
      }

    //Se actualiza el estado de la inversión
    final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Entregada Al Promotor",usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Entregada Al Promotor")).build().findFirst();
    final updateInversion = dataBase.inversionesBox.get(inversionXProdCotizados.inversion.target!.id);
    if (newEstadoInversion != null && updateInversion != null) {
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
        updateInversion.estadoInversion.target = newEstadoInversion;
        updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
        dataBase.inversionesBox.put(updateInversion);
        print("Inversion updated succesfully");
      }
    }
  }

   void entregaInversion(String imagenFirma, String imagenProducto, int idInversion) {

    final updateInversion = dataBase.inversionesBox.get(idInversion);
    if (updateInversion != null) {
      final nuevaInstruccionImagenInversion = Bitacora(instruccion: 'syncUpdateImagenInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se agrega la imagen de la Firma
      final nuevaImagenFirma = Imagenes(imagenes: imagenFirma); //Se crea el objeto imagenes para la Inversion
      updateInversion.imagenes.add(nuevaImagenFirma);
      //Se agrega la imagen del Producto
      final nuevaImagenProducto = Imagenes(imagenes: imagenProducto); //Se crea el objeto imagenes para el Producto
      updateInversion.imagenes.add(nuevaImagenProducto);
      //Se actualiza el estado de la inversión
      final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Entregada Al Emprendedor",usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Entregada Al Emprendedor")).build().findFirst();
      if (newEstadoInversion != null) {
        final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
        if (statusSync != null) {
          statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la inversion
          dataBase.statusSyncBox.put(statusSync);
          updateInversion.estadoInversion.target = newEstadoInversion;
          updateInversion.bitacora.add(nuevaInstruccionImagenInversion);
          updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
          dataBase.inversionesBox.put(updateInversion);
          print("Inversion updated succesfully");
        }
      }
      
    }
  }

void updatePago(double newMontoAbonado, int idInversion) {
  final updateInversion = dataBase.inversionesBox.get(idInversion);
  if (updateInversion != null) {
    final nuevaInstruccion = Bitacora(instruccion: 'syncAddPagoInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    //Se agrega el nuevo pago para la Inversion
    final nuevoPago = Pagos(
      montoAbonado: newMontoAbonado,
      fechaMovimiento: DateTime.now()
      );
    final nuevoSyncPago = StatusSync(); //Se crea el objeto estatus por dedault //M__ para el Pago
    nuevoPago.statusSync.target = nuevoSyncPago;
    updateInversion.pagos.add(nuevoPago);
    //Se resta el nuevo monto abonado al saldo de la Inversion
    updateInversion.saldo = updateInversion.saldo - newMontoAbonado;
    updateInversion.bitacora.add(nuevaInstruccion);
    final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
    if (statusSync != null) {
      statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la inversion
      dataBase.statusSyncBox.put(statusSync);
      dataBase.inversionesBox.put(updateInversion);
      print("Inversion updated succesfully");
    }
  }
}

  void finishPago(double newMontoAbonado, int idInversion) {
  final updateInversion = dataBase.inversionesBox.get(idInversion);
  if (updateInversion != null) {
    final nuevaInstruccionPagoInversion = Bitacora(instruccion: 'syncAddPagoInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    //Se agrega el nuevo pago para la Inversion
    final nuevoPago = Pagos(
      montoAbonado: newMontoAbonado,
      fechaMovimiento: DateTime.now()
      );
    final nuevoSyncPago = StatusSync(); //Se crea el objeto estatus por dedault //M__ para el Pago
    nuevoPago.statusSync.target = nuevoSyncPago;
    updateInversion.pagos.add(nuevoPago);
    //Se resta el nuevo monto abonado al saldo de la Inversion
    updateInversion.saldo = 0.0;
    updateInversion.bitacora.add(nuevaInstruccionPagoInversion);
    //Se actualiza el estado de la inversión
    final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Pagado",usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Pagado")).build().findFirst();
    final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
    if (statusSync != null && newEstadoInversion != null) {
      statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la inversion
      updateInversion.estadoInversion.target = newEstadoInversion;
      updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
      dataBase.statusSyncBox.put(statusSync);
      dataBase.inversionesBox.put(updateInversion);
      print("Inversion updated succesfully");
    }
  }
  }


  void remove(ProdCotizados prodCotizados) {
    notifyListeners(); 
  }

   void notification() {
    notifyListeners(); 
  }

  
}