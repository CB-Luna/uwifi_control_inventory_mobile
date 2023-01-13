import 'dart:convert';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsEmiWeb/get_emprendimiento_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_inversion_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_prod_cotizados_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_productos_vendidos_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_roles_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_exitoso_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_exitoso_emi_web_single.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_imagen_exitoso_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_simple_registro_exitoso_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_validate_usuaio_estatus_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/venta_actualizar_request_list.dart';
import 'package:bizpro_app/modelsEmiWeb/venta_crear_request_list_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/instruccion_no_sincronizada.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class SyncProviderEmiWeb extends ChangeNotifier {

  var uuid = Uuid();
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
  List<InstruccionNoSincronizada> instruccionesFallidas = [];
  bool exitoso = true;
  bool usuarioExit = false;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    // notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    // notifyListeners();
  }

  void procesoExitoso(bool boleano) {
    procesoexitoso = boleano;
    // notifyListeners();
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
      print("Response body");
      print(response.body);
      //Se actualiza la información del usuario de forma autómatica, cada vez que se hace una sincronización
      final updateUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(prefs.getString("userId")!)).build().findUnique();
      if (updateUsuario != null) {
        switch (response.statusCode) {
          case 200:
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
            response.body);
            tokenGlobal = responseTokenEmiWeb.accessToken;
            var urlgetRolesUsuario = Uri.parse("$baseUrlEmiWebServices/usuarios/${updateUsuario.idEmiWeb}/roles");
            final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
            var responseGetRolesUsuario = await get(
              urlgetRolesUsuario,
              headers: headers
            );
            switch (responseGetRolesUsuario.statusCode) {
              case 200: //Caso éxitoso
                print("Caso exitoso 200 en get Roles Emi Web");
                final responseListRoles = getRolesEmiWebFromMap(
                const Utf8Decoder().convert(responseGetRolesUsuario.bodyBytes));
                List<String> listRoles = [];
                //Se recuperan los id Emi Web de los roles del Usuario
                for (var i = 0; i < responseListRoles.payload!.length; i++) {
                  final rol = dataBase.rolesBox.query(Roles_.idEmiWeb.equals(responseListRoles.payload![i].idCatRoles.toString())).build().findUnique();
                  if (rol != null) {
                    print("Se recupera el rol tipo: '${rol.rol}' del usuario a registrar con id: '${rol.idDBR}'");
                    if (rol.rol != "Staff Logística" && rol.rol != "Staff Dirección") {
                      listRoles.add(rol.idDBR!);
                    }
                  } 
                }
                if(listRoles.isEmpty) {
                  final updateRecordEmiUser = await client.records.update('emi_users', updateUsuario.idDBR.toString(), body: {
                    "id_roles_fk": [],
                  });
                  if (updateRecordEmiUser.id.isNotEmpty) {
                    //Se agregan los roles actualizados
                    updateUsuario.roles.clear();
                    dataBase.usuariosBox.put(updateUsuario);
                    snackbarKey.currentState?.showSnackBar(const SnackBar(
                      content: Text("El Usuario no cuenta con los permisos necesarios para sincronizar, favor de comunicarse con el Administrador."),
                    ));
                    usuarioExit = true;
                    return false;
                  } else {
                    snackbarKey.currentState?.showSnackBar(const SnackBar(
                      content: Text("No se pudieron actualizar los roles del Usuario en Servidor."),
                    ));
                    return false;
                  }
                } else {
                  final updateRecordEmiUser = await client.records.update('emi_users', updateUsuario.idDBR.toString(), body: {
                    "id_roles_fk": listRoles,
                  });
                  if (updateRecordEmiUser.id.isNotEmpty) {
                    //Se agregan los roles actualizados
                    updateUsuario.roles.clear();
                    for (var i = 0; i < listRoles.length; i++) {
                      final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(listRoles[i])).build().findUnique(); //Se recupera el rol del Usuario
                      if (nuevoRol != null) {
                        updateUsuario.roles.add(nuevoRol);
                      }
                    } 
                    //Se asiga el rol actual que ocupará
                    final rolActual = dataBase.rolesBox.query(Roles_.idDBR.equals(listRoles[0])).build().findUnique(); //Se recupera el rol actual del Usuario
                    if (rolActual != null) {
                      updateUsuario.rol.target = rolActual;
                    }
                    dataBase.usuariosBox.put(updateUsuario);
                    return true;
                  } else {
                    snackbarKey.currentState?.showSnackBar(const SnackBar(
                      content: Text("No se pudieron actualizar los roles del Usuario en Servidor."),
                    ));
                    return false;
                  }
                }
              default:
                return false;
            } 
           case 400:
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("Correo electrónico y/o contraseña incorrectos."),
            ));
            usuarioExit = true;
            return false;
          case 401:
            //Se actualiza Usuario archivado en Pocketbase y objectBox
            final updateUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(prefs.getString("userId")!)).build().findUnique();
            if (updateUsuario != null) {
              final recordUsuario = await client.records.
                getFullList('emi_users', batch: 200,
                filter: "id='${updateUsuario.idDBR}'");
              if (recordUsuario.isNotEmpty) {
                // Se actualiza el usuario con éxito
                updateUsuario.archivado = true;
                dataBase.usuariosBox.put(updateUsuario); 
              }
            }
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("El usuario se encuentra archivado, comuníquese con el Administrador."),
            ));
            usuarioExit = true;
            return false;
          default:
            snackbarKey.currentState?.showSnackBar(const SnackBar(
              content: Text("Falló al conectarse con el servidor Emi Web."),
            ));
            return false;
        }
      } else {
        snackbarKey.currentState?.showSnackBar(const SnackBar(
          content: Text("Falló al recuperar usuario de forma local."),
        ));
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    final usuarioActual = dataBase.usuariosBox.query(Usuarios_.correo.equals(prefs.getString("userId")!)).build().findUnique();
    if (usuarioActual != null) {
      // Se recupera el Usuario Actual del dispositivo
      if (await getTokenOAuth()) {
        for (var i = 0; i < instruccionesBitacora.length; i++) {
          print("Tamaño instrucciones Emi Web: ${instruccionesBitacora.length}");
          print("Instrucción a realizar en Emi Web: ${instruccionesBitacora[i].instruccion}");
          switch (instruccionesBitacora[i].instruccion) {
            case "syncAddImagenUsuario":
              print("Entro al caso de syncAddImagenUsuario Emi Web");
              if(!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró la imagen y se puede agregar
                  final boolSyncAddImagenUsuario = await syncAddImagenUsuario(imagenToSync, instruccionesBitacora[i]);
                  if (boolSyncAddImagenUsuario) {
                    banderasExistoSync.add(boolSyncAddImagenUsuario);
                    continue;
                  } else {
                    //Recuperamos la instrucción que no se ejecutó
                    banderasExistoSync.add(boolSyncAddImagenUsuario);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      instruccion: "Agregar Imagen de Perfil Usuario Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    instruccion: "Agregar Imagen de Perfil Usuario Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddEmprendedor":
              print("Entro al caso de syncAddEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
                if(emprendedorToSync != null){
                  //Se encontró al emprendedor y se puede agregar
                  final boolSyncAddEmprendedor = await syncAddEmprendedor(emprendedorToSync, instruccionesBitacora[i]);
                  if (boolSyncAddEmprendedor != null) {
                    if (boolSyncAddEmprendedor) {
                      banderasExistoSync.add(boolSyncAddEmprendedor);
                      continue;
                    } else {
                      //Recuperamos la instrucción que no se ejecutó
                      banderasExistoSync.add(boolSyncAddEmprendedor);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: emprendedorToSync.emprendimiento.target!.nombre,
                        instruccion: "Agregar Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    }
                  } else {
                    //Recuperamos la instrucción que no se ejecutó
                    banderasExistoSync.add(false);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      emprendimiento: emprendedorToSync.emprendimiento.target!.nombre,
                      instruccion: "El emprendedor ya se encuentra registrado en Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddEmprendimiento":
              print("Entro al caso de syncAddEmprendimiento Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
                if(emprendimientoToSync != null){
                  //Se encontró al emprendimiento y se puede agregar
                  final boolSyncAddEmprendimiento = syncAddEmprendimiento(instruccionesBitacora[i]);
                  if (boolSyncAddEmprendimiento) {
                    banderasExistoSync.add(boolSyncAddEmprendimiento);
                    continue;
                  } else {
                    //Recuperamos la instrucción que no se ejecutó
                    banderasExistoSync.add(boolSyncAddEmprendimiento);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      emprendimiento: emprendimientoToSync.nombre,
                      instruccion: "Agregar Emprendimiento Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Emprendimiento Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddJornada1":
              print("Entro al caso de syncAddJornada1 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede agregar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddJornada1 = await syncAddJornada1(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddJornada1) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Jornada 1 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Jornada 1 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddJornada2":
              print("Entro al caso de syncAddJornada2 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede agregar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddJornada2 = await syncAddJornada2(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddJornada2) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Jornada 2 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Jornada 2 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddImagenJornada2":
              print("Entro al caso de syncAddImagenJornada2 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target?.emprendimiento.target?.nombre;
                  var caseSyncAddImagenJornada2 = await syncAddImagenJornada2(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddImagenJornada2) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Imagen Jornada 2 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Imagen Jornada 2 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddJornada3":
              print("Entro al caso de syncAddJornada3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede agregar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddJornada3 = await syncAddJornada3(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddJornada3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddImagenJornada3":
              print("Entro al caso de syncAddImagenJornada3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target?.emprendimiento.target?.nombre;
                  var caseSyncAddImagenJornada3 = await syncAddImagenJornada3(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddImagenJornada3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Imagen Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Imagen Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddProductoInversionJ3":
              print("Entro al caso de syncAddProductoInversionJ3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final prodSolicitadoToSync = getFirstProdSolicitado(dataBase.productosSolicitadosBox.getAll(), instruccionesBitacora[i].id);
                if(prodSolicitadoToSync != null){
                  //Se encontró al producto de la inversión J3 y se puede agregar
                  final nombreEmprendimiento = prodSolicitadoToSync.inversion.target!.emprendimiento.target!.nombre;
                  var caseSyncAddProductoInversionJ3 = await syncAddProductoInversionJ3(prodSolicitadoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddProductoInversionJ3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Producto Inversión Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Producto Inversión Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateProductoInversionJ3":
              print("Entro al caso de syncUpdateProductoInversionJ3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final prodSolicitadoToSync = getFirstProdSolicitado(dataBase.productosSolicitadosBox.getAll(), instruccionesBitacora[i].id);
                if(prodSolicitadoToSync != null){
                  //Se encontró al producto de la inversión J3 y se puede actualizar
                  final nombreEmprendimiento = prodSolicitadoToSync.inversion.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateProductoInversionJ3 = await syncUpdateProductoInversionJ3(prodSolicitadoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateProductoInversionJ3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Producto Inversión Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Producto Inversión Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddJornada4":
              print("Entro al caso de syncAddJornada4 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede agregar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddJornada4 = await syncAddJornada4(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddJornada4) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Jornada 4 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Jornada 4 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddImagenJornada4":
              print("Entro al caso de syncAddImagenJornada4 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target?.emprendimiento.target?.nombre;
                  var caseSyncAddImagenJornada4 = await syncAddImagenJornada4(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddImagenJornada4) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Imagen Jornada 4 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Imagen Jornada 4 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddConsultoria":
              print("Entro al caso de syncAddConsultoria Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
                if(consultoriaToSync != null){
                  //Se encontró a la consultoría y se puede agregar
                  final nombreEmprendimiento = consultoriaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddConsultoria = await syncAddConsultoria(consultoriaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddConsultoria) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Consultoría Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Consultoría Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddProductoEmprendedor":
              print("Entro al caso de syncAddProductoEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final productoEmpToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
                if(productoEmpToSync != null){
                  //Se encontró el producto Emp y se puede agregar
                  final nombreEmprendimiento = productoEmpToSync.emprendimientos.target!.nombre;
                  var caseSyncAddProductoEmp = await syncAddProductoEmprendedor(productoEmpToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddProductoEmp) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Producto Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Producto Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddImagenProductoEmprendedor":
              print("Entro al caso de syncAddImagenProductoEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.productosEmp.target?.emprendimientos.target?.nombre;
                  var caseSyncAddImagenProdEmprendedor = await syncAddImagenProductoEmprendedor(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddImagenProdEmprendedor) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Imagen del Producto Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Imagen del Producto Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddVenta":
              print("Entro al caso de syncAddVenta Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
                if(ventaToSync != null){
                  //Se encontró la venta y se puede agregar
                  final nombreEmprendimiento = ventaToSync.emprendimiento.target!.nombre;
                  var caseSyncAddVenta = await syncAddVenta(ventaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddVenta) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Venta Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Venta Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddProductoVendido":
            if (!instruccionesBitacora[i].executeEmiWeb) {
                final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
                if(prodVendidoToSync != null){
                  //Se encontró el producto Vendido y se puede agregar
                  final nombreEmprendimiento = prodVendidoToSync.venta.target?.emprendimiento.target?.nombre;
                  var caseSyncAddProductoVendido = await syncAddProductoVendido(prodVendidoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddProductoVendido) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Producto Vendido Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Producto Vendido Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddSingleProductoVendido":
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
                if(prodVendidoToSync != null){
                  //Se encontró el producto Vendido y se puede agregar
                  final nombreEmprendimiento = prodVendidoToSync.venta.target?.emprendimiento.target?.nombre;
                  var caseSyncAddSingleProductoVendido = await syncAddSingleProductoVendido(prodVendidoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddSingleProductoVendido) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar un Producto Vendido en Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar un Producto Vendido en Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddInversion":
              print("Entro al caso de syncAddInversion Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
                if(inversionToSync != null){
                  //Se encontró la inversión y se puede agregar
                  final nombreEmprendimiento = inversionToSync.emprendimiento.target!.nombre;
                  var caseSyncAddInversion = await syncAddInversion(inversionToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddInversion) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Inversión Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Inversión Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateUsuario":
              print("Entro al caso de syncUpdateUsuario Emi Web");
              final usuarioToSync = getFirstUsuario(dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
              if(usuarioToSync != null){
                //Se encontró al usuario y se puede actualizar
                final boolSyncUpdateUsuario = await syncUpdateUsuario(usuarioToSync, instruccionesBitacora[i]);
                if (boolSyncUpdateUsuario) {
                  banderasExistoSync.add(boolSyncUpdateUsuario);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncUpdateUsuario);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    instruccion: "Actualización Datos Usuario Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                //Recuperamos la instrucción que no se ejecutó
                banderasExistoSync.add(false);
                final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: "Actualización Datos Usuario Emi Web", 
                  fecha: instruccionesBitacora[i].fechaRegistro);
                instruccionesFallidas.add(instruccionNoSincronizada);
                continue;
              }
            case "syncUpdateImagenUsuario":
              print("Entro al caso de syncUpdateImagenUsuario Emi Web");
              if(!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró la imagen y se puede actualizar
                  final boolSyncUpdateUsuario = await syncUpdateImagenUsuario(imagenToSync, instruccionesBitacora[i]);
                  if (boolSyncUpdateUsuario) {
                    banderasExistoSync.add(boolSyncUpdateUsuario);
                    continue;
                  } else {
                    //Recuperamos la instrucción que no se ejecutó
                    banderasExistoSync.add(boolSyncUpdateUsuario);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      instruccion: "Actualización Imagen de Perfil Usuario Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    instruccion: "Actualización Imagen de Perfil Usuario Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateFaseEmprendimiento":
              print("Entro al caso de syncUpdateFaseEmprendimiento Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
                if(emprendimientoToSync != null){
                  //Se encontró fase del emprendimiento y se puede actualizar
                  final nombreEmprendimiento = emprendimientoToSync.nombre;
                  var caseSyncUpdateFaseEmprendimiento = await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateFaseEmprendimiento) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateEmprendedor":
              print("Entro al caso de syncUpdateEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
                if(emprendedorToSync != null){
                  //Se encontró el emprendedor y se puede actualizar
                  final nombreEmprendimiento = emprendedorToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateEmprendedor = await syncUpdateEmprendedor(emprendedorToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateEmprendedor) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateEmprendimiento":
              print("Entro al caso de syncUpdateEmprendimiento Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
                if(emprendimientoToSync != null){
                  //Se encontró al emprendimiento y se puede actualizar
                  final nombreEmprendimiento = emprendimientoToSync.nombre;
                  var caseSyncUpdateEmprendimiento = await syncUpdateEmprendimiento(emprendimientoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateEmprendimiento) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Emprendimiento Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Emprendimiento Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateJornada1":
              print("Entro al caso de syncUpdateJornada1 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede actualizar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateJornada1 = await syncUpdateJornada1(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateJornada1) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Jornada 1 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Jornada 1 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateJornada2":
              print("Entro al caso de syncUpdateJornada2 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede actualizar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateJornada2 = await syncUpdateJornada2(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateJornada2) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Jornada 2 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Jornada 2 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateImagenJornada2":
              print("Entro al caso de syncUpdateImagenJornada2 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateImagenJornada2 = await syncUpdateImagenJornada2(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateImagenJornada2) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualizar Imagen Jornada 2 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualizar Imagen Jornada 2 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateJornada3":
              print("Entro al caso de syncUpdateJornada3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede actualizar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateJornada3 = await syncUpdateJornada3(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateJornada3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateImagenJornada3":
              print("Entro al caso de syncUpdateImagenJornada3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede agregar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateImagenJornada3 = await syncUpdateImagenJornada3(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateImagenJornada3) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualizar Imagen Jornada 3 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualizar Imagen Jornada 3 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateJornada4":
              print("Entro al caso de syncUpdateJornada4 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
                if(jornadaToSync != null){
                  //Se encontró a la jornada y se puede actualizar
                  final nombreEmprendimiento = jornadaToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateJornada4 = await syncUpdateJornada4(jornadaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateJornada4) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Jornada 4 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Jornada 4 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateImagenJornada4":
              print("Entro al caso de syncUpdateImagenJornada4 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede actualizar
                  final nombreEmprendimiento = imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateImagenJornada4 = await syncUpdateImagenJornada4(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateImagenJornada4) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualizar Imagen Jornada 4 Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualizar Imagen Jornada 4 Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateEstadoInversion":
              print("Entro al caso de syncUpdateEstadoInversion Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
                if(inversionToSync != null){
                  //Se encontró la inversión y se puede actualizar su estado
                  final nombreEmprendimiento = inversionToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateEstadoInversion = await syncUpdateEstadoInversion(inversionToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateEstadoInversion) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualizar Estado Inversión Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualizar Estado Inversión Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateTareaConsultoria":
              print("Entro al caso de syncUpdateTareaConsultoria Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
                if(tareaToSync != null){
                  //Se encontró la tarea y se puede agregar a la consultoría
                  final nombreEmprendimiento = tareaToSync.consultoria.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateTareaConsultoria = await syncUpdateTareaConsultoria(tareaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateTareaConsultoria) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Tarea Consultoría Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Tarea Consultoría Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateProductoEmprendedor":
              print("Entro al caso de syncUpdateProductoEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final productoEmprendedorToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
                if(productoEmprendedorToSync != null){
                  //Se encontró el producto emprendedor y se puede actualizar
                  final nombreEmprendimiento = productoEmprendedorToSync.emprendimientos.target!.nombre;
                  var caseSyncUpdateProductoEmprendedor = await syncUpdateProductoEmprendedor(productoEmprendedorToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateProductoEmprendedor) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Producto Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Producto Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateImagenProductoEmprendedor":
              print("Entro al caso de syncUpdateImagenProductoEmprendedor Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
                if(imagenToSync != null){
                  //Se encontró a la imagen y se puede actualizar
                  final nombreEmprendimiento = imagenToSync.productosEmp.target?.emprendimientos.target?.nombre;
                  var caseSyncUpdateImagenProdEmprendedor = await syncUpdateImagenProductoEmprendedor(imagenToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateImagenProdEmprendedor) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Imagen del Producto Emprendedor Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Imagen del Producto Emprendedor Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateVenta":
              print("Entro al caso de syncUpdateVenta Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
                if(ventaToSync != null){
                  //Se encontró la venta y se puede actualizar
                  final nombreEmprendimiento = ventaToSync.emprendimiento.target!.nombre;
                  var caseUpdateVenta = await syncUpdateVenta(ventaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseUpdateVenta) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Venta Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Venta Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateProductoVendido":
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
                if(prodVendidoToSync != null){
                  //Se encontró el producto vendido y se puede actualizar
                  final nombreEmprendimiento = prodVendidoToSync.venta.target!.emprendimiento.target!.nombre;
                  var caseSyncUpdateProductoVendido = await syncUpdateProductoVendido(prodVendidoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateProductoVendido) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Producto Vendido Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Producto Vendido Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncUpdateProductosVendidosVenta":
              print("Entro al caso de syncUpdateProductosVendidosVenta Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
                if(ventaToSync != null){
                  //Se encontró la venta y se puede actualizar
                  final nombreEmprendimiento = ventaToSync.emprendimiento.target!.nombre;
                  var caseSyncUpdateProductosVendidosVenta = await syncUpdateProductosVendidosVenta(ventaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncUpdateProductosVendidosVenta) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Actualización Productos Vendidos Venta Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Actualización Productos Vendidos Venta Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncDeleteImagenJornada":
              print("Entro al caso de syncDeleteImagenJornada Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final nombreEmprendimiento = instruccionesBitacora[i].emprendimiento;
                var caseSyncDeleteImagenJornada = await syncDeleteImagenJornada(instruccionesBitacora[i], usuarioActual.idEmiWeb);
                switch (caseSyncDeleteImagenJornada) {
                  case 0:
                    banderasExistoSync.add(false);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      emprendimiento: nombreEmprendimiento,
                      instruccion: "Eliminar ${instruccionesBitacora[i].instruccionAdicional} Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  case 1:
                    banderasExistoSync.add(true);
                    continue;
                  case 2:
                    await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                    i = instruccionesBitacora.length;
                    snackbarKey.currentState?.showSnackBar(SnackBar(
                      content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                    ));
                    continue;
                  default:
                    continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncDeleteProductoInversionJ3":
              print("Entro al caso de syncDeleteProductoInversionJ3 Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final nombreEmprendimiento = instruccionesBitacora[i].emprendimiento;
                var caseSyncDeleteProductoInversionJ3 = await syncDeleteProductoInversionJ3(instruccionesBitacora[i], usuarioActual.idEmiWeb);
                switch (caseSyncDeleteProductoInversionJ3) {
                  case 0:
                    banderasExistoSync.add(false);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      emprendimiento: nombreEmprendimiento,
                      instruccion: "Eliminar Producto Inversión Jornada 3 Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  case 1:
                    banderasExistoSync.add(true);
                    continue;
                  case 2:
                    await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                    i = instruccionesBitacora.length;
                    snackbarKey.currentState?.showSnackBar(SnackBar(
                      content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                    ));
                    continue;
                  default:
                    continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncDeleteProductoVendido":
              print("Entro al caso de syncDeleteProductoVendido Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final nombreEmprendimiento = instruccionesBitacora[i].emprendimiento;
                var caseSyncDeleteProductoVendido = await syncDeleteProductoVendido(instruccionesBitacora[i], usuarioActual.idEmiWeb);
                switch (caseSyncDeleteProductoVendido) {
                  case 0:
                    banderasExistoSync.add(false);
                    final instruccionNoSincronizada = InstruccionNoSincronizada(
                      emprendimiento: nombreEmprendimiento,
                      instruccion: "Eliminar Producto Vendido Emi Web", 
                      fecha: instruccionesBitacora[i].fechaRegistro);
                    instruccionesFallidas.add(instruccionNoSincronizada);
                    continue;
                  case 1:
                    banderasExistoSync.add(true);
                    continue;
                  case 2:
                    await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                    i = instruccionesBitacora.length;
                    snackbarKey.currentState?.showSnackBar(SnackBar(
                      content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                    ));
                    continue;
                  default:
                    continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncArchivarEmprendimiento":
              print("Entro al caso de syncArchivarEmprendimiento Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
                if(emprendimientoToSync != null){
                  //Se encontró el emprendimiento y se puede archivar
                  final nombreEmprendimiento = emprendimientoToSync.nombre;
                  var caseSyncArchivarEmprendimiento = await syncArchivarEmprendimiento(emprendimientoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncArchivarEmprendimiento) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Archivar Emprendimiento Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Archivar Emprendimiento Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncDesarchivarEmprendimiento":
              print("Entro al caso de syncDesarchivarEmprendimiento Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
                if(emprendimientoToSync != null){
                  //Se encontró el emprendimiento y se puede desarchivar
                  final nombreEmprendimiento = emprendimientoToSync.nombre;
                  var caseSyncDesarchivarEmprendimiento = await syncDesarchivarEmprendimiento(emprendimientoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncDesarchivarEmprendimiento) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Desarchivar Emprendimiento Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Desarchivar Emprendimiento Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncArchivarConsultoria":
              print("Entro al caso de syncArchivarConsultoria Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
                if(consultoriaToSync != null){
                  //Se encontró la consultoría y se puede archivar
                  final nombreEmprendimiento = consultoriaToSync.emprendimiento.target!.nombre;
                  var caseSyncArchivarConsultoria = await syncArchivarConsultoria(consultoriaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncArchivarConsultoria) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Archivar Consultoría Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Archivar Consultoría Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncDesarchivarConsultoria":
              print("Entro al caso de syncDesarchivarConsultoria Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
                if(consultoriaToSync != null){
                  //Se encontró la consultoría y se puede desarchivar
                  final nombreEmprendimiento = consultoriaToSync.emprendimiento.target!.nombre;
                  var caseSyncDesarchivarConsultoria = await syncDesarchivarConsultoria(consultoriaToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncDesarchivarConsultoria) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Desarchivar Consultoría Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Desarchivar Consultoría Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAcceptInversionXProdCotizado":
              print("Entro al caso de syncAcceptInversionXProdCotizado Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final inversionXproductoCotizadoToSync = getFirstInversionXProductosCotizados(dataBase.inversionesXprodCotizadosBox.getAll(), instruccionesBitacora[i].id);
                if(inversionXproductoCotizadoToSync != null){
                  //Se encontró el inversion X producto Cotizado y se puede agregar
                  final nombreEmprendimiento = inversionXproductoCotizadoToSync.inversion.target!.emprendimiento.target!.nombre;
                  var caseSyncAcceptInversionXProductoCotizado = await syncAcceptInversionesXProductosCotizados(inversionXproductoCotizadoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAcceptInversionXProductoCotizado) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Aceptar Inversion por Productos Cotizados Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Aceptar Inversion por Productos Cotizados Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAcceptProdCotizado":
              print("Entro al caso de syncAcceptProdCotizado Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final productoCotizadoToSync = getFirstProductoCotizado(dataBase.productosCotBox.getAll(), instruccionesBitacora[i].id);
                if(productoCotizadoToSync != null){
                  //Se encontró el producto Cotizado y se puede agregar
                  final nombreEmprendimiento = productoCotizadoToSync.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.nombre;
                  var caseSyncAcceptProductoCotizado = await syncAcceptProdCotizado(productoCotizadoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAcceptProductoCotizado) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Aceptar Producto Cotizado Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Aceptar Producto Cotizado Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddImagenesEntregaInversion":
              print("Entro al caso de syncAddImagenesEntregaInversion Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
                if(inversionToSync != null){
                  //Se encontró la inversión y se puede actualizar
                  final nombreEmprendimiento = inversionToSync.emprendimiento.target!.nombre;
                  var caseSyncAddImagenesEntregaInversion = await syncAddImagenesEntregaInversion(inversionToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddImagenesEntregaInversion) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Imagénes Entrega Inversión Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Imagénes Entrega Inversión Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            case "syncAddPagoInversion":
              print("Entro al caso de syncAddPagoInversion Emi Web");
              if (!instruccionesBitacora[i].executeEmiWeb) {
                final pagoToSync = getFirstPago(dataBase.pagosBox.getAll(), instruccionesBitacora[i].id);
                if(pagoToSync != null){
                  //Se encontró el pago y se puede agregar
                  final nombreEmprendimiento = pagoToSync.inversion.target!.emprendimiento.target!.nombre;
                  var caseSyncAddPagoInversion = await syncAddPagoInversion(pagoToSync, instruccionesBitacora[i], usuarioActual.idEmiWeb);
                  switch (caseSyncAddPagoInversion) {
                    case 0:
                      banderasExistoSync.add(false);
                      final instruccionNoSincronizada = InstruccionNoSincronizada(
                        emprendimiento: nombreEmprendimiento,
                        instruccion: "Agregar Pago Inversión Emi Web", 
                        fecha: instruccionesBitacora[i].fechaRegistro);
                      instruccionesFallidas.add(instruccionNoSincronizada);
                      continue;
                    case 1:
                      banderasExistoSync.add(true);
                      continue;
                    case 2:
                      await deleteEmprendimientoLocal(instruccionesBitacora[i].idEmprendimiento);
                      i = instruccionesBitacora.length;
                      snackbarKey.currentState?.showSnackBar(SnackBar(
                        content: Text("El Emprendimiento $nombreEmprendimiento con id Local ${instruccionesBitacora[i].idEmprendimiento} ya no puede ser editado en este dispositivo."),
                      ));
                      continue;
                    default:
                      continue;
                  }
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(false);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: "No encontrado",
                    instruccion: "Agregar Pago Inversión Emi Web",
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
                  continue;
                }
              } else {
                // Ya se ha ejecutado esta instrucción en Emi Web
                banderasExistoSync.add(true);
                continue;
              }
            default:
              continue;
          }
        }
        for (var element in banderasExistoSync) {
          //Aplicamos una operación and para validar que no haya habido una acción con False
          exitoso = exitoso && element;
        }
        //Verificamos que no haya habido errores al sincronizar con las banderas
        if (exitoso) {
          print("Proceso de sync Emi Web exitoso");
          procesocargando = false;
          procesoterminado = true;
          procesoexitoso = true;
          banderasExistoSync.clear();
          notifyListeners();
          return exitoso;
        } else {
          print("Proceso de sync Emi Web fallido");
          procesocargando = false;
          procesoterminado = true;
          procesoexitoso = false;
          banderasExistoSync.clear();
          notifyListeners();
          return exitoso;
        }
      } else {
        print("Proceso de sync Emi Web fallido por Token");
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        banderasExistoSync.clear();
        notifyListeners();
        return false;
      }
    } else {
      //No se pudo recuperar el Usuario Actual del dispositivo
      return false;
    }
  }

  Usuarios? getFirstUsuario(List<Usuarios> usuarios, int idInstruccionesBitacora)
  {
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < usuarios[i].bitacora.length; j++) {
          if (usuarios[i].bitacora[j].id == idInstruccionesBitacora) {
            return usuarios[i];
          } 
        }
      }
    }
    return null;
  }

  Imagenes? getFirstImagen(List<Imagenes> imagenes, int idInstruccionesBitacora)
    {
      for (var i = 0; i < imagenes.length; i++) {
        if (imagenes[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < imagenes[i].bitacora.length; j++) {
            if (imagenes[i].bitacora[j].id == idInstruccionesBitacora) {
              return imagenes[i];
            } 
          }
        }
      }
      return null;
    }

  Emprendedores? getFirstEmprendedor(List<Emprendedores> emprendedores, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendedores.length; i++) {
      if (emprendedores[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendedores[i].bitacora.length; j++) {
          if (emprendedores[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendedores[i];
          } 
        }
      }
    }
    return null;
  }
  Emprendimientos? getFirstEmprendimiento(List<Emprendimientos> emprendimientos, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendimientos.length; i++) {
      if (emprendimientos[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendimientos[i].bitacora.length; j++) {
          if (emprendimientos[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendimientos[i];
          } 
        }
      }
    }
    return null;
  }
  Jornadas? getFirstJornada(List<Jornadas> jornadas, int idInstruccionesBitacora)
  {
    for (var i = 0; i < jornadas.length; i++) {
      if (jornadas[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < jornadas[i].bitacora.length; j++) {
          if (jornadas[i].bitacora[j].id == idInstruccionesBitacora) {
            return jornadas[i];
          } 
        }
      }
    }
    return null;
  }
  Inversiones? getFirstInversion(List<Inversiones> inversiones, int idInstruccionesBitacora)
  {
    for (var i = 0; i < inversiones.length; i++) {
      if (inversiones[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < inversiones[i].bitacora.length; j++) {
          if (inversiones[i].bitacora[j].id == idInstruccionesBitacora) {
            return inversiones[i];
          } 
        }
      }
    }
    return null;
  }
  ProdSolicitado? getFirstProdSolicitado(List<ProdSolicitado> prodSolicitado, int idInstruccionesBitacora)
  {
    for (var i = 0; i < prodSolicitado.length; i++) {
      if (prodSolicitado[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < prodSolicitado[i].bitacora.length; j++) {
          if (prodSolicitado[i].bitacora[j].id == idInstruccionesBitacora) {
            return prodSolicitado[i];
          } 
        }
      }
    }
    return null;
  }
  Consultorias? getFirstConsultoria(List<Consultorias> consultorias, int idInstruccionesBitacora)
  {
    for (var i = 0; i < consultorias.length; i++) {
      if (consultorias[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < consultorias[i].bitacora.length; j++) {
          if (consultorias[i].bitacora[j].id == idInstruccionesBitacora) {
            return consultorias[i];
          } 
        }
      }
    }
    return null;
  }
  ProductosEmp? getFirstProductoEmprendedor(List<ProductosEmp> productosEmp, int idInstruccionesBitacora)
    {
      for (var i = 0; i < productosEmp.length; i++) {
        if (productosEmp[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < productosEmp[i].bitacora.length; j++) {
            if (productosEmp[i].bitacora[j].id == idInstruccionesBitacora) {
              return productosEmp[i];
            } 
          }
        }
      }
      return null;
    }
  Ventas? getFirstVenta(List<Ventas> ventas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < ventas.length; i++) {
        if (ventas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < ventas[i].bitacora.length; j++) {
            if (ventas[i].bitacora[j].id == idInstruccionesBitacora) {
              return ventas[i];
            } 
          }
        }
      }
      return null;
    }
  ProdVendidos? getFirstProductoVendido(List<ProdVendidos> prodVendidos, int idInstruccionesBitacora)
    {
      for (var i = 0; i < prodVendidos.length; i++) {
        if (prodVendidos[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < prodVendidos[i].bitacora.length; j++) {
            if (prodVendidos[i].bitacora[j].id == idInstruccionesBitacora) {
              return prodVendidos[i];
            } 
          }
        }
      }
      return null;
    }
  Tareas? getFirstTarea(List<Tareas> tareas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < tareas.length; i++) {
        if (tareas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < tareas[i].bitacora.length; j++) {
            if (tareas[i].bitacora[j].id == idInstruccionesBitacora) {
              return tareas[i];
            } 
          }
        }
      }
      return null;
    }
  ProdCotizados? getFirstProductoCotizado(List<ProdCotizados> prodCotizados, int idInstruccionesBitacora)
    {
      for (var i = 0; i < prodCotizados.length; i++) {
        if (prodCotizados[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < prodCotizados[i].bitacora.length; j++) {
            if (prodCotizados[i].bitacora[j].id == idInstruccionesBitacora) {
              return prodCotizados[i];
            } 
          }
        }
      }
      return null;
    }
  InversionesXProdCotizados? getFirstInversionXProductosCotizados(List<InversionesXProdCotizados> inversionXprodCotizados, int idInstruccionesBitacora)
    {
      for (var i = 0; i < inversionXprodCotizados.length; i++) {
        if (inversionXprodCotizados[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < inversionXprodCotizados[i].bitacora.length; j++) {
            if (inversionXprodCotizados[i].bitacora[j].id == idInstruccionesBitacora) {
              return inversionXprodCotizados[i];
            } 
          }
        }
      }
      return null;
    }
  Pagos? getFirstPago(List<Pagos> pagos, int idInstruccionesBitacora)
    {
      for (var i = 0; i < pagos.length; i++) {
        if (pagos[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < pagos[i].bitacora.length; j++) {
            if (pagos[i].bitacora[j].id == idInstruccionesBitacora) {
              return pagos[i];
            } 
          }
        }
      }
      return null;
    }

  Future<bool?> syncAddEmprendedor(Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncAddEmprendedor de Emi Web");
    try {
      if (emprendedor.emprendimiento.target!.idEmiWeb == null) {
        //Verificamos que no se haya posteado anteriormente el emprendedor y emprendimiento
        if (emprendedor.idEmiWeb == null) {
          // Primero creamos el emprendedor asociado al emprendimiento
          final crearEmprendedorUri =
            Uri.parse('$baseUrlEmiWebServices/emprendedores/registro/crear');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          final responsePostEmprendedor = await post(crearEmprendedorUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
            "nombreUsuario": "${emprendedor.emprendimiento
            .target!.usuario.target!.nombre} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoP} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "nombre": emprendedor.nombre,
            "apellidos": emprendedor.apellidos,
            "curp": emprendedor.curp,
            "integrantesFamilia": emprendedor.integrantesFamilia,
            "comunidad": emprendedor.comunidad.target!.idEmiWeb,
            "estado": emprendedor.comunidad.target!.municipios.target!.estados.target!.idEmiWeb,
            "municipio": emprendedor.comunidad.target!.municipios.target!.idEmiWeb,
            "emprendimiento": emprendedor.emprendimiento.target!.nombre,
            "telefono": emprendedor.telefono?.replaceAll("-", ""),
            "comentarios": emprendedor.comentarios,
            "fechaRegistro": (DateFormat("yyyy-MM-ddTHH:mm:ss").format(emprendedor.fechaRegistro)).toString(),
            "archivado": false
          }));
          print("Respuesta Post Emprendedor");
          print(responsePostEmprendedor.body);
          switch (responsePostEmprendedor.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Emprendedor");
            //Se recupera el id Emi Web del Emprendedor que será el mismo id para el Emprendimiento
            final responsePostEmprendedorParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostEmprendedor.bodyBytes));
            emprendedor.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendedoresBox.put(emprendedor);
            //Segundo creamos el emprendimiento
            // Recuperamos el id asociado al emprendimiento
            final obtenerEmprendimientoUri =
              Uri.parse('$baseUrlEmiWebServices/proyectos/${emprendedor.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseGetEmprendimiento = await get(obtenerEmprendimientoUri, 
              headers: headers,
            );
            print("Respuesta Get Emprendimiento");
            print(responseGetEmprendimiento.body);     
            switch (responseGetEmprendimiento.statusCode) {
              case 200:
                //Se recupera el id Emi Web del emprendimiento
                final responseGetEmprendimientoParse = getEmprendimientoEmiWebFromMap(
                const Utf8Decoder().convert(responseGetEmprendimiento.bodyBytes));
                //Se agrega el API adicional que indica quién es el Usuario propietario del proyecto
                final actualizarUsuarioUri =
                  Uri.parse('$baseUrlEmiWebServices/proyectos/status?idProyecto=${responseGetEmprendimientoParse.payload!.id}');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePutUsuario = await put(actualizarUsuarioUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuarioRegistra": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "usuarioRegistra": "${emprendedor.emprendimiento
                  .target!.usuario.target!.nombre} ${emprendedor.emprendimiento
                  .target!.usuario.target!.apellidoP} ${emprendedor.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "switchMovil": 1,
                  "idPromotor": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
                }));
                switch(responsePutUsuario.statusCode)
                {
                  case 200:
                    emprendedor.emprendimiento.target!.idEmiWeb = responseGetEmprendimientoParse.payload!.id.toString();
                    dataBase.emprendimientosBox.put(emprendedor.emprendimiento.target!);
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return true;
                  default:
                    return false;
                }
              default:
                //No se obtiene con éxito el emprendimiento
                return false;
            }
            case 409:
              return null;
            default: //No se realizo con éxito el post
              print("Error en postear emprendedor Emi Web");
              return false;
          }       
        } else {
          // Recuperamos el id asociado al emprendimiento
          final obtenerEmprendimientoUri =
            Uri.parse('$baseUrlEmiWebServices/proyectos/${emprendedor.idEmiWeb}');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          final responseGetEmprendimiento = await get(obtenerEmprendimientoUri, 
            headers: headers,
          );
          print("Respuesta Get Emprendimiento");
          print(responseGetEmprendimiento.body);     
          switch (responseGetEmprendimiento.statusCode) {
            case 200:
              //Se recupera el id Emi Web del emprendimiento
              final responseGetEmprendimientoParse = getEmprendimientoEmiWebFromMap(
              const Utf8Decoder().convert(responseGetEmprendimiento.bodyBytes));
              //Se agrega el API adicional que indica quién es el Usuario propietario del proyecto
              final actualizarUsuarioUri =
                Uri.parse('$baseUrlEmiWebServices/proyectos/status?idProyecto=${responseGetEmprendimientoParse.payload!.id}');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePutUsuario = await put(actualizarUsuarioUri, 
              headers: headers,
              body: jsonEncode({
                "idUsuarioRegistra": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${emprendedor.emprendimiento
                .target!.usuario.target!.nombre} ${emprendedor.emprendimiento
                .target!.usuario.target!.apellidoP} ${emprendedor.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "switchMovil": 1,
                "idPromotor": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
              }));
              switch(responsePutUsuario.statusCode)
              {
                case 200:
                  emprendedor.emprendimiento.target!.idEmiWeb = responseGetEmprendimientoParse.payload!.id.toString();
                  dataBase.emprendimientosBox.put(emprendedor.emprendimiento.target!);
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return true;
                default:
                  return false;
              }
            default:
              //No se obtiene con éxito el emprendimiento
              return false;
          }
        }
      } else {
        //Se marca como realizada en EmiWeb la instrucción en Bitacora
        bitacora.executeEmiWeb = true;
        dataBase.bitacoraBox.put(bitacora);
        return true;
      }
    } catch (e) { //Fallo en el momento se sincronizar
    print("ERROR - function syncAddEmprendedor(): $e");
      return false;
    }
}

  bool syncAddEmprendimiento(Bitacora bitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se marca como realizada en EmiWeb la instrucción en Bitacora
      bitacora.executeEmiWeb = true;
      dataBase.bitacoraBox.put(bitacora);
      return true;
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }
  }

  Future<int> syncAddJornada1(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddJornada1 de Emi Web");
    // Validamos que se pueda ejecutar la instrucción
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
            if (tareaToSync != null) {
              //Verificamos que no se haya posteado anteriormente la jornada y tarea
              if (jornada.idEmiWeb == null) {
                // Primero creamos la jornada asociada a la tarea
                final crearJornadaUri =
                  Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostJornada = await post(crearJornadaUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
                  "registrarTarea": jornada.tarea.target!.tarea,
                  "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
                  "comentarios": jornada.tarea.target!.comentarios,
                  "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
                  "descripcion": jornada.tarea.target!.descripcion,
                  "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                  "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
                }));
                print("Respuesta Post Jornada 1");
                print(responsePostJornada.body);
                switch (responsePostJornada.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Jornada");
                    //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
                    final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostJornada.bodyBytes));
                    print("Se convierte a utf8 exitosamente");
                    //Se concatena el id recuperado con uuid para que los ids no se repitan
                    final idEmiWebUUid = "${responsePostJornadaParse.payload!.id.toString()}?${uuid.v1()}";
                    jornada.idEmiWeb = idEmiWebUUid;
                    print("Se recupera el idEmiWeb");
                    dataBase.jornadasBox.put(jornada);
                    print("Se hace put a la jornada");
                    //Segundo creamos la Tarea
                    //Se recupera el id Emi Web de la Tarea
                    tareaToSync.idEmiWeb = idEmiWebUUid;
                    dataBase.tareasBox.put(tareaToSync);
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el post
                    print("Error en postear jornada Emi Web");
                    return 0;
                }       
              } else {
                if (tareaToSync.idEmiWeb == null) {
                  //Se concatena el id recuperado con uuid para que los ids no se repitan
                  print("Se hace put a la jornada");
                  //Segundo creamos la Tarea
                  //Se recupera el id Emi Web de la Tarea
                  tareaToSync.idEmiWeb = jornada.idEmiWeb;
                  dataBase.tareasBox.put(tareaToSync);
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              //No existe una tarea asociada a la jornada de forma local
              print("No existe una tarea asociada a la jornada de forma local");
              return 0;
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddJornada1: $e");
            return 0;
          }     
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
}

  Future<int> syncAddJornada2(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddJornada2 de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
            if (tareaToSync != null) {
              //Verificamos que no se haya posteado anteriormente la jornada y tarea
              if (jornada.idEmiWeb == null) {
                // Primero creamos la jornada asociada a la tarea
                final crearJornadaUri =
                  Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostJornada = await post(crearJornadaUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
                  "registrarTarea": jornada.tarea.target!.tarea,
                  "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
                  "comentarios": jornada.tarea.target!.comentarios,
                  "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
                  "descripcion": jornada.tarea.target!.descripcion,
                  "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                  "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
                }));
                print("Respuesta Post Jornada 2");
                print(responsePostJornada.body);
                switch (responsePostJornada.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Jornada");
                    //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
                    final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostJornada.bodyBytes));
                    //Se concatena el id recuperado con uuid para que los ids no se repitan
                    final idEmiWebUuid = "${responsePostJornadaParse.payload!.id.toString()}?${uuid.v1()}";
                    jornada.idEmiWeb = idEmiWebUuid;
                    dataBase.jornadasBox.put(jornada);
                    print("Se hace put a la jornada");
                    // Segundo creamos y enviamos las imágenes de la jornada
                    for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                      final crearImagenJornadaUri =
                      Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                      headers: headers,
                      body: jsonEncode({
                        "idCatTipoDocumento": "4", //Círculo Empresa
                        "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                        "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                        "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                        "idJornada2": jornada.idEmiWeb!.split("?")[0],
                      }));
                      final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                      const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                      jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                      dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                    }
                    // Tercero creamos la Tarea
                    // Se recupera el id Emi Web de la Tarea
                    tareaToSync.idEmiWeb = idEmiWebUuid;
                    dataBase.tareasBox.put(tareaToSync);
                    print("Se hace put a la tarea");
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el post
                    print("Error en postear jornada Emi Web");
                    return 0;
                }       
              } else {
                if (tareaToSync.idEmiWeb == null) {
                  // Segundo creamos y enviamos las imágenes de la jornada
                  for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                    if (jornada.tarea.target!.imagenes.toList()[i].idEmiWeb == null) {
                      final crearImagenJornadaUri =
                      Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                      headers: headers,
                      body: jsonEncode({
                        "idCatTipoDocumento": "4", //Círculo Empresa
                        "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                        "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                        "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                        "idJornada2": jornada.idEmiWeb!.split("?")[0],
                      }));
                      final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                      const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                      jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                      dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                    }
                  }
                  // Tercero creamos la Tarea
                  // Se recupera el id Emi Web de la Tarea
                  tareaToSync.idEmiWeb = jornada.idEmiWeb;
                  dataBase.tareasBox.put(tareaToSync);
                  print("Se hace put a la tarea");
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              //No existe una tarea asociada a la jornada de forma local
              print("No existe una tarea asociada a la jornada de forma local");
              return 0;
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddJornada2: $e");
            return 0;
          }
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
}

  Future<int> syncAddImagenJornada2(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddImagenJornada2() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final crearImagenJornada2Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responsePostAddImagenJornada2 = await post(crearImagenJornada2Uri, 
            headers: headers,
            body: jsonEncode({
              "idCatTipoDocumento": "4", //Círculo Empresa
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idJornada2": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responsePostAddImagenJornada2.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Add Imagen Usuario");
                //Se recupera el id Emi Web
                final responsePostImagenUsuarioParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostAddImagenJornada2.bodyBytes));
                imagen.idEmiWeb = responsePostImagenUsuarioParse.payload.idDocumento.toString();
                dataBase.imagenesBox.put(imagen);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el post
                print("Error en agregar imagen jornada 2 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncAddImagenJornada2(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddJornada3(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddJornada3 de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
            if (tareaToSync != null) {
              //Verificamos que no se haya posteado anteriormente la jornada y tarea
              if (jornada.idEmiWeb == null) {
                // Primero creamos la jornada asociada a la tarea
                final crearJornadaUri =
                  Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostJornada = await post(crearJornadaUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
                  "registrarTarea": jornada.tarea.target!.tarea,
                  "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
                  "comentarios": jornada.tarea.target!.comentarios,
                  "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
                  "descripcion": jornada.tarea.target!.descripcion,
                  "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                  "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
                }));
                switch (responsePostJornada.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Jornada");
                    //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
                    final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostJornada.bodyBytes));
                    //Se concatena el id recuperado con uuid para que los ids no se repitan
                    final idEmiWebUUid = "${responsePostJornadaParse.payload!.id.toString()}?${uuid.v1()}";
                    jornada.idEmiWeb = idEmiWebUUid;
                    dataBase.jornadasBox.put(jornada);
                    //Segundo actualizamos el tipo de proyecto del emprendimiento
                    final updateTipoProyectoEmprendimientoUri =
                    Uri.parse('$baseUrlEmiWebServices/proyectos/catProyectos/');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responseUpdateTipoProyectoEmprendimiento = await put(updateTipoProyectoEmprendimientoUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idUsuarioRegistra": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                      "usuarioRegistra": "${jornada.emprendimiento
                      .target!.usuario.target!.nombre} ${jornada.emprendimiento
                      .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                      .target!.usuario.target!.apellidoM}",
                      "id": jornada.emprendimiento.target!.idEmiWeb,
                      "idCatProyecto": jornada.emprendimiento.target!.catalogoProyecto.target!.idEmiWeb,
                      "idCatTipoProyecto": jornada.emprendimiento.target!.catalogoProyecto.target!.tipoProyecto.target!.idEmiWeb,
                    }));
                    switch (responseUpdateTipoProyectoEmprendimiento.statusCode) {
                      case 200:
                        // Tercero creamos y enviamos las imágenes de la jornada
                        print("Caso 200 en Emi Web Actualización Tipo de Proyecto");
                        for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                          final crearImagenJornadaUri =
                          Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                          final headers = ({
                            "Content-Type": "application/json",
                            'Authorization': 'Bearer $tokenGlobal',
                          });
                          final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                          headers: headers,
                          body: jsonEncode({
                            "idCatTipoDocumento": "5", //Análisis Financiero
                            "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                            "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                            "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                            "idJornada3": jornada.idEmiWeb!.split("?")[0],
                          }));
                          final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                          const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                          jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                          dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                        }
                        // Cuarto creamos y enviamos los productos de la inversión asociada
                        final inversionJornada3 = dataBase.inversionesBox.get(jornada.emprendimiento.target?.idInversionJornada ?? -1);
                        if(inversionJornada3 != null) {
                          for (var i = 0; i < inversionJornada3.prodSolicitados.toList().length; i++) {
                            if (inversionJornada3.prodSolicitados.toList()[i].idEmiWeb == null) {
                              if (inversionJornada3.prodSolicitados.toList()[i].imagen.target != null) {
                                //El producto tiene imagen asociada
                                final crearProductoProyectoUri =
                                Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
                                final headers = ({
                                  "Content-Type": "application/json",
                                  'Authorization': 'Bearer $tokenGlobal',
                                });
                                final responsePostProductoProyecto = await post(crearProductoProyectoUri, 
                                headers: headers,
                                body: jsonEncode({
                                  "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                                  "nombreUsuario": "${jornada.emprendimiento
                                    .target!.usuario.target!.nombre} ${jornada.emprendimiento
                                    .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                                    .target!.usuario.target!.apellidoM}",
                                  "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                                  "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                                  "marcaRecomendada": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                                  "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                                  "costoEstimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                                  "proveedorSugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                                  "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                                  "idFamilia": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idEmiWeb,
                                  "unidadMedida": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb, //TODO: Posible falla en sincronización, Unidad medida-Tipo empaque
                                }));
                                final responsePostProductoProyectoParse = postRegistroExitosoEmiWebFromMap(
                                const Utf8Decoder().convert(responsePostProductoProyecto.bodyBytes));
                                inversionJornada3.prodSolicitados.toList()[i].idEmiWeb = responsePostProductoProyectoParse.payload!.id.toString();
                                dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                              } else {
                                //El producto no tiene imagen asociada
                                final crearProductoProyectoUri =
                                Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
                                final headers = ({
                                  "Content-Type": "application/json",
                                  'Authorization': 'Bearer $tokenGlobal',
                                });
                                final responsePostProductoProyecto = await post(crearProductoProyectoUri, 
                                headers: headers,
                                body: jsonEncode({
                                  "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                                  "nombreUsuario": "${jornada.emprendimiento
                                    .target!.usuario.target!.nombre} ${jornada.emprendimiento
                                    .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                                    .target!.usuario.target!.apellidoM}",
                                  "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                                  "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                                  "marcaRecomendada": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                                  "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                                  "costoEstimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                                  "proveedorSugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                                  "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                                  "idFamilia": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idEmiWeb,
                                  "unidadMedida": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb,
                                }));
                                final responsePostProductoProyectoParse = postRegistroExitosoEmiWebFromMap(
                                const Utf8Decoder().convert(responsePostProductoProyecto.bodyBytes));
                                inversionJornada3.prodSolicitados.toList()[i].idEmiWeb = responsePostProductoProyectoParse.payload!.id.toString();
                                dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                              }
                            }
                          }
                          //Se recupera el id Emi Web de la Tarea
                          tareaToSync.idEmiWeb = idEmiWebUUid;
                          dataBase.tareasBox.put(tareaToSync);
                          //Se marca como realizada en EmiWeb la instrucción en Bitacora
                          bitacora.executeEmiWeb = true;
                          dataBase.bitacoraBox.put(bitacora);
                          return 1;
                        } else {
                          //No se recupera la inversión de la Jornada 3
                          return 0;
                        }
                      default: //No se realizo con éxito el post
                        print("Error en actualizar tipo proyecto de emprendimiento");
                        return 0;
                    } 
                  default: //No se realizo con éxito el post
                    print("Error en postear jornada Emi Web");
                    return 0;
                }       
              } else {
                if (tareaToSync.idEmiWeb == null) {
                  //Segundo actualizamos el tipo de proyecto del emprendimiento
                  final updateTipoProyectoEmprendimientoUri =
                  Uri.parse('$baseUrlEmiWebServices/proyectos/catProyectos/');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responseUpdateTipoProyectoEmprendimiento = await put(updateTipoProyectoEmprendimientoUri, 
                  headers: headers,
                  body: jsonEncode({
                    "idUsuarioRegistra": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                    "usuarioRegistra": "${jornada.emprendimiento
                    .target!.usuario.target!.nombre} ${jornada.emprendimiento
                    .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                    .target!.usuario.target!.apellidoM}",
                    "id": jornada.emprendimiento.target!.idEmiWeb,
                    "idCatProyecto": jornada.emprendimiento.target!.catalogoProyecto.target!.idEmiWeb,
                    "idCatTipoProyecto": jornada.emprendimiento.target!.catalogoProyecto.target!.tipoProyecto.target!.idEmiWeb,
                  }));
                  switch (responseUpdateTipoProyectoEmprendimiento.statusCode) {
                    case 200:
                      // Tercero creamos y enviamos las imágenes de la jornada
                      print("Caso 200 en Emi Web Actualización Tipo de Proyecto");
                      for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                        if (jornada.tarea.target!.imagenes.toList()[i].idEmiWeb == null) {
                          final crearImagenJornadaUri =
                          Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                          final headers = ({
                            "Content-Type": "application/json",
                            'Authorization': 'Bearer $tokenGlobal',
                          });
                          final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                          headers: headers,
                          body: jsonEncode({
                            "idCatTipoDocumento": "5", //Análisis Financiero
                            "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                            "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                            "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                            "idJornada3": jornada.idEmiWeb!.split("?")[0],
                          }));
                          final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                          const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                          jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                          dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                          }
                      }
                      print("Se postean imagenes de jornada");
                      // Cuarto creamos y enviamos los productos de la inversión asociada
                      final inversionJornada3 = dataBase.inversionesBox.get(jornada.emprendimiento.target?.idInversionJornada ?? -1);
                      if(inversionJornada3 != null) {
                        for (var i = 0; i < inversionJornada3.prodSolicitados.toList().length; i++) {
                          if (inversionJornada3.prodSolicitados.toList()[i].idEmiWeb == null) {
                            if (inversionJornada3.prodSolicitados.toList()[i].imagen.target != null) {
                              //El producto tiene imagen asociada
                              final crearProductoProyectoUri =
                              Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
                              final headers = ({
                                "Content-Type": "application/json",
                                'Authorization': 'Bearer $tokenGlobal',
                              });
                              final responsePostProductoProyecto = await post(crearProductoProyectoUri, 
                              headers: headers,
                              body: jsonEncode({
                                "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                                "nombreUsuario": "${jornada.emprendimiento
                                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                                  .target!.usuario.target!.apellidoM}",
                                "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                                "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                                "marcaRecomendada": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                                "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                                "costoEstimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                                "proveedorSugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                                "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                                "idFamilia": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idEmiWeb,
                                "unidadMedida": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb,
                              }));
                              final responsePostProductoProyectoParse = postRegistroExitosoEmiWebFromMap(
                              const Utf8Decoder().convert(responsePostProductoProyecto.bodyBytes));
                              inversionJornada3.prodSolicitados.toList()[i].idEmiWeb = responsePostProductoProyectoParse.payload!.id.toString();
                              dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                            } else {
                              //El producto no tiene imagen asociada
                              final crearProductoProyectoUri =
                              Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
                              final headers = ({
                                "Content-Type": "application/json",
                                'Authorization': 'Bearer $tokenGlobal',
                              });
                              final responsePostProductoProyecto = await post(crearProductoProyectoUri, 
                              headers: headers,
                              body: jsonEncode({
                                "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                                "nombreUsuario": "${jornada.emprendimiento
                                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                                  .target!.usuario.target!.apellidoM}",
                                "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                                "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                                "marcaRecomendada": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                                "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                                "costoEstimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                                "proveedorSugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                                "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                                "idFamilia": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idEmiWeb,
                                "unidadMedida": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb,
                              }));
                              print(responsePostProductoProyecto.body);
                              final responsePostProductoProyectoParse = postRegistroExitosoEmiWebFromMap(
                              const Utf8Decoder().convert(responsePostProductoProyecto.bodyBytes));
                              inversionJornada3.prodSolicitados.toList()[i].idEmiWeb = responsePostProductoProyectoParse.payload!.id.toString();
                              dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                            }
                          }
                        } 
                        //Se recupera el id Emi Web de la Tarea
                        tareaToSync.idEmiWeb = jornada.idEmiWeb;
                        dataBase.tareasBox.put(tareaToSync);
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return 1;
                      } else {
                        //No se recupera la inversión de la Jornada 3
                        return 0;
                      }
                    default: //No se realizo con éxito el post
                      print("Error en actualizar tipo proyecto de emprendimiento");
                      return 0;
                  } 
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              //No existe una tarea asociada a la jornada de forma local
              print("No existe una tarea asociada a la jornada de forma local");
              return 0;
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddJornada3: $e");
            return 0;
          }
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
}

  Future<int> syncAddImagenJornada3(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddImagenJornada3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final crearImagenJornada3Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responsePostAddImagenJornada3 = await post(crearImagenJornada3Uri, 
            headers: headers,
            body: jsonEncode({
              "idCatTipoDocumento": "5", //Análisis Financiero
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idJornada2": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responsePostAddImagenJornada3.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Add Imagen Jornada 3");
                //Se recupera el id Emi Web
                final responsePostImagenUsuarioParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostAddImagenJornada3.bodyBytes));
                imagen.idEmiWeb = responsePostImagenUsuarioParse.payload.idDocumento.toString();
                dataBase.imagenesBox.put(imagen);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el post
                print("Error en agregar imagen jornada 3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncAddImagenJornada3(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddJornada4(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddJornada4 de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          final listJornadas = jornada.emprendimiento.target!.jornadas.toList();
        try {
          final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (tareaToSync != null) {
            //Verificamos que no se haya posteado anteriormente la jornada y tarea
            if (jornada.idEmiWeb == null) {
              //Antes finalizamos las jornadas previas 
              for (var i = 0; i < listJornadas.length; i++) {
                if (listJornadas[i].numJornada != "4") {
                  final actualizarJornada1Uri =
                    Uri.parse('$baseUrlEmiWebServices/jornadas?id=${listJornadas[i].idEmiWeb!.split("?")[0]}&jornada=${listJornadas[i].numJornada}');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responseUpdateJornada = await put(actualizarJornada1Uri, 
                  headers: headers,
                  body: jsonEncode({
                    "idUsuario": listJornadas[i].emprendimiento.target!.usuario.target!.idEmiWeb,
                    "nombreUsuario": "${listJornadas[i].emprendimiento
                        .target!.usuario.target!.nombre} ${listJornadas[i].emprendimiento
                        .target!.usuario.target!.apellidoP} ${listJornadas[i].emprendimiento
                        .target!.usuario.target!.apellidoM}",
                    "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(listJornadas[i].fechaRegistro),
                    "registrarTarea": listJornadas[i].tarea.target!.tarea,
                    "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(listJornadas[i].fechaRevision),
                    "comentarios": listJornadas[i].tarea.target!.comentarios,
                    "tareaCompletada": true,
                    "descripcion": listJornadas[i].tarea.target!.descripcion,
                    "idProyecto": listJornadas[i].emprendimiento.target!.idEmiWeb,
                    "nombreEmprendimiento": listJornadas[i].emprendimiento.target!.nombre,
                  }));

                  switch (responseUpdateJornada.statusCode) {
                    case 200:
                    print("Caso 200 en Emi Web Update Jornada");
                      continue;
                    default: //No se realizo con éxito el update
                      print("Error en actualizar jornadas Emi Web");
                      return 0;
                  }  
                }
              }
              // Primero creamos la jornada asociada a la tarea
              final crearJornadaUri =
                Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostJornada = await post(crearJornadaUri, 
              headers: headers,
              body: jsonEncode({
                "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                "nombreUsuario": "${jornada.emprendimiento
                .target!.usuario.target!.nombre} ${jornada.emprendimiento
                .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
                "registrarTarea": jornada.tarea.target!.tarea,
                "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
                "comentarios": jornada.tarea.target!.comentarios,
                "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
                "descripcion": jornada.tarea.target!.descripcion,
                "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
                "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
              }));
              print("Respuesta Post Jornada 4");
              print(responsePostJornada.body);
              switch (responsePostJornada.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Jornada");
                  //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
                  final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
                  const Utf8Decoder().convert(responsePostJornada.bodyBytes));
                  //Se concatena el id recuperado con uuid para que los ids no se repitan
                  final idEmiWebUuid = "${responsePostJornadaParse.payload!.id.toString()}?${uuid.v1()}";
                  jornada.idEmiWeb = idEmiWebUuid;
                  dataBase.jornadasBox.put(jornada);
                  print("Se hace put a la jornada");
                  // Segundo creamos y enviamos las imágenes de la jornada
                  for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                    final crearImagenJornadaUri =
                    Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idCatTipoDocumento": "6", //Convenio
                      "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                      "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                      "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                      "idJornada4": jornada.idEmiWeb!.split("?")[0],
                    }));
                    final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                    jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                    dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                  }
                  // Tercero creamos la Tarea
                  // Se recupera el id Emi Web de la Tarea
                  tareaToSync.idEmiWeb = idEmiWebUuid;
                  dataBase.tareasBox.put(tareaToSync);
                  print("Se hace put a la tarea");
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                default: //No se realizo con éxito el post
                  print("Error en postear jornada Emi Web");
                  return 0;
              }       
            } else {
              if (tareaToSync.idEmiWeb == null) {
                // Segundo creamos y enviamos las imágenes de la jornada
                for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                  if (jornada.tarea.target!.imagenes.toList()[i].idEmiWeb == null) {
                    final crearImagenJornadaUri =
                    Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responsePostImagenJornada = await post(crearImagenJornadaUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idCatTipoDocumento": "6", //Convenio
                      "nombreArchivo": jornada.tarea.target!.imagenes.toList()[i].nombre,
                      "archivo": jornada.tarea.target!.imagenes.toList()[i].base64,
                      "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
                      "idJornada4": jornada.idEmiWeb!.split("?")[0],
                    }));
                    final responsePostImagenJornadaParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostImagenJornada.bodyBytes));
                    jornada.tarea.target!.imagenes.toList()[i].idEmiWeb = responsePostImagenJornadaParse.payload.idDocumento.toString();
                    dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                  }
                }
                // Tercero creamos la Tarea
                // Se recupera el id Emi Web de la Tarea
                tareaToSync.idEmiWeb = jornada.idEmiWeb;
                dataBase.tareasBox.put(tareaToSync);
                print("Se hace put a la tarea");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              } else {
                //Ya se ha posteado anteriormente
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              }
            }
          } else {
            //No existe una tarea asociada a la jornada de forma local
            print("No existe una tarea asociada a la jornada de forma local");
            return 0;
          }
        } catch (e) { //Fallo en el momento se sincronizar
          print("Catch de syncAddJornada4: $e");
          return 0;
        }
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
}

  Future<int> syncAddProductoInversionJ3(ProdSolicitado prodSolicitado, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddProductoInversionJ3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar el post
            final crearProductoProyectoUri =
            Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responsePostProductoProyecto = await post(crearProductoProyectoUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": prodSolicitado.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.nombre} ${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoP} ${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoM}",
              "producto": prodSolicitado.producto,
              "descripcion": prodSolicitado.descripcion,
              "marcaRecomendada": prodSolicitado.marcaSugerida,
              "cantidad": prodSolicitado.cantidad,
              "costoEstimado": prodSolicitado.costoEstimado,
              "proveedorSugerido": prodSolicitado.proveedorSugerido,
              "idProyecto": prodSolicitado.inversion.target!.emprendimiento.target!.idEmiWeb,
              "idFamilia": prodSolicitado.familiaProducto.target!.idEmiWeb,
              "unidadMedida": prodSolicitado.tipoEmpaques.target!.idEmiWeb,
            }));
            switch (responsePostProductoProyecto.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Add Producto Inversion J3");
                //Se recupera el id Emi Web
                final responsePostProductoProyectoParse = postRegistroExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostProductoProyecto.bodyBytes));
                prodSolicitado.idEmiWeb = responsePostProductoProyectoParse.payload!.id.toString();
                dataBase.productosSolicitadosBox.put(prodSolicitado);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el post
                print("Error en agregar producto inversión J3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncAddProductoInversionJ3(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddImagenJornada4(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddImagenJornada4() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final crearImagenJornada4Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responsePostAddImagenJornada4 = await post(crearImagenJornada4Uri, 
            headers: headers,
            body: jsonEncode({
              "idCatTipoDocumento": "6", //Convenio
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idJornada2": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responsePostAddImagenJornada4.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Add Imagen Jornada 4");
                //Se recupera el id Emi Web
                final responsePostImagenUsuarioParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostAddImagenJornada4.bodyBytes));
                imagen.idEmiWeb = responsePostImagenUsuarioParse.payload.idDocumento.toString();
                dataBase.imagenesBox.put(imagen);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el post
                print("Error en agregar imagen jornada 4 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncAddImagenJornada4(): $e');
            return 0;
          }
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
  }


  Future<int> syncAddConsultoria(Consultorias consultoria, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddConsultoria de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final tareaToSync = dataBase.tareasBox.get(consultoria.tareas.first.id);
            if (tareaToSync != null) {
              //Verificamos que no se haya posteado anteriormente la consultoria y tarea
              if (consultoria.idEmiWeb == null) {
                //Creamos la consultoria asociada a la primera tarea creada
                final crearConsultoriaUri =
                  Uri.parse('$baseUrlEmiWebServices/consultorias');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostConsultoria = await post(crearConsultoriaUri, 
                headers: headers,
                body: jsonEncode({   
                  "idUsuario": consultoria.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "nombreUsuario": "${consultoria.emprendimiento
                  .target!.usuario.target!.nombre} ${consultoria.emprendimiento
                  .target!.usuario.target!.apellidoP} ${consultoria.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "idCatAmbito": consultoria.ambitoConsultoria.target!.idEmiWeb,
                  "idCatAreaCirculo": consultoria.areaCirculo.target!.idEmiWeb,
                  "asignarTarea": consultoria.tareas.first.tarea,
                  "proximaVisita": DateFormat("yyyy-MM-dd").format(consultoria.tareas.first.fechaRevision),
                  "idProyecto": consultoria.emprendimiento.target!.idEmiWeb,
                  "archivado": false, //Es falso por que apenas la estamos dando de alta
                  "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(consultoria.tareas.first.fechaRegistro),
                }));
                print(responsePostConsultoria.statusCode);
                print(responsePostConsultoria.body);
                print("Respuesta Post Consultoria");
                switch (responsePostConsultoria.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Consultoría");
                    //Se recupera el id Emi Web de la Consultoría que será el mismo id para la Tarea
                    final responsePostConsultoriaParse = postRegistroExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostConsultoria.bodyBytes));
                    consultoria.idEmiWeb = responsePostConsultoriaParse.payload!.id.toString();
                    dataBase.consultoriasBox.put(consultoria);
                    // Segundo creamos la Tarea
                    // Se recupera el id Emi Web de la Tarea
                    tareaToSync.idEmiWeb = consultoria.idEmiWeb;
                    dataBase.tareasBox.put(tareaToSync);
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el post
                    print("Error en postear consultoría Emi Web");
                    return 0;
                }       
              } else {
                if (tareaToSync.idEmiWeb == null) {
                  // Segundo creamos la Tarea
                  // Se recupera el id Emi Web de la Tarea
                  tareaToSync.idEmiWeb = consultoria.idEmiWeb;
                  dataBase.tareasBox.put(tareaToSync);
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              //No existe una tarea asociada a la consultoría de forma local
              print("No existe una tarea asociada a la consultoría de forma local");
              return 0;
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddConsultoria: $e");
            return 0;
          }
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
}

  Future<int> syncAddProductoEmprendedor(ProductosEmp productoEmp, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddProductoEmprendedor de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final imagenToSync = dataBase.imagenesBox.query(Imagenes_.id.equals(productoEmp.imagen.target?.id ?? -1)).build().findUnique();
            if (imagenToSync != null) {
              print("SÍ HAY IMAGEN ASOCIADA EN EMI WEB");
              //Verificamos que no se haya posteado anteriormente la imagen
              if (imagenToSync.idEmiWeb == null) {
                print("Primer if");
                //Aún no se ha posteado la imagen
                //Primero se postea la imagen
                final crearImagenProductoEmpUri =
                Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostImagenProductoEmp = await post(crearImagenProductoEmpUri, 
                headers: headers,
                body: jsonEncode({
                  "idCatTipoDocumento": "3", //Producto emprendedor
                  "nombreArchivo": imagenToSync.nombre,
                  "archivo": imagenToSync.base64,
                  "idUsuario":productoEmp.emprendimientos.target!.usuario.target!.idEmiWeb,
                }));
                switch (responsePostImagenProductoEmp.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Imagen Producto Emprendedor 1");
                    final responsePostImagenProductoEmpParse = postRegistroImagenExitosoEmiWebFromMap(
                      const Utf8Decoder().convert(responsePostImagenProductoEmp.bodyBytes));
                    imagenToSync.idEmiWeb = responsePostImagenProductoEmpParse.payload.idDocumento.toString();
                    dataBase.imagenesBox.put(imagenToSync);
                    // Segundo creamos el producto Emprendedor
                    print("Id Imagen Emi Web Prod EMPRENDEDOR: ${responsePostImagenProductoEmpParse.payload.idDocumento.toString()}");
                    final crearProductoEmprendedorUri =
                      Uri.parse('$baseUrlEmiWebServices/productos/emprendedores/registro/crear');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responsePostProductoEmprendedor = await post(crearProductoEmprendedorUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idUsuario": productoEmp.emprendimientos.target!.usuario.target!.idEmiWeb,
                      "nombreUsuario": "${productoEmp.emprendimientos
                      .target!.usuario.target!.nombre} ${productoEmp.emprendimientos
                      .target!.usuario.target!.apellidoP} ${productoEmp.emprendimientos
                      .target!.usuario.target!.apellidoM}",
                      "idEmprendedor": productoEmp.emprendimientos.target!.emprendedor.target!.idEmiWeb,
                      "producto": productoEmp.nombre,
                      "idEmprendimiento": productoEmp.emprendimientos.target!.idEmiWeb,
                      "idUnidadMedida": productoEmp.unidadMedida.target!.idEmiWeb,
                      "idDocumento": responsePostImagenProductoEmpParse.payload.idDocumento.toString(),
                      "descripcion": productoEmp.descripcion,
                      "costoUnidadMedida": productoEmp.costo,
                    }));
                    switch (responsePostProductoEmprendedor.statusCode) {
                      case 200:
                        print("Caso 200 en Emi Web Producto Emprendedor 1");
                        //Tercero se recupera el id Emi Web del Producto Emprendedor
                        final responsePostProductoEmprendedorParse = postRegistroExitosoEmiWebSingleFromMap(
                          const Utf8Decoder().convert(responsePostProductoEmprendedor.bodyBytes));
                        //Se necesita hacer este paso para actualizar la información
                        productoEmp.idEmiWeb = responsePostProductoEmprendedorParse.payload.toString();
                        dataBase.productosEmpBox.put(productoEmp);
                        print("Se hace put al producto emprendedor 1");
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return 1;
                      default: //No se realizo con éxito el post del producto Emp
                        print("Error en Emi Web Producto Emprendedor 1");
                        return 0;
                    } 
                  default:
                    //No se realizo con éxito el post de la imagen asociada
                    print("Error en Emi Web Imagen Producto Emprendedor 1");
                    return 0;
                }  
              } else {
                print("Primer else");
                if (productoEmp.idEmiWeb == null) {
                  // Segundo creamos el producto Emprendedor
                  final crearProductoEmprendedorUri =
                    Uri.parse('$baseUrlEmiWebServices/productos/emprendedores/registro/crear');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responsePostProductoEmprendedor = await post(crearProductoEmprendedorUri, 
                  headers: headers,
                  body: jsonEncode({
                    "idUsuario": productoEmp.emprendimientos.target!.usuario.target!.idEmiWeb,
                    "nombreUsuario": "${productoEmp.emprendimientos
                    .target!.usuario.target!.nombre} ${productoEmp.emprendimientos
                    .target!.usuario.target!.apellidoP} ${productoEmp.emprendimientos
                    .target!.usuario.target!.apellidoM}",
                    "idEmprendedor": productoEmp.emprendimientos.target!.emprendedor.target!.idEmiWeb,
                    "producto": productoEmp.nombre,
                    "idEmprendimiento": productoEmp.emprendimientos.target!.idEmiWeb,
                    "idUnidadMedida": productoEmp.unidadMedida.target!.idEmiWeb,
                    "idDocumento": productoEmp.imagen.target!.idEmiWeb,
                    "descripcion": productoEmp.descripcion,
                    "costoUnidadMedida": productoEmp.costo,
                  }));
                  print("${responsePostProductoEmprendedor.statusCode}");
                  print("${responsePostProductoEmprendedor.body.toString()}");
                  switch (responsePostProductoEmprendedor.statusCode) {
                    case 200:
                      print("Caso 200 en Emi Web Producto Emprendedor 2");
                      //Tercero se recupera el id Emi Web del Producto Emprendedor
                      final responsePostProductoEmprendedorParse = postRegistroExitosoEmiWebSingleFromMap(
                          const Utf8Decoder().convert(responsePostProductoEmprendedor.bodyBytes));
                      //Se necesita hacer este paso para actualizar la información
                      productoEmp.idEmiWeb = responsePostProductoEmprendedorParse.payload.toString();
                      dataBase.productosEmpBox.put(productoEmp);
                      print("Se hace put al producto emprendedor 2");
                      //Se marca como realizada en EmiWeb la instrucción en Bitacora
                      bitacora.executeEmiWeb = true;
                      dataBase.bitacoraBox.put(bitacora);
                      return 1;
                    default: //No se realizo con éxito el post del producto Emp
                      print("Error en Emi Web Producto Emprendedor 2");
                      return 0;
                  } 
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              print("NO HAY IMAGEN ASOCIADA EN EMI WEB");
              if (productoEmp.idEmiWeb == null) {
                //No existe una imagen asociada al producto Emp
                // Primero creamos el producto Emprendedor
                final crearProductoEmprendedorUri =
                  Uri.parse('$baseUrlEmiWebServices/productos/emprendedores/registro/crear');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostProductoEmprendedor = await post(crearProductoEmprendedorUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuario": productoEmp.emprendimientos.target!.usuario.target!.idEmiWeb,
                  "nombreUsuario": "${productoEmp.emprendimientos
                  .target!.usuario.target!.nombre} ${productoEmp.emprendimientos
                  .target!.usuario.target!.apellidoP} ${productoEmp.emprendimientos
                  .target!.usuario.target!.apellidoM}",
                  "idEmprendedor": productoEmp.emprendimientos.target!.emprendedor.target!.idEmiWeb,
                  "producto": productoEmp.nombre,
                  "idEmprendimiento": productoEmp.emprendimientos.target!.idEmiWeb,
                  "idUnidadMedida": productoEmp.unidadMedida.target!.idEmiWeb,
                  "descripcion": productoEmp.descripcion,
                  "costoUnidadMedida": productoEmp.costo,
                }));
                switch (responsePostProductoEmprendedor.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Producto Emprendedor 3");
                    //Segundo se recupera el id Emi Web del Producto Emprendedor mediante otro API
                    final responsePostProductoEmprendedorParse = postRegistroExitosoEmiWebSingleFromMap(
                      const Utf8Decoder().convert(responsePostProductoEmprendedor.bodyBytes));
                    //Se necesita hacer este paso para actualizar la información
                    productoEmp.idEmiWeb = responsePostProductoEmprendedorParse.payload.toString();
                    dataBase.productosEmpBox.put(productoEmp);
                    print("Se hace put al producto emprendedor 3");
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el post del producto Emp
                    print("Error en Emi Web Producto Emprendedor 3");
                    return 0;
                } 
              } else {
                //Ya se ha posteado anteriormente
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              }
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddProductoEmprendedor: $e");
            return 0;
          }
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
}

  Future<int> syncAddImagenProductoEmprendedor(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddImagenProductoEmprendedor() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final crearImagenProductoEmprendedorUri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            print("DATOS DE LA IMAGEN DEL PROD EMPRENDEDOR");
            print(imagen.nombre);
            print(imagen.base64);
            print(imagen.productosEmp.target!.emprendimientos.target!.usuario.target!.idEmiWeb);
            final responsePostAddImagenProductoEmprendedor = await post(crearImagenProductoEmprendedorUri, 
            headers: headers,
            body: jsonEncode({
              "idCatTipoDocumento": "3", //Imagen Producto Emprendedor
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idUsuario": imagen.productosEmp.target!.emprendimientos.target!.usuario.target!.idEmiWeb,
            }));

            switch (responsePostAddImagenProductoEmprendedor.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Add Imagen Usuario");
                //Se recupera el id Emi Web
                final responsePostImagenProductoEmprendedorParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostAddImagenProductoEmprendedor.bodyBytes));
                imagen.idEmiWeb = responsePostImagenProductoEmprendedorParse.payload.idDocumento.toString();
                dataBase.imagenesBox.put(imagen);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el post
                print("Error en agregar imagen usuario Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncAddImagenProductoEmprendedor(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddVenta(Ventas venta, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddVenta de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            List<dynamic> ventaCrearRequestList = [];
            //Verificamos que no se haya posteado anteriormente la venta
            if (venta.idEmiWeb == null) {
              //Creamos la venta asociada a los productos vendidos
              final crearVentaUri =
                Uri.parse('$baseUrlEmiWebServices/ventas');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              for (var i = 0; i < venta.prodVendidos.length; i++) {
                var newVentaCreada = VentaCrearRequestListEmiWeb(
                  idProductoEmprendedor: int.parse(venta.prodVendidos[i].productoEmp.target!.idEmiWeb!), 
                  cantidadVendida: venta.prodVendidos[i].cantVendida, 
                  precioVenta: venta.prodVendidos[i].precioVenta);
                ventaCrearRequestList.add(newVentaCreada.toMap());
              }
              print(jsonEncode(ventaCrearRequestList));
              final responsePostVenta = await post(crearVentaUri, 
              headers: headers,
              body: jsonEncode({   
                "idUsuarioRegistra": venta.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${venta.emprendimiento
                .target!.usuario.target!.nombre} ${venta.emprendimiento
                .target!.usuario.target!.apellidoP} ${venta.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "idProyecto": venta.emprendimiento.target!.idEmiWeb,
                "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaInicio),
                "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaTermino),
                "total": venta.total,
                "ventaCrearRequestList": ventaCrearRequestList,     
              }));
              print("Respuesta Post Venta");
              print(responsePostVenta.body);     
              switch (responsePostVenta.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Venta");
                  //Se recupera el id Emi Web de la Venta
                  final responsePostVentaParse = postRegistroExitosoEmiWebSingleFromMap(
                  const Utf8Decoder().convert(responsePostVenta.bodyBytes));
                  venta.idEmiWeb = responsePostVentaParse.payload.toString();
                  dataBase.ventasBox.put(venta);
                  // Se recuperan los ids de los productos vendidos
                  final obtenerProductosVendidosUri =
                    Uri.parse('$baseUrlEmiWebServices/ventas/${responsePostVentaParse.payload.toString()}');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responseGetProductosVendidos = await get(obtenerProductosVendidosUri, 
                    headers: headers,
                  );
                  print("Respuesta Get Productos Vendidos");
                  print(responseGetProductosVendidos.body);     
                  switch (responseGetProductosVendidos.statusCode) {
                    case 200:
                      //Se recupera el id Emi Web de los Prod Vendidos
                      final responseGetProductosVendidosParse = getProductosVendidosEmiWebFromMap(
                      const Utf8Decoder().convert(responseGetProductosVendidos.bodyBytes));
                      for (var i = 0; i < responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList!.length; i++) {
                        for (var element in venta.prodVendidos.toList()) {
                          if (element.nombreProd == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.producto && 
                          element.costo == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.costoUnidadMedida &&
                          element.cantVendida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.cantidadVendida &&
                          element.precioVenta == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.precioVenta &&
                          element.unidadMedida.target!.unidadMedida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.unidadMedida) {
                            if (venta.prodVendidos.toList()[i].idEmiWeb == null) {
                              //Se asigna el id Emi Web al prod Vendido
                              venta.prodVendidos.toList()[i].idEmiWeb = responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].id.toString();
                              dataBase.productosVendidosBox.put(venta.prodVendidos.toList()[i]);
                            }
                          }
                        }
                      }
                      //Se marca como realizada en EmiWeb la instrucción en Bitacora
                      bitacora.executeEmiWeb = true;
                      dataBase.bitacoraBox.put(bitacora);
                      return 1;
                    default:
                      //No se obtiene con éxito los prod Vendidos
                      return 0;
                  }
                default: //No se realizo con éxito el post
                  print("Error en postear venta Emi Web");
                  return 0;
              }       
            } else {
              // Se recuperan los ids de los productos vendidos
              final obtenerProductosVendidosUri =
                Uri.parse('$baseUrlEmiWebServices/ventas/${venta.idEmiWeb}');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responseGetProductosVendidos = await get(obtenerProductosVendidosUri, 
                headers: headers,
              );
              print("Respuesta Get Productos Vendidos");
              print(responseGetProductosVendidos.body);     
              switch (responseGetProductosVendidos.statusCode) {
                case 200:
                  //Se recupera el id Emi Web de los Prod Vendidos
                  final responseGetProductosVendidosParse = getProductosVendidosEmiWebFromMap(
                  const Utf8Decoder().convert(responseGetProductosVendidos.bodyBytes));
                  for (var i = 0; i < responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList!.length; i++) {
                    for (var element in venta.prodVendidos.toList()) {
                      if (element.nombreProd == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.producto && 
                      element.costo == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.costoUnidadMedida &&
                      element.cantVendida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.cantidadVendida &&
                      element.precioVenta == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.precioVenta &&
                      element.unidadMedida.target!.unidadMedida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.unidadMedida) {
                        if (venta.prodVendidos.toList()[i].idEmiWeb == null) {
                          //Se asigna el id Emi Web al prod Vendido
                          venta.prodVendidos.toList()[i].idEmiWeb = responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].id.toString();
                          dataBase.productosVendidosBox.put(venta.prodVendidos.toList()[i]);
                        }
                      }
                    }
                  }
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                default:
                  //No se obtiene con éxito los prod Vendidos
                  return 0;
              }
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddVenta: $e");
            return 0;
          }
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
}

  Future<int> syncAddProductoVendido(ProdVendidos prodVendido, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddProductoVendido de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return 1;
          } catch (e) { //Fallo en el momento se sincronizar
            print('ERROR - function syncAddProductoVendido(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddSingleProductoVendido(ProdVendidos prodVendido, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddSingleProductoVendido de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            List<dynamic> ventaActualizarRequestList = [];
            if (!prodVendido.postEmiWeb) {
              //Creamos el API para agregar el prod Vendido
              final actualizarProdVendidoUri =
                Uri.parse('$baseUrlEmiWebServices/ventas');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              var newProdVendido = VentaActualizarRequestList(
                id: 0,
                idProductoEmprendedor: prodVendido.productoEmp.target!.idEmiWeb!, 
                cantidadVendida: prodVendido.cantVendida, 
                precioVenta: prodVendido.precioVenta,
                nombreProducto: prodVendido.nombreProd,
                costoUnitario: prodVendido.costo,
                unidadMedida: prodVendido.unidadMedida.target!.idEmiWeb,
              );
              ventaActualizarRequestList.add(newProdVendido.toMap());
              final responseAddProdVendido = await put(actualizarProdVendidoUri, 
              headers: headers,
              body: jsonEncode({   
                "idUsuarioRegistra": prodVendido.venta.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${prodVendido.venta.target!.emprendimiento
                .target!.usuario.target!.nombre} ${prodVendido.venta.target!.emprendimiento
                .target!.usuario.target!.apellidoP} ${prodVendido.venta.target!.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "idVentas": prodVendido.venta.target!.idEmiWeb,
                "idProyecto": prodVendido.venta.target!.emprendimiento.target!.idEmiWeb,
                "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(prodVendido.venta.target!.fechaInicio),
                "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(prodVendido.venta.target!.fechaTermino),
                "total": prodVendido.venta.target!.total,
                "ventaActualizarRequestList": ventaActualizarRequestList,     
              }));
              print("Respuesta Add prod vendido");
              print(responseAddProdVendido.body);     
              switch (responseAddProdVendido.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Prod Vendido");
                  prodVendido.postEmiWeb = true;
                  dataBase.productosVendidosBox.put(prodVendido);
                  // Se recuperan el id del producto vendido
                  final obtenerProductosVendidosUri =
                    Uri.parse('$baseUrlEmiWebServices/ventas/${prodVendido.venta.target!.idEmiWeb}');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responseGetProductosVendidos = await get(obtenerProductosVendidosUri, 
                    headers: headers,
                  );
                  print("Respuesta Get Productos Vendidos");
                  print(responseGetProductosVendidos.body);     
                  switch (responseGetProductosVendidos.statusCode) {
                    case 200:
                      //Se recupera el id Emi Web del Prod Vendido
                      final responseGetProductosVendidosParse = getProductosVendidosEmiWebFromMap(
                      const Utf8Decoder().convert(responseGetProductosVendidos.bodyBytes));
                      for (var i = 0; i < responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList!.length; i++) {
                        if (prodVendido.nombreProd == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.producto && 
                          prodVendido.costo == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.costoUnidadMedida &&
                          prodVendido.cantVendida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.cantidadVendida &&
                          prodVendido.precioVenta == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.precioVenta &&
                          prodVendido.unidadMedida.target!.unidadMedida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.unidadMedida) {
                          if (prodVendido.idEmiWeb == null) {
                            //Se asigna el id Emi Web al prod Vendido
                            prodVendido.idEmiWeb = responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].id.toString();
                            dataBase.productosVendidosBox.put(prodVendido);
                            //Se marca como realizada en EmiWeb la instrucción en Bitacora
                            bitacora.executeEmiWeb = true;
                            dataBase.bitacoraBox.put(bitacora);
                            return 1;
                          }
                        }
                      }
                      return 0;
                    default:
                      //No se obtiene con éxito los prod Vendidos
                      return 0;
                  }
                default: //No se realizo con éxito el agregar
                  print("Error en agregar prod Vendido Emi Web");
                  return 0;
              }     
            } else {
              // Se recuperan el id del producto vendido
              final obtenerProductosVendidosUri =
                Uri.parse('$baseUrlEmiWebServices/ventas/${prodVendido.venta.target!.idEmiWeb}');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responseGetProductosVendidos = await get(obtenerProductosVendidosUri, 
                headers: headers,
              );
              print("Respuesta Get Productos Vendidos");
              print(responseGetProductosVendidos.body);     
              switch (responseGetProductosVendidos.statusCode) {
                case 200:
                  //Se recupera el id Emi Web del Prod Vendido
                  final responseGetProductosVendidosParse = getProductosVendidosEmiWebFromMap(
                  const Utf8Decoder().convert(responseGetProductosVendidos.bodyBytes));
                  for (var i = 0; i < responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList!.length; i++) {
                    if (prodVendido.nombreProd == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.producto && 
                      prodVendido.costo == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.costoUnidadMedida &&
                      prodVendido.cantVendida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.cantidadVendida &&
                      prodVendido.precioVenta == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.precioVenta &&
                      prodVendido.unidadMedida.target!.unidadMedida == responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].productoEmprendedorDto!.unidadMedida) {
                      if (prodVendido.idEmiWeb == null) {
                        //Se asigna el id Emi Web al prod Vendido
                        prodVendido.idEmiWeb = responseGetProductosVendidosParse.payload!.ventasXProductoEmprenedorList![i].id.toString();
                        dataBase.productosVendidosBox.put(prodVendido);
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return 1;
                      }
                    }
                  }
                  return 0;
                default:
                  //No se obtiene con éxito los prod Vendidos
                  return 0;
              }
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print('ERROR - function syncAddSingleProductoVendido(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateProductoVendido(ProdVendidos prodVendido, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateProductoVendido de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
           try {
            List<dynamic> ventaActualizarRequestList = [];
            //Creamos el API para actualizar el prod Vendido
            final actualizarProdVendidoUri =
              Uri.parse('$baseUrlEmiWebServices/ventas');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var updateProdVenido = VentaActualizarRequestList(
              id: int.parse(prodVendido.idEmiWeb!),
              idProductoEmprendedor: prodVendido.productoEmp.target!.idEmiWeb!, 
              cantidadVendida: prodVendido.cantVendida, 
              precioVenta: prodVendido.precioVenta,
              nombreProducto: prodVendido.nombreProd,
              costoUnitario: prodVendido.costo,
              unidadMedida: prodVendido.unidadMedida.target!.idEmiWeb,
            );
            ventaActualizarRequestList.add(updateProdVenido.toMap());
            print(jsonEncode(ventaActualizarRequestList));
            print("Total: ${prodVendido.venta.target!.total}");
            final responsePutProdVendido = await put(actualizarProdVendidoUri, 
            headers: headers,
            body: jsonEncode({   
              "idUsuarioRegistra": prodVendido.venta.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "usuarioRegistra": "${prodVendido.venta.target!.emprendimiento
              .target!.usuario.target!.nombre} ${prodVendido.venta.target!.emprendimiento
              .target!.usuario.target!.apellidoP} ${prodVendido.venta.target!.emprendimiento
              .target!.usuario.target!.apellidoM}",
              "idVentas": prodVendido.venta.target!.idEmiWeb,
              "idProyecto": prodVendido.venta.target!.emprendimiento.target!.idEmiWeb,
              "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(prodVendido.venta.target!.fechaInicio),
              "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(prodVendido.venta.target!.fechaTermino),
              "total": prodVendido.venta.target!.total,
              "ventaActualizarRequestList": ventaActualizarRequestList,     
            }));
            print("Respuesta Put prod vendido");
            print(responsePutProdVendido.body);     
            switch (responsePutProdVendido.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Prod Vendido");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el actualizar
                print("Error en actualizar prod Vendido Emi Web");
                return 0;
            }       
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncUpdateProductoVendido: $e");
            return 0;
          }
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
  }

  Future<int> syncDeleteProductoVendido(Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncDeleteProductoVendido de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la eliminación
            final eliminarProductoVendido =
              Uri.parse('$baseUrlEmiWebServices/ventasXProductoEmprendedor');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseDeleteProdVendido = await put(eliminarProductoVendido, 
            headers: headers,
            body: jsonEncode({
              "ventasXProductoDeleteRequests": [
                  {
                    "id": "${bitacora.idEmiWeb}"
                  }
                ]
            }));
            switch (responseDeleteProdVendido.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Delete Prod vendido");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el delete
                print("Error en eliminar prod vendido Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncDeleteProductoVendido(): $e');
            return 0;
          }
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
  }

  Future<int> syncAddInversion(Inversiones inversion, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddInversion de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            //Verificamos que no se haya posteado anteriormente la inversión
            if (inversion.idEmiWeb == null) {
              //Creamos la inversión asociada a los prod solicitados
              final crearInversionUri =
                Uri.parse('$baseUrlEmiWebServices/inversiones');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostInversion = await post(crearInversionUri, 
              headers: headers,
              body: jsonEncode({   
                "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${inversion.emprendimiento
                .target!.usuario.target!.nombre} ${inversion.emprendimiento
                .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
                .target!.usuario.target!.apellidoM}",
                "idProyecto": inversion.emprendimiento.target!.idEmiWeb,
                "idCatEstadoInversion": inversion.estadoInversion.target!.idEmiWeb,
                "porcentajePago": inversion.porcentajePago,
                "archivadoPromotor": false,
                "archivadoStaff": false,
                "fechaCompra": inversion.fechaCompra,
                "montoPagar": inversion.montoPagar,
                "saldo": inversion.saldo,
                "totalInversion": 0.0,
                "inversionRecibida": true,
              }));
              print("Respuesta Post Inversión");
              print(responsePostInversion.body);
              switch (responsePostInversion.statusCode) {
                case 200:
                print("Caso 200 en Emi Web Inversión");
                final responsePostInversionParse = postSimpleRegistroExitosoEmiWebFromMap(
                const Utf8Decoder().convert(responsePostInversion.bodyBytes));
                //Creamos los prod Solicitados
                for(var i = 0; i < inversion.prodSolicitados.toList().length; i++){
                  if (inversion.prodSolicitados.toList()[i].imagen.target?.path != null) {
                    //El prod Solicitado está asociado a una imagen
                    final crearImagenProdSolicitadoUri =
                    Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                    final responsePostImagenProdSolicitado = await post(crearImagenProdSolicitadoUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idCatTipoDocumento": "8", //Prod Solicitado
                      "nombreArchivo": inversion.prodSolicitados.toList()[i].imagen.target!.nombre,
                      "archivo": inversion.prodSolicitados.toList()[i].imagen.target!.base64,
                      "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                    }));
                    switch (responsePostImagenProdSolicitado.statusCode) {
                      case 200:
                        //Se recupera el id Emi Web de la imagen del Prod Solicitado
                        final responsePostImagenProdSolicitadoParse = postRegistroImagenExitosoEmiWebFromMap(
                        const Utf8Decoder().convert(responsePostImagenProdSolicitado.bodyBytes));
                        print("Id de la Imagen: ${responsePostImagenProdSolicitadoParse.payload.idDocumento.toString()}");
                        inversion.prodSolicitados.toList()[i].imagen.target!.idEmiWeb = responsePostImagenProdSolicitadoParse.payload.idDocumento.toString();             
                        dataBase.imagenesBox.put(inversion.prodSolicitados.toList()[i].imagen.target!);
                        print("Se recupera el idEmiWeb de la imagen prod solicitado");
                        final crearProdSolicitadosUri =
                          Uri.parse('$baseUrlEmiWebServices/productosSolicitados');
                        final responsePostProdSolicitado = await post(crearProdSolicitadosUri, 
                        headers: headers,
                        body: jsonEncode({   
                          "idInversion": responsePostInversionParse.payload,
                          "producto": inversion.prodSolicitados.toList()[i].producto,
                          "descripcion": inversion.prodSolicitados.toList()[i].descripcion,
                          "idCatTipoEmpaque": inversion.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb,
                          "cantidad": inversion.prodSolicitados.toList()[i].cantidad,
                          "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                          "nombreUsuario": "${inversion.emprendimiento
                          .target!.usuario.target!.nombre} ${inversion.emprendimiento
                          .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
                          .target!.usuario.target!.apellidoM}",
                          "marcaSugerida": inversion.prodSolicitados.toList()[i].marcaSugerida,
                          "proveedorSugerido": inversion.prodSolicitados.toList()[i].proveedorSugerido,
                          "costoEstimado": (inversion.prodSolicitados.toList()[i].cantidad * (inversion.prodSolicitados.toList()[i].costoEstimado ?? 0)),
                          "idDocumento": responsePostImagenProdSolicitadoParse.payload.idDocumento,
                        }));       
                        switch (responsePostProdSolicitado.statusCode) {
                          case 200:
                            //Se recupera el id Emi Web del Prod Solicitado
                            final responsePostProdSolicitadoParse = postRegistroExitosoEmiWebFromMap(
                            const Utf8Decoder().convert(responsePostProdSolicitado.bodyBytes));
                            inversion.prodSolicitados.toList()[i].idEmiWeb = responsePostProdSolicitadoParse.payload!.id.toString();
                            dataBase.productosSolicitadosBox.put(inversion.prodSolicitados.toList()[i]);
                            continue;
                          default:
                            //No se postea con éxito el prod Solicitado
                            i = inversion.prodSolicitados.toList().length;
                            return 0;
                        }
                      default:
                        //No se postea con éxito la imagen del prod Solicitado
                        i = inversion.prodSolicitados.toList().length;
                        return 0;
                    }
                  } else {
                    //El prod Solicitado no está asociado a una imagen
                    final crearProdSolicitadosUri =
                      Uri.parse('$baseUrlEmiWebServices/productosSolicitados');
                    final responsePostProdSolicitado = await post(crearProdSolicitadosUri, 
                    headers: headers,
                    body: jsonEncode({   
                      "idInversion": responsePostInversionParse.payload,
                      "producto": inversion.prodSolicitados.toList()[i].producto,
                      "descripcion": inversion.prodSolicitados.toList()[i].descripcion,
                      "idCatTipoEmpaque": inversion.prodSolicitados.toList()[i].tipoEmpaques.target!.idEmiWeb,
                      "cantidad": inversion.prodSolicitados.toList()[i].cantidad,
                      "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                      "nombreUsuario": "${inversion.emprendimiento
                      .target!.usuario.target!.nombre} ${inversion.emprendimiento
                      .target!.usuario.target!.apellidoP} ${inversion.emprendimiento
                      .target!.usuario.target!.apellidoM}",
                      "marcaSugerida": inversion.prodSolicitados.toList()[i].marcaSugerida,
                      "proveedorSugerido": inversion.prodSolicitados.toList()[i].proveedorSugerido,
                      "costoEstimado": (inversion.prodSolicitados.toList()[i].cantidad * (inversion.prodSolicitados.toList()[i].costoEstimado ?? 0)),
                    }));       
                    switch (responsePostProdSolicitado.statusCode) {
                      case 200:
                        //Se recupera el id Emi Web del Prod Solicitado
                        final responsePostProdSolicitadoParse = postRegistroExitosoEmiWebFromMap(
                        const Utf8Decoder().convert(responsePostProdSolicitado.bodyBytes));
                        inversion.prodSolicitados.toList()[i].idEmiWeb = responsePostProdSolicitadoParse.payload!.id.toString();
                        dataBase.productosSolicitadosBox.put(inversion.prodSolicitados.toList()[i]);
                        continue;
                      default:
                        //No se postea con éxito el prod Solicitado
                        i = inversion.prodSolicitados.toList().length;
                        return 0;
                    }
                  }
                }
                //Se recupera el id Emi Web de la Inversión
                inversion.idEmiWeb = responsePostInversionParse.payload.toString();
                dataBase.inversionesBox.put(inversion);
                print("Se recupera el idEmiWeb de la inversión");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default:
                //Falló al postear la inversión
                return 0;
              }       
            } else {
              //Se marca como realizada en EmiWeb la instrucción en Bitacora
              bitacora.executeEmiWeb = true;
              dataBase.bitacoraBox.put(bitacora);
              return 1;
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddInversion: $e");
            return 0;
          }
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
}

  Future<int> syncAddPagoInversion(Pagos pago, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddPagoInversion de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            //Verificamos que no se haya posteado anteriormente el pago
            if (pago.idEmiWeb == null) {
              final crearPagoUri =
                Uri.parse('$baseUrlEmiWebServices/inversiones/pago');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostPago = await post(crearPagoUri, 
              headers: headers,
              body: jsonEncode({
                "idInversion": pago.inversion.target!.idEmiWeb,
                "montoAbonado": pago.montoAbonado,
                "idUsuario": pago.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                "nombreUsuario": "${pago.inversion.target!.emprendimiento
                .target!.usuario.target!.nombre} ${pago.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoP} ${pago.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoM}",
              }));
              print("Respuesta Post Pago");
              print(responsePostPago.body);
              switch (responsePostPago.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Pago");
                  //Se recupera el id Emi Web del Pago
                  final responsePostPagoParse = postRegistroExitosoEmiWebFromMap(
                  const Utf8Decoder().convert(responsePostPago.bodyBytes));
                  pago.idEmiWeb = responsePostPagoParse.payload!.id.toString();
                  dataBase.pagosBox.put(pago);
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                default: //No se realizo con éxito el post
                  print("Error en postear pago Emi Web");
                  return 0;
              }       
            } else {
              //Se marca como realizada en EmiWeb la instrucción en Bitacora
              bitacora.executeEmiWeb = true;
              dataBase.bitacoraBox.put(bitacora);
              return 1;
            }
          } catch (e) { //Fallo en el momento se sincronizar
          print("ERROR - function syncAddPagoInversion(): $e");
            return 0;
          }
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
}

  Future<int> syncUpdateEmprendedor(Emprendedores emprendedor, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateEmprendedor Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarEmprendedorUri =
              Uri.parse('$baseUrlEmiWebServices/emprendedores/registro/actualizar');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateEmprendedor = await put(actualizarEmprendedorUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${emprendedor.emprendimiento.target!.usuario
                  .target!.nombre} ${emprendedor.emprendimiento.target!.usuario
                  .target!.apellidoP} ${emprendedor.emprendimiento.target!.usuario
                  .target!.apellidoM}",
              "emprendimiento": emprendedor.emprendimiento.target!.nombre,
              "idEmprendedor": emprendedor.idEmiWeb,
              "nombre": emprendedor.nombre,
              "apellidos": emprendedor.apellidos,
              "curp": emprendedor.curp,
              "integrantesFamilia": emprendedor.integrantesFamilia,
              "comunidad": emprendedor.comunidad.target!.idEmiWeb,
              "estado": emprendedor.comunidad.target!.municipios.target!.estados.target!.idEmiWeb,
              "municipio": emprendedor.comunidad.target!.municipios.target!.idEmiWeb,
              "telefono": emprendedor.telefono?.replaceAll("-", ""),
              "comentarios": emprendedor.comentarios,
              "fechaRegistro": (DateFormat("yyyy-MM-ddTHH:mm:ss").format(emprendedor.fechaRegistro)).toString(),
              "archivado": emprendedor.emprendimiento.target!.archivado,
            }));
            print(responseUpdateEmprendedor.statusCode);
            print(responseUpdateEmprendedor.body);
            switch (responseUpdateEmprendedor.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Emprendedor");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar Emprendedor Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncUpdateEmprendedor(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateEmprendimiento Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarEmprendimientoUri =
              Uri.parse('$baseUrlEmiWebServices/proyectos/emprendimiento');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateEmprendimiento = await put(actualizarEmprendimientoUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuarioRegistra": emprendimiento.usuario.target!.idEmiWeb,
              "usuarioRegistra": "${emprendimiento.usuario
                  .target!.nombre} ${emprendimiento.usuario
                  .target!.apellidoP} ${emprendimiento.usuario
                  .target!.apellidoM}",
              "emprendimiento": emprendimiento.nombre,
              "id": emprendimiento.idEmiWeb,
            }));
            print(responseUpdateEmprendimiento.statusCode);
            print(responseUpdateEmprendimiento.body);
            switch (responseUpdateEmprendimiento.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Emprendedor");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar Emprendedor Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncUpdateEmprendimiento(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateFaseEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final faseActual = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(bitacora.instruccionAdicional!)).build().findUnique();
            if (faseActual != null) {
              // Primero creamos el API para realizar la actualización
                final actualizarFaseEmprendimientoUri =
                  Uri.parse('$baseUrlEmiWebServices/proyectos/fase');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                print("Fase Actual: ${faseActual.fase}");
                print("Id Emprendimiento: ${emprendimiento.idEmiWeb}");
                final responseUpdateFaseEmprendimiento = await put(actualizarFaseEmprendimientoUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuarioRegistra": emprendimiento.usuario.target!.idEmiWeb,
                  "usuarioRegistra": "${emprendimiento
                  .usuario.target!.nombre} ${emprendimiento
                  .usuario.target!.apellidoP} ${emprendimiento
                  .usuario.target!.apellidoM}",
                  "id": emprendimiento.idEmiWeb,
                  "idCatFase": faseActual.idEmiWeb,
                }));

                switch (responseUpdateFaseEmprendimiento.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Update Fase Emprendimiento");
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el update
                    print("Error en actualizar fase emprendimiento Emi Web");
                    return 0;
                }  
            } else {
              return 0;
            }
          } catch (e) {
            print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateEstadoInversion(Inversiones inversion, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateEstadoInversion en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final estadoActual = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals(bitacora.instruccionAdicional!)).build().findUnique();
            if (estadoActual != null) {
              // Primero creamos el API para realizar la actualización del estado de la inversión
              final syncUpdateEstadoInversionUri =
                Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              print("Fase Actual: ${estadoActual.estado}");
              final responseUpdateEstasyncUpdateEstadoInversion = await put(syncUpdateEstadoInversionUri, 
              headers: headers,
              body: jsonEncode({
                "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${inversion.emprendimiento.target!
                .usuario.target!.nombre} ${inversion.emprendimiento.target!
                .usuario.target!.apellidoP} ${inversion.emprendimiento.target!
                .usuario.target!.apellidoM}",
                "idInversiones": inversion.idEmiWeb,
                "idCatEstadoInversion": estadoActual.idEmiWeb,
              }));

              switch (responseUpdateEstasyncUpdateEstadoInversion.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Update Estado Inversión");
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                default: //No se realizo con éxito el update de la actualización de estado de la inversión
                  print("Error en actualizar estado inversion Emi Web");
                  return 0;
              }  
            } else {
              // No se encontró el estado actual da la inversión
              return 0;
            }
          } catch (e) {
            print('ERROR - function syncUpdateEstadoInversion(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateJornada1(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateJornada1() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarJornada1Uri =
              Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateJornada1 = await put(actualizarJornada1Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
              "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
              "registrarTarea": jornada.tarea.target!.tarea,
              "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
              "comentarios": jornada.tarea.target!.comentarios,
              "tareaCompletada": jornada.completada,
              "descripcion": jornada.tarea.target!.descripcion,
              "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
              "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
            }));

            switch (responseUpdateJornada1.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Jornada 1");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar jornada 1 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateJornada1(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateJornada2(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateJornada2() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarJornada2Uri =
              Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateJornada2 = await put(actualizarJornada2Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
              "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
              "registrarTarea": jornada.tarea.target!.tarea,
              "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
              "comentarios": jornada.tarea.target!.comentarios,
              "tareaCompletada": jornada.completada,
              "descripcion": jornada.tarea.target!.descripcion,
              "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
              "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
            }));

            switch (responseUpdateJornada2.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Jornada 2");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar jornada 2 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateJornada2(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateImagenJornada2(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateImagenJornada2() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            print("${imagen.idEmiWeb}");
            final actualizarImagenJornada2Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/actualizar?id=${imagen.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateImagenJornada2 = await put(actualizarImagenJornada2Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idCatTipoDocumento": "4", //Círculo Empresa
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idJornada2": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responseUpdateImagenJornada2.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Imagen Jornada 2");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar imagen jornada 2 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateImagenJornada2(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateJornada3(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateJornada3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarJornada3Uri =
              Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateJornada3 = await put(actualizarJornada3Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
              "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
              "registrarTarea": jornada.tarea.target!.tarea,
              "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
              "comentarios": jornada.tarea.target!.comentarios,
              "tareaCompletada": jornada.completada,
              "descripcion": jornada.tarea.target!.descripcion,
              "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
              "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
            }));

            switch (responseUpdateJornada3.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Jornada 3");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar jornada 3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateJornada3(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateImagenJornada3(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateImagenJornada3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            print("${imagen.idEmiWeb}");
            final actualizarImagenJornada3Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/actualizar?id=${imagen.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateImagenJornada3 = await put(actualizarImagenJornada3Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idCatTipoDocumento": "5", //Análisis Financiero
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idJornada4": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responseUpdateImagenJornada3.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Imagen Jornada 3");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar imagen jornada 3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateImagenJornada3(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateProductoInversionJ3(ProdSolicitado prodSolicitado, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateProductoInversionJ3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarProductoProyectoUri =
            Uri.parse('$baseUrlEmiWebServices/productos/proyectos');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateProductoProyecto = await put(actualizarProductoProyectoUri, 
            headers: headers,
            body: jsonEncode({
              "idProductoDeProyecto": prodSolicitado.idEmiWeb,
              "idUsuario": prodSolicitado.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.nombre} ${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoP} ${prodSolicitado.inversion.target!.emprendimiento
                .target!.usuario.target!.apellidoM}",
              "producto": prodSolicitado.producto,
              "descripcion": prodSolicitado.descripcion,
              "marcaRecomendada": prodSolicitado.marcaSugerida,
              "cantidad": prodSolicitado.cantidad,
              "costoEstimado": prodSolicitado.costoEstimado,
              "proveedorSugerido": prodSolicitado.proveedorSugerido,
              "idProyecto": prodSolicitado.inversion.target!.emprendimiento.target!.idEmiWeb,
              "idFamilia": prodSolicitado.familiaProducto.target!.idEmiWeb,
              "unidadMedida": prodSolicitado.tipoEmpaques.target!.idEmiWeb,
            }));
            switch (responseUpdateProductoProyecto.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Producto Inversion J3");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el put
                print("Error en actualizar producto inversión J3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateProductoInversionJ3(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateJornada4(Jornadas jornada, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateJornada4() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarJornada4Uri =
              Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateJornada4 = await put(actualizarJornada4Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${jornada.emprendimiento
                  .target!.usuario.target!.nombre} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
                  .target!.usuario.target!.apellidoM}",
              "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
              "registrarTarea": jornada.tarea.target!.tarea,
              "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
              "comentarios": jornada.tarea.target!.comentarios,
              "tareaCompletada": jornada.completada,
              "descripcion": jornada.tarea.target!.descripcion,
              "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
              "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
            }));

            switch (responseUpdateJornada4.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Jornada 4");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar jornada 4 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateJornada4(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateImagenJornada4(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateImagenJornada4() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            print("${imagen.idEmiWeb}");
            final actualizarImagenJornada4Uri =
              Uri.parse('$baseUrlEmiWebServices/documentos/actualizar?id=${imagen.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateImagenJornada4 = await put(actualizarImagenJornada4Uri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": imagen.tarea.target!.jornada.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "idCatTipoDocumento": "6", //Convenio
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
              "idJornada4": imagen.tarea.target!.jornada.target!.idEmiWeb!.split("?")[0],
            }));
            switch (responseUpdateImagenJornada4.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Imagen Jornada 4");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar imagen jornada 4 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateImagenJornada4(): $e');
            return 0;
          }
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
  }

  Future<int> syncDeleteImagenJornada(Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncDeleteImagenJornada() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la eliminación
            final eliminarImagenJornada =
              Uri.parse('$baseUrlEmiWebServices/documentos/eliminar?id=${bitacora.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseDeleteImagenJornada = await delete(eliminarImagenJornada, 
            headers: headers,
            body: jsonEncode({
            }));
            switch (responseDeleteImagenJornada.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Delete Imagen Usuario");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el delete
                print("Error en eliminar imagen usuario Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncDeleteImagenJornada(): $e');
            return 0;
          }
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
  }

  Future<int> syncDeleteProductoInversionJ3(Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncDeleteProductoInversionJ3() en Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final eliminarProductoInversionJ3 =
              Uri.parse('$baseUrlEmiWebServices/productos/proyectos/ids');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseDeleteProductoInversionJ3 = await put(eliminarProductoInversionJ3, 
            headers: headers,
            body: jsonEncode({
              {
                "productosProyectoDeleteRequests": [
                  {
                    "idProductoDeProyecto": bitacora.idEmiWeb
                  }
                ]
              }
            }));
            switch (responseDeleteProductoInversionJ3.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Delete Producto Inversion J3");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el delete
                print("Error en eliminar producto inversion J3 Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncDeleteProductoInversionJ3(): $e');
            return 0;
          }
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
  }

  Future<int> syncUpdateTareaConsultoria(Tareas tarea, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateTareaConsultoria de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            if (tarea.imagenes.isNotEmpty) {
              //Verificamos que no se haya posteado anteriormente la imagen
              if (tarea.imagenes.first.idEmiWeb == null) {
                //Aún no se ha posteado la imagen
                //Primero se postea la imagen
                final crearImagenProductoEmpUri =
                Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostImagenProductoEmp = await post(crearImagenProductoEmpUri, 
                headers: headers,
                body: jsonEncode({
                  "idCatTipoDocumento": "7", //Avance tarea
                  "nombreArchivo": tarea.imagenes.first.nombre,
                  "archivo": tarea.imagenes.first.base64,
                  "idUsuario": tarea.consultoria.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                }));
                switch (responsePostImagenProductoEmp.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Imagen Avance tarea");
                    final responsePostImagenProductoEmpParse = postRegistroImagenExitosoEmiWebFromMap(
                      const Utf8Decoder().convert(responsePostImagenProductoEmp.bodyBytes));
                    tarea.imagenes.first.idEmiWeb = responsePostImagenProductoEmpParse.payload.idDocumento.toString();
                    dataBase.imagenesBox.put(tarea.imagenes.first);
                    // print("${responsePostImagenProductoEmpParse.payload.idDocumento.toString()}");
                    // Segundo creamos la nueva tarea asociada a la consultoría
                    final actualizarTareaConsultoriaUri =
                      Uri.parse('$baseUrlEmiWebServices/tareas');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responsePostConsultoria = await post(actualizarTareaConsultoriaUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idUsuarioRegistra": tarea.consultoria.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                      "usuarioRegistra": "${tarea.consultoria.target!.emprendimiento
                      .target!.usuario.target!.nombre} ${tarea.consultoria.target!.emprendimiento
                      .target!.usuario.target!.apellidoP} ${tarea.consultoria.target!.emprendimiento
                      .target!.usuario.target!.apellidoM}",
                      "avanceObservado": tarea.descripcion,
                      "idCatPorcentajeAvance": tarea.porcentaje.target!.idEmiWeb,
                      "siguientesPasos": tarea.tarea,
                      "idConsultoria": tarea.consultoria.target!.idEmiWeb,
                      "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(tarea.fechaRegistro),
                      "idDocumento": responsePostImagenProductoEmpParse.payload.idDocumento,
                    }));
                    print(responsePostConsultoria.statusCode);
                    print(responsePostConsultoria.body);
                    print("Respuesta Post Tarea Consultoria");
                    switch (responsePostConsultoria.statusCode) {
                      case 200:
                        print("Caso 200 en Emi Web Tarea Consultoría");
                        //Se recupera el id Emi Web de la Consultoría que será el mismo id para la nueva Tarea
                        tarea.idEmiWeb = tarea.consultoria.target!.idEmiWeb;
                        dataBase.tareasBox.put(tarea);
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return 1;
                      default: //No se realizo con éxito el post
                        print("Error en postear tarea consultoría Emi Web");
                        return 0;
                    }  
                  default:
                    //No se realizo con éxito el post de la imagen asociada
                    print("Error en Emi Web Imagen Producto Emprendedor");
                    return 0;
                }  
              } else {
                if (tarea.idEmiWeb == null) {
                  // Segundo creamos la nueva tarea asociada a la consultoría
                  final actualizarTareaConsultoriaUri =
                    Uri.parse('$baseUrlEmiWebServices/tareas');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responsePostConsultoria = await post(actualizarTareaConsultoriaUri, 
                  headers: headers,
                  body: jsonEncode({
                    "idUsuarioRegistra": tarea.consultoria.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                    "usuarioRegistra": "${tarea.consultoria.target!.emprendimiento
                    .target!.usuario.target!.nombre} ${tarea.consultoria.target!.emprendimiento
                    .target!.usuario.target!.apellidoP} ${tarea.consultoria.target!.emprendimiento
                    .target!.usuario.target!.apellidoM}",
                    "avanceObservado": tarea.descripcion,
                    "idCatPorcentajeAvance": tarea.porcentaje.target!.idEmiWeb,
                    "siguientesPasos": tarea.tarea,
                    "idConsultoria": tarea.consultoria.target!.idEmiWeb,
                    "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(tarea.fechaRegistro),
                    "idDocumento": tarea.imagenes.first.idEmiWeb,
                  }));
                  print(responsePostConsultoria.statusCode);
                  print(responsePostConsultoria.body);
                  print("Respuesta Post Tarea Consultoria");
                  switch (responsePostConsultoria.statusCode) {
                    case 200:
                      print("Caso 200 en Emi Web Tarea Consultoría");
                      //Se recupera el id Emi Web de la Consultoría que será el mismo id para la nueva Tarea
                      tarea.idEmiWeb = tarea.consultoria.target!.idEmiWeb;
                      dataBase.tareasBox.put(tarea);
                      //Se marca como realizada en EmiWeb la instrucción en Bitacora
                      bitacora.executeEmiWeb = true;
                      dataBase.bitacoraBox.put(bitacora);
                      return 1;
                    default: //No se realizo con éxito el post
                      print("Error en postear tarea consultoría Emi Web");
                      return 0;
                  }  
                } else {
                  //Ya se ha posteado anteriormente
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
                  return 1;
                }
              }
            } else {
              if (tarea.idEmiWeb == null) {
                // Segundo creamos la nueva tarea asociada a la consultoría
                final actualizarTareaConsultoriaUri =
                  Uri.parse('$baseUrlEmiWebServices/tareas');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostConsultoria = await post(actualizarTareaConsultoriaUri, 
                headers: headers,
                body: jsonEncode({
                  "idUsuarioRegistra": tarea.consultoria.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                  "usuarioRegistra": "${tarea.consultoria.target!.emprendimiento
                  .target!.usuario.target!.nombre} ${tarea.consultoria.target!.emprendimiento
                  .target!.usuario.target!.apellidoP} ${tarea.consultoria.target!.emprendimiento
                  .target!.usuario.target!.apellidoM}",
                  "avanceObservado": tarea.descripcion,
                  "idCatPorcentajeAvance": tarea.porcentaje.target!.idEmiWeb,
                  "siguientesPasos": tarea.tarea,
                  "idConsultoria": tarea.consultoria.target!.idEmiWeb,
                  "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(tarea.fechaRegistro),
                }));
                print(responsePostConsultoria.statusCode);
                print(responsePostConsultoria.body);
                print("Respuesta Post Tarea Consultoria");
                switch (responsePostConsultoria.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Tarea Consultoría");
                    //Se recupera el id Emi Web de la Consultoría que será el mismo id para la nueva Tarea
                    tarea.idEmiWeb = tarea.consultoria.target!.idEmiWeb;
                    dataBase.tareasBox.put(tarea);
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default: //No se realizo con éxito el post
                    print("Error en postear tarea consultoría Emi Web");
                    return 0;
                }  
              } else {
                //Ya se ha posteado anteriormente
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              }
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncUpdateTareaConsultoria: $e");
            return 0;
          }
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
  }

  Future<int> syncUpdateProductoEmprendedor(ProductosEmp productoEmprendedor, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateProductoEmprendedor Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final actualizarProductoEmprendedorUri =
              Uri.parse('$baseUrlEmiWebServices/productos/emprendedores/registro/actualizar');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateEmprendedor = await put(actualizarProductoEmprendedorUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": productoEmprendedor.emprendimientos.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${productoEmprendedor.emprendimientos.target!.usuario
                  .target!.nombre} ${productoEmprendedor.emprendimientos.target!.usuario
                  .target!.apellidoP} ${productoEmprendedor.emprendimientos.target!.usuario
                  .target!.apellidoM}",
              "emprendimiento": productoEmprendedor.emprendimientos.target!.nombre,
              "idProductoEmprendedor": productoEmprendedor.idEmiWeb,
              "idEmprendedor": productoEmprendedor.emprendimientos.target!.idEmiWeb,
              "producto": productoEmprendedor.nombre,
              "idEmprendimiento": productoEmprendedor.emprendimientos.target!.idEmiWeb,
              "idUnidadMedida": productoEmprendedor.unidadMedida.target!.idEmiWeb,
              "descripcion": productoEmprendedor.descripcion,
              "costoUnidadMedida": productoEmprendedor.costo,
              "idDocumento": productoEmprendedor.imagen.target?.idEmiWeb ?? "",
            }));
            print(responseUpdateEmprendedor.statusCode);
            print(responseUpdateEmprendedor.body);
            switch (responseUpdateEmprendedor.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Update Emprendedor");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar Emprendedor Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncUpdateProductoEmprendedor(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateImagenProductoEmprendedor(Imagenes imagen, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateImagenProductoEmprendedor Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            print("${imagen.idEmiWeb}");
            final actualizarImagenProdEmprendedorUri =
              Uri.parse('$baseUrlEmiWebServices/documentos/actualizar?id=${imagen.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseUpdateImagenProductoEmprendedor = await put(actualizarImagenProdEmprendedorUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": imagen.productosEmp.target!.emprendimientos.target!.usuario.target!.idEmiWeb,
              "idCatTipoDocumento": "3", //Producto emprendedor
              "nombreArchivo": imagen.nombre,
              "archivo": imagen.base64,
            }));
            switch (responseUpdateImagenProductoEmprendedor.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Update Imagen Prod Emprendedor");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en actualizar imagen prod emprendedor Emi Web");
                return 0;
            }  
          } catch (e) {
            print('ERROR - function syncUpdateImagenProductoEmprendedor(): $e');
            return 0;
          }
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
  } 

  Future<int> syncUpdateVenta(Ventas venta, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateVenta de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            List<dynamic> ventaActualizarRequestList = [];
            //Creamos la venta asociada a los productos vendidos
            final actualizarVentaUri =
              Uri.parse('$baseUrlEmiWebServices/ventas');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            for (var i = 0; i < venta.prodVendidos.length; i++) {
              if (venta.prodVendidos.toList()[i].idEmiWeb != null) {
                var newVentaCreada = VentaActualizarRequestList(
                  id: int.parse(venta.prodVendidos.toList()[i].idEmiWeb!),
                  idProductoEmprendedor: venta.prodVendidos[i].productoEmp.target!.idEmiWeb!, 
                  cantidadVendida: venta.prodVendidos[i].cantVendida, 
                  precioVenta: venta.prodVendidos[i].precioVenta,
                  nombreProducto: venta.prodVendidos[i].nombreProd,
                  costoUnitario: venta.prodVendidos[i].costo,
                  unidadMedida: venta.prodVendidos[i].unidadMedida.target!.idEmiWeb,
                );
                ventaActualizarRequestList.add(newVentaCreada.toMap());
              }
            }
            print(jsonEncode(ventaActualizarRequestList));
            final responsePutVenta = await put(actualizarVentaUri, 
            headers: headers,
            body: jsonEncode({   
              "idUsuarioRegistra": venta.emprendimiento.target!.usuario.target!.idEmiWeb,
              "usuarioRegistra": "${venta.emprendimiento
              .target!.usuario.target!.nombre} ${venta.emprendimiento
              .target!.usuario.target!.apellidoP} ${venta.emprendimiento
              .target!.usuario.target!.apellidoM}",
              "idVentas": venta.idEmiWeb,
              "idProyecto": venta.emprendimiento.target!.idEmiWeb,
              "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaInicio),
              "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaTermino),
              "total": venta.total,
              "ventaActualizarRequestList": ventaActualizarRequestList,     
            }));
            print("Respuesta Put Venta");
            print(responsePutVenta.body);     
            switch (responsePutVenta.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Venta");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el actualizar
                print("Error en actualizar venta Emi Web");
                return 0;
            }       
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncUpdateVenta: $e");
            return 0;
          }
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
}

  Future<bool> syncUpdateUsuario(Usuarios usuario, Bitacora bitacora) async {
    print("Estoy en El syncUpdateUsuario() en Emi Web");
    try {
      //Primero creamos el API para realizar la actualización
      final actualizarUsuarioUri =
        Uri.parse('$baseUrlEmiWebServices/usuarios/actualizar');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePutUpdateUsuario = await put(actualizarUsuarioUri, 
      headers: headers,
      body: jsonEncode({
        "idUsuarioRegistra": usuario.idEmiWeb,
        "usuarioRegistra": "${usuario.nombre} ${usuario
            .apellidoP} ${usuario.apellidoM}",
        "idUsuario": usuario.idEmiWeb,
        "nombre": usuario.nombre,
        "apellidoPaterno": usuario.apellidoP,
        "apellidoMaterno": usuario.apellidoM,
        "telefono": usuario.telefono,
      }));

      switch (responsePutUpdateUsuario.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Update Usuario");
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar usuario Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncUpdateUsuario(): $e');
      return false;
    }
  } 

  Future<int> syncUpdateProductosVendidosVenta(Ventas venta, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncUpdateProductosVendidosVenta de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            List<dynamic> ventaActualizarRequestList = [];
            //Actualizamos la venta con las nuevas modificaciones a los prod Vendidos
            final actualizarVentaUri =
              Uri.parse('$baseUrlEmiWebServices/ventas');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            for (var i = 0; i < venta.prodVendidos.length; i++) {
              if (venta.prodVendidos.toList()[i].idEmiWeb != null) {
                var newVentaCreada = VentaActualizarRequestList(
                  id: int.parse(venta.prodVendidos.toList()[i].idEmiWeb!),
                  idProductoEmprendedor: venta.prodVendidos[i].productoEmp.target!.idEmiWeb!, 
                  cantidadVendida: venta.prodVendidos[i].cantVendida, 
                  precioVenta: venta.prodVendidos[i].precioVenta,
                  nombreProducto: venta.prodVendidos[i].nombreProd,
                  costoUnitario: venta.prodVendidos[i].costo,
                  unidadMedida: venta.prodVendidos[i].unidadMedida.target!.idEmiWeb,
                );
                ventaActualizarRequestList.add(newVentaCreada.toMap());
              }
            }
            print(jsonEncode(ventaActualizarRequestList));
            final responsePutVenta = await put(actualizarVentaUri, 
            headers: headers,
            body: jsonEncode({   
              "idUsuarioRegistra": venta.emprendimiento.target!.usuario.target!.idEmiWeb,
              "usuarioRegistra": "${venta.emprendimiento
              .target!.usuario.target!.nombre} ${venta.emprendimiento
              .target!.usuario.target!.apellidoP} ${venta.emprendimiento
              .target!.usuario.target!.apellidoM}",
              "idVentas": venta.idEmiWeb,
              "idProyecto": venta.emprendimiento.target!.idEmiWeb,
              "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaInicio),
              "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaTermino),
              "total": venta.total,
              "ventaActualizarRequestList": ventaActualizarRequestList,     
            }));
            print("Respuesta Put Venta");
            print(responsePutVenta.body);     
            switch (responsePutVenta.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Venta");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el actualizar
                print("Error en actualizar venta Emi Web");
                return 0;
            }    
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncUpdateProductosVendidosVenta: $e");
            return 0;
          }
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
}

  Future<int> syncAcceptProdCotizado(ProdCotizados prodCotizado, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAcceptProdCotizado Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar la actualización
            final aceptarProdCotizadoUri =
              Uri.parse('$baseUrlEmiWebServices/inversiones/productos/cotizados/aprobados?id=${prodCotizado.inversionXprodCotizados.target!.inversion.target!.idEmiWeb!}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseAceptarProdCotizado = await put(aceptarProdCotizadoUri, 
            headers: headers,
            body: jsonEncode({
              "productos": [
                {
                  "idProducto": prodCotizado.idEmiWeb,
                  "cantidad": prodCotizado.cantidad,
                  "aceptado": true,
                  "costoTotal": prodCotizado.costoTotal
                }
              ],
              "idUsuario": prodCotizado.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${prodCotizado.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.usuario
              .target!.nombre} ${prodCotizado.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.usuario
              .target!.apellidoP} ${prodCotizado.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.usuario
              .target!.apellidoM}",
            }));
            print(responseAceptarProdCotizado.statusCode);
            print(responseAceptarProdCotizado.body);
            switch (responseAceptarProdCotizado.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Aceptar Prod cotizados");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en aceptar Inversion por Prod cotizados Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncAcceptProdCotizado(): $e');
            return 0;
          }
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
  } 

  Future<int> syncAcceptInversionesXProductosCotizados(InversionesXProdCotizados inversionXprodCotizados, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAcceptInversionesXProductosCotizados Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            final actualEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Entregada Al Promotor")).build().findFirst();
            if (actualEstadoInversion != null) {
              // Primero creamos el API para realizar la actualización
              final aceptarInversionXProdCotizadosEmprendedorUri =
                Uri.parse('$baseUrlEmiWebServices/cotizacion/aceptadoCotizacion');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responseAceptarInversionXProdCotizados = await put(aceptarInversionXProdCotizadosEmprendedorUri, 
              headers: headers,
              body: jsonEncode({
                "idUsuarioRegistra": inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                "usuarioRegistra": "${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.nombre} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.apellidoP} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.apellidoM}",
                "aceptado": inversionXprodCotizados.aceptado,
                "idListaCotizacion": inversionXprodCotizados.idEmiWeb,
                "idInversion": inversionXprodCotizados.inversion.target!.idEmiWeb,
              }));
              print(responseAceptarInversionXProdCotizados.statusCode);
              print(responseAceptarInversionXProdCotizados.body);
              switch (responseAceptarInversionXProdCotizados.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Aceptar Inversión x Prod cotizados");
                  // Creamos el API para realizar la actualización del estado de inversión
                  final actualizarEstadoInversionUri =
                    Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responsePutEstadoInversion = await put(actualizarEstadoInversionUri, 
                  headers: headers,
                  body: jsonEncode({
                    "idUsuarioRegistra": inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                    "usuarioRegistra": "${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.nombre} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.apellidoP} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                    .target!.apellidoM}",
                    "idInversiones": inversionXprodCotizados.inversion.target!.idEmiWeb,
                    "idCatEstadoInversion": actualEstadoInversion.idEmiWeb,
                  }));
                  print(responsePutEstadoInversion.statusCode);
                  print(responsePutEstadoInversion.body);
                  print("Respuesta Put Estado Inversión");
                  switch (responsePutEstadoInversion.statusCode) {
                    case 200:
                      print("Caso 200 en Emi Web  Actualizar Estado Inversión");
                      // Creamos el API para realizar la actualización del monto, saldo y total de la inversión
                      final actualizarMontoSaldoTotalInversionUri =
                        Uri.parse('$baseUrlEmiWebServices/inversiones/promotor/inversionRecibida');
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      final responsePutMontoSaldoTotalInversion = await put(actualizarMontoSaldoTotalInversionUri, 
                      headers: headers,
                      body: jsonEncode({
                        "idUsuario": inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario.target!.idEmiWeb,
                        "nombreUsuario": "${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                        .target!.nombre} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                        .target!.apellidoP} ${inversionXprodCotizados.inversion.target!.emprendimiento.target!.usuario
                        .target!.apellidoM}",
                        "idInversiones": inversionXprodCotizados.inversion.target!.idEmiWeb,
                        "inversionRecibida": true,
                      }));
                      print(responsePutMontoSaldoTotalInversion.statusCode);
                      print(responsePutMontoSaldoTotalInversion.body);
                      print("Respuesta Put Monto Saldo y total Inversión");
                      switch (responsePutMontoSaldoTotalInversion.statusCode) {
                        case 200:
                          print("Caso 200 en Emi Web  Actualizar monto, saldo, total Inversión");
                          //Se marca como realizada en EmiWeb la instrucción en Bitacora
                          bitacora.executeEmiWeb = true;
                          dataBase.bitacoraBox.put(bitacora);
                          return 1;
                        default: //No se realizo con éxito el put
                          print("Error en actualizar monto, saldo y total inversion Emi Web");
                          return 0;
                      }  
                    default: //No se realizo con éxito el put
                      print("Error en actualizar estado inversion Emi Web");
                      return 0;
                  }  
                default: //No se realizo con éxito el update
                  print("Error en aceptar Inversion por Prod cotizados Emi Web");
                  return 0;
              }  
            } else {
              print("no se pudo recuperar el estado");
              return 0;
            }
          } catch (e) {
            print('Catch en syncAcceptInversionesXProductosCotizados(): $e');
            return 0;
          }
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
  } 

  Future<bool> syncUpdateImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenUsuario() en Emi Web");
    try {
      print("ID IMAGEN: ${imagen.idEmiWeb}");
      print("NOMBRE IMAGEN: ${imagen.nombre}");
      // Primero creamos el API para realizar la actualización
      final actualizarImagenUsuarioUri =
        Uri.parse('$baseUrlEmiWebServices/documentos/actualizar?id=${imagen.idEmiWeb}');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePostUpdateImagenUsuario = await put(actualizarImagenUsuarioUri, 
      headers: headers,
      body: jsonEncode({
        "idUsuario": imagen.usuario.target!.idEmiWeb,
        "idCatTipoDocumento": "1", //Foto perfil Usuario
        "nombreArchivo": imagen.nombre,
        "archivo": imagen.base64,
      }));
      switch (responsePostUpdateImagenUsuario.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Update Imagen Usuario");
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar imagen usuario Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncUpdateImagenUsuario(): $e');
      return false;
    }
  }

  Future<bool> syncAddImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncAddImagenUsuario() en Emi Web");
    try {
      // Primero creamos el API para realizar la actualización
      final crearImagenUsuarioUri =
        Uri.parse('$baseUrlEmiWebServices/documentos/crear');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePostAddImagenUsuario = await post(crearImagenUsuarioUri, 
      headers: headers,
      body: jsonEncode({
        "idCatTipoDocumento": "1", //Foto perfil Usuario
        "nombreArchivo": imagen.nombre,
        "archivo": imagen.base64,
        "idUsuario": imagen.usuario.target!.idEmiWeb,
      }));

      switch (responsePostAddImagenUsuario.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Add Imagen Usuario");
          //Se recupera el id Emi Web
          final responsePostImagenUsuarioParse = postRegistroImagenExitosoEmiWebFromMap(
               const Utf8Decoder().convert(responsePostAddImagenUsuario.bodyBytes));
          imagen.idEmiWeb = responsePostImagenUsuarioParse.payload.idDocumento.toString();
          dataBase.imagenesBox.put(imagen);
          print("ID DE IMAGEN NUEVO: ${responsePostImagenUsuarioParse.payload.idDocumento.toString()}");
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        default: //No se realizo con éxito el post
          print("Error en agregar imagen usuario Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncAddImagenUsuario(): $e');
      return false;
    }
  }

  Future<int> syncArchivarEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncArchivarEmprendimiento Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
          // Primero creamos el API para realizar el archivado
          final archivarEmprendimientoUri =
            Uri.parse('$baseUrlEmiWebServices/proyectos/archivar');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          final responseArchivarEmprendimiento = await put(archivarEmprendimientoUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuarioRegistra": emprendimiento.usuario.target!.idEmiWeb,
            "usuarioRegistra": "${emprendimiento.usuario
                .target!.nombre} ${emprendimiento.usuario
                .target!.apellidoP} ${emprendimiento.usuario
                .target!.apellidoM}",
            "id": emprendimiento.idEmiWeb,
            "archivado": true,
          }));
          print(responseArchivarEmprendimiento.statusCode);
          print(responseArchivarEmprendimiento.body);
          switch (responseArchivarEmprendimiento.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Archivar Emprendedor");
              //Se marca como realizada en EmiWeb la instrucción en Bitacora
              bitacora.executeEmiWeb = true;
              dataBase.bitacoraBox.put(bitacora);
              return 1;
            default: //No se realizo con éxito el update
              print("Error en archivar Emprendedor Emi Web");
              return 0;
          }  
        } catch (e) {
          print('Catch en syncArchivarEmprendimiento(): $e');
          return 0;
        }
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
  } 

  Future<int> syncDesarchivarEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncDesarchivarEmprendimiento Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar el desarchivado
            final desarchivarEmprendimientoUri =
              Uri.parse('$baseUrlEmiWebServices/proyectos/archivar');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseDesarchivarEmprendimiento = await put(desarchivarEmprendimientoUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuarioRegistra": emprendimiento.usuario.target!.idEmiWeb,
              "usuarioRegistra": "${emprendimiento.usuario
                  .target!.nombre} ${emprendimiento.usuario
                  .target!.apellidoP} ${emprendimiento.usuario
                  .target!.apellidoM}",
              "id": emprendimiento.idEmiWeb,
              "archivado": false,
            }));
            print(responseDesarchivarEmprendimiento.statusCode);
            print(responseDesarchivarEmprendimiento.body);
            switch (responseDesarchivarEmprendimiento.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Desarchivar Emprendedor");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en desarchivar Emprendedor Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncDesarchivarEmprendimiento(): $e');
            return 0;
          }
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
  } 

  Future<int> syncArchivarConsultoria(Consultorias consultoria, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncArchivarConsultoria Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar el archivado
            final archivarConsultoriaUri =
              Uri.parse('$baseUrlEmiWebServices/consultoria/archivar');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseArchivarConsultoria = await put(archivarConsultoriaUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": consultoria.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${consultoria.emprendimiento.target!.usuario
                  .target!.nombre} ${consultoria.emprendimiento.target!.usuario
                  .target!.apellidoP} ${consultoria.emprendimiento.target!.usuario
                  .target!.apellidoM}",
              "idConsultoria": consultoria.idEmiWeb,
              "archivado": true,
            }));
            print(responseArchivarConsultoria.statusCode);
            print(responseArchivarConsultoria.body);
            switch (responseArchivarConsultoria.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Archivar Consultoria");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en archivar Consultoria Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncArchivarConsultoria(): $e');
            return 0;
          }
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
  } 

  Future<int> syncDesarchivarConsultoria(Consultorias consultoria, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncDesarchivarConsultoria Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            // Primero creamos el API para realizar el archivado
            final desarchivarConsultoriaUri =
              Uri.parse('$baseUrlEmiWebServices/consultoria/archivar');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            final responseDesarchivarConsultoria = await put(desarchivarConsultoriaUri, 
            headers: headers,
            body: jsonEncode({
              "idUsuario": consultoria.emprendimiento.target!.usuario.target!.idEmiWeb,
              "nombreUsuario": "${consultoria.emprendimiento.target!.usuario
                  .target!.nombre} ${consultoria.emprendimiento.target!.usuario
                  .target!.apellidoP} ${consultoria.emprendimiento.target!.usuario
                  .target!.apellidoM}",
              "idConsultoria": consultoria.idEmiWeb,
              "archivado": false,
            }));
            print(responseDesarchivarConsultoria.statusCode);
            print(responseDesarchivarConsultoria.body);
            switch (responseDesarchivarConsultoria.statusCode) {
              case 200:
              print("Caso 200 en Emi Web Desarchivar Consultoria");
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return 1;
              default: //No se realizo con éxito el update
                print("Error en desarchivar Consultoria Emi Web");
                return 0;
            }  
          } catch (e) {
            print('Catch en syncDesarchivarConsultoria(): $e');
            return 0;
          }
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
  } 
 
  Future<int> syncAddImagenesEntregaInversion(Inversiones inversion, Bitacora bitacora, String idUsuario) async {
    print("Estoy en El syncAddImagenesEntregaInversion de Emi Web");
    String? idProyectoEmiWeb = dataBase.emprendimientosBox.get(bitacora.idEmprendimiento)?.idEmiWeb;
    if (idProyectoEmiWeb != null) {
      final getUsuarioEstatusUri =
        Uri.parse('$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idProyectoEmiWeb');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responseGetUsuarioEstatusProyecto = await get(getUsuarioEstatusUri, 
      headers: headers
      );
      if (responseGetUsuarioEstatusProyecto.statusCode == 200) {
        //Se recupera el Usuario y el Estatus
        final responseProyecto = getValidateUsuarioEstatusEmiWebFromMap(
          const Utf8Decoder().convert(responseGetUsuarioEstatusProyecto.bodyBytes));
        if (responseProyecto.payload.idPromotor.toString() == idUsuario && responseProyecto.payload.switchMovil == true) {
          try {
            if (inversion.imagenFirmaRecibido.target!.idEmiWeb == null) {
              //Primero se postea la imagen de firma de recibo
              final crearImagenFirmaRecibidoUri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostImagenFirmaRecibido = await post(crearImagenFirmaRecibidoUri, 
              headers: headers,
              body: jsonEncode({
                "idCatTipoDocumento": "10", //Firma de recibo
                "nombreArchivo": inversion.imagenFirmaRecibido.target!.nombre,
                "archivo": inversion.imagenFirmaRecibido.target!.base64,
                "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
              }));
              switch (responsePostImagenFirmaRecibido.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Imagen Frirma de recibo");
                  final responsePostImagenFirmaRecibidoParse = postRegistroImagenExitosoEmiWebFromMap(
                    const Utf8Decoder().convert(responsePostImagenFirmaRecibido.bodyBytes));
                  inversion.imagenFirmaRecibido.target!.idEmiWeb = responsePostImagenFirmaRecibidoParse.payload.idDocumento.toString();
                  dataBase.imagenesBox.put(inversion.imagenFirmaRecibido.target!);
                  // Segundo creamos la nueva imagen de producto entregado
                  final crearImagenProductoEntregadoUri =
                  Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  final responsePostImagenProductoEntregado = await post(crearImagenProductoEntregadoUri, 
                  headers: headers,
                  body: jsonEncode({
                    "idCatTipoDocumento": "11", //Producto entregado
                    "nombreArchivo": inversion.imagenProductoEntregado.target!.nombre,
                    "archivo": inversion.imagenProductoEntregado.target!.base64,
                    "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                  }));
                  print(responsePostImagenProductoEntregado.statusCode);
                  print(responsePostImagenProductoEntregado.body);
                  switch (responsePostImagenProductoEntregado.statusCode) {
                    case 200:
                      print("Caso 200 en Emi Web Imagen Frirma de recibo");
                      final responsePostImagenProductoEntregadoParse = postRegistroImagenExitosoEmiWebFromMap(
                        const Utf8Decoder().convert(responsePostImagenProductoEntregado.bodyBytes));
                      inversion.imagenProductoEntregado.target!.idEmiWeb = responsePostImagenProductoEntregadoParse.payload.idDocumento.toString();
                      dataBase.imagenesBox.put(inversion.imagenProductoEntregado.target!);
                      //Se asocian las imágenes creadas con la inversión
                      final actualizarImagenFirmaRecibidoUri =
                      Uri.parse('$baseUrlEmiWebServices/inversiones/actualizar/documentos');
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      final responseActualizarImagenesFirmaRecibidoProductoEntregado = await put(actualizarImagenFirmaRecibidoUri, 
                      headers: headers,
                      body: jsonEncode({
                        "idInversion": inversion.idEmiWeb,
                        "pagoRecibido": responsePostImagenFirmaRecibidoParse.payload.idDocumento.toString(),
                        "productoEntregado": responsePostImagenProductoEntregadoParse.payload.idDocumento.toString(),
                      }));
                      switch (responseActualizarImagenesFirmaRecibidoProductoEntregado.statusCode) {
                        case 200:
                          print("Caso 200 en Emi Web Actualizar Imagen Frirma de recibo y Producto Entregado");
                          //Se marca como realizada en EmiWeb la instrucción en Bitacora
                          bitacora.executeEmiWeb = true;
                          dataBase.bitacoraBox.put(bitacora);
                          return 1;
                        default:
                          //No se realizo con éxito el put de la acción
                          print("Error en Emi Web Imagen Firma de recibo y Producto Entregado");
                          return 0;
                      }  
                    default: //No se realizo con éxito el post
                      print("Error en Emi Web Imagen Producto Entregado");
                      return 0;
                  }  
                default:
                  //No se realizo con éxito el post de la imagen asociada
                  print("Error en Emi Web Imagen Firma de recibo");
                  return 0;
              }  
            } else {
              if (inversion.imagenProductoEntregado.target!.idEmiWeb == null) {
                // Segundo creamos la nueva imagen de producto entregado
                final crearImagenProductoEntregadoUri =
                Uri.parse('$baseUrlEmiWebServices/documentos/crear');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responsePostImagenProductoEntregado = await post(crearImagenProductoEntregadoUri, 
                headers: headers,
                body: jsonEncode({
                  "idCatTipoDocumento": "11", //Producto entregado
                  "nombreArchivo": inversion.imagenProductoEntregado.target!.nombre,
                  "archivo": inversion.imagenProductoEntregado.target!.base64,
                  "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
                }));
                print(responsePostImagenProductoEntregado.statusCode);
                print(responsePostImagenProductoEntregado.body);
                switch (responsePostImagenProductoEntregado.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Imagen Frirma de recibo");
                    final responsePostImagenProductoEntregadoParse = postRegistroImagenExitosoEmiWebFromMap(
                      const Utf8Decoder().convert(responsePostImagenProductoEntregado.bodyBytes));
                    inversion.imagenProductoEntregado.target!.idEmiWeb = responsePostImagenProductoEntregadoParse.payload.idDocumento.toString();
                    dataBase.imagenesBox.put(inversion.imagenProductoEntregado.target!);
                    //Se asocian las imágenes creadas con la inversión
                    final actualizarImagenFirmaRecibidoUri =
                    Uri.parse('$baseUrlEmiWebServices/inversiones/actualizar/documentos');
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    final responseActualizarImagenesFirmaRecibidoProductoEntregado = await put(actualizarImagenFirmaRecibidoUri, 
                    headers: headers,
                    body: jsonEncode({
                      "idInversion": inversion.idEmiWeb,
                      "pagoRecibido": inversion.imagenFirmaRecibido.target!.idEmiWeb,
                      "productoEntregado": responsePostImagenProductoEntregadoParse.payload.idDocumento.toString(),
                    }));
                    switch (responseActualizarImagenesFirmaRecibidoProductoEntregado.statusCode) {
                      case 200:
                        print("Caso 200 en Emi Web Actualizar Imagen Frirma de recibo y Producto Entregado");
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return 1;
                      default:
                        //No se realizo con éxito el put de la acción
                        print("Error en Emi Web Imagen Firma de recibo y Producto Entregado");
                        return 0;
                    }  
                  default: //No se realizo con éxito el post
                    print("Error en Emi Web Imagen Producto Entregado");
                    return 0;
                }  
              } else {
                //Se asocian las imágenes creadas con la inversión
                final actualizarImagenFirmaRecibidoUri =
                Uri.parse('$baseUrlEmiWebServices/inversiones/actualizar/documentos');
                final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
                final responseActualizarImagenesFirmaRecibidoProductoEntregado = await put(actualizarImagenFirmaRecibidoUri, 
                headers: headers,
                body: jsonEncode({
                  "idInversion": inversion.idEmiWeb,
                  "pagoRecibido": inversion.imagenFirmaRecibido.target!.idEmiWeb,
                  "productoEntregado": inversion.imagenProductoEntregado.target!.idEmiWeb,
                }));
                switch (responseActualizarImagenesFirmaRecibidoProductoEntregado.statusCode) {
                  case 200:
                    print("Caso 200 en Emi Web Actualizar Imagen Frirma de recibo y Producto Entregado");
                    //Se marca como realizada en EmiWeb la instrucción en Bitacora
                    bitacora.executeEmiWeb = true;
                    dataBase.bitacoraBox.put(bitacora);
                    return 1;
                  default:
                    //No se realizo con éxito el put de la acción
                    print("Error en Emi Web Imagen Firma de recibo y Producto Entregado");
                    return 0;
                }  
              }
            }
          } catch (e) { //Fallo en el momento se sincronizar
            print("Catch de syncAddImagenesEntregaInversion: $e");
            return 0;
          }
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
}

// PROCESO DE OBTENCIÓN DE PRODUCTOS COTIZADOS 
  Future<bool> executeProductosCotizadosEmiWeb(Inversiones inversion) async {
    if (await getTokenOAuth()) {
      exitoso = await getProductosCotizadosEmiWeb(inversion);
      //Verificamos que no haya habido errores en el proceso
      if (exitoso) {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = true;
        notifyListeners();
        return exitoso;
      } else {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        notifyListeners();
        return exitoso;
      }
    } else {
      print("Proceso de sync Emi Web fallido por Token");
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return false;
    }

  }


// VALIDAR QUE HAYA INFO EN EL BACKEND
// False se espera hasta que haya cotización
// True se recupera la cotización
  Future<bool> validateCotizacionFirstTimeEmiWeb(Inversiones inversion) async {
    try {
      if (await getTokenOAuth()) {
        print("idInversion Emi Web: ${inversion.idEmiWeb}");
        var url = Uri.parse("$baseUrlEmiWebServices/productosCotizados?idInversion=${inversion.idEmiWeb}");
        final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
        var response = await get(
          url,
          headers: headers
        );
        switch (response.statusCode) {
          case 200: //Caso éxitoso
            print("Caso 200");
            return true;
          case 404: //Error no existen productos cotizados a esta inversión
            print("Caso 404");
            return false;
          default:
            print("Default");
            return false;
        }  
      } else {
        print("Error en el token");
        return false;
      }
    } catch (e) {
      print("Error en validateCotizacionEmiWeb(): $e");
      return false;
    }
  }

  Future<bool> validateCotizacionNTimeEmiWeb(Inversiones inversion) async {
    try {
      if (await getTokenOAuth()) {
        var url = Uri.parse("$baseUrlEmiWebServices/productosCotizados?idInversion=${inversion.idEmiWeb}");
        final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
        var response = await get(
          url,
          headers: headers
        );
        switch (response.statusCode) {
          case 200: //Caso éxitoso
            print("Caso exitoso");
            print("${inversion.idEmiWeb}");
            print("Tamaño: ${inversion.inversionXprodCotizados.toList().length}");
            final responseListProdCotizados = getProdCotizadosEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
            print("Indice a buscar: ${int.parse(inversion.inversionXprodCotizados.toList()[inversion.inversionXprodCotizados.toList().length - 2].idEmiWeb!)}");
            print("${responseListProdCotizados.payload![int.parse(inversion.inversionXprodCotizados.toList()[inversion.inversionXprodCotizados.toList().length - 2].idEmiWeb!)] != []}");
            if(responseListProdCotizados.payload![int.parse(inversion.inversionXprodCotizados.toList()[inversion.inversionXprodCotizados.toList().length - 2].idEmiWeb!)] != []){
              print("es true");
              return true;
            } else{
              print("Es false");
              return false;
            }
          case 404: //Error no existen productos cotizados a esta inversión
            return false;
          default:
            return false;
        }  
      } else {
        return false;
      }
    } catch (e) {
      print("Error en validateCotizacionEmiWeb(): $e");
      return false;
    }
  }

  Future<bool> getProductosCotizadosEmiWeb(Inversiones inversion) async {
    try {
      //Validamos que ya se haya realizado el proceso 
        final recordInversion = await client.records.
        getOne('inversiones', 
        inversion.idDBR!);
        if (recordInversion.id.isNotEmpty) {
          print("Record Inversión no está vacía");
          final GetInversion inversionParse = getInversionFromMap(recordInversion.toString());
          final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(inversionParse.idEstadoInversionFk)).build().findUnique();
          if (estadoInversion != null) {
            if (estadoInversion.estado == "En Cotización") {
              print("Ya se ha realizado la inversión");
              //Ya se ha realizado el proceso para Emi Web
              return true;
            } else {
              print("No se ha realizado la cotización");
              if (await getTokenOAuth()) {
              var url = Uri.parse("$baseUrlEmiWebServices/productosCotizados?idInversion=${inversion.idEmiWeb}");
              final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
              var response = await get(
                url,
                headers: headers
              );
              print("Response: ${response.body}");
              switch (response.statusCode) {
                case 200: //Caso éxitoso
                print("200 Con Caso éxitoso en get Productos Exitosos Emi Web");
                  final responseListProdCotizados = getProdCotizadosEmiWebFromMap(
                  const Utf8Decoder().convert(response.bodyBytes));
                  //Se crea la instancia de inversion x prod Cotizados en el backend
                  print("SE CREA LA INSTANCIA DE INVERSION X PROD COTIZADOS EN BACKEND");
                  final inversionXprodCotizados = inversion.inversionXprodCotizados.last;
                  print("ID EMI WEB: ${responseListProdCotizados.payload![responseListProdCotizados.payload!.length - 1].first.idListaCotizacion.toString()}");
                  // print("Yo supongo que es: ${responseListProdCotizados.payload!.first[responseListProdCotizados.payload!.length - 1].idListaCotizacion.toString()}");
                  print("ID INVERSION FK: ${inversionXprodCotizados.inversion.target!.idDBR}");
                  final recordInversionXProdCotizados = await client.records.create('inversion_x_prod_cotizados', body: {
                    "id_inversion_fk": inversionXprodCotizados.inversion.target!.idDBR,
                    "id_emi_web": responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.idListaCotizacion.toString(),
                  });
                  if (recordInversionXProdCotizados.id.isNotEmpty) {
                    //Se recuperan los prod Cotizados a utilizar para ser posteados en Pocketbase
                    for (var i = 0; i < responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList!.length; i++) {
                      //Verificamos que el nuevo prod Cotizado no exista en Pocketbase
                      final recordProdCotizado = await client.records.getFullList(
                        'productos_cotizados', 
                        batch: 200, 
                        filter: "id_emi_web='${responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].idProducto.toString()}'");
                      if (recordProdCotizado.isEmpty) {
                        final productoProveedor = dataBase.productosProvBox.query(ProductosProv_.nombre.equals(responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].producto)
                        .and(ProductosProv_.marca.equals(responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].marca))
                        .and(ProductosProv_.descripcion.equals(responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].descripcion))).build().findFirst();
                        //Se crean los prod Cotizados
                        if (productoProveedor != null) {
                          await client.records.create('productos_cotizados', body: {
                            "cantidad": responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].cantidad,
                            "costo_total": responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].costoTotal,
                            "id_producto_prov_fk": productoProveedor.idDBR,
                            "id_inversion_x_prod_cotizados_fk": recordInversionXProdCotizados.id,
                            "id_emi_web": responseListProdCotizados.payload![responseListProdCotizados.payload!.length -1].first.productosCotizadosList![i].idProducto.toString(),
                            "aceptado": false
                          });
                        } else{
                          return false;
                        }
                      } else {
                        //Ya existe el prod Cotizado en Pocketbase
                        continue;
                      }
                    }
                    //Se cambia el estado a En Cotización en la colección de inversiones
                    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findUnique();
                    if (newEstadoInversion != null) {
                      final updateInversion = await client.records.update('inversiones', "${inversion.idDBR}", body: {
                      "id_estado_inversion_fk": newEstadoInversion.idDBR,
                      }); 
                      if (updateInversion.id.isNotEmpty) {
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
                case 404: //Error no existen productos cotizados a esta inversión
                  return false;
                default:
                  return false;
              }  
            } else {
              return false;
            }
            }
          } else {
            //No se encontró el estado de l inversión
            return false;
          }
        } else {
          //No se recupero la inversión en Pocketbase
          return false;
        }
    } catch (e) {
      print("Error en getProductosCotizadosEmiWeb(): $e");
      return false;
    }
  }


  // VALIDAR QUE HAYA CAMBIADO EL ESTADO DE LA INVERSION A COMPRADA
  Future<bool> validateInversionComprada(Inversiones inversion) async {
    try {
      if (await getTokenOAuth()) {
        print("Id inversion Emi Web: ${inversion.idEmiWeb}");
        var url = Uri.parse("$baseUrlEmiWebServices/inversiones/${inversion.idEmiWeb}");
        final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
        var response = await get(
          url,
          headers: headers
        );
        print("Status: ${response.statusCode}");
        print("Body: ${response.body}");
        switch (response.statusCode) {
          case 200: //Caso éxitoso
            final responseGetInversionParse = getInversionEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
            final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idEmiWeb.equals(responseGetInversionParse.payload!.idCatEstadoInversion.toString())).build().findUnique();
            if(estadoInversion != null) {
              if(estadoInversion.estado == "Comprada") {
                //Se actualiza estado de Inversión en Pocketbase
                final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
                "id_estado_inversion_fk": estadoInversion.idDBR,
                }); 
                if (record.id.isEmpty) {
                  return false;
                } else {
                    inversion.estadoInversion.target = estadoInversion;
                    dataBase.inversionesBox.put(inversion);
                    return true;
              }
              } else {
                return false;
              }
            } else {
              return false;
            }
          default:
            //Ocurrió un error
            return false;
        }  
      } else {
        return false;
      }
    } catch (e) {
      print("Error en validateInversionComprada(): $e");
      return false;
    }
  }
}

Future<void> deleteEmprendimientoLocal(int idEmprendimiento) async {
  if (idEmprendimiento != -1) {
    //Se elimina la imagen del emprendimiento
    final idImagenEmprendimiento = dataBase.imagenesBox.query(Imagenes_.emprendimiento.equals(idEmprendimiento)).build().findUnique()?.id;
    if (idImagenEmprendimiento != null) {
      dataBase.imagenesBox.remove(idImagenEmprendimiento);
    }
    //Se elimina la imagen del emprendedor
    final idEmprendedor =  dataBase.emprendedoresBox.query(Emprendedores_.emprendimiento.equals(idEmprendimiento)).build().findUnique()?.id;
    final idImagenEmprendedor = dataBase.imagenesBox.query(Imagenes_.emprendedor.equals(idEmprendedor ?? -1)).build().findUnique()?.id;
    if (idImagenEmprendedor != null) {
      dataBase.imagenesBox.remove(idImagenEmprendedor);
    }
    //Se elimina el emprendedor
    if (idEmprendedor != null) {
      dataBase.emprendedoresBox.remove(idEmprendedor);
    }
    //Se eliminan todas las imagenes 
    List<int> imagenesDelete = dataBase.imagenesBox.query(Imagenes_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var imagen in imagenesDelete) {
      dataBase.imagenesBox.remove(imagen);
    }
    //Se eliminan todas las tareas
    List<int> tareasDelete = dataBase.tareasBox.query(Tareas_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var tarea in tareasDelete) {
      dataBase.tareasBox.remove(tarea);
    }
    //Se eliminan todas las jornadas
    List<int> jornadasDelete = dataBase.jornadasBox.query(Jornadas_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var jornada in jornadasDelete) {
      dataBase.jornadasBox.remove(jornada);
    }
    //Se eliminan todas las consultorías
    List<int> consultoriasDelete = dataBase.consultoriasBox.query(Consultorias_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var consultoria in consultoriasDelete) {
      dataBase.consultoriasBox.remove(consultoria);
    }
    //Se eliminan todos los productos Emprendedor
    List<int> productosEmpDelete = dataBase.productosEmpBox.query(ProductosEmp_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var productoEmp in productosEmpDelete) {
      dataBase.productosEmpBox.remove(productoEmp);
    }
    //Se eliminan todos los productos Vendidos
    List<int> prodVendidosDelete = dataBase.productosVendidosBox.query(ProdVendidos_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var prodVendido in prodVendidosDelete) {
      dataBase.productosVendidosBox.remove(prodVendido);
    }
    //Se eliminan todas las Ventas
    List<int> ventas = dataBase.ventasBox.query(Ventas_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var venta in ventas) {
      dataBase.ventasBox.remove(venta);
    }
    //Se eliminan todos los ProdCotizados
    List<int> productosCotizados = dataBase.productosCotBox.query(ProdCotizados_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var productoCotizado in productosCotizados) {
      dataBase.productosCotBox.remove(productoCotizado);
    }
    //Se eliminan todas las Inversiones X ProdCotizados
    List<int> inversionesXproductosCotizados = dataBase.inversionesXprodCotizadosBox.query(InversionesXProdCotizados_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var inversionXproductoCotizado in inversionesXproductosCotizados) {
      dataBase.inversionesXprodCotizadosBox.remove(inversionXproductoCotizado);
    }
    //Se eliminan todos los ProdSolicitado
    List<int> productosSolicitados = dataBase.productosSolicitadosBox.query(ProdSolicitado_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var productoSolicitado in productosSolicitados) {
      dataBase.productosSolicitadosBox.remove(productoSolicitado);
    }
    //Se eliminan todas las Inversiones
    List<int> inversiones = dataBase.inversionesBox.query(Inversiones_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var inversion in inversiones) {
      dataBase.inversionesBox.remove(inversion);
    }
    //Se eliminan todos los Pagos
    List<int> pagos = dataBase.pagosBox.query(Pagos_.idEmprendimiento.equals(idEmprendimiento)).build().findIds();
    for (var pago in pagos) {
      dataBase.pagosBox.remove(pago);
    }
    //Se elimina el emprendimiento
    dataBase.emprendimientosBox.remove(idEmprendimiento);
  }
}