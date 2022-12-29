import 'dart:convert';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_emprendimiento_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_jornadas_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_emp_externo_emi_web_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class SyncEmpExternosEmiWebProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  String idEmprendimientoPocketbase = "";
  List<bool> banderasExitoSync = [];
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

//Función inicial para recuperar el Token para el llamado de proyectos
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

      var response = await post(url, headers: headers, body: bodyMsg);

      print(response.body);

      switch (response.statusCode) {
        case 200:
          final responseTokenEmiWeb = getTokenEmiWebFromMap(response.body);
          tokenGlobal = responseTokenEmiWeb.accessToken;
          return true;
        case 400:
          usuarioExit = true;
          return false;
        case 401:
          //Se actualiza Usuario archivado en Pocketbase y objectBox
          return false;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Falló al conectarse con el servidor Emi Web."),
          ));
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getProyectosExternosEmiWeb(String idEmprendimiento, Usuarios usuario) async {
    try {
      if (await getTokenOAuth()) {
        print("INICIO CON LLAMADO DE API 2");
        //API 2 Se recupera la información básica del Emprendimiento y el Emprendedor
        var url = Uri.parse("$baseUrlEmiWebServices/proyectos/emprendedor?idProyecto=$idEmprendimiento");
        final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
        var responseAPI2 = await get(
          url,
          headers: headers
        ); 
        if (responseAPI2.statusCode == 200) {
          print("Respuesta 200 en API 2");
          var basicProyecto = getBasicEmprendimientoEmiWebFromMap(
            const Utf8Decoder().convert(responseAPI2.bodyBytes)
          );
          print("Se realiza el parseo exitoso de la respuesta API 2");
          final comunidad = dataBase.comunidadesBox.query(Comunidades_.idEmiWeb.equals(basicProyecto.payload.emprendedor.comunidad.toString())).build().findUnique();
          final fase = dataBase.fasesEmpBox.query(FasesEmp_.idEmiWeb.equals(basicProyecto.payload.idCatFase.toString())).build().findUnique();
          // Se valida que el emprendimiento exista en Pocketbase
          final recordValidateEmprendimiento = await client.records.getFullList(
          'emprendimientos',
          batch: 200,
          filter:
            "id_emi_web='${basicProyecto.payload.idProyecto}'");
          if (recordValidateEmprendimiento.isEmpty) {
            print("El Emprendimiento no existe en Pocketbase");
            //El emprendimiento no existe en Pocketbase
            // Se valida que el emprendedor exista en Pocketbase
            final recordValidateEmprendedor = await client.records.getFullList(
              'emprendedores',
              batch: 200,
              filter:
                "id_emi_web='${basicProyecto.payload.emprendedor.idEmprendedor}'");
            if (recordValidateEmprendedor.isEmpty) {
              // El emprendedor no existe en Pocketbase
              if (comunidad != null && fase != null) {
                //Primero creamos el emprendedor asociado al emprendimiento
                final recordEmprendedor = await client.records.create('emprendedores', body: {
                  "nombre_emprendedor": basicProyecto.payload.emprendedor.nombre,
                  "apellidos_emp": basicProyecto.payload.emprendedor.apellidos,
                  "curp": basicProyecto.payload.emprendedor.curp,
                  "integrantes_familia": basicProyecto.payload.emprendedor.integrantesFamilia,
                  "id_comunidad_fk": comunidad.idDBR,
                  "telefono": basicProyecto.payload.emprendedor.telefono,
                  "comentarios": basicProyecto.payload.emprendedor.comentarios,
                  "id_emprendimiento_fk": "",
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": basicProyecto.payload.emprendedor.idEmprendedor,
                });

                if (recordEmprendedor.id.isNotEmpty) {
                  //Segundo creamos el emprendimiento
                  final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                    "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                    "descripcion": basicProyecto.payload.emprendedor.comentarios,
                    "activo": basicProyecto.payload.activo,
                    "archivado": basicProyecto.payload.archivado,
                    "id_promotor_fk": usuario.idDBR,
                    "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                    "id_fase_emp_fk": fase.idDBR,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "id_emprendedor_fk": recordEmprendedor.id,
                    "id_emi_web": basicProyecto.payload.idProyecto,
                  });
                  if (recordEmprendimiento.id.isNotEmpty) {
                    // Se hizo con éxito el posteo
                  } else {
                    //No se pudo postear el Emprendimiento en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  //No se pudo postear el Emprendedor en Pocketbase
                  banderasExitoSync.add(false);
                }   
              } else {
                //La comunidad o la fase no se pudo encontrar en el dispositivo
                banderasExitoSync.add(false);
              }
            } else {
              //El emprendedor ya existe en Pocketbase
              if (comunidad != null && fase != null) {
                //Segundo creamos el emprendimiento
                final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                  "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                  "descripcion": basicProyecto.payload.emprendedor.comentarios,
                  "activo": basicProyecto.payload.activo,
                  "archivado": basicProyecto.payload.archivado,
                  "id_promotor_fk": usuario.idDBR,
                  "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                  "id_fase_emp_fk": fase.idDBR,
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emprendedor_fk": recordValidateEmprendedor.first.id,
                  "id_emi_web": basicProyecto.payload.idProyecto,
                });
                if (recordEmprendimiento.id.isNotEmpty) {
                  // Se hizo con éxito el posteo
                  idEmprendimientoPocketbase = recordEmprendimiento.id;
                } else {
                  //No se pudo postear el Emprendimiento en Pocketbase
                  banderasExitoSync.add(false);
                }
              } else {
                //La comunidad o la fase no se pudo encontrar en el dispositivo
                banderasExitoSync.add(false);
              }
            }
          } else {
            print("El Emprendimiento ya existe en Pocketbase");
            print(recordValidateEmprendimiento.toString());
            //El emprendimiento ya existe en Pocketbase
            if (comunidad != null && fase != null) {
              final recordRecoverEmprendedor = await client.records.getFullList(
                'emprendedores',
                batch: 200,
                filter:
                  "id_emi_web='${basicProyecto.payload.emprendedor.idEmprendedor}'");
              if (recordRecoverEmprendedor.isNotEmpty) {
                //Primero actualizamos el emprendedor asociado al emprendimiento
                final recordEmprendedor = await client.records.update('emprendedores', recordRecoverEmprendedor.first.id, body: {
                  "nombre_emprendedor": basicProyecto.payload.emprendedor.nombre,
                  "apellidos_emp": basicProyecto.payload.emprendedor.apellidos,
                  "curp": basicProyecto.payload.emprendedor.curp,
                  "integrantes_familia": basicProyecto.payload.emprendedor.integrantesFamilia,
                  "id_comunidad_fk": comunidad.idDBR,
                  "telefono": basicProyecto.payload.emprendedor.telefono,
                  "comentarios": basicProyecto.payload.emprendedor.comentarios,
                  "id_emi_web": basicProyecto.payload.emprendedor.idEmprendedor,
                });

                if (recordEmprendedor.id.isNotEmpty) {
                  //Segundo actualizamos el emprendimiento
                  final recordEmprendimiento = await client.records.update('emprendimientos', recordValidateEmprendimiento.first.id, body: {
                    "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                    "descripcion": basicProyecto.payload.emprendedor.comentarios,
                    "activo": basicProyecto.payload.activo,
                    "archivado": basicProyecto.payload.archivado,
                    "id_promotor_fk": usuario.idDBR,
                    "id_fase_emp_fk": fase.idDBR,
                    "id_emprendedor_fk": recordEmprendedor.id,
                    "id_emi_web": basicProyecto.payload.idProyecto,
                  });
                  if (recordEmprendimiento.id.isNotEmpty) {
                    // Se hizo con éxito la actualización
                    idEmprendimientoPocketbase = recordEmprendimiento.id;
                  } else {
                    // No se pudo actualizar el Emprendimiento en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  // No se pudo actualizar el Emprendedor en Pocketbase
                  banderasExitoSync.add(false);
                }  
              } else {
                // No se pudo encontrar el emprendedor asociado en Pocketbase
                banderasExitoSync.add(false);
              } 
            } else {
              // La comunidad o la fase no se pudo encontrar en el dispositivo
              banderasExitoSync.add(false);
            }
          }
          print("LLAMADO DE API 3");
          //API 3 Se recupera la información básica de las Jornadas
          // var url = Uri.parse("$baseUrlEmiWebServices/jornadas/emprendimiento?idProyecto=$idEmprendimiento");
          // final headers = ({
          //     "Content-Type": "application/json",
          //     'Authorization': 'Bearer $tokenGlobal',
          //   });
          // var responseAPI3 = await get(
          //   url,
          //   headers: headers
          // ); 
          // switch (responseAPI3.statusCode) {
          //   case 200:
          //     print("Respuesta 200 en API 3");
          //     var basicJornadas = getBasicJornadasEmiWebFromMap(
          //       const Utf8Decoder().convert(responseAPI3.bodyBytes)
          //     );
          //     // if (basicJornadas.payload!.jornada1 != null) {
          //     //     final nuevaJornada1 = Jornadas(
          //     //       numJornada: elementJornada.numJornada.toString(),
          //     //       fechaRevision: elementJornada.proximaVisita!,
          //     //       fechaRegistro: elementJornada.created,
          //     //       completada: elementJornada.completada,
          //     //       idDBR: elementJornada.id,
          //     //       idEmiWeb: elementJornada.idEmiWeb,
          //     //     );
          //     //     final nuevaTarea1 = Tareas(
          //     //       tarea: elementJornada.expand.idTareaFk.tarea,
          //     //       descripcion: "Creación Jornada 1",
          //     //       fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
          //     //       fechaRegistro: elementJornada.expand.idTareaFk.created,
          //     //       idDBR: elementJornada.expand.idTareaFk.id,
          //     //       idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
          //     //     );
          //     //     nuevaJornada1.tarea.target = nuevaTarea1;
          //     //     nuevaJornada1.emprendimiento.target = nuevoEmprendimiento;
          //     //     nuevaTarea1.jornada.target = nuevaJornada1;
          //     //     nuevoEmprendimiento.jornadas.add(nuevaJornada1);
          //     //     dataBase.jornadasBox.put(nuevaJornada1);
          //     //     dataBase.tareasBox.put(nuevaTarea1);
          //     //     dataBase.emprendimientosBox.put(nuevoEmprendimiento);
          //     //   }
          //     break;
          //   case 404:
          //     break;
          //   default:
          //   print("Error en llamado al API 3");
          //   print(responseAPI2.statusCode);
          //   banderasExitoSync.add(false);
          // }
        } else {
          print("Error en llamado al API 2");
          print(responseAPI2.statusCode);
          banderasExitoSync.add(false);
        }
        for (var element in banderasExitoSync) {
        //Aplicamos una operación and para validar que no haya habido un catálogo con False
          exitoso = exitoso && element;
        }
        //Verificamos que no haya habido errores al sincronizar con las banderas
        if (exitoso) {
          procesocargando = false;
          procesoterminado = true;
          procesoexitoso = true;
          banderasExitoSync.clear();
          notifyListeners();
          return exitoso;
        } else {
          procesocargando = false;
          procesoterminado = true;
          procesoexitoso = false;
          banderasExitoSync.clear();
          notifyListeners();
          return exitoso;
        }
      } else {
        print("Falló en Recuperar Token");
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        banderasExitoSync.clear();
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Catch de Descarga Productos Externos Emi Web: $e");
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExitoSync.clear();
      notifyListeners();
      return false;
    }
  }

