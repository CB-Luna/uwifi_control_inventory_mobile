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
        //Se actualiza el estado en ObjectBox
        final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox.get(idInversionesXProdCotizados);
        if (inversionXprodCotizados != null) {
          final listProdCotizados = inversionXprodCotizados.prodCotizados.toList();
          for (var i = 0; i < listProdCotizados.length; i++) {
            listProdCotizados[i].aceptado = true;
            dataBase.productosCotBox.put(listProdCotizados[i]);
            print("Prod Cotizado updated succesfully");
          }
          inversion.estadoInversion.target = newEstadoInversion;
          dataBase.inversionesBox.put(inversion);
          print("Inversion updated succesfully");
          if (await getTokenOAuth()) {
            // Se crea el API para realizar la actualización de estado inversión en Emi Web
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
                      listProdCotizados[i].aceptado = false;
                      dataBase.productosCotBox.put(listProdCotizados[i]);
                      print("Prod Cotizado updated succesfully");
                    }
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

  Future<bool> buscarOtraCotizacion(Inversiones inversion, int idInversionesXProdCotizados, int idEmprendimiento) async {
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
                      listProdCotizados[i].aceptado = false;
                      dataBase.productosCotBox.put(listProdCotizados[i]);
                      print("Prod Cotizado updated succesfully");
                    }
                    final nuevaInversionXprodCotizados = InversionesXProdCotizados(idEmprendimiento: idEmprendimiento); //Se crea la instancia inversion x prod Cotizados
                    // final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Solicitada", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
                    inversion.estadoInversion.target = newEstadoInversion;
                    nuevaInversionXprodCotizados.inversion.target = inversion;
                    // inversion.bitacora.add(nuevaInstruccion);
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