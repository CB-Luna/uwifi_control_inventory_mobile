import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:http/http.dart';

class CotizacionController extends ChangeNotifier {

  List<ProdCotizados> productosCot= [];

  GlobalKey<FormState> productoCotFormKey = GlobalKey<FormState>();
 
  //ProductoCot
  String producto = '';
  double costoTotal = 0.00;
  int cantidad = 0;
  String estado = '';
  String tokenGlobal = "";


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

//Función inicial para recuperar el Token para la sincronización/posteo de datos
  Future<bool> getTokenOAuth() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": prefs.getString("userId"),
          "password": prefs.getString("passEncrypted"),
        });
      
      var response = await post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      print(response.body);

      switch (response.statusCode) {
          case 200:
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
            response.body);
            tokenGlobal = responseTokenEmiWeb.accessToken;
            return true;
          case 401:
            return false;
          case 404:
            return false;
          default:
            return false;
        }
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> acceptCotizacion(Inversiones inversion, int idInversionesXProdCotizados) async {
    try {
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Autorizada")).build().findFirst();
      if (newEstadoInversion != null) {
        //Se actualiza el estado y el monto en ObjectBox
        double montoPagarYSaldoInicial = 0.0;
        //Se actualiza es el estado de los prod Cotizados
        final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
        if (inversionXprodCotizados != null) {
          final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
          for (var i = 0; i < listProdCotizados.length; i++) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(listProdCotizados[i].statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
              dataBase.statusSyncBox.put(statusSync);
              listProdCotizados[i].aceptado = true;
              dataBase.productosCotBox.put(listProdCotizados[i]);
              print("Prod Cotizado updated succesfully");
            }
            //Se suma el total del Prod Cotizado al monto a pagar y saldo
            montoPagarYSaldoInicial += listProdCotizados[i].costoTotal;
          }
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
            inversion.estadoInversion.target = newEstadoInversion;
            //Se asigna monto a Pagar y el Saldo inicial
            inversion.montoPagar = double.parse(((montoPagarYSaldoInicial * inversion.porcentajePago)/100).toStringAsFixed(2));
            inversion.saldo = double.parse(((montoPagarYSaldoInicial * inversion.porcentajePago)/100).toStringAsFixed(2));
            dataBase.inversionesBox.put(inversion);
            print("Inversion updated succesfully");
            if (await getTokenOAuth()) {
              // Se crea el API para realizar la actualización en Emi Web
              final actualizarEstadoInversionUri =
                Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              //Se actualiza el estado de la inversión en Emi Web
              final responsePutUpdateEstadoInversion = await put(actualizarEstadoInversionUri, 
              headers: headers,
              body: jsonEncode({
                "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${inversion.emprendimiento
                .target!.usuario.target!.nombre} ${inversion.emprendimiento
                .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "idInversiones": inversion.idEmiWeb,
                "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
              }));
              print("Id Inversión: ${inversion.idEmiWeb}");
              switch (responsePutUpdateEstadoInversion.statusCode) {
                case 200:
                print("Caso 200 en Emi Web Update Estado Inversión");
                  //Se actualiza el estado de la Inversión en Pocketbase
                  final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
                      "id_estado_inversion_fk": newEstadoInversion.idDBR,
                      "monto_pagar": double.parse(((montoPagarYSaldoInicial * inversion.porcentajePago)/100).toStringAsFixed(2)),
                      "saldo": double.parse(((montoPagarYSaldoInicial * inversion.porcentajePago)/100).toStringAsFixed(2)),
                      "total_inversion": montoPagarYSaldoInicial,
                    }); 
                    if (record.id.isNotEmpty) {
                      return true;
                    } else {
                      return false;
                    }
                default: //No se realizo con éxito el put
                  print("Error en actualizar estado inversión Emi Web");
                  return false;
              }  
            } else {
              print("Fallo en el Token");
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }   
      } else {
        return false;
      }
    } catch (e) {
      print("Error en acceptCotizacion(): $e");
      return false;
    }
  }

  Future<bool> cancelCotizacion(Inversiones inversion, int idInversionesXProdCotizados) async {
    try {
      if (await getTokenOAuth()) {
        final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Cancelada")).build().findFirst();
        if (newEstadoInversion != null) {
          // Primero creamos el API para realizar la actualización
          final actualizarEstadoInversionUri =
            Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          //Se actualiza el estado de la inversión en Emi Web
          final responsePutUpdateEstadoInversion = await put(actualizarEstadoInversionUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
            "usuarioRegistra": "${inversion.emprendimiento
            .target!.usuario.target!.nombre} ${inversion.emprendimiento
            .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "idInversiones": inversion.idEmiWeb,
            "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
          }));
          switch (responsePutUpdateEstadoInversion.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Update Estado Inversión");
              //Se actualiza el estado de la Inversión en Pocketbase
              final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                }); 
                if (record.id.isNotEmpty) {
                  //Se actualiza el estado en ObjectBox
                  //Se actualiza es el estado de los prod Cotizados
                  final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
                  if (inversionXprodCotizados != null) {
                    final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
                    for (var i = 0; i < listProdCotizados.length; i++) {
                      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(listProdCotizados[i].statusSync.target!.id)).build().findUnique();
                      if (statusSync != null) {
                        statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
                        listProdCotizados[i].aceptado = false;
                        dataBase.statusSyncBox.put(statusSync);
                        dataBase.productosCotBox.put(listProdCotizados[i]);
                        print("Prod Cotizado updated succesfully");
                      }
                    }
                    final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
                    if (statusSync != null) {
                      statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
                      dataBase.statusSyncBox.put(statusSync);
                      inversion.estadoInversion.target = newEstadoInversion;
                      dataBase.inversionesBox.put(inversion);
                      print("Inversion updated succesfully");
                      return true;
                    } else {
                      return false;
                    }
                  } else {
                    return false;
                  }
                } else {
                  return false;
                }
            default: //No se realizo con éxito el put
              print("Error en actualizar estado inversión Emi Web");
              return false;
          }  

        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error en cancelCotizacion(): $e");
      return false;
    }
  }

  Future<bool> buscarOtraCotizacion(Inversiones inversion, int idInversionesXProdCotizados) async {
    try {
      if (await getTokenOAuth()) {
        final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Buscar Otra Cotización")).build().findFirst();
        if (newEstadoInversion != null) {
          // Primero creamos el API para realizar la actualización
          final actualizarEstadoInversionUri =
            Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          //Se actualiza el estado de la inversión en Emi Web
          final responsePutUpdateEstadoInversion = await put(actualizarEstadoInversionUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
            "usuarioRegistra": "${inversion.emprendimiento
            .target!.usuario.target!.nombre} ${inversion.emprendimiento
            .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "idInversiones": inversion.idEmiWeb,
            "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
          }));
          switch (responsePutUpdateEstadoInversion.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Update Estado Inversión");
              //Se actualiza el estado de la Inversión en Pocketbase
              final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                }); 
                if (record.id.isNotEmpty) {
                  //Se actualiza el estado en ObjectBox
                  //Se actualiza es el estado de los prod Cotizados
                  final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
                  if (inversionXprodCotizados != null) {
                    final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
                    for (var i = 0; i < listProdCotizados.length; i++) {
                      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(listProdCotizados[i].statusSync.target!.id)).build().findUnique();
                      if (statusSync != null) {
                        statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del prod Cotizado
                        listProdCotizados[i].aceptado = false;
                        dataBase.statusSyncBox.put(statusSync);
                        dataBase.productosCotBox.put(listProdCotizados[i]);
                        print("Prod Cotizado updated succesfully");
                      }
                    }
                    final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
                    if (statusSync != null) {
                      final nuevaInversionXprodCotizados = InversionesXProdCotizados(); //Se crea la instancia inversion x prod Cotizados
                      final nuevoSyncInversionXprodCotizados = StatusSync(); //Se crea el objeto estatus por dedault //M__
                      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
                      nuevaInversionXprodCotizados.statusSync.target = nuevoSyncInversionXprodCotizados;
                      statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la inversión
                      dataBase.statusSyncBox.put(statusSync);
                      inversion.estadoInversion.target = newEstadoInversion;
                      nuevaInversionXprodCotizados.inversion.target = inversion;
                      inversion.bitacora.add(nuevaInstruccion);
                      inversion.inversionXprodCotizados.add(nuevaInversionXprodCotizados);
                      dataBase.inversionesBox.put(inversion);
                      print("Inversion updated succesfully");
                      return true;
                    } else {
                      return false;
                    }
                  } else {
                    return false;
                  }
                } else {
                  return false;
                }
            default: //No se realizo con éxito el put
              print("Error en actualizar estado inversión Emi Web");
              return false;
          }  

        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("Error en cancelCotizacion(): $e");
      return false;
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