//Función para recuperar los emprendimientos externos de EmiWeb
  Future<List<UsuarioProyectosTemporal>?> getUsuariosProyectosEmiWeb() async {
    final GetEmpExternoEmiWebTemp listEmpExternosEmiWebTemp;
    List<UsuarioProyectosTemporal> listUsuariosProyectosTemp = [];
    try {
      if (await getTokenOAuth()) {
        //Se recupera toda la colección de usuarios en EmiWeb
        var url = Uri.parse("$baseUrlEmiWebServices/proyectos/emprendedor/promotor");
        final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
        var response = await get(
          url,
          headers: headers
        ); 

        if (response.statusCode == 200) {
          listEmpExternosEmiWebTemp = getEmpExternoEmiWebTempFromMap(
            const Utf8Decoder().convert(response.bodyBytes)
          );

          for (var elementEmprendimientoEmp in listEmpExternosEmiWebTemp.payload!.toList()) {
            var indexItemUpdated = listUsuariosProyectosTemp.indexWhere((elementUsuario) => elementUsuario.usuarioTemp.idUsuario == elementEmprendimientoEmp.promotor.idUsuario);
            if (indexItemUpdated != -1) {
              listUsuariosProyectosTemp[indexItemUpdated].emprendimientosTemp.add(elementEmprendimientoEmp);
            } else {
              final newUsuarioProyectoTemporal = 
              UsuarioProyectosTemporal(
                usuarioTemp: elementEmprendimientoEmp.promotor, 
                emprendimientosTemp: [elementEmprendimientoEmp]
              );
              listUsuariosProyectosTemp.add(newUsuarioProyectoTemporal);
            }
          }
          return listUsuariosProyectosTemp;
        } else {
          print("Error en llamado al API");
          print(response.statusCode);
          return null;
        }
      } else {
        print("Falló en Recuperar Token");
        return null;
      }
    } catch (e) {
      print("Catch en Recuperación de Usuarios");
      print(e);
      return null;
    }
  }
}
