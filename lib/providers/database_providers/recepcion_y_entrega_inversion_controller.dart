import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';

class RecepcionYEntregaController extends ChangeNotifier {

  List<ProdCotizados> prodCotizadosTemp = [];
  InversionesXProdCotizados? inversionXProdCotizadosTemp;

  GlobalKey<FormState> recepcionYentregaInversionFormKey = GlobalKey<FormState>();

  bool validateForm(GlobalKey<FormState> recepcionYentregaInversionKey) {
    return recepcionYentregaInversionKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    prodCotizadosTemp.clear();
    inversionXProdCotizadosTemp = null;
  }

  double getProdCotizadosEinversionXprodCotizados(List<ProdCotizados> actualProdCotizados, InversionesXProdCotizados actualInversionXprodCotizados) {
    double totalProyecto = 0.0;
    prodCotizadosTemp = actualProdCotizados;
    inversionXProdCotizadosTemp = actualInversionXprodCotizados;
    for (var i = 0; i < actualProdCotizados.length; i++) {
      if (actualProdCotizados[i].aceptado) {
        totalProyecto += actualProdCotizados[i].costoTotal;
      }
    }
    return totalProyecto;
  }

  void updateRecepcionInversion() {
    for (var i = 0; i < prodCotizadosTemp.length; i++) {
      final updateProdCotizado = dataBase.productosCotBox.get(prodCotizadosTemp[i].id);
       if (updateProdCotizado != null) {
        if (prodCotizadosTemp[i].aceptado) {
          updateProdCotizado.aceptado = prodCotizadosTemp[i].aceptado;
          updateProdCotizado.cantidad = prodCotizadosTemp[i].cantidad;
          updateProdCotizado.costoTotal = prodCotizadosTemp[i].costoTotal;
          dataBase.productosCotBox.put(updateProdCotizado);
          //print('Prod Cotizado aceptado exitosamente');
        } else {
          updateProdCotizado.aceptado = prodCotizadosTemp[i].aceptado;
          dataBase.productosCotBox.put(updateProdCotizado);
          //print('Prod Cotizado rechazado exitosamente');
        }
      }
    }
  }

  void finishRecepcionInversion(InversionesXProdCotizados inversionXProdCotizados, List<ProdCotizados> prodCotizados, int porcentaje, int idEmprendimiento) {
    for (var i = 0; i < prodCotizados.length; i++) {
        if (prodCotizados[i].aceptado) {
          final nuevaInstruccion = Bitacora(instruccion: 'syncAcceptProdCotizado', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          prodCotizados[i].bitacora.add(nuevaInstruccion);
          dataBase.productosCotBox.put(prodCotizados[i]);
        }
    }
    var totalProyecto = 0.0;
    final nuevaInstruccionInversionXprodCotizado = Bitacora(instruccion: 'syncUpdateInversionXProdCotizado', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    inversionXProdCotizados.aceptado = true;
    inversionXProdCotizados.bitacora.add(nuevaInstruccionInversionXprodCotizado);
    dataBase.inversionesXprodCotizadosBox.put(inversionXProdCotizados);
    //print('Inversion X Prod Cotizado actualizado exitosamente');
    //Se actualiza el estado de la inversión, monto, saldo y total de la inversión
    final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Entregada Al Promotor", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Entregada Al Promotor")).build().findFirst();
    final updateInversion = dataBase.inversionesBox.get(inversionXProdCotizados.inversion.target!.id);
    if (newEstadoInversion != null && updateInversion != null) {
      for (var i = 0; i < inversionXProdCotizados.prodCotizados.toList().length; i++) {
        if (inversionXProdCotizados.prodCotizados.toList()[i].aceptado) {
          totalProyecto += inversionXProdCotizados.prodCotizados.toList()[i].costoTotal; //aqui tambien se cambia
        }
      }
      updateInversion.montoPagar = totalProyecto * (porcentaje * 0.01); //Se actualiza el monto a pagar
      updateInversion.saldo = totalProyecto * (porcentaje * 0.01);
      updateInversion.totalInversion = totalProyecto;
      updateInversion.estadoInversion.target = newEstadoInversion;
      updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
      dataBase.inversionesBox.put(updateInversion);
      //print("Inversion updated succesfully");
    }
  }

