import 'dart:convert';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsEmiWeb/get_prod_emprendedor_by_emprendedor_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_exitoso_emi_web.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';

class SyncProviderEmiWeb extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
  bool exitoso = true;

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

  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    if (await getTokenOAuth()) {
      for (var i = 0; i < instruccionesBitacora.length; i++) {
        print("Tamaño instrucciones Emi Web: ${instruccionesBitacora.length}");
        print("Instrucción a realizar en Emi Web: ${instruccionesBitacora[i].instrucciones}");
        switch (instruccionesBitacora[i].instrucciones) {
          case "syncAddEmprendedor":
            print("Entro al caso de syncAddEmprendedor Emi Web");
            final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
            if(emprendedorToSync != null){
              var result = await syncAddEmprendedor(emprendedorToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result);     
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              } 
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddEmprendimiento":
            print("Entro al caso de syncAddEmprendimiento Emi Web");
            var result = syncAddEmprendimiento(instruccionesBitacora[i].id);
            banderasExistoSync.add(result);
            continue;
          case "syncAddJornada1":
            print("Entro al caso de syncAddJornada1 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              var result = await syncAddJornada12y4(jornadaToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result);    
                continue; 
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }       
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddJornada2":
            print("Entro al caso de syncAddJornada2 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              var result = await syncAddJornada12y4(jornadaToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result); 
                continue;    
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }         
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddJornada3":
            print("Entro al caso de syncAddJornada3 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              var result = await syncAddJornada3(jornadaToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result);  
                continue;   
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }         
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddJornada4":
            print("Entro al caso de syncAddJornada4 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              var result = await syncAddJornada12y4(jornadaToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result);     
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }         
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddConsultoria":
            print("Entro al caso de syncAddConsultoria Emi Web");
            final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
            if(consultoriaToSync != null){
              var result = await syncAddConsultoria(consultoriaToSync, instruccionesBitacora[i].id);
              if (result) {
                banderasExistoSync.add(result);   
                continue;  
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }         
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddProductoEmprendedor":
            print("Entro al caso de syncAddProductoEmprendedor Emi Web");
            final productoEmprendedorToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
            if(productoEmprendedorToSync != null){
              var result = await syncAddProductoEmprendedor(productoEmprendedorToSync, instruccionesBitacora[i].id);
              print("Result de syncAddProductoEmprendedor: $result");
              if (result) {
                banderasExistoSync.add(result);    
                continue; 
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }       
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddVenta":
            print("Entro al caso de syncAddVenta Emi Web");
            final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
            if(ventaToSync != null){
              var result = await syncAddVenta(ventaToSync, instruccionesBitacora[i].id);
              print("Result de syncAddVenta: $result");
              if (result) {
                banderasExistoSync.add(result);    
                continue; 
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }       
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddProductoVendido":
            print("Entro al caso de syncAddProductoVendido Emi Web");
            var result = syncAddProductoVendido(instruccionesBitacora[i].id);
            banderasExistoSync.add(result);
            continue;
          case "syncUpdateFaseEmprendimiento":
            print("Entro al caso de syncUpdateFaseEmprendimiento Emi Web");
            final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
            if(emprendimientoToSync != null){
              var result = await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i]);
              if (result) {
                banderasExistoSync.add(result);     
                continue;
              } else {
                //Salimos del bucle
                banderasExistoSync.add(false);
                i = instruccionesBitacora.length;
                break;
              }         
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncUpdateJornada1":
            print("Entro al caso de syncAddJornada1 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              if (jornadaToSync.idEmiWeb != null) {
                //Ya se ha enviado al backend la jornada y se puede actualizar
                final boolSyncUpdateJornada1 = await syncUpdateJornada1(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncUpdateJornada1) {
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  continue;
                } else {
                  //Salimos del bucle
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  i = instruccionesBitacora.length;
                  break;
                }
              } else {
                //No se ha enviado al backend la jornada y por lo tanto no se puede actualizar
                banderasExistoSync.add(true);
                continue;
              } 
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncUpdateJornada2":
            print("Entro al caso de syncAddJornada2 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              if (jornadaToSync.idEmiWeb != null) {
                //Ya se ha enviado al backend la jornada y se puede actualizar
                final boolSyncUpdateJornada1 = await syncUpdateJornada2(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncUpdateJornada1) {
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  continue;
                } else {
                  //Salimos del bucle
                  banderasExistoSync.add(boolSyncUpdateJornada1);
                  i = instruccionesBitacora.length;
                  break;
                }
              } else {
                //No se ha enviado al backend la jornada y por lo tanto no se puede actualizar
                banderasExistoSync.add(true);
                continue;
              } 
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
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
        dataBase.bitacoraBox.removeAll(); //TOD0: Quitar instrucción cuando se hayan colocado todos los casos de instrucciones.
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


  Future<bool> syncAddEmprendedor(Emprendedores emprendedor, int idInstruccionBitacora) async {
    print("Estoy en El syncAddEmprendedor de Emi Web");
    try {
      final emprendimientoToSync = dataBase.emprendimientosBox.get(emprendedor.emprendimiento.target!.id);
      if (emprendimientoToSync != null) {
        //Verificamos que no se haya posteado anteriormente el emprendedor y emprendimiento
        if (emprendedor.idEmiWeb == null && emprendimientoToSync.idEmiWeb == null) {
          // Primero creamos el emprendedor asociado al emprendimiento
          final crearEmprendedorUri =
            Uri.parse('$baseUrlEmiWebServices/emprendedores/registro/crear');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Nombre: ${emprendedor.nombre}");
          print("Fecha: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(emprendedor.fechaRegistro)}");
          print("idUsuario: ${emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb}");
          print("nombreUsuario: ${emprendedor.emprendimiento
            .target!.usuario.target!.nombre} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoP} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoM}");
          print("Telefono: ${emprendedor.telefono}");
          final responsePostEmprendedor = await post(crearEmprendedorUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": emprendedor.emprendimiento.target!.usuario.target!.idEmiWeb, //TODO: Cambiar a usuario correcto
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
          print(responsePostEmprendedor.statusCode);
          print(responsePostEmprendedor.body);
          print("Respuesta Post Emprendedor");
          switch (responsePostEmprendedor.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Emprendedor");
            //Se recupera el id Emi Web del Emprendedor que será el mismo id para el Emprendimiento
            final responsePostEmprendedorParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostEmprendedor.bodyBytes));
            emprendedor.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendedoresBox.put(emprendedor);
            //Segundo creamos el emprendimiento
            //Se recupera el id Emi Web del Emprendimiento
            emprendimientoToSync.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendimientosBox.put(emprendimientoToSync);
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear emprendedor Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe un emprendimiento asociado al emprendedor de forma local
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
    print("Error es: ${e}");
      return false;
    }
}

  bool syncAddEmprendimiento(int idInstruccionBitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se elimina la instrucción de la bitacora
      print("Elimino Instrucción de bitacora");
      dataBase.bitacoraBox.remove(idInstruccionBitacora);
      return true;
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }
  }

  Future<bool> syncAddJornada12y4(Jornadas jornada, int idInstruccionBitacora) async {
    print("Estoy en El syncAddJornada12y4 de Emi Web");
    try {
      final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (tareaToSync != null) {
        //Verificamos que no se haya posteado anteriormente el jornada y tarea
        if (jornada.idEmiWeb == null && tareaToSync.idEmiWeb == null) {
          // Primero creamos la jornada asociada a la tarea
          final crearJornadaUri =
            Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Número de Jornada: ${jornada.numJornada}");
          print("Fecha Registro: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro)}");
          print("Fecha Revisión: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision)}");
          final responsePostJornada = await post(crearJornadaUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb, //TODO: Cambiar a usuario correcto
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
          print(responsePostJornada.statusCode);
          print(responsePostJornada.body);
          print("Respuesta Post Jornada");
          switch (responsePostJornada.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Jornada");
            //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
            final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostJornada.bodyBytes));
            print("Se convierte a utf8 exitosamente");
            jornada.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
             print("Se recupera el idEmiWeb");
            dataBase.jornadasBox.put(jornada);
            print("Se hace put a la jornada");
            //Segundo creamos la Tarea
            //Se recupera el id Emi Web de la Tarea
            tareaToSync.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
            dataBase.tareasBox.put(tareaToSync);
            //Se elimina la instrucción de la bitacora
            print("Antes de remover la instrucción");
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            print("Después de remover la instrucción");
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        print("No existe una tarea asociada a la jornada de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
     print("Catch de syncAddJornada12y4: $e");
      return false;
    }
}

  Future<bool> syncAddJornada3(Jornadas jornada, int idInstruccionBitacora) async {
    print("Estoy en El syncAddJornada3 de Emi Web");
    try {
      final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (tareaToSync != null) {
        //Verificamos que no se haya posteado anteriormente el jornada y tarea
        if (jornada.idEmiWeb == null && tareaToSync.idEmiWeb == null) {
          // Primero creamos la jornada asociada a la tarea
          final crearJornadaUri =
            Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Número de Jornada: ${jornada.numJornada}");
          print("Fecha Registro: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro)}");
          print("Fecha Revisión: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision)}");
          final responsePostJornada = await post(crearJornadaUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": jornada.emprendimiento.target!.usuario.target!.idEmiWeb, //TODO: Cambiar a usuario correcto
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
          print(responsePostJornada.statusCode);
          print(responsePostJornada.body);
          print("Respuesta Post Jornada");
          switch (responsePostJornada.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Jornada");
            //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
            final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostJornada.bodyBytes));
            jornada.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
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
            print("Response Status Code: ${responseUpdateTipoProyectoEmprendimiento.statusCode}");
            print("Body Status Code: ${responseUpdateTipoProyectoEmprendimiento.body}");
            switch (responseUpdateTipoProyectoEmprendimiento.statusCode) {
              case 200:
              //Tercero creamos la Tarea
              //Se recupera el id Emi Web de la Tarea
              tareaToSync.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
              dataBase.tareasBox.put(tareaToSync);
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(idInstruccionBitacora);
              return true;
              default: //No se realizo con éxito el post
                print("Error en actualizar tipo proyecto de emprendimiento");
                return false;
            }    
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      return false;
    }
}

  Future<bool> syncAddConsultoria(Consultorias consultoria, int idInstruccionBitacora) async {
    print("Estoy en El syncAddConsultoria de Emi Web");
    try {
      final tareaToSync = dataBase.tareasBox.get(consultoria.tareas.first.id);
      if (tareaToSync != null) {
        //Verificamos que no se haya posteado anteriormente la consultoría y tarea
        if (consultoria.idEmiWeb == null && tareaToSync.idEmiWeb == null) {
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
            print("Se convierte a utf8 exitosamente");
            consultoria.idEmiWeb = responsePostConsultoriaParse.payload!.id.toString();
             print("Se recupera el idEmiWeb");
            dataBase.consultoriasBox.put(consultoria);
            print("Se hace put a la consultoria");
            //Segundo creamos la Tarea
            //Se recupera el id Emi Web de la Tarea
            tareaToSync.idEmiWeb = responsePostConsultoriaParse.payload!.id.toString();
            dataBase.tareasBox.put(tareaToSync);
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            print("Se ha removido la instrucción");
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear consultoría Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe una tarea asociada a la consultoría de forma local
        print("No existe una tarea asociada a la consultoría de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
     print("Catch de syncAddConsultoria: $e");
      return false;
    }
}

  Future<bool> syncAddProductoEmprendedor(ProductosEmp productoEmp, int idInstruccionBitacora) async {
    print("Estoy en El syncAddProductoEmprendedor de Emi Web");
    try {
      //Verificamos que no se haya posteado anteriormente el producto Emprendedor
      if (productoEmp.idEmiWeb == null) {
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
          "idDocumento": 1, //TODO: Crear el documento corresponsiente y asociarlo
          "descripcion": productoEmp.descripcion,
          "costoUnidadMedida": productoEmp.costo,
        }));
        print(responsePostProductoEmprendedor.statusCode);
        print(responsePostProductoEmprendedor.body);
        print("Respuesta Post Producto Emprendedor");
        switch (responsePostProductoEmprendedor.statusCode) {
          case 200:
            print("Caso 200 en Emi Web Producto Emprendedor");
            //Segundo se recupera el id Emi Web del Producto Emprendedor mediante otro API
            final url =
              Uri.parse('$baseUrlEmiWebServices/productosEmprendedor?idEmprendedor=${productoEmp.emprendimientos.target!.emprendedor.target!.idEmiWeb}');
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var responseIdProductoEmprendedor = await get(
              url,
              headers: headers
            );
            print(responseIdProductoEmprendedor.statusCode);
            print(responseIdProductoEmprendedor.body);
            print("Respuesta Get Productos Emprendedor");
            switch(responseIdProductoEmprendedor.statusCode) {
              case 200:
                final responsePostProductosEmprendedorParse = getProdEmprendedorByEmprendedorEmiWebFromMap(
                const Utf8Decoder().convert(responseIdProductoEmprendedor.bodyBytes));
                for(var i = 0; i < responsePostProductosEmprendedorParse.payload!.toList().length; i++){
                  if (productoEmp.nombre == responsePostProductosEmprendedorParse.payload![i].producto &&
                      productoEmp.costo == responsePostProductosEmprendedorParse.payload![i].costoUnidadMedida &&
                      productoEmp.unidadMedida.target!.unidadMedida == responsePostProductosEmprendedorParse.payload![i].unidadMedida) {
                    productoEmp.idEmiWeb = responsePostProductosEmprendedorParse.payload![i].idProductoEmprendedor.toString();
                    dataBase.productosEmpBox.put(productoEmp);
                    print("Se hace put al producto emprendedor");
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(idInstruccionBitacora);
                    print("Después de remover la instrucción");
                    print("Tamaño banderas: ${banderasExistoSync.length}");
                    return true;
                  }
                }
                //No se encontró ningún producto con las caracerísticas establecidas
                return false;
              default:
                return false;
            }
          default: //No se realizo con éxito el post
            return false;
        }       
      } else {
        //Ya se ha posteado anteriormente
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(idInstruccionBitacora);
        return true;
      }
    } catch (e) { //Fallo en el momento se sincronizar
     print("Catch de syncAddProductoEmprendedor: $e");
      return false;
    }
}

  Future<bool> syncAddVenta(Ventas venta, int idInstruccionBitacora) async {
    print("Estoy en El syncAddVenta de Emi Web");
    try {
      return true;
      // //Verificamos que no se haya posteado anteriormente la venta
      // if (venta.idEmiWeb == null) {
      //   //Creamos la venta asociada a la primera tarea creada
      //   final crearVentaUri =
      //     Uri.parse('$baseUrlEmiWebServices/ventas');
      //   final headers = ({
      //     "Content-Type": "application/json",
      //     'Authorization': 'Bearer $tokenGlobal',
      //   });

      //   final responsePostVenta = await post(crearVentaUri, 
      //   headers: headers,
      //   body: jsonEncode({   
      //     "idUsuarioRegistra": venta.emprendimiento.target!.usuario.target!.idEmiWeb,
      //     "usuarioRegistra": "${venta.emprendimiento
      //     .target!.usuario.target!.nombre} ${venta.emprendimiento
      //     .target!.usuario.target!.apellidoP} ${venta.emprendimiento
      //     .target!.usuario.target!.apellidoM}",
      //     "idProyecto": venta.emprendimiento.target!.idEmiWeb,
      //     "fechaInicio": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaInicio),
      //     "fechaTermino": DateFormat("yyyy-MM-ddTHH:mm:ss").format(venta.fechaTermino),
      //     "total": venta.total,
      //     "ventaCrearRequestList": [
      //       {
      //         "idProductoEmprendedor": "<number>",
      //         "cantidadVendida": "<number>",
      //         "precioVenta": "<number>"
      //       }
            
      //     "idUsuario": consultoria.emprendimiento.target!.usuario.target!.idEmiWeb,
      //     "nombreUsuario": "${consultoria.emprendimiento
      //     .target!.usuario.target!.nombre} ${consultoria.emprendimiento
      //     .target!.usuario.target!.apellidoP} ${consultoria.emprendimiento
      //     .target!.usuario.target!.apellidoM}",
      //     "idCatAmbito": consultoria.ambitoConsultoria.target!.idEmiWeb,
      //     "idCatAreaCirculo": consultoria.areaCirculo.target!.idEmiWeb,
      //     "asignarTarea": consultoria.tareas.first.tarea,
      //     "proximaVisita": DateFormat("yyyy-MM-dd").format(consultoria.tareas.first.fechaRevision),
      //     "idProyecto": consultoria.emprendimiento.target!.idEmiWeb,
      //     "archivado": false, //Es falso por que apenas la estamos dando de alta
      //     "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(consultoria.tareas.first.fechaRegistro),
      //   }));
      //   print(responsePostVenta.statusCode);
      //   print(responsePostVenta.body);
      //   print("Respuesta Post Consultoria");
      //   switch (responsePostVenta.statusCode) {
      //     case 200:
      //     print("Caso 200 en Emi Web Consultoría");
      //     //Se recupera el id Emi Web de la Consultoría que será el mismo id para la Tarea
      //     final responsePostVentaParse = postRegistroExitosoEmiWebFromMap(
      //     const Utf8Decoder().convert(responsePostVenta.bodyBytes));
      //     print("Se convierte a utf8 exitosamente");
      //     consultoria.idEmiWeb = responsePostVentaParse.payload!.id.toString();
      //       print("Se recupera el idEmiWeb");
      //     dataBase.consultoriasBox.put(consultoria);
      //     print("Se hace put a la consultoria");
      //     //Segundo creamos la Tarea
      //     //Se recupera el id Emi Web de la Tarea
      //     tareaToSync.idEmiWeb = responsePostVentaParse.payload!.id.toString();
      //     dataBase.tareasBox.put(tareaToSync);
      //     //Se elimina la instrucción de la bitacora
      //     dataBase.bitacoraBox.remove(idInstruccionBitacora);
      //     print("Se ha removido la instrucción");
      //     return true;
      //     default: //No se realizo con éxito el post
      //       print("Error en postear consultoría Emi Web");
      //       return false;
      //   }       
      // } else {
      //   //Ya se ha posteado anteriormente
      //   //Se elimina la instrucción de la bitacora
      //   dataBase.bitacoraBox.remove(idInstruccionBitacora);
      //   return true;
      // }
    } catch (e) { //Fallo en el momento se sincronizar
     print("Catch de syncAddVenta: $e");
      return false;
    }
}

  bool syncAddProductoVendido(int idInstruccionBitacora) {
    print("Estoy en El syncAddProductoVendido de Emi Web");
    try {
      //Se elimina la instrucción de la bitacora
      print("Elimino Instrucción de bitacora");
      dataBase.bitacoraBox.remove(idInstruccionBitacora);
      return true;
    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return false;
    }
  }


  Future<bool> syncUpdateFaseEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Emi Web");
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
          final responsePostUpdateFaseEmprendimiento = await put(actualizarFaseEmprendimientoUri, 
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
          print(responsePostUpdateFaseEmprendimiento.statusCode);
          print(responsePostUpdateFaseEmprendimiento.body);
          print("Respuesta Post Update Fase Emprendimiento");
          switch (responsePostUpdateFaseEmprendimiento.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Update Fase Emprendimiento");
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
            return true;
            default: //No se realizo con éxito el post
              print("Error en actualizar fase emprendimiento Emi Web");
              return false;
          }  
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
      return false;
    }
  }

    Future<bool> syncUpdateJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada1() en Emi Web");
    try {
      // Primero creamos el API para realizar la actualización
      final actualizarJornada1Uri =
        Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb}&jornada=${jornada.numJornada}');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePostUpdateJornada1 = await put(actualizarJornada1Uri, 
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
      print(responsePostUpdateJornada1.statusCode);
      print(responsePostUpdateJornada1.body);
      switch (responsePostUpdateJornada1.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Update Fase Emprendimiento");
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar fase emprendimiento Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }
  } 

    Future<bool> syncUpdateJornada2(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada2() en Emi Web");
    try {
      // Primero creamos el API para realizar la actualización
      final actualizarJornada1Uri =
        Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb}&jornada=${jornada.numJornada}');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePostUpdateJornada2 = await put(actualizarJornada1Uri, 
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
      print(responsePostUpdateJornada2.statusCode);
      print(responsePostUpdateJornada2.body);
      switch (responsePostUpdateJornada2.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Update Fase Emprendimiento");
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar fase emprendimiento Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncUpdateJornada2(): $e');
      return false;
    }
  } 

}
