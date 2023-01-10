import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_consultorias_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_emprendimiento_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_inversiones_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_jornadas_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_productos_emprendedor_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_basic_ventas_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_emp_externo_emi_web_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_single_consultorias_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_single_jornada_pocketbase.dart';
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
                  final catProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idEmiWeb.equals(basicProyecto.payload.idCatProyecto.toString())).build().findUnique();
                  final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                    "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                    "descripcion": basicProyecto.payload.emprendedor.comentarios == "" ? "Sin Descripción" : basicProyecto.payload.emprendedor.comentarios,
                    "activo": basicProyecto.payload.activo,
                    "archivado": basicProyecto.payload.archivado,
                    "id_promotor_fk": usuario.idDBR,
                    "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                    "id_fase_emp_fk": fase.idDBR,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "id_emprendedor_fk": recordEmprendedor.id,
                    "id_emi_web": basicProyecto.payload.idProyecto,
                    "id_nombre_proyecto_fk": catProyecto?.idDBR ?? "",
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
                final catProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idEmiWeb.equals(basicProyecto.payload.idCatProyecto.toString())).build().findUnique();
                final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                  "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                  "descripcion": basicProyecto.payload.emprendedor.comentarios == "" ? "Sin Descripción" : basicProyecto.payload.emprendedor.comentarios,
                  "activo": basicProyecto.payload.activo,
                  "archivado": basicProyecto.payload.archivado,
                  "id_promotor_fk": usuario.idDBR,
                  "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                  "id_fase_emp_fk": fase.idDBR,
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emprendedor_fk": recordValidateEmprendedor.first.id,
                  "id_emi_web": basicProyecto.payload.idProyecto,
                  "id_nombre_proyecto_fk": catProyecto?.idDBR ?? "",
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
                  final catProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idEmiWeb.equals(basicProyecto.payload.idCatProyecto.toString())).build().findUnique();
                  final recordEmprendimiento = await client.records.update('emprendimientos', recordValidateEmprendimiento.first.id, body: {
                    "nombre_emprendimiento": basicProyecto.payload.emprendimiento,
                    "descripcion": basicProyecto.payload.emprendedor.comentarios == "" ? "Sin Descripción" : basicProyecto.payload.emprendedor.comentarios,
                    "activo": basicProyecto.payload.activo,
                    "archivado": basicProyecto.payload.archivado,
                    "id_promotor_fk": usuario.idDBR,
                    "id_fase_emp_fk": fase.idDBR,
                    "id_emprendedor_fk": recordEmprendedor.id,
                    "id_emi_web": basicProyecto.payload.idProyecto,
                    "id_nombre_proyecto_fk": catProyecto?.idDBR ?? "",
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
          // API 3 Se recupera la información básica de las Jornadas
          var url = Uri.parse("$baseUrlEmiWebServices/jornadas/emprendimiento?idProyecto=$idEmprendimiento");
          final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
          var responseAPI3 = await get(
            url,
            headers: headers
          ); 
          switch (responseAPI3.statusCode) {
            case 200:
              print("Respuesta 200 en API 3");
              var basicJornadas = getBasicJornadasEmiWebFromMap(
                const Utf8Decoder().convert(responseAPI3.bodyBytes)
              );
              if (basicJornadas.payload!.jornada1 != null) {
                // Se valida que la jornada exista en Pocketbase
                final recordValidateJornada = await client.records.getFullList(
                  'jornadas',
                  batch: 200,
                  filter:
                    "id_emi_web='${basicJornadas.payload!.jornada1!.idJornada1}'&&num_jornada~1");
                if (recordValidateJornada.isEmpty) {
                  print("La jornada 1 no existe en Pocketbase");
                  //Primero creamos la tarea asociada a la jornada
                  final recordTarea = await client.records.create('tareas', body: {
                  "tarea": basicJornadas.payload!.jornada1!.registrarTarea,
                  "descripcion": "Creación Jornada 1",
                  "fecha_revision": basicJornadas.payload!.jornada1!.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": basicJornadas.payload!.jornada1!.idJornada1.toString(),
                  "jornada": true,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Segundo creamos la jornada  
                    final recordJornada = await client.records.create('jornadas', body: {
                      "num_jornada": 1,
                      "id_tarea_fk": recordTarea.id,
                      "proxima_visita": basicJornadas.payload!.jornada1!.fechaRevision.toUtc().toString(),
                      "id_emprendimiento_fk": idEmprendimientoPocketbase,
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                      "completada": basicJornadas.payload!.jornada1!.tareaCompletada,
                      "id_emi_web": basicJornadas.payload!.jornada1!.idJornada1.toString(),
                    });

                    if (recordJornada.id.isNotEmpty) {
                      //Se hizo con éxito la actualización
                    } else {
                      //No se pudo postear la Jornada en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    //No se pudo postear la Tarea asociada a la Jornada 1 en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  print("La jornada 1 ya existe en Pocketbase");
                  //Se actualiza la Jornada 1 y su Tarea asociada
                  //Primero actualizamos la Jornada 1
                  final recordJ1 = await client.records.update('jornadas', recordValidateJornada.first.id, body: {
                    "proxima_visita": basicJornadas.payload!.jornada1!.fechaRevision.toUtc().toString(),
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": basicJornadas.payload!.jornada1!.tareaCompletada,
                  });

                  if (recordJ1.id.isNotEmpty) {
                    print("Se actualiza la Tarea de la J1");
                    print(recordJ1.toString());
                    //Se recupere el id de la tarea asociada a la J1
                    var singleJornada1 = getSingleJornadaPocketbaseFromMap(recordJ1.toString());
                    //Segundo actualizamos la tarea asociada a la J1
                    final recordTareaJ1 = await client.records.update('tareas', singleJornada1.idTareaFk, body: {
                      "tarea": basicJornadas.payload!.jornada1!.registrarTarea,
                      "descripcion": "Creación Jornada 1",
                      "fecha_revision": basicJornadas.payload!.jornada1!.fechaRevision.toUtc().toString(),
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    });
                    if (recordTareaJ1.id.isNotEmpty) {
                      // Se hizo con éxito la actualización
                    } else {
                      // No se pudo actualizar la Tarea de la J1 en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    // No se pudo actualizar la J1 en Pocketbase
                    banderasExitoSync.add(false);
                  }  
                }
              }
              if (basicJornadas.payload!.jornada2 != null) {
                // Se valida que la jornada exista en Pocketbase
                final recordValidateJornada = await client.records.getFullList(
                  'jornadas',
                  batch: 200,
                  filter:
                    "id_emi_web='${basicJornadas.payload!.jornada2!.idJornada2}'&&num_jornada~2");
                if (recordValidateJornada.isEmpty) {
                  print("La jornada 2 no existe en Pocketbase");
                  // Creamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada2!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada2!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada2!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada2!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada2!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J2 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada2!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada2!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J2 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Primero creamos la tarea asociada a la jornada
                  final recordTarea = await client.records.create('tareas', body: {
                  "tarea": basicJornadas.payload!.jornada2!.registrarTarea,
                  "descripcion": "Creación Jornada 2",
                  "comentarios": basicJornadas.payload!.jornada2!.comentarios,
                  "fecha_revision": basicJornadas.payload!.jornada2!.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": basicJornadas.payload!.jornada2!.idJornada2.toString(),
                  "id_imagenes_fk": idsDBRImagenes,
                  "jornada": true,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Segundo creamos la jornada  
                    final recordJornada = await client.records.create('jornadas', body: {
                      "num_jornada": 2,
                      "id_tarea_fk": recordTarea.id,
                      "proxima_visita": basicJornadas.payload!.jornada2!.fechaRevision.toUtc().toString(),
                      "id_emprendimiento_fk": idEmprendimientoPocketbase,
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                      "completada": basicJornadas.payload!.jornada2!.tareaCompletada,
                      "id_emi_web": basicJornadas.payload!.jornada2!.idJornada2.toString(),
                    });

                    if (recordJornada.id.isNotEmpty) {
                      //Se hizo con éxito la actualización
                    } else {
                      //No se pudo postear la Jornada en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    //No se pudo postear la Tarea asociada a la Jornada 2 en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  print("La jornada 2 ya existe en Pocketbase");
                  // ACtualizamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada2!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada2!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada2!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada2!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada2!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J2 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada2!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada2!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J2 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Se actualiza la Jornada 2 y su Tarea asociada
                  //Primero actualizamos la Jornada 2
                  final recordJ2 = await client.records.update('jornadas', recordValidateJornada.first.id, body: {
                    "proxima_visita": basicJornadas.payload!.jornada2!.fechaRevision.toUtc().toString(),
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": basicJornadas.payload!.jornada2!.tareaCompletada,
                  });

                  if (recordJ2.id.isNotEmpty) {
                    //Se recupere el id de la tarea asociada a la J2
                    var singleJornada2 = getSingleJornadaPocketbaseFromMap(recordJ2.toString());
                    //Segundo actualizamos la tarea asociada a la J2
                    final recordTareaJ2 = await client.records.update('tareas', singleJornada2.idTareaFk, body: {
                      "tarea": basicJornadas.payload!.jornada2!.registrarTarea,
                      "descripcion": "Creación Jornada 2",
                      "comentarios": basicJornadas.payload!.jornada2!.comentarios,
                      "fecha_revision": basicJornadas.payload!.jornada2!.fechaRevision.toUtc().toString(),
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    });
                    if (recordTareaJ2.id.isNotEmpty) {
                      // Se hizo con éxito la actualización
                    } else {
                      // No se pudo actualizar la Tarea de la J2 en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    // No se pudo actualizar la J2 en Pocketbase
                    banderasExitoSync.add(false);
                  }  
                }
              }
              if (basicJornadas.payload!.jornada3 != null) {
                // Se valida que la jornada exista en Pocketbase
                final recordValidateJornada = await client.records.getFullList(
                  'jornadas',
                  batch: 200,
                  filter:
                    "id_emi_web='${basicJornadas.payload!.jornada3!.idJornada3}'&&num_jornada~3");
                if (recordValidateJornada.isEmpty) {
                  print("La jornada 3 no existe en Pocketbase");
                  // Creamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada3!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada3!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada3!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada3!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada3!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J3 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada3!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada3!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J3 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Primero creamos la tarea asociada a la jornada
                  final recordTarea = await client.records.create('tareas', body: {
                  "tarea": basicJornadas.payload!.jornada3!.registrarTarea,
                  "descripcion": basicJornadas.payload!.jornada3!.descripcion,
                  "comentarios": basicJornadas.payload!.jornada3!.comentarios,
                  "fecha_revision": basicJornadas.payload!.jornada3!.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": basicJornadas.payload!.jornada3!.idJornada3.toString(),
                  "id_imagenes_fk": idsDBRImagenes,
                  "jornada": true,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Segundo creamos la jornada  
                    final recordJornada = await client.records.create('jornadas', body: {
                      "num_jornada": 3,
                      "id_tarea_fk": recordTarea.id,
                      "proxima_visita": basicJornadas.payload!.jornada3!.fechaRevision.toUtc().toString(),
                      "id_emprendimiento_fk": idEmprendimientoPocketbase,
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                      "completada": basicJornadas.payload!.jornada3!.tareaCompletada,
                      "id_emi_web": basicJornadas.payload!.jornada3!.idJornada3.toString(),
                    });

                    if (recordJornada.id.isNotEmpty) {
                      //Se hizo con éxito la alta
                      // Creamos la inversión asociada a la J3
                      var totalInversion = 0.0;
                      for (var element in basicJornadas.payload!.productoDeProyecto!.toList()) {
                        totalInversion = totalInversion + (element?.costoEstimado ?? 0.0);
                      }
                      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
                      if (estadoInversion != null) {
                        final recordInversion =
                          await client.records.create('inversiones', body: {
                          "id_emprendimiento_fk": idEmprendimientoPocketbase,
                          "id_estado_inversion_fk": estadoInversion.idDBR,
                          "porcentaje_pago": 50,
                          "monto_pagar": 0,
                          "saldo": 0,
                          "total_inversion": totalInversion,
                          "inversion_recibida": true,
                          "pago_recibido": false,
                          "producto_entregado": false,
                          "id_emi_web": "0",
                          "jornada_3": true,
                        });
                        if (recordInversion.id.isNotEmpty) {
                          // Creamos y enviamos los prod Solicitados
                          for (var i = 0;
                            i < basicJornadas.payload!.productoDeProyecto!.toList().length;
                            i++) {
                              final familiaProducto = dataBase.familiaProductosBox.query(FamiliaProd_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idFamilia.toString())).build().findFirst();
                              final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.unidadMedida.toString())).build().findFirst();
                              if (familiaProducto != null && tipoEmpaque != null) {
                                final recordProdProyecto = await client.records
                                  .create('productos_proyecto', body: {
                                  "producto": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.producto,
                                  "marca_sugerida": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.marcaRecomendada,
                                  "descripcion": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.descripcion,
                                  "proveedo_sugerido": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.proveedorSugerido,
                                  "cantidad": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.cantidad,
                                  "costo_estimado": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.costoEstimado,
                                  "id_familia_prod_fk": familiaProducto.idDBR,
                                  "id_tipo_empaque_fk": tipoEmpaque.idDBR,
                                  "id_inversion_fk": recordInversion.id,
                                  "id_emi_web": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idProductoDeProyecto,
                                });
                                if (recordProdProyecto.id.isNotEmpty) {
                                  //Se hizo con éxito la alta
                                } else {
                                  //No se pudo postear el Producto Proyecto de la inversión en la J3 en Pocketbase
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //No se pudo recuperar información del producto del proyecto en la Inversión de la J3
                                banderasExitoSync.add(false);
                              }
                            }
                        } else {
                          //No se pudo postear la inversión en la J3 en Pocketbase
                          banderasExitoSync.add(false);
                        }
                      } else {
                        //No se pudo recuperar información de la Inversión asociada a la J3
                        banderasExitoSync.add(false);
                      }
                    } else {
                      //No se pudo postear la Jornada en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    //No se pudo postear la Tarea asociada a la Jornada 3 en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  print("La jornada 3 ya existe en Pocketbase");
                  // ACtualizamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada3!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada3!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada3!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada3!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada3!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J3 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada3!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada3!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J3 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Se actualiza la Jornada 3 y su Tarea asociada
                  //Primero actualizamos la Jornada 3
                  final recordJ3 = await client.records.update('jornadas', recordValidateJornada.first.id, body: {
                    "proxima_visita": basicJornadas.payload!.jornada3!.fechaRevision.toUtc().toString(),
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": basicJornadas.payload!.jornada3!.tareaCompletada,
                  });

                  if (recordJ3.id.isNotEmpty) {
                    //Se recupere el id de la tarea asociada a la J3
                    var singleJornada3 = getSingleJornadaPocketbaseFromMap(recordJ3.toString());
                    //Segundo actualizamos la tarea asociada a la J3
                    final recordTareaJ3 = await client.records.update('tareas', singleJornada3.idTareaFk, body: {
                      "tarea": basicJornadas.payload!.jornada3!.registrarTarea,
                      "descripcion": basicJornadas.payload!.jornada3!.descripcion,
                      "comentarios": basicJornadas.payload!.jornada3!.comentarios,
                      "fecha_revision": basicJornadas.payload!.jornada3!.fechaRevision.toUtc().toString(),
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    });
                    if (recordTareaJ3.id.isNotEmpty) {
                      // Se hizo con éxito la actualización
                      //Se actualiza la inversión asociada a la J3
                      final recordValidateInversionJ3 = await client.records.getFullList(
                      'inversiones',
                      batch: 200,
                      filter:
                        "id_emi_web='0'&&id_emprendimiento_fk='$idEmprendimientoPocketbase'");
                      if (recordValidateInversionJ3.isEmpty) {
                        //La inversión asociada a la J3 no existe en Pocketbase
                        // Creamos la inversión asociada a la J3
                        var totalInversion = 0.0;
                        for (var element in basicJornadas.payload!.productoDeProyecto!.toList()) {
                          totalInversion = totalInversion + (element?.costoEstimado ?? 0.0);
                        }
                        final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
                        if (estadoInversion != null) {
                          final recordInversion =
                            await client.records.create('inversiones', body: {
                            "id_emprendimiento_fk": idEmprendimientoPocketbase,
                            "id_estado_inversion_fk": estadoInversion.idDBR,
                            "porcentaje_pago": 50,
                            "monto_pagar": 0,
                            "saldo": 0,
                            "total_inversion": totalInversion,
                            "inversion_recibida": true,
                            "pago_recibido": false,
                            "producto_entregado": false,
                            "id_emi_web": "0",
                            "jornada_3": true,
                          });
                          if (recordInversion.id.isNotEmpty) {
                            // Creamos y enviamos los productos proyecto
                            for (var i = 0;
                              i < basicJornadas.payload!.productoDeProyecto!.toList().length;
                              i++) {
                                final familiaProducto = dataBase.familiaProductosBox.query(FamiliaProd_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idFamilia.toString())).build().findFirst();
                                final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.unidadMedida.toString())).build().findFirst();
                                if (familiaProducto != null && tipoEmpaque != null) {
                                  final recordProdProyecto = await client.records
                                    .create('productos_proyecto', body: {
                                    "producto": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.producto,
                                    "marca_sugerida": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.marcaRecomendada,
                                    "descripcion": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.descripcion,
                                    "proveedo_sugerido": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.proveedorSugerido,
                                    "cantidad": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.cantidad,
                                    "costo_estimado": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.costoEstimado,
                                    "id_familia_prod_fk": familiaProducto.idDBR,
                                    "id_tipo_empaque_fk": tipoEmpaque.idDBR,
                                    "id_inversion_fk": recordInversion.id,
                                    "id_emi_web": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idProductoDeProyecto,
                                  });
                                  if (recordProdProyecto.id.isNotEmpty) {
                                    //Se hizo con éxito la alta
                                  } else {
                                    //No se pudo postear el Producto Proyecto de la inversión en la J3 en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información del producto del proyecto en la Inversión de la J3
                                  banderasExitoSync.add(false);
                                }
                              }
                          } else {
                            //No se pudo postear la inversión en la J3 en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        } else {
                          //No se pudo recuperar información de la Inversión asociada a la J3
                          banderasExitoSync.add(false);
                        }
                      } else {
                        //La inversión asociada a la J3 ya existe en Pocketbase
                        // Actualizamos la inversión asociada a la J3
                        var totalInversion = 0.0;
                        for (var element in basicJornadas.payload!.productoDeProyecto!.toList()) {
                          totalInversion = totalInversion + (element?.costoEstimado ?? 0.0);
                        }
                        final recordInversion =
                          await client.records.update('inversiones', recordValidateInversionJ3.first.id, body: {
                          "id_emprendimiento_fk": idEmprendimientoPocketbase,
                          "total_inversion": totalInversion,
                          "inversion_recibida": true,
                          "pago_recibido": false,
                          "producto_entregado": false,
                          "jornada_3": true,
                        });
                        if (recordInversion.id.isNotEmpty) {
                          // Actualizamos los productos del Proyecto
                          //Recuperamos todos los productos existentes en Emi Web
                          final recordProductosProyecto = await client.records.getFullList(
                          'productos_proyecto',
                          batch: 200,
                          filter:
                            "id_inversion_fk='${recordInversion.id}'");
                          final List<String> idsProductosProyectoEliminados = [];
                          //Recuperamos los ids de los productos existentes en Emi Web
                          for (var element in recordProductosProyecto) {
                            idsProductosProyectoEliminados.add(element.id);
                          }
                          //Se recorre la lista de productos de proyecto de la respuesta desde Emi Web
                          for (var i = 0;
                            i < basicJornadas.payload!.productoDeProyecto!.toList().length;
                            i++) {
                              //Se valida que el producto Proyecto exista en Pocketbase
                              final recordProductoProyecto = await client.records.getFullList(
                                'productos_proyecto',
                                batch: 200,
                                filter:
                                  "id_emi_web='${basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idProductoDeProyecto}'");
                              if (recordProductoProyecto.isEmpty) {
                                //El producto proyecto no existe en Pocketbase
                                final familiaProducto = dataBase.familiaProductosBox.query(FamiliaProd_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idFamilia.toString())).build().findFirst();
                                final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.unidadMedida.toString())).build().findFirst();
                                if (familiaProducto != null && tipoEmpaque != null) {
                                  final recordProdProyecto = await client.records
                                    .create('productos_proyecto', body: {
                                    "producto": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.producto,
                                    "marca_sugerida": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.marcaRecomendada,
                                    "descripcion": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.descripcion,
                                    "proveedo_sugerido": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.proveedorSugerido,
                                    "cantidad": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.cantidad,
                                    "costo_estimado": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.costoEstimado,
                                    "id_familia_prod_fk": familiaProducto.idDBR,
                                    "id_tipo_empaque_fk": tipoEmpaque.idDBR,
                                    "id_inversion_fk": recordInversion.id,
                                    "id_emi_web": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idProductoDeProyecto,
                                  });
                                  if (recordProdProyecto.id.isNotEmpty) {
                                    //Se hizo con éxito la alta del producto proyecto
                                    idsProductosProyectoEliminados.remove(recordProdProyecto.id);
                                  } else {
                                    //No se pudo postear el Producto Proyecto de la inversión en la J3 en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información del producto del proyecto en la Inversión de la J3
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //El producto proyecto ya existe en Pocketbase
                                final familiaProducto = dataBase.familiaProductosBox.query(FamiliaProd_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.idFamilia.toString())).build().findFirst();
                                final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idEmiWeb.equals(basicJornadas.payload!.productoDeProyecto!.toList()[i]!.unidadMedida.toString())).build().findFirst();
                                if (familiaProducto != null && tipoEmpaque != null) {
                                  final recordProdProyecto = await client.records
                                    .update('productos_proyecto', recordProductoProyecto.first.id, body: {
                                      "producto": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.producto,
                                      "marca_sugerida": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.marcaRecomendada,
                                      "descripcion": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.descripcion,
                                      "proveedo_sugerido": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.proveedorSugerido,
                                      "cantidad": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.cantidad,
                                      "costo_estimado": basicJornadas.payload!.productoDeProyecto!.toList()[i]!.costoEstimado,
                                      "id_familia_prod_fk": familiaProducto.idDBR,
                                      "id_tipo_empaque_fk": tipoEmpaque.idDBR,
                                  });
                                  if (recordProdProyecto.id.isNotEmpty) {
                                    //Se hizo con éxito la actualización del producto proyecto
                                    idsProductosProyectoEliminados.remove(recordProdProyecto.id);
                                  } else {
                                    //No se pudo actualizar el Producto Proyecto de la inversión en la J3 en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información del producto del proyecto en la Inversión de la J3
                                  banderasExitoSync.add(false);
                                }
                              }
                            }
                            //Se eliminan los productos de proyecto sobrantes
                            for (var element in idsProductosProyectoEliminados) {
                              await client.records.delete('productos_proyecto', element);
                            }
                        } else {
                          //No se pudo postear la inversión en la J3 en Pocketbase
                          banderasExitoSync.add(false);
                        }
                      }
                    } else {
                      // No se pudo actualizar la Tarea de la J3 en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    // No se pudo actualizar la J3 en Pocketbase
                    banderasExitoSync.add(false);
                  }  
                }
              }
              if (basicJornadas.payload!.jornada4 != null) {
                // Se valida que la jornada exista en Pocketbase
                final recordValidateJornada = await client.records.getFullList(
                  'jornadas',
                  batch: 200,
                  filter:
                    "id_emi_web='${basicJornadas.payload!.jornada4!.idJornada4}'&&num_jornada~4");
                if (recordValidateJornada.isEmpty) {
                  print("La jornada 4 no existe en Pocketbase");
                  // Creamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada4!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada4!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada4!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada4!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada4!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J4 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada4!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada4!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J4 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Primero creamos la tarea asociada a la jornada
                  final recordTarea = await client.records.create('tareas', body: {
                  "tarea": "Creación Jornada 4",
                  "descripcion": "Creación Jornada 4",
                  "comentarios": basicJornadas.payload!.jornada4!.comentarios,
                  "fecha_revision": basicJornadas.payload!.jornada4!.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": basicJornadas.payload!.jornada4!.idJornada4.toString(),
                  "id_imagenes_fk": idsDBRImagenes,
                  "jornada": true,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Segundo creamos la jornada  
                    final recordJornada = await client.records.create('jornadas', body: {
                      "num_jornada": 4,
                      "id_tarea_fk": recordTarea.id,
                      "proxima_visita": basicJornadas.payload!.jornada4!.fechaRevision.toUtc().toString(),
                      "id_emprendimiento_fk": idEmprendimientoPocketbase,
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                      "completada": true,
                      "id_emi_web": basicJornadas.payload!.jornada4!.idJornada4.toString(),
                    });

                    if (recordJornada.id.isNotEmpty) {
                      //Se hizo con éxito la actualización
                    } else {
                      //No se pudo postear la Jornada en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    //No se pudo postear la Tarea asociada a la Jornada 2 en Pocketbase
                    banderasExitoSync.add(false);
                  }
                } else {
                  print("La jornada 4 ya existe en Pocketbase");
                  // Actualizamos las imágenes de la jornada
                  List<String> idsDBRImagenes = [];
                  for (var i = 0; i < basicJornadas.payload!.jornada4!.documentos.toList().length; i++) {
                    // Se valida que la imagen no exista en Pocketbase
                    final recordValidateImagen = await client.records.getFullList(
                      'imagenes',
                      batch: 200,
                      filter:
                        "id_emi_web='${basicJornadas.payload!.jornada4!.documentos.toList()[i].idDocumento}'");
                    if (recordValidateImagen.isEmpty) {
                      // La imagen no existe y se tiene que crear
                      final recordImagen = await client.records.create('imagenes', body: {
                        "nombre": basicJornadas.payload!.jornada4!.documentos.toList()[i].nombreArchivo,
                        "id_emi_web": basicJornadas.payload!.jornada4!.documentos.toList()[i].idDocumento,
                        "base64": basicJornadas.payload!.jornada4!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo agregar una Imagen de la J4 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    } else {
                      // La imagen existe y se tiene que actualizar
                      final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id,body: {
                        "nombre": basicJornadas.payload!.jornada4!.documentos.toList()[i].nombreArchivo,
                        "base64": basicJornadas.payload!.jornada4!.documentos.toList()[i].archivo,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        idsDBRImagenes.add(recordImagen.id);
                      } else {
                        // No se pudo actualizar una Imagen de la J4 en Pocketbase
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  //Se actualiza la Jornada 4 y su Tarea asociada
                  //Primero actualizamos la Jornada 4
                  final recordJ4 = await client.records.update('jornadas', recordValidateJornada.first.id, body: {
                    "proxima_visita": basicJornadas.payload!.jornada4!.fechaRevision.toUtc().toString(),
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": true,
                  });

                  if (recordJ4.id.isNotEmpty) {
                    //Se recupera el id de la tarea asociada a la J4
                    var singleJornada4 = getSingleJornadaPocketbaseFromMap(recordJ4.toString());
                    //Segundo actualizamos la tarea asociada a la J4
                    final recordTareaJ4 = await client.records.update('tareas', singleJornada4.idTareaFk, body: {
                      "comentarios": basicJornadas.payload!.jornada4!.comentarios,
                      "fecha_revision": basicJornadas.payload!.jornada4!.fechaRevision.toUtc().toString(),
                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    });
                    if (recordTareaJ4.id.isNotEmpty) {
                      // Se hizo con éxito la actualización
                    } else {
                      // No se pudo actualizar la Tarea de la J2 en Pocketbase
                      banderasExitoSync.add(false);
                    }
                  } else {
                    // No se pudo actualizar la J2 en Pocketbase
                    banderasExitoSync.add(false);
                  }  
                }
              }
              print("LLAMADO DE API 5");
              // API 5 Se recupera la información básica de los productos del Emprendedor
              var url = Uri.parse("$baseUrlEmiWebServices/productosEmprendedor/emprendimiento?idEmprendimiento=$idEmprendimiento");
              final headers = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
              var responseAPI5 = await get(
                url,
                headers: headers
              ); 
              switch(responseAPI5.statusCode)
              {
                case 200:
                  print("Respuesta 200 en API 5");
                  var basicProductosEmprendedor = getBasicProductosEmprendedorEmiWebFromMap(
                    const Utf8Decoder().convert(responseAPI5.bodyBytes)
                  );
                  for(var productoEmprendedor in basicProductosEmprendedor.payload!)
                  {
                    // Se valida que el producto del emprendedor exista en Pocketbase
                    final recordValidateProductoEmp = await client.records.getFullList(
                      'productos_emp',
                      batch: 200,
                      filter:
                        "id_emi_web='${productoEmprendedor.idProductoEmprendedor}'");
                    if (recordValidateProductoEmp.isEmpty) {
                      print("El Producto del Emprendedor con id Emi Web ${productoEmprendedor.idProductoEmprendedor} no existe en Pocketbase");
                      //Se verifica que el producto del emprendedor tenga imagen 
                      if (productoEmprendedor.documento != null) {
                        //El Producto del Emprendedor tiene imagen asociada
                        //Se crea la imagen del Producto del Emprendedor
                        final recordImagen = await client.records.create('imagenes', body: {
                          "nombre": productoEmprendedor.documento!.nombreArchivo,
                          "id_emi_web": productoEmprendedor.documento!.idDocumento,
                          "base64": productoEmprendedor.documento!.archivo,
                        });
                        if (recordImagen.id.isNotEmpty) {
                          final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(productoEmprendedor.idUnidadMedida.toString())).build().findUnique();
                          if (unidadMedida != null) {
                            //Se crea el producto del Emprendedor
                            final recordProductoEmp = await client.records.create('productos_emp', body: {
                              "nombre_prod_emp": productoEmprendedor.producto,
                              "descripcion": productoEmprendedor.descripcion,
                              "id_und_medida_fk": unidadMedida.idDBR,
                              "costo_prod_emp": productoEmprendedor.costoUnidadMedida,
                              "id_emprendimiento_fk": idEmprendimientoPocketbase,
                              "archivado": productoEmprendedor.archivado,
                              "id_emi_web": productoEmprendedor.idProductoEmprendedor.toString(),
                              "id_imagen_fk": recordImagen.id,
                            });
                            if (recordProductoEmp.id.isNotEmpty) {
                              //Se hizo con éxito el posteo del producto del emprendedor
                            } else {
                              // No se pudo agregar un Producto del Emprendedor en Pocketbase
                              banderasExitoSync.add(false);
                            }
                          } else {
                            //No se pudo recuperar información del producto del emprendedor para postearlo
                            banderasExitoSync.add(false);
                          }
                        } else {
                          // No se pudo agregar la Imagen del producto del emprendedor en Pocketbase
                          banderasExitoSync.add(false);
                        }
                      } else {
                        //El producto del emprendedor no tiene imagen asociada
                        final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(productoEmprendedor.idUnidadMedida.toString())).build().findUnique();
                        if (unidadMedida != null) {
                          //Se crea el producto del Emprendedor
                          final recordProductoEmp = await client.records.create('productos_emp', body: {
                            "nombre_prod_emp": productoEmprendedor.producto,
                            "descripcion": productoEmprendedor.descripcion,
                            "id_und_medida_fk": unidadMedida.idDBR,
                            "costo_prod_emp": productoEmprendedor.costoUnidadMedida,
                            "id_emprendimiento_fk": idEmprendimientoPocketbase,
                            "archivado": productoEmprendedor.archivado,
                            "id_emi_web": productoEmprendedor.idProductoEmprendedor.toString(),
                          });
                          if (recordProductoEmp.id.isNotEmpty) {
                            //Se hizo con éxito el posteo del producto del emprendedor
                          } else {
                            // No se pudo agregar un Producto del Emprendedor en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        } else {
                          //No se pudo recuperar información del producto del emprendedor para postearlo
                          banderasExitoSync.add(false);
                        }
                      }
                    } else {
                      print("El Producto del Emprendedor con id Emi Web ${productoEmprendedor.idProductoEmprendedor} ya existe en Pocketbase");
                      //Se verifica que el producto del emprendedor tenga imagen 
                      if (productoEmprendedor.documento != null) {
                        //El Producto del Emprendedor tiene imagen asociada
                        // Se valida que la imagen no exista en Pocketbase
                        final recordValidateImagen = await client.records.getFullList(
                          'imagenes',
                          batch: 200,
                          filter:
                            "id_emi_web='${productoEmprendedor.documento!.idDocumento}'");
                        if (recordValidateImagen.isEmpty) {
                          //La imagen del producto del emprendedor no existe en Pocketbase y se tiene que crear
                          //Se crea la imagen del Producto del Emprendedor
                          final recordImagen = await client.records.create('imagenes', body: {
                            "nombre": productoEmprendedor.documento!.nombreArchivo,
                            "id_emi_web": productoEmprendedor.documento!.idDocumento,
                            "base64": productoEmprendedor.documento!.archivo,
                          });
                          if (recordImagen.id.isNotEmpty) {
                            final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(productoEmprendedor.idUnidadMedida.toString())).build().findUnique();
                            if (unidadMedida != null) {
                              //Se actualiza el producto del Emprendedor
                              final recordProductoEmp = await client.records.update('productos_emp', recordValidateProductoEmp.first.id, body: {
                                "nombre_prod_emp": productoEmprendedor.producto,
                                "descripcion": productoEmprendedor.descripcion,
                                "id_und_medida_fk": unidadMedida.idDBR,
                                "costo_prod_emp": productoEmprendedor.costoUnidadMedida,
                                "id_emprendimiento_fk": idEmprendimientoPocketbase,
                                "archivado": productoEmprendedor.archivado,
                                "id_emi_web": productoEmprendedor.idProductoEmprendedor.toString(),
                                "id_imagen_fk": recordImagen.id,
                              });
                              if (recordProductoEmp.id.isNotEmpty) {
                                //Se hizo con éxito el posteo del producto del emprendedor
                              } else {
                                // No se pudo agregar un Producto del Emprendedor en Pocketbase
                                banderasExitoSync.add(false);
                              }
                            } else {
                              //No se pudo recuperar información del producto del emprendedor para postearlo
                              banderasExitoSync.add(false);
                            }
                          } else {
                            // No se pudo agregar la Imagen del producto del emprendedor en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        } else {
                          //La imagen del producto del emprendedor existe en Pocketbase y se tiene que actualizar
                          //Se actualiza la imagen del Producto del Emprendedor
                          final recordImagen = await client.records.update('imagenes', recordValidateImagen.first.id, body: {
                            "nombre": productoEmprendedor.documento!.nombreArchivo,
                            "base64": productoEmprendedor.documento!.archivo,
                          });
                          if (recordImagen.id.isNotEmpty) {
                            final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(productoEmprendedor.idUnidadMedida.toString())).build().findUnique();
                            if (unidadMedida != null) {
                              //Se actualiza el producto del Emprendedor
                              final recordProductoEmp = await client.records.update('productos_emp', recordValidateProductoEmp.first.id, body: {
                                "nombre_prod_emp": productoEmprendedor.producto,
                                "descripcion": productoEmprendedor.descripcion,
                                "id_und_medida_fk": unidadMedida.idDBR,
                                "costo_prod_emp": productoEmprendedor.costoUnidadMedida,
                                "id_emprendimiento_fk": idEmprendimientoPocketbase,
                                "archivado": productoEmprendedor.archivado,
                                "id_emi_web": productoEmprendedor.idProductoEmprendedor.toString(),
                                "id_imagen_fk": recordImagen.id,
                              });
                              if (recordProductoEmp.id.isNotEmpty) {
                                //Se hizo con éxito el posteo del producto del emprendedor
                              } else {
                                // No se pudo agregar un Producto del Emprendedor en Pocketbase
                                banderasExitoSync.add(false);
                              }
                            } else {
                              //No se pudo recuperar información del producto del emprendedor para postearlo
                              banderasExitoSync.add(false);
                            }
                          } else {
                            // No se pudo agregar la Imagen del producto del emprendedor en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        }      
                      } else {
                        //El producto del emprendedor no tiene imagen asociada
                        final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(productoEmprendedor.idUnidadMedida.toString())).build().findUnique();
                        if (unidadMedida != null) {
                          //Se actualiza el producto del Emprendedor
                          final recordProductoEmp = await client.records.update('productos_emp', recordValidateProductoEmp.first.id, body: {
                            "nombre_prod_emp": productoEmprendedor.producto,
                            "descripcion": productoEmprendedor.descripcion,
                            "id_und_medida_fk": unidadMedida.idDBR,
                            "costo_prod_emp": productoEmprendedor.costoUnidadMedida,
                            "id_emprendimiento_fk": idEmprendimientoPocketbase,
                            "archivado": productoEmprendedor.archivado,
                            "id_emi_web": productoEmprendedor.idProductoEmprendedor.toString(),
                          });
                          if (recordProductoEmp.id.isNotEmpty) {
                            //Se hizo con éxito la actualización del producto del emprendedor
                          } else {
                            // No se pudo actualizar un Producto del Emprendedor en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        } else {
                          //No se pudo recuperar información del producto del emprendedor para actualizarlo
                          banderasExitoSync.add(false);
                        }
                      }
                    }
                  }
                  print("LLAMADO DE API 6");
                  // API 6 Se recupera la información básica de las Ventas
                  var url = Uri.parse("$baseUrlEmiWebServices/ventas/emprendimiento?idEmprendimiento=$idEmprendimiento");
                  final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                  var responseAPI6 = await get(
                    url,
                    headers: headers
                  ); 
                  switch(responseAPI6.statusCode){
                    case 200:
                      print("Respuesta 200 en API 6");
                      var basicVentas = getBasicVentasEmiWebFromMap(
                        const Utf8Decoder().convert(responseAPI6.bodyBytes)
                      );
                      for(var venta in basicVentas.payload!)
                      {
                        // Se valida que la venta exista en Pocketbase
                        final recordValidateVenta = await client.records.getFullList(
                          'ventas',
                          batch: 200,
                          filter:
                            "id_emi_web='${venta.idVentas}'");
                        if (recordValidateVenta.isEmpty) {
                          print("La venta con id Emi Web ${venta.idVentas} no existe en Pocketbase");
                          // Se crea la venta
                          final recordVenta = await client.records.create('ventas', body: {
                            "id_emprendimiento_fk": idEmprendimientoPocketbase,
                            "fecha_inicio": venta.fechaInicio.toUtc().toString(),
                            "fecha_termino": venta.fechaTermino.toUtc().toString(),
                            "total": venta.total,
                            "archivado": venta.archivado,
                            "id_emi_web": venta.idVentas,
                          });
                          if (recordVenta.id.isNotEmpty) {
                            for (var i = 0; i < venta.ventasXProductoEmprendedor.toList().length; i++) {
                              // Se crea el producto vendido asociado a la venta
                              final productoEmprendedor = await client.records.getFullList(
                              'productos_emp',
                              batch: 200,
                              filter:
                                "id_emi_web='${venta.ventasXProductoEmprendedor.toList()[i].idProductoEmprendedor}'");
                              final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(venta.ventasXProductoEmprendedor.toList()[i].unidadMedidaEmprendedor.idCatUnidadMedida.toString())).build().findUnique();
                              if (productoEmprendedor.isNotEmpty &&
                              unidadMedida != null) {
                                final recordProdVendido =
                                  await client.records.create('prod_vendidos', body: {
                                  "id_productos_emp_fk": productoEmprendedor.first.id,
                                  "cantidad_vendida": venta.ventasXProductoEmprendedor.toList()[i].cantidadVendida,
                                  "subTotal": venta.ventasXProductoEmprendedor.toList()[i].subTotal,
                                  "precio_venta": venta.ventasXProductoEmprendedor.toList()[i].precioVenta,
                                  "id_venta_fk": recordVenta.id,
                                  "id_emi_web": venta.ventasXProductoEmprendedor.toList()[i].id,
                                  "costo": venta.ventasXProductoEmprendedor.toList()[i].costoUnitario,
                                  "descripcion": venta.ventasXProductoEmprendedor.toList()[i].producto.descripcion,
                                  "id_und_medida_fk": unidadMedida.idDBR,
                                  "nombre_prod": venta.ventasXProductoEmprendedor.toList()[i].producto.producto,
                                });
                                if (recordProdVendido.id.isNotEmpty) {
                                  //Se hizo con éxito el posteo del producto vendido
                                } else {
                                  // No se pudo postear un Producto Vendido en Pocketbase
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //No se pudo recuperar información del producto vendido para postearlo
                                banderasExitoSync.add(false);
                              }
                            }
                          } else {
                            // No se pudo agregar una Venta en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        } else {
                          print("La venta con id Emi Web ${venta.idVentas} ya existe en Pocketbase");
                          // Se actualiza la venta
                          final recordVenta = await client.records.update('ventas', recordValidateVenta.first.id, body: {
                            "id_emprendimiento_fk": idEmprendimientoPocketbase,
                            "fecha_inicio": venta.fechaInicio.toUtc().toString(),
                            "fecha_termino": venta.fechaTermino.toUtc().toString(),
                            "total": venta.total,
                            "archivado": venta.archivado,
                          });
                          if (recordVenta.id.isNotEmpty) {
                            // Actualizamos los productos Vendidos
                            //Recuperamos todos los productos vendidos existentes en Emi Web
                            final recordProductosVendidos = await client.records.getFullList(
                            'prod_vendidos',
                            batch: 200,
                            filter:
                              "id_venta_fk='${recordVenta.id}'");
                            final List<String> idsProductosVendidosEliminados = [];
                            //Recuperamos los ids de los productos vendidos existentes en Emi Web
                            for (var element in recordProductosVendidos) {
                              idsProductosVendidosEliminados.add(element.id);
                            }
                            for (var i = 0; i < venta.ventasXProductoEmprendedor.toList().length; i++) {
                              // Se valida que el producto Vendido no exista en Pocketbase
                              final recordValidateProductoVendido = await client.records.getFullList(
                                'prod_vendidos',
                                batch: 200,
                                filter:
                                  "id_emi_web='${venta.ventasXProductoEmprendedor.toList()[i].id}'");
                              if (recordValidateProductoVendido.isEmpty) {
                                // El producto Vendido no existe en pocketbase y se tiene que crear
                                // Se crea el producto vendido asociado a la venta
                                final productoEmprendedor = await client.records.getFullList(
                                'productos_emp',
                                batch: 200,
                                filter:
                                  "id_emi_web='${venta.ventasXProductoEmprendedor.toList()[i].idProductoEmprendedor}'");
                                final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(venta.ventasXProductoEmprendedor.toList()[i].unidadMedidaEmprendedor.idCatUnidadMedida.toString())).build().findUnique();
                                if (productoEmprendedor.isNotEmpty &&
                                unidadMedida != null) {
                                  final recordProdVendido =
                                    await client.records.create('prod_vendidos', body: {
                                    "id_productos_emp_fk": productoEmprendedor.first.id,
                                    "cantidad_vendida": venta.ventasXProductoEmprendedor.toList()[i].cantidadVendida,
                                    "subTotal": venta.ventasXProductoEmprendedor.toList()[i].subTotal,
                                    "precio_venta": venta.ventasXProductoEmprendedor.toList()[i].precioVenta,
                                    "id_venta_fk": recordVenta.id,
                                    "id_emi_web": venta.ventasXProductoEmprendedor.toList()[i].id,
                                    "costo": venta.ventasXProductoEmprendedor.toList()[i].costoUnitario,
                                    "descripcion": venta.ventasXProductoEmprendedor.toList()[i].producto.descripcion,
                                    "id_und_medida_fk": unidadMedida.idDBR,
                                    "nombre_prod": venta.ventasXProductoEmprendedor.toList()[i].producto.producto,
                                  });
                                  if (recordProdVendido.id.isNotEmpty) {
                                    //Se hizo con éxito el posteo del producto vendido
                                    idsProductosVendidosEliminados.remove(recordProdVendido.id);
                                  } else {
                                    // No se pudo postear un Producto Vendido en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información del producto vendido para postearlo
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                // El producto Vendido ya existe en pocketbase y se tiene que actualizar
                                // Se actualiza el producto vendido asociado a la venta
                                final productoEmprendedor = await client.records.getFullList(
                                'productos_emp',
                                batch: 200,
                                filter:
                                  "id_emi_web='${venta.ventasXProductoEmprendedor.toList()[i].idProductoEmprendedor}'");
                                final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(venta.ventasXProductoEmprendedor.toList()[i].unidadMedidaEmprendedor.idCatUnidadMedida.toString())).build().findUnique();
                                if (productoEmprendedor.isNotEmpty &&
                                unidadMedida != null) {
                                  final recordProdVendido =
                                    await client.records.update('prod_vendidos', recordValidateProductoVendido.first.id, body: {
                                    "id_productos_emp_fk": productoEmprendedor.first.id,
                                    "cantidad_vendida": venta.ventasXProductoEmprendedor.toList()[i].cantidadVendida,
                                    "subTotal": venta.ventasXProductoEmprendedor.toList()[i].subTotal,
                                    "precio_venta": venta.ventasXProductoEmprendedor.toList()[i].precioVenta,
                                    "id_venta_fk": recordVenta.id,
                                    "costo": venta.ventasXProductoEmprendedor.toList()[i].costoUnitario,
                                    "descripcion": venta.ventasXProductoEmprendedor.toList()[i].producto.descripcion,
                                    "id_und_medida_fk": unidadMedida.idDBR,
                                    "nombre_prod": venta.ventasXProductoEmprendedor.toList()[i].producto.producto,
                                  });
                                  if (recordProdVendido.id.isNotEmpty) {
                                    //Se hizo con éxito la actualización del producto vendido
                                    idsProductosVendidosEliminados.remove(recordProdVendido.id);
                                  } else {
                                    // No se pudo actualizar un Producto Vendido en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información del producto vendido para actualizarlo
                                  banderasExitoSync.add(false);
                                }
                              }
                            }
                            //Se eliminan los productos vendidos sobrantes
                            for (var element in idsProductosVendidosEliminados) {
                              await client.records.delete('prod_vendidos', element);
                            }
                          } else {
                            // No se pudo actualizar una Venta en Pocketbase
                            banderasExitoSync.add(false);
                          }
                        }
                      }
                      break;
                    case 404:
                      break;
                    default:
                      print("Error en llamado al API 6");
                      print(responseAPI6.statusCode);
                      banderasExitoSync.add(false);
                  }
                  break;
                case 404:
                  break;
                default:
                  print("Error en llamado al API 5");
                  print(responseAPI5.statusCode);
                  banderasExitoSync.add(false);
              }
              print("LLAMADO DE API 4");
              // API 4 Se recupera la información básica de las Consultorías
              var urlAPI4 = Uri.parse("$baseUrlEmiWebServices/consultorias/tareas?idProyecto=$idEmprendimiento");
              final headersAPI4 = ({
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer $tokenGlobal',
                });
              var responseAPI4 = await get(
                urlAPI4,
                headers: headersAPI4
              ); 
              switch (responseAPI4.statusCode) {
                case 200:
                  print("Respuesta 200 en API 4");
                  var basicConsultorias = getBasicConsultoriasEmiWebFromMap(
                    const Utf8Decoder().convert(responseAPI4.bodyBytes)
                  );
                  for(var consultoria in basicConsultorias.payload!) {
                    // Se valida que la consultoría exista en Pocketbase
                    final recordValidateConsultoria = await client.records.getFullList(
                      'consultorias',
                      batch: 200,
                      filter:
                        "id_emi_web='${consultoria.idConsultorias}'");
                    if (recordValidateConsultoria.isEmpty) {
                      print("La consultoría con id ${consultoria.idConsultorias} no existe en Pocketbase");
                      List<String> idsDBRTareas = [];
                      for (var i = 0; i < (consultoria.tareas.toList().length + 1); i++) {
                        // Creamos las tareas de la consultoría
                        if (i == 0) {
                          final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.porcentajeAvance.equals("1")).build().findUnique();
                          if (porcentajeAvance != null) {
                            //Se crea la primera tarea de la Consultoría
                            final recordTarea = await client.records.create('tareas', body: {
                              "tarea": consultoria.asignarTarea,
                              "descripcion": "Creación de Consultoría",
                              "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                              "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                              "id_porcentaje_fk": porcentajeAvance.idDBR,
                              "id_emi_web": consultoria.idConsultorias.toString(),
                              "jornada": false,
                            });
                            if (recordTarea.id.isNotEmpty) {
                              idsDBRTareas.add(recordTarea.id);
                            } else {
                              // No se pudo agregar una Tarea de la Consultoría en Pocketbase
                              banderasExitoSync.add(false);
                            }
                          } else {
                            //No se pudo recuperar información de la tarea para crearla
                            banderasExitoSync.add(false);
                          }
                        } else {
                          //Se verifica que la tarea tenga imagen 
                          if (consultoria.tareas.toList()[i - 1].documento != null) {
                            //La tarea tiene imagen asociada
                            final recordImagen = await client.records.create('imagenes', body: {
                              "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                              "id_emi_web": consultoria.tareas.toList()[i - 1].documento!.idDocumento,
                              "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                            });
                            if (recordImagen.id.isNotEmpty) {
                              final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                              if (porcentajeAvance != null) {
                                //Se crea la tarea de la Consultoría
                                final recordTarea = await client.records.create('tareas', body: {
                                  "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                  "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                  "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                  "id_porcentaje_fk": porcentajeAvance.idDBR,
                                  "id_emi_web": consultoria.idConsultorias.toString(),
                                  "id_imagenes_fk": [recordImagen.id],
                                  "jornada": false,
                                });
                                if (recordTarea.id.isNotEmpty) {
                                  idsDBRTareas.add(recordTarea.id);
                                } else {
                                  // No se pudo agregar una Tarea de la Consultoría en Pocketbase
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //No se pudo recuperar información de la tarea para crearla
                                banderasExitoSync.add(false);
                              }
                            } else {
                              // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                              banderasExitoSync.add(false);
                            }
                          } else {
                            //La tarea no tiene imagen asociada
                            final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                            if (porcentajeAvance != null) {
                              //Se crea la tarea de la Consultoría
                              final recordTarea = await client.records.create('tareas', body: {
                                "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                "id_porcentaje_fk": porcentajeAvance.idDBR,
                                "id_emi_web": consultoria.idConsultorias.toString(),
                                "jornada": false,
                              });
                              if (recordTarea.id.isNotEmpty) {
                                idsDBRTareas.add(recordTarea.id);
                              } else {
                                // No se pudo agregar una Tarea de la Consultoría en Pocketbase
                                banderasExitoSync.add(false);
                              }
                            } else {
                              //No se pudo recuperar información de la tarea para crearla
                              banderasExitoSync.add(false);
                            }
                          }
                        }
                      }
                      final ambito = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idEmiWeb.equals(consultoria.idCatAmbito.toString())).build().findUnique();
                      final areaCirculo = dataBase.areaCirculoBox.query(AreaCirculo_.idEmiWeb.equals(consultoria.idCatAreaCirculo.toString())).build().findUnique();
                      if (ambito != null && areaCirculo != null && idsDBRTareas != []) {
                        //Segundo creamos la consultoría  
                        final recordConsultoria = await client.records.create('consultorias', body: {
                          "id_emprendimiento_fk": idEmprendimientoPocketbase,
                          "id_tarea_fk": idsDBRTareas,
                          "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                          "id_ambito_fk": ambito.idDBR,
                          "id_area_circulo_fk": areaCirculo.idDBR,
                          "id_emi_web": consultoria.idConsultorias.toString(),
                        });
                        if (recordConsultoria.id.isNotEmpty) {
                          //Se hizo con éxito la alta de la consultoría
                        } else {
                          //No se pudo postear la Consultoría en Pocketbase
                          banderasExitoSync.add(false);
                        }
                      } else {
                        //No se pudo recuperar información de la Consultoría para postearla
                        banderasExitoSync.add(false);
                      }
                    } else {
                      print("La consultoría ya existe en Pocketbase");
                      List<String> idsDBRTareas = [];
                      for (var i = 0; i < (consultoria.tareas.toList().length + 1); i++) {
                        // Actualizamos las tareas de la consultoría
                        //Se recuperan las tareas de la consultoría
                        final recordValidateTareasConsultoria = await client.records.getFullList(
                          'tareas',
                          batch: 200,
                          filter:
                            "id_emi_web='${consultoria.idConsultorias}'&&jornada=false");
                        if (recordValidateTareasConsultoria.isNotEmpty) {
                          //Lista de Consultorías en Pocketbase
                          print(recordValidateTareasConsultoria.toString());
                          var basicValidateConsultorias = getSingleConsultoriasPocketbaseFromMap(recordValidateTareasConsultoria.toString());
                          //Se compara el tamaño de listas en ambos lados y se escoge el proceso a realizar
                          if (basicValidateConsultorias.length >= (consultoria.tareas.toList().length + 1)) {
                            if (i == 0) {
                              final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.porcentajeAvance.equals("1")).build().findUnique();
                              if (porcentajeAvance != null) {
                                final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                  "tarea": consultoria.asignarTarea,
                                  "descripcion": "Creación de Consultoría",
                                  "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                  "id_porcentaje_fk": porcentajeAvance.idDBR,
                                  "id_emi_web": consultoria.idConsultorias.toString(),
                                  "id_imagenes_fk": [],
                                });
                                if (recordTarea.id.isNotEmpty) {
                                  idsDBRTareas.add(recordTarea.id);
                                } else {
                                  // No se pudo actualizar la primera Tarea de la Consultoría en Pocketbase
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //No se pudo recuperar información de la tarea para crearla
                                banderasExitoSync.add(false);
                              }
                            } else {
                              //Se verifica que la tarea de Emi Web tenga imagen 
                              if (consultoria.tareas.toList()[i - 1].documento != null) {
                                //Se verifica que la tarea de Pocketbase tenga imagen 
                                if (basicValidateConsultorias[i].idImagenesFk == []) {
                                  //La tarea de Pocketbase no tiene Imagen, entonces se crea
                                  final recordImagen = await client.records.create('imagenes', body: {
                                    "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                                    "id_emi_web": consultoria.tareas.toList()[i - 1].documento!.idDocumento,
                                    "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                                  });
                                  if (recordImagen.id.isNotEmpty) {
                                    //Se actualiza la tarea de la Consultoría
                                    final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                    if (porcentajeAvance != null) {
                                      final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                        "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                        "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                        "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                        "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                        "id_porcentaje_fk": porcentajeAvance.idDBR,
                                        "id_emi_web": consultoria.idConsultorias.toString(),
                                        "id_imagenes_fk": [recordImagen.id],
                                      });
                                      if (recordTarea.id.isNotEmpty) {
                                        idsDBRTareas.add(recordTarea.id);
                                      } else {
                                        // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                        banderasExitoSync.add(false);
                                      }
                                    } else {
                                      //No se pudo recuperar información de la tarea para crearla
                                      banderasExitoSync.add(false);
                                    }
                                  } else {
                                    // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //La tarea de Pocketbase tiene Imagen, entonces se actualiza
                                  final recordImagen = await client.records.update('imagenes', basicValidateConsultorias.toList()[i].idImagenesFk!.first, body: {
                                    "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                                    "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                                  });
                                  if (recordImagen.id.isNotEmpty) {
                                    //Se actualiza la tarea de la Consultoría
                                    final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                    if (porcentajeAvance != null) {
                                      final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                        "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                        "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                        "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                        "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                        "id_porcentaje_fk": porcentajeAvance.idDBR,
                                        "id_emi_web": consultoria.idConsultorias.toString(),
                                        "id_imagenes_fk": [recordImagen.id],
                                      });
                                      if (recordTarea.id.isNotEmpty) {
                                        idsDBRTareas.add(recordTarea.id);
                                      } else {
                                        // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                        banderasExitoSync.add(false);
                                      }
                                    } else {
                                      //No se pudo recuperar información de la tarea para crearla
                                      banderasExitoSync.add(false);
                                    }
                                  } else {
                                    // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                }
                              } else {
                                //La tarea no tiene imagen asociada
                                //Se actualiza la tarea de la Consultoría
                                final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                if (porcentajeAvance != null) {
                                  final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                    "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                    "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                    "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                    "id_porcentaje_fk": porcentajeAvance.idDBR,
                                    "id_emi_web": consultoria.idConsultorias.toString(),
                                    "id_imagenes_fk": [],
                                  });
                                  if (recordTarea.id.isNotEmpty) {
                                    idsDBRTareas.add(recordTarea.id);
                                  } else {
                                    // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información de la tarea para crearla
                                  banderasExitoSync.add(false);
                                }
                              } 
                            }
                          } else {
                            try
                            {
                              //Actualizamos las tareas que ya existen en Pocketbase
                              basicValidateConsultorias.toList().elementAt(i);
                              if (i == 0) {
                                final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.porcentajeAvance.equals("1")).build().findUnique();
                                if (porcentajeAvance != null) {
                                  //Se actualiza la primera tarea de la Consultoría, por ende hay que restar una posición en la reuperación de info en consultoria.tareas.toList()
                                  final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                    "tarea": consultoria.asignarTarea,
                                    "descripcion": "Creación de Consultoría",
                                    "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                    "id_porcentaje_fk": porcentajeAvance.idDBR,
                                    "id_emi_web": consultoria.idConsultorias.toString(),
                                    "id_imagenes_fk": [],
                                  });
                                  if (recordTarea.id.isNotEmpty) {
                                    idsDBRTareas.add(recordTarea.id);
                                  } else {
                                    // No se pudo actualizar la primera Tarea de la Consultoría en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información de la tarea para crearla
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //Se verifica que la tarea de Emi Web tenga imagen 
                                if (consultoria.tareas.toList()[i - 1].documento != null) {
                                  //Se verifica que la tarea de Pocketbase tenga imagen 
                                  if (basicValidateConsultorias.toList()[i].idImagenesFk == []) {
                                    //La tarea de Pocketbase no tiene Imagen, entonces se crea
                                    final recordImagen = await client.records.create('imagenes', body: {
                                      "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                                      "id_emi_web": consultoria.tareas.toList()[i - 1].documento!.idDocumento,
                                      "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                                    });
                                    if (recordImagen.id.isNotEmpty) {
                                      //Se actualiza la tarea de la Consultoría
                                      final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                      if (porcentajeAvance != null) {
                                        final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                          "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                          "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                          "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                          "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                          "id_porcentaje_fk": porcentajeAvance.idDBR,
                                          "id_emi_web": consultoria.idConsultorias.toString(),
                                          "id_imagenes_fk": [recordImagen.id],
                                        });
                                        if (recordTarea.id.isNotEmpty) {
                                          idsDBRTareas.add(recordTarea.id);
                                        } else {
                                          // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                          banderasExitoSync.add(false);
                                        }
                                      } else {
                                        //No se pudo recuperar información de la tarea para crearla
                                        banderasExitoSync.add(false);
                                      }
                                    } else {
                                      // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                                      banderasExitoSync.add(false);
                                    }
                                  } else {
                                    //La tarea de Pocketbase tiene Imagen, entonces se actualiza
                                    final recordImagen = await client.records.update('imagenes', basicValidateConsultorias.toList()[i].idImagenesFk!.first, body: {
                                      "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                                      "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                                    });
                                    if (recordImagen.id.isNotEmpty) {
                                      //Se actualiza la tarea de la Consultoría
                                      final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                      if (porcentajeAvance != null) {
                                        final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                          "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                          "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                          "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                          "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                          "id_porcentaje_fk": porcentajeAvance.idDBR,
                                          "id_emi_web": consultoria.idConsultorias.toString(),
                                          "id_imagenes_fk": [recordImagen.id],
                                        });
                                        if (recordTarea.id.isNotEmpty) {
                                          idsDBRTareas.add(recordTarea.id);
                                        } else {
                                          // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                          banderasExitoSync.add(false);
                                        }
                                      } else {
                                        //No se pudo recuperar información de la tarea para crearla
                                        banderasExitoSync.add(false);
                                      }
                                    } else {
                                      // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                                      banderasExitoSync.add(false);
                                    }
                                  }
                                } else {
                                  //La tarea no tiene imagen asociada
                                  final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                  if (porcentajeAvance != null) {
                                    //Se actualiza la tarea de la Consultoría
                                    final recordTarea = await client.records.update('tareas', basicValidateConsultorias.toList()[i].id, body: {
                                      "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                      "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                      "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                      "id_porcentaje_fk": porcentajeAvance.idDBR,
                                      "id_emi_web": consultoria.idConsultorias.toString(),
                                      "id_imagenes_fk": [],
                                    });
                                    if (recordTarea.id.isNotEmpty) {
                                      idsDBRTareas.add(recordTarea.id);
                                    } else {
                                      // No se pudo actualizar una Tarea de la Consultoría en Pocketbase
                                      banderasExitoSync.add(false);
                                    }
                                  } else {
                                    //No se pudo recuperar información de la tarea para crearla
                                    banderasExitoSync.add(false);
                                  }
                                } 
                              } 
                            }
                            on RangeError { 
                              //Luego se agregan las tareas que vienen de Emi Web
                              //Se verifica que la tarea tenga imagen 
                              if (consultoria.tareas.toList()[i - 1].documento != null) {
                                //La tarea tiene imagen asociada
                                final recordImagen = await client.records.create('imagenes', body: {
                                  "nombre": consultoria.tareas.toList()[i - 1].documento!.nombreArchivo,
                                  "id_emi_web": consultoria.tareas.toList()[i - 1].documento!.idDocumento,
                                  "base64": consultoria.tareas.toList()[i - 1].documento!.archivo,
                                });
                                if (recordImagen.id.isNotEmpty) {
                                  final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                  if (porcentajeAvance != null) {
                                    //Se crea la tarea de la Consultoría
                                    final recordTarea = await client.records.create('tareas', body: {
                                      "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                      "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                      "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                      "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                      "id_porcentaje_fk": porcentajeAvance.idDBR,
                                      "id_emi_web": consultoria.idConsultorias.toString(),
                                      "id_imagenes_fk": [recordImagen.id],
                                      "jornada": false,
                                    });
                                    if (recordTarea.id.isNotEmpty) {
                                      idsDBRTareas.add(recordTarea.id);
                                    } else {
                                      // No se pudo agregar una Tarea de la Consultoría en Pocketbase
                                      banderasExitoSync.add(false);
                                    }
                                  } else {
                                    //No se pudo recuperar información de la tarea para crearla
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  // No se pudo agregar una Imagen de la tarea de consultoría en Pocketbase
                                  banderasExitoSync.add(false);
                                }
                              } else {
                                //La tarea no tiene imagen asociada
                                final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(consultoria.tareas.toList()[i - 1].idCatPorcentajeAvance.toString())).build().findUnique();
                                if (porcentajeAvance != null) {
                                  //Se crea la tarea de la Consultoría
                                  final recordTarea = await client.records.create('tareas', body: {
                                    "tarea": consultoria.tareas.toList()[i - 1].siguientesPasos,
                                    "descripcion": consultoria.tareas.toList()[i - 1].avanceObservado,
                                    "fecha_revision": consultoria.proximaVisita.toUtc().toString(),
                                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                                    "id_porcentaje_fk": porcentajeAvance.idDBR,
                                    "id_emi_web": consultoria.idConsultorias.toString(),
                                    "jornada": false,
                                  });
                                  if (recordTarea.id.isNotEmpty) {
                                    idsDBRTareas.add(recordTarea.id);
                                  } else {
                                    // No se pudo agregar una Tarea de la Consultoría en Pocketbase
                                    banderasExitoSync.add(false);
                                  }
                                } else {
                                  //No se pudo recuperar información de la tarea para crearla
                                  banderasExitoSync.add(false);
                                }
                              }
                            }  
                          }
                        } else {
                          //No se pudo recuperar información de las Tareas de Consultoría para actualizar
                          banderasExitoSync.add(false);
                        }
                      }
                      final ambito = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idEmiWeb.equals(consultoria.idCatAmbito.toString())).build().findUnique();
                      final areaCirculo = dataBase.areaCirculoBox.query(AreaCirculo_.idEmiWeb.equals(consultoria.idCatAreaCirculo.toString())).build().findUnique();
                      if (ambito != null && areaCirculo != null && idsDBRTareas != []) {
                        //Segundo actualizamos la consultoría  
                        final recordConsultoria = await client.records.update('consultorias', recordValidateConsultoria.first.id, body: {
                          "id_emprendimiento_fk": idEmprendimientoPocketbase,
                          "id_tarea_fk": idsDBRTareas,
                          "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                          "id_ambito_fk": ambito.idDBR,
                          "id_area_circulo_fk": areaCirculo.idDBR,
                          "id_emi_web": consultoria.idConsultorias.toString(),
                        });
                        if (recordConsultoria.id.isNotEmpty) {
                          //Se hizo con éxito la actualización de la consultoría
                        } else {
                          //No se pudo actualizar la Consultoría en Pocketbase
                          banderasExitoSync.add(false);
                        }
                      } else {
                        //No se pudo recuperar información de la Consultoría para actualizarla
                        banderasExitoSync.add(false);
                      }
                    }
                  }
                  break;
                case 404:
                  break;
                default:
                  print("Error en llamado al API 4");
                  print(responseAPI4.statusCode);
                  banderasExitoSync.add(false);
              }
              // print("LLAMADO DE API 7");
              // // API 6 Se recupera la información básica de las Inversiones
              // var urlAPI7 = Uri.parse("$baseUrlEmiWebServices/inversiones/emprendimiento?idEmprendimiento=$idEmprendimiento");
              // final headersAPI7 = ({
              //     "Content-Type": "application/json",
              //     'Authorization': 'Bearer $tokenGlobal',
              //   });
              // var responseAPI7 = await get(
              //   urlAPI7,
              //   headers: headersAPI7
              // ); 
              // switch (responseAPI7.statusCode) {
              //   case 200:
              //     print("Respuesta 200 en API 7");
              //     var basicInversiones = getBasicInversionesEmiWebFromMap(
              //       const Utf8Decoder().convert(responseAPI7.bodyBytes)
              //     );
              //     for(var inversion in basicInversiones.payload!)
              //     {
              //       // Se valida que la inversión exista en Pocketbase
              //       final recordValidateInversion = await client.records.getFullList(
              //         'inversiones',
              //         batch: 200,
              //         filter:
              //           "id_emi_web='${inversion.idInversiones}'");
              //       if (recordValidateInversion.isEmpty) {
              //         //La inversión no existe en Pocketbase y se tienen que crear
              //         //Primero creamos la inversion
              //         //Se busca el estado de la inversión
              //         final estadoInversion = dataBase.estadoInversionBox
              //             .query(EstadoInversion_.idEmiWeb.equals(inversion.idCatEstadoInversion.toString()))
              //             .build()
              //             .findFirst();
              //         if (estadoInversion != null) {
              //           final recordInversion =
              //               await client.records.create('inversiones', body: {
              //             "id_emprendimiento_fk": idEmprendimientoPocketbase,
              //             "id_estado_inversion_fk": estadoInversion.idDBR,
              //             "porcentaje_pago": int.parse(inversion.porcentajePago.toString()),
              //             "monto_pagar": inversion.montoPagar,
              //             "saldo": inversion.saldo,
              //             "total_inversion": inversion.totalInversion,
              //             "inversion_recibida": inversion.inversionRecibida,
              //             "pago_recibido": inversion.pagoRecibido != null ? true : false,
              //             "producto_entregado": inversion.productoEntregado != null ? true : false,
              //             "id_emi_web": inversion.idInversiones.toString(),
              //             "jornada_3": false,
              //           });
              //           if (recordInversion.id.isNotEmpty) {
              //             //Segundo creamos los productos solicitados asociados a la inversion
              //             for (var i = 0; i < inversion.productosSolicitados.toList().length; i++) {
              //               //Se verifica que el producto Solicitado esté asociado a una imagen
              //               if (inversion.productosSolicitados.toList()[i].productoSolicitado.idDocumento != null) {
              //                 //El producto Solicitado está asociado a una imagen
              //               } else {
              //                 //El producto Solicitado no está asociado a una imagen
              //                 final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idEmiWeb.equals(inversion.productosSolicitados.toList()[i].productoSolicitado.catTipoEmpaque.idCatTipoEmpaque.toString())).build().findUnique();
              //                 if (tipoEmpaque != null) {
              //                   final recordProdSolicitado = await client.records
              //                       .create('productos_solicitados', body: {
              //                     "producto": inversion.productosSolicitados.toList()[i].productoSolicitado.producto,
              //                     "marca_sugerida": inversion.productosSolicitados.toList()[i].productoSolicitado.marcaSugerida,
              //                     "descripcion": inversion.productosSolicitados.toList()[i].productoSolicitado.descripcion,
              //                     "proveedo_sugerido": inversion.productosSolicitados.toList()[i].productoSolicitado.proveedorSugerido,
              //                     "cantidad": inversion.productosSolicitados.toList()[i].productoSolicitado.cantidad,
              //                     "costo_estimado": inversion.productosSolicitados.toList()[i].productoSolicitado.costoEstimado,
              //                     "id_familia_prod_fk": "5BQwxKKFMPXRXIe",
              //                     "id_tipo_empaques_fk": tipoEmpaque.idDBR,
              //                     "id_inversion_fk": recordInversion.id,
              //                     "id_emi_web": inversion.productosSolicitados.toList()[i].productoSolicitado.idProductoSolicitado.toString(),
              //                   });
              //                   if (recordProdSolicitado.id.isNotEmpty) {
              //                     //Se creó con éxito el Prod Solicitado en Pocketbase
              //                   } else {
              //                     //No se pudo crear un Prod Solicitado en Pocketbase
              //                     banderasExitoSync.add(false);
              //                   }
              //                 } else {
              //                   //No se pudo recuperar información del Prod Solicitado para crearlo
              //                   banderasExitoSync.add(false);
              //                 }
              //               }
              //             }
              //             //Tercero creamos la inversión X prod Cotizados, si es que existe
              //             // if (inversion.) {
                            
              //             // }
              //           } else {
              //             // No se pudo agregar una Inversión en Pocketbase
              //             banderasExitoSync.add(false);
              //           }
              //         } else{
              //           //No se pudo recuperar información de la Inversión para crearla
              //           banderasExitoSync.add(false);
              //         }
              //       } else {
              //         //La inversión ya existe en Pocketbase y se tienen que actualizar
              //       }
              //     }
              //     break;
              //   case 404:
              //     break;
              //   default:
              //     print("Error en llamado al API 7");
              //     print(responseAPI7.statusCode);
              //     banderasExitoSync.add(false);
              // }
              break;
            case 404:
              break;
            default:
            print("Error en llamado al API 3");
            print(responseAPI3.statusCode);
            banderasExitoSync.add(false);
          }
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

//Función para quitar instrucciones asociadas al Emprendimiento que se eliminará localmente

void deleteEmprendimientoLocal(int idEmprendimiento) {
  //Se recuperan y eliminan todas las instrucciones de la bitacora
  final listIntruccionesEmp = dataBase.bitacoraBox.getAll().toList();
  for (var element in listIntruccionesEmp) {
    if (element.idEmprendimiento == idEmprendimiento) {
      dataBase.bitacoraBox.remove(element.id);
    }
  }
  //Se elimina el emprendimiento
  dataBase.emprendimientosBox.remove(idEmprendimiento);
  //Se elimina la imagen del emprendimiento
  final idImagenEmprendimiento = dataBase.imagenesBox.query(Imagenes_.emprendimiento.equals(idEmprendimiento)).build().findUnique()?.id;
  dataBase.imagenesBox.remove(idImagenEmprendimiento ?? -1);
  //Se elimina el emprendedor
  final idEmprendedor =  dataBase.emprendedoresBox.query(Emprendedores_.emprendimiento.equals(idEmprendimiento)).build().findUnique()?.id;
  dataBase.emprendedoresBox.remove(idEmprendedor ?? -1);
  //Se elimina la imagen del emprendedor
  final idImagenEmprendedor = dataBase.imagenesBox.query(Imagenes_.emprendedor.equals(idEmprendedor ?? -1)).build().findUnique()?.id;
  dataBase.imagenesBox.remove(idImagenEmprendedor ?? -1);
  //Se elimina la jornada 1
//   final idJornada1 = dataBase.jornadasBox.query(Jornadas_.emprendimiento.equals(idEmprendimiento)).build().findUnique()?.id;
//   dataBase.jornadasBox.remove(idJornada1 ?? -1);
//   //Se elimina la tarea jornada 1
//   final idTarea1 = dataBase.tareasBox.query(Tareas_.jornada.equals(idJornada1 ?? -1)).build().findUnique()?.id;
//   dataBase.tareasBox.remove(idTarea1 ?? -1);
//   //Se eliminan la imágenes asociadas a la tarea J1
//   dataBase.imagenesBox.query(Imagenes_.tarea).link(Tareas_());
//   dataBase.imagenesBox.query().link(Tareas_.jornada, (Jornadas_.id, 1))
//   QueryBuilder<Emprendimientos> builder = dataBase.emprendimientosBox
//     .query(Emprendimientos_.id.equals(1));
  
//   builder.linkMany(Emprendimientos_.jornadas, Jornadas_.numJornada.equals('1'));

//   dataBase.imagenesBox.query(Imagenes_.path.equals("e"));

//   dataBase.tareasBox.query().link(Tareas_.jornada, Jornadas_.id.equals(1));
//   personBox.query().apply {
//     link(Person_.company).equal(Company_.id, 1)
//     link(Person_.addresses).equal(Address_.street, "Sesame Street")
// }.build().find()
}

//Función para recuperar los emprendimientos externos de EmiWeb
  Future<List<UsuarioProyectosTemporal>?> getUsuariosProyectosEmiWeb() async {
    final GetEmpExternoEmiWebTemp listEmpExternosEmiWebTemp;
    List<UsuarioProyectosTemporal> listUsuariosProyectosTemp = [];
    try {
      if (await getTokenOAuth()) {
        //Se recupera toda la colección de usuarios en EmiWeb
        var url = Uri.parse("$baseUrlEmiWebServices/proyectos/promotor");
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
          //Se recorre toda la lista de emprendimientos para hacer el filtrado
          for (var elementEmprendimientoEmp in listEmpExternosEmiWebTemp.payload!.toList()) {
            //Se valida que el emprendimiento tenga promotor asociado y el switch móvil con la condición en False
            if (elementEmprendimientoEmp.proyecto.promotor != null && elementEmprendimientoEmp.proyecto.switchMovil == false) {
              final emprendimientoLocal = dataBase.emprendimientosBox.query(Emprendimientos_.idEmiWeb.equals(elementEmprendimientoEmp.proyecto.idProyecto.toString())).build().findUnique();
              if (emprendimientoLocal == null) {
                //Se puede recuperar emprendimiento externo
                //Recopilamos que el usuario actual en el for no exista en nuestra Lista de Usuarios principal
                var indexItemUpdated = listUsuariosProyectosTemp.indexWhere((elementUsuario) => elementUsuario.usuarioTemp.idUsuario == elementEmprendimientoEmp.proyecto.promotor!.idUsuario);
                if (indexItemUpdated != -1) {
                  //Si existe el usuario, se agrega su respectivo emprendimiento
                  listUsuariosProyectosTemp[indexItemUpdated].emprendimientosTemp.add(elementEmprendimientoEmp);
                } else {
                  //Si no existe el usuario, se crea en la Lista de Usuarios principal
                    if (elementEmprendimientoEmp.imagenPerfil != null) {
                    final uInt8ListImagen = base64Decode(elementEmprendimientoEmp.imagenPerfil!.archivo);
                    final tempDir = await getTemporaryDirectory();
                    File file =
                        await File('${tempDir.path}/${elementEmprendimientoEmp.imagenPerfil!.nombreArchivo}')
                            .create();
                    file.writeAsBytesSync(uInt8ListImagen);
                    final newUsuarioProyectoTemporal = 
                    UsuarioProyectosTemporal(
                      usuarioTemp: elementEmprendimientoEmp.proyecto.promotor!, 
                      emprendimientosTemp: [elementEmprendimientoEmp],
                      pathImagenPerfil: file.path
                    );
                    listUsuariosProyectosTemp.add(newUsuarioProyectoTemporal);
                  } else {
                    final newUsuarioProyectoTemporal = 
                    UsuarioProyectosTemporal(
                      usuarioTemp: elementEmprendimientoEmp.proyecto.promotor!, 
                      emprendimientosTemp: [elementEmprendimientoEmp],
                    );
                    listUsuariosProyectosTemp.add(newUsuarioProyectoTemporal);
                  }
                }
              } 
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
