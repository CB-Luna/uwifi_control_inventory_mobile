import 'dart:convert';

import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_token_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/temporals/get_validate_usuaio_estatus_emi_web.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:http/http.dart';

class CotizacionController extends ChangeNotifier {
  List<ProdCotizados> productosCot = [];

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

  void clearInformation() {
    producto = '';
    costoTotal = 0.00;
    cantidad = 0;
    estado = '';
    notifyListeners();
  }

//Función inicial para recuperar el Token para la sincronización/posteo de datos
  Future<int> getTokenOAuth(int idEmprendimiento) async {
    final usuarioActual = dataBase.usuariosBox
        .query(Usuarios_.correo.equals(prefs.getString("userId")!))
        .build()
        .findUnique();
    if (usuarioActual != null) {
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

        var response = await post(url, headers: headers, body: bodyMsg);

        //print(response.body);

        switch (response.statusCode) {
          case 200:
            final responseTokenEmiWeb = getTokenEmiWebFromMap(response.body);
            tokenGlobal = responseTokenEmiWeb.accessToken;
            String? idProyectoEmiWeb =
                dataBase.emprendimientosBox.get(idEmprendimiento)?.idEmiWeb;
            if (idProyectoEmiWeb != null) {
              final getUsuarioEstatusUri = Uri.parse(
                  '$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responseGetUsuarioEstatusProyecto =
                  await get(getUsuarioEstatusUri, headers: headers);
              if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
                //Se recupera el Usuario y el Estatus
                final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
                    const Utf8Decoder()
                        .convert(responseGetUsuarioEstatusProyecto.bodyBytes));
                if (responseProyecto.payload.switchMovil == true) {
                  return 1;
                } else {
                  //El estatus o el Usuario del Proyecto cambiaron, así que se tienen que eliminar de este dispositivo
                  return 2;
                }
              } else {
                //No se pudo llamar el API de validación en EmiWeb del estatus-usuario proyecto
                return 0;
              }
            } else {
              //No se pudo recuperar el idEmiWeb del Proyecto
              return 0;
            }
          case 401:
            return 0;
          case 404:
            return 0;
          default:
            return 0;
        }
      } catch (e) {
        return 0;
      }
    } else {
      //No se pudo encontrar el Usuario Actual del dispositivo
      return 0;
    }
  }

  Future<int> acceptCotizacion(Inversiones inversion,
      int idInversionesXProdCotizados, int idEmprendimiento) async {
    try {
      final newEstadoInversion = dataBase.estadoInversionBox
          .query(EstadoInversion_.estado.equals("Autorizada"))
          .build()
          .findFirst();
      if (newEstadoInversion != null) {
        //Se actualiza el estado en ObjectBox
        final inversionXprodCotizados = dataBase.inversionesXprodCotizadosBox
            .get(idInversionesXProdCotizados);
        if (inversionXprodCotizados != null) {
          final listProdCotizados =
              inversionXprodCotizados.prodCotizados.toList();
          for (var i = 0; i < listProdCotizados.length; i++) {
            listProdCotizados[i].aceptado = false;
            dataBase.productosCotBox.put(listProdCotizados[i]);
            //print("Prod Cotizado updated succesfully");
          }
          inversion.estadoInversion.target = newEstadoInversion;
          dataBase.inversionesBox.put(inversion);
          //print("Inversion updated succesfully");
          switch (await getTokenOAuth(idEmprendimiento)) {
            case 0:
              return 0;
            case 1:
              // Se crea el API para realizar la actualización de estado inversión en Emi Web
              final actualizarEstadoInversionUri =
                  Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              //Se actualiza el estado de la inversión en Emi Web
              final responsePutUpdateEstadoInversion =
                  await put(actualizarEstadoInversionUri,
                      headers: headers,
                      body: jsonEncode({
                        "usuarioRegistra":
                            "${inversion.emprendimiento.target!.usuario.target!.nombre} ${inversion.emprendimiento.target!.usuario.target!.apellidoP} ${inversion.emprendimiento.target!.usuario.target!.apellidoM}",
                        "idInversiones": inversion.idEmiWeb,
                        "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
                      }));
              //print("Id Inversión: ${inversion.idEmiWeb}");
              switch (responsePutUpdateEstadoInversion.statusCode) {
                case 200:
                  //print("Caso 200 en Emi Web Update Estado Inversión");
                  //Se agrega la instrucción para mandar Proyectos a Emi Web
                  final nuevaInstruccionInversionXprodCotizado = Bitacora(
                      instruccion: 'syncAcceptInversionXProdCotizado',
                      usuario: prefs.getString("userId")!,
                      idEmprendimiento:
                          idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
                  inversionXprodCotizados.aceptado = false;
                  inversionXprodCotizados.bitacora
                      .add(nuevaInstruccionInversionXprodCotizado);
                  dataBase.inversionesXprodCotizadosBox
                      .put(inversionXprodCotizados);
                  //Se actualiza el estado de la Inversión en Pocketbase
                  final record = await client.records
                      .update('inversiones', inversion.idDBR.toString(), body: {
                    "id_estado_inversion_fk": newEstadoInversion.idDBR,
                  });
                  if (record.id.isNotEmpty) {
                    return 1;
                  } else {
                    return 0;
                  }
                default: //No se realizo con éxito el put
                  //print("Error en actualizar estado inversión Emi Web");
                  return 0;
              }
            case 2:
              return 2;
            default:
              return 0;
          }
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } catch (e) {
      //print("Error en acceptCotizacion(): $e");
      return 0;
    }
  }

  Future<int> cancelCotizacion(Inversiones inversion,
      int idInversionesXProdCotizados, int idEmprendimiento) async {
    try {
      switch (await getTokenOAuth(idEmprendimiento)) {
        case 0:
          return 0;
        case 1:
          final newEstadoInversion = dataBase.estadoInversionBox
              .query(EstadoInversion_.estado.equals("Cancelada"))
              .build()
              .findFirst();
          if (newEstadoInversion != null) {
            // Primero creamos el API para realizar la actualización
            final actualizarEstadoInversionUri =
                Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            //Se actualiza el estado de la inversión en Emi Web
            final responsePutUpdateEstadoInversion =
                await put(actualizarEstadoInversionUri,
                    headers: headers,
                    body: jsonEncode({
                      "usuarioRegistra":
                          "${inversion.emprendimiento.target!.usuario.target!.nombre} ${inversion.emprendimiento.target!.usuario.target!.apellidoP} ${inversion.emprendimiento.target!.usuario.target!.apellidoM}",
                      "idInversiones": inversion.idEmiWeb,
                      "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
                    }));
            switch (responsePutUpdateEstadoInversion.statusCode) {
              case 200:
                //print("Caso 200 en Emi Web Update Estado Inversión");
                //Se actualiza el estado de la Inversión en Pocketbase
                final record = await client.records
                    .update('inversiones', inversion.idDBR.toString(), body: {
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                });
                if (record.id.isNotEmpty) {
                  //Se actualiza el estado en ObjectBox
                  //Se actualiza es el estado de los prod Cotizados
                  final inversionXprodCotizados = dataBase
                      .inversionesXprodCotizadosBox
                      .get(idInversionesXProdCotizados);
                  if (inversionXprodCotizados != null) {
                    final listProdCotizados =
                        inversionXprodCotizados.prodCotizados.toList();
                    for (var i = 0; i < listProdCotizados.length; i++) {
                      listProdCotizados[i].aceptado = false;
                      dataBase.productosCotBox.put(listProdCotizados[i]);
                      //print("Prod Cotizado updated succesfully");
                    }
                    inversion.estadoInversion.target = newEstadoInversion;
                    dataBase.inversionesBox.put(inversion);
                    //print("Inversion updated succesfully");
                    return 1;
                  } else {
                    return 0;
                  }
                } else {
                  return 0;
                }
              default: //No se realizo con éxito el put
                //print("Error en actualizar estado inversión Emi Web");
                return 0;
            }
          } else {
            return 0;
          }
        case 2:
          return 2;
        default:
          return 0;
      }
    } catch (e) {
      //print("Error en cancelCotizacion(): $e");
      return 0;
    }
  }

  Future<int> buscarOtraCotizacion(Inversiones inversion,
      int idInversionesXProdCotizados, int idEmprendimiento) async {
    try {
      switch (await getTokenOAuth(idEmprendimiento)) {
        case 0:
          return 0;
        case 1:
          final newEstadoInversion = dataBase.estadoInversionBox
              .query(EstadoInversion_.estado.equals("Buscar Otra Cotización"))
              .build()
              .findFirst();
          if (newEstadoInversion != null) {
            // Primero creamos el API para realizar la actualización
            final actualizarEstadoInversionUri =
                Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            //Se actualiza el estado de la inversión en Emi Web
            final responsePutUpdateEstadoInversion =
                await put(actualizarEstadoInversionUri,
                    headers: headers,
                    body: jsonEncode({
                      "usuarioRegistra":
                          "${inversion.emprendimiento.target!.usuario.target!.nombre} ${inversion.emprendimiento.target!.usuario.target!.apellidoP} ${inversion.emprendimiento.target!.usuario.target!.apellidoM}",
                      "idInversiones": inversion.idEmiWeb,
                      "idCatEstadoInversion": newEstadoInversion.idEmiWeb,
                    }));
            switch (responsePutUpdateEstadoInversion.statusCode) {
              case 200:
                //print("Caso 200 en Emi Web Update Estado Inversión");
                //Se actualiza el estado de la Inversión en Pocketbase
                final record = await client.records
                    .update('inversiones', inversion.idDBR.toString(), body: {
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                });
                if (record.id.isNotEmpty) {
                  //Se actualiza el estado en ObjectBox
                  //Se actualiza es el estado de los prod Cotizados
                  final inversionXprodCotizados = dataBase
                      .inversionesXprodCotizadosBox
                      .get(idInversionesXProdCotizados);
                  if (inversionXprodCotizados != null) {
                    final listProdCotizados =
                        inversionXprodCotizados.prodCotizados.toList();
                    for (var i = 0; i < listProdCotizados.length; i++) {
                      listProdCotizados[i].aceptado = false;
                      dataBase.productosCotBox.put(listProdCotizados[i]);
                      //print("Prod Cotizado updated succesfully");
                    }
                    final nuevaInversionXprodCotizados = InversionesXProdCotizados(
                        idEmprendimiento:
                            idEmprendimiento); //Se crea la instancia inversion x prod Cotizados
                    // final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateEstadoInversion', instruccionAdicional: "Solicitada", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
                    inversion.estadoInversion.target = newEstadoInversion;
                    nuevaInversionXprodCotizados.inversion.target = inversion;
                    // inversion.bitacora.add(nuevaInstruccion);
                    inversion.inversionXprodCotizados
                        .add(nuevaInversionXprodCotizados);
                    dataBase.inversionesBox.put(inversion);
                    //print("Inversion updated succesfully");
                    return 1;
                  } else {
                    return 0;
                  }
                } else {
                  return 0;
                }
              default: //No se realizo con éxito el put
                //print("Error en actualizar estado inversión Emi Web");
                return 0;
            }
          } else {
            return 0;
          }
        case 2:
          return 2;
        default:
          return 0;
      }
    } catch (e) {
      //print("Error en cancelCotizacion(): $e");
      return 0;
    }
  }

  void deleteEmprendimientoLocal(int idEmprendimiento) async {
    if (idEmprendimiento != -1) {
      final listIntruccionesEmp = dataBase.bitacoraBox.getAll().toList();
      for (var element in listIntruccionesEmp) {
        if (element.idEmprendimiento == idEmprendimiento) {
          dataBase.bitacoraBox.remove(element.id);
        }
      }
      //Se elimina la imagen del emprendimiento
      final idImagenEmprendimiento = dataBase.imagenesBox
          .query(Imagenes_.emprendimiento.equals(idEmprendimiento))
          .build()
          .findUnique()
          ?.id;
      if (idImagenEmprendimiento != null) {
        dataBase.imagenesBox.remove(idImagenEmprendimiento);
      }
      //Se elimina la imagen del emprendedor
      final idEmprendedor = dataBase.emprendedoresBox
          .query(Emprendedores_.emprendimiento.equals(idEmprendimiento))
          .build()
          .findUnique()
          ?.id;
      final idImagenEmprendedor = dataBase.imagenesBox
          .query(Imagenes_.emprendedor.equals(idEmprendedor ?? -1))
          .build()
          .findUnique()
          ?.id;
      if (idImagenEmprendedor != null) {
        dataBase.imagenesBox.remove(idImagenEmprendedor);
      }
      //Se elimina el emprendedor
      if (idEmprendedor != null) {
        dataBase.emprendedoresBox.remove(idEmprendedor);
      }
      //Se eliminan todas las imagenes
      List<int> imagenesDelete = dataBase.imagenesBox
          .query(Imagenes_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var imagen in imagenesDelete) {
        dataBase.imagenesBox.remove(imagen);
      }
      //Se eliminan todas las tareas
      List<int> tareasDelete = dataBase.tareasBox
          .query(Tareas_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var tarea in tareasDelete) {
        dataBase.tareasBox.remove(tarea);
      }
      //Se eliminan todas las jornadas
      List<int> jornadasDelete = dataBase.jornadasBox
          .query(Jornadas_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var jornada in jornadasDelete) {
        dataBase.jornadasBox.remove(jornada);
      }
      //Se eliminan todas las consultorías
      List<int> consultoriasDelete = dataBase.consultoriasBox
          .query(Consultorias_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var consultoria in consultoriasDelete) {
        dataBase.consultoriasBox.remove(consultoria);
      }
      //Se eliminan todos los productos Emprendedor
      List<int> productosEmpDelete = dataBase.productosEmpBox
          .query(ProductosEmp_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var productoEmp in productosEmpDelete) {
        dataBase.productosEmpBox.remove(productoEmp);
      }
      //Se eliminan todos los productos Vendidos
      List<int> prodVendidosDelete = dataBase.productosVendidosBox
          .query(ProdVendidos_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var prodVendido in prodVendidosDelete) {
        dataBase.productosVendidosBox.remove(prodVendido);
      }
      //Se eliminan todas las Ventas
      List<int> ventas = dataBase.ventasBox
          .query(Ventas_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var venta in ventas) {
        dataBase.ventasBox.remove(venta);
      }
      //Se eliminan todos los ProdCotizados
      List<int> productosCotizados = dataBase.productosCotBox
          .query(ProdCotizados_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var productoCotizado in productosCotizados) {
        dataBase.productosCotBox.remove(productoCotizado);
      }
      //Se eliminan todas las Inversiones X ProdCotizados
      List<int> inversionesXproductosCotizados = dataBase
          .inversionesXprodCotizadosBox
          .query(InversionesXProdCotizados_.idEmprendimiento
              .equals(idEmprendimiento))
          .build()
          .findIds();
      for (var inversionXproductoCotizado in inversionesXproductosCotizados) {
        dataBase.inversionesXprodCotizadosBox
            .remove(inversionXproductoCotizado);
      }
      //Se eliminan todos los ProdSolicitado
      List<int> productosSolicitados = dataBase.productosSolicitadosBox
          .query(ProdSolicitado_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var productoSolicitado in productosSolicitados) {
        dataBase.productosSolicitadosBox.remove(productoSolicitado);
      }
      //Se eliminan todas las Inversiones
      List<int> inversiones = dataBase.inversionesBox
          .query(Inversiones_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var inversion in inversiones) {
        dataBase.inversionesBox.remove(inversion);
      }
      //Se eliminan todos los Pagos
      List<int> pagos = dataBase.pagosBox
          .query(Pagos_.idEmprendimiento.equals(idEmprendimiento))
          .build()
          .findIds();
      for (var pago in pagos) {
        dataBase.pagosBox.remove(pago);
      }
      //Se elimina el emprendimiento
      dataBase.emprendimientosBox.remove(idEmprendimiento);
    }
  }
}