   void entregaInversion(Imagenes imagenFirma, Imagenes imagenProductoEntregado, int idInversion, int idEmprendimiento) {

    final updateInversion = dataBase.inversionesBox.get(idInversion);
    if (updateInversion != null) {
      //Se agrega la imagen de la Firma
      final nuevaInstruccionImagenesEntregaInversion = Bitacora(instruccion: 'syncAddImagenesEntregaInversion', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      imagenFirma.inversion.target = updateInversion;
      imagenFirma.idEmprendimiento = idEmprendimiento;
      updateInversion.imagenFirmaRecibido.target = imagenFirma;
      dataBase.imagenesBox.put(imagenFirma);
      //Se agrega la imagen del Producto Entregado
      imagenProductoEntregado.inversion.target = updateInversion;
      imagenProductoEntregado.idEmprendimiento = idEmprendimiento;
      updateInversion.imagenProductoEntregado.target = imagenProductoEntregado;
      dataBase.imagenesBox.put(imagenProductoEntregado);
      //Se actualiza el estado de la inversión
      final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Entregada Al Emprendedor", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Entregada Al Emprendedor")).build().findFirst();
      if (newEstadoInversion != null) {
        updateInversion.estadoInversion.target = newEstadoInversion;
        updateInversion.bitacora.add(nuevaInstruccionImagenesEntregaInversion);
        updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
        dataBase.inversionesBox.put(updateInversion);
        //print("Inversion updated succesfully");
      }
    }
  }

void updatePago(double newMontoAbonado, int idInversion, int idEmprendimiento) {
  final updateInversion = dataBase.inversionesBox.get(idInversion);
  if (updateInversion != null) {
    final nuevaInstruccion = Bitacora(instruccion: 'syncAddPagoInversion', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    //Se agrega el nuevo pago para la Inversion
    final nuevoPago = Pagos(
      montoAbonado: newMontoAbonado,
      fechaMovimiento: DateTime.now(), 
      idEmprendimiento: idEmprendimiento,
      );
    nuevoPago.inversion.target = updateInversion;
    nuevoPago.bitacora.add(nuevaInstruccion);
    dataBase.pagosBox.put(nuevoPago);
    updateInversion.pagos.add(nuevoPago);
    //Se resta el nuevo monto abonado al saldo de la Inversion
    updateInversion.saldo = updateInversion.saldo - newMontoAbonado;
    dataBase.inversionesBox.put(updateInversion);
  }
}

  void finishPago(double newMontoAbonado, int idInversion, int idEmprendimiento) {
  final updateInversion = dataBase.inversionesBox.get(idInversion);
  if (updateInversion != null) {
    final nuevaInstruccionPago = Bitacora(instruccion: 'syncAddPagoInversion', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    //Se agrega el nuevo pago para la Inversion
    final nuevoPago = Pagos(
      montoAbonado: newMontoAbonado,
      fechaMovimiento: DateTime.now(), 
      idEmprendimiento: idEmprendimiento,
      );
    nuevoPago.inversion.target = updateInversion;
    nuevoPago.bitacora.add(nuevaInstruccionPago);
    dataBase.pagosBox.put(nuevoPago);
    updateInversion.pagos.add(nuevoPago);
    //Se actualiza a 0.0 el saldo de la Inversión
    updateInversion.saldo = 0.0;
    dataBase.inversionesBox.put(updateInversion);
    //Se actualiza el estado de la inversión
    final nuevaInstruccionEstadoInversion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Pagado", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Pagado")).build().findFirst();
    if (newEstadoInversion != null) {
      updateInversion.estadoInversion.target = newEstadoInversion;
      updateInversion.bitacora.add(nuevaInstruccionEstadoInversion);
      dataBase.inversionesBox.put(updateInversion);
      //print("Inversion updated succesfully");
    }
  }
  }


  void remove(ProdCotizados prodCotizados) {
    notifyListeners(); 
  }

  
}