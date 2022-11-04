import 'dart:convert';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsEmiWeb/get_inversion_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_prod_cotizados_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_prod_emprendedor_by_emprendedor_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_venta_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_exitoso_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_imagen_exitoso_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_simple_registro_exitoso_emi_web.dart';
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
                var boolSyncAddJornada1 = await syncAddJornada1(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncAddJornada1) {
                  banderasExistoSync.add(boolSyncAddJornada1);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddJornada1);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Jornada 1 Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
                var boolSyncAddJornada2 = await syncAddJornada2(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncAddJornada2) {
                  banderasExistoSync.add(boolSyncAddJornada2);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddJornada2);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Jornada 2 Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncAddJornada3":
            print("Entro al caso de syncAddJornada3 Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
              if(jornadaToSync != null){
                //Se encontró a la jornada y se puede agregar
                var boolSyncAddJornada3 = await syncAddJornada3(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncAddJornada3) {
                  banderasExistoSync.add(boolSyncAddJornada3);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddJornada3);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Jornada 3 Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncAddJornada4":
          print("Entro al caso de syncAddJornada4 Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
              if(jornadaToSync != null){
                //Se encontró a la jornada y se puede agregar
                var boolSyncAddJornada4 = await syncAddJornada4(jornadaToSync, instruccionesBitacora[i]);
                if (boolSyncAddJornada4) {
                  banderasExistoSync.add(boolSyncAddJornada4);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddJornada4);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Jornada 4 Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncAddConsultoria":
            print("Entro al caso de syncAddConsultoria Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
              if(consultoriaToSync != null){
                //Se encontró a la consultoría y se puede agregar
                var boolSyncAddConsultoria = await syncAddConsultoria(consultoriaToSync, instruccionesBitacora[i]);
                if (boolSyncAddConsultoria) {
                  banderasExistoSync.add(boolSyncAddConsultoria);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddConsultoria);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: consultoriaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Consultoría Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
                var boolSyncAddProductoEmp = await syncAddProductoEmprendedor(productoEmpToSync, instruccionesBitacora[i]);
                if (boolSyncAddProductoEmp) {
                  banderasExistoSync.add(boolSyncAddProductoEmp);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddProductoEmp);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: productoEmpToSync.emprendimientos.target!.nombre,
                    instruccion: "Agregar Producto Emprendedor Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncAddVenta":
            print("Entro al caso de syncAddVenta Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
              if(ventaToSync != null){
                //Se encontró la venta y se puede agregar
                var boolSyncAddVenta = await syncAddVenta(ventaToSync, instruccionesBitacora[i]);
                if (boolSyncAddVenta) {
                  banderasExistoSync.add(boolSyncAddVenta);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddVenta);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Venta Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
                //Se encontró el producto vendido y se puede agregar
                var boolSyncAddProductoVendido = syncAddProductoVendido(instruccionesBitacora[i]);
                if (boolSyncAddProductoVendido) {
                  banderasExistoSync.add(boolSyncAddProductoVendido);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddProductoVendido);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: prodVendidoToSync.venta.target!.emprendimiento.target!.nombre,
                    instruccion: "Agregar Producto Vendido Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncAddInversion":
            print("Entro al caso de syncAddInversion Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
              if(inversionToSync != null){
                //Se encontró la inversión y se puede agregar
                var boolSyncAddInversion = await syncAddInversion(inversionToSync, instruccionesBitacora[i]);
                if (boolSyncAddInversion) {
                  banderasExistoSync.add(boolSyncAddInversion);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncAddInversion);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                    instruccion: "Agregar Inversión Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
                //Se encontró al usuario y se puede actualizar
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
            if(!instruccionesBitacora[i].executeEmiWeb){
              final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
              if(emprendimientoToSync != null){
                //Se encontró el emprendimiento y se puede actualizar
                final boolSyncUpdateFaseEmprendimiento = await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i]);
                if (boolSyncUpdateFaseEmprendimiento) {
                  banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: emprendimientoToSync.nombre,
                    instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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
          case "syncUpdateJornada1":
            print("Entro al caso de syncUpdateJornada1 Emi Web");
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
          case "syncUpdateEstadoInversion":
            print("Entro al caso de syncUpdateEstadoInversion Emi Web");
            if (!instruccionesBitacora[i].executeEmiWeb) {
              final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
              if(inversionToSync != null){
                //Se encontró la inversión y se puede actualizar su estado
                var boolSyncUpdateEstadoInversion = await syncUpdateEstadoInversion(inversionToSync, instruccionesBitacora[i]);
                if (boolSyncUpdateEstadoInversion) {
                  banderasExistoSync.add(boolSyncUpdateEstadoInversion);
                  continue;
                } else {
                  //Recuperamos la instrucción que no se ejecutó
                  banderasExistoSync.add(boolSyncUpdateEstadoInversion);
                  final instruccionNoSincronizada = InstruccionNoSincronizada(
                    emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                    instruccion: "Actualizar Estado Inversión Emi Web", 
                    fecha: instruccionesBitacora[i].fechaRegistro);
                  instruccionesFallidas.add(instruccionNoSincronizada);
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


  Future<bool> syncAddEmprendedor(Emprendedores emprendedor, Bitacora bitacora) async {
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
            //Se recupera el id Emi Web del Emprendimiento
            emprendimientoToSync.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendimientosBox.put(emprendimientoToSync);
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear emprendedor Emi Web");
              return false;
          }       
        } else {
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        }
      } else {
        //No existe un emprendimiento asociado al emprendedor de forma local
        return false;
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

  Future<bool> syncAddJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncAddJornada1 de Emi Web");
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
              return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
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
            return true;
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        print("No existe una tarea asociada a la jornada de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddJornada1: $e");
      return false;
    }
}

  Future<bool> syncAddJornada2(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncAddJornada2 de Emi Web");
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
              return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
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
            return true;
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        print("No existe una tarea asociada a la jornada de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddJornada2: $e");
      return false;
    }
}

  Future<bool> syncAddJornada3(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncAddJornada3 de Emi Web");
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
          print("Respuesta Post Jornada 3");
          print(responsePostJornada.body);
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
                  //Tercero creamos la Tarea
                  //Se recupera el id Emi Web de la Tarea
                  tareaToSync.idEmiWeb = idEmiWebUUid;
                  dataBase.tareasBox.put(tareaToSync);
                  //Se marca como realizada en EmiWeb la instrucción en Bitacora
                  bitacora.executeEmiWeb = true;
                  dataBase.bitacoraBox.put(bitacora);
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
                //Tercero creamos la Tarea
                //Se recupera el id Emi Web de la Tarea
                tareaToSync.idEmiWeb = jornada.idEmiWeb;
                dataBase.tareasBox.put(tareaToSync);
                //Se marca como realizada en EmiWeb la instrucción en Bitacora
                bitacora.executeEmiWeb = true;
                dataBase.bitacoraBox.put(bitacora);
                return true;
              default: //No se realizo con éxito el post
                print("Error en actualizar tipo proyecto de emprendimiento");
                return false;
            } 
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        print("No existe una tarea asociada a la jornada de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddJornada3: $e");
      return false;
    }
}

  Future<bool> syncAddJornada4(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncAddJornada4 de Emi Web");
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
              return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
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
            return true;
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        print("No existe una tarea asociada a la jornada de forma local");
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddJornada4: $e");
      return false;
    }
}

  Future<bool> syncAddConsultoria(Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en El syncAddConsultoria de Emi Web");
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
              return true;
            default: //No se realizo con éxito el post
              print("Error en postear consultoría Emi Web");
              return false;
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
            return true;
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
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

  Future<bool> syncAddProductoEmprendedor(ProductosEmp productoEmp, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoEmprendedor de Emi Web");
    try {
      final imagenToSync = dataBase.imagenesBox.get(productoEmp.imagen.target?.id ?? -1);
      if (imagenToSync != null) {
        //Verificamos que no se haya posteado anteriormente la imagen
        if (imagenToSync.idEmiWeb == null) {
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
              final responsePostImagenProductoEmpParse = postRegistroImagenExitosoEmiWebFromMap(
                const Utf8Decoder().convert(responsePostImagenProductoEmp.bodyBytes));
              imagenToSync.idEmiWeb = responsePostImagenProductoEmpParse.payload.idDocumento.toString();
              dataBase.imagenesBox.put(imagenToSync);
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
              print("Respuesta Post Producto Emprendedor");
              print(responsePostProductoEmprendedor.body);
              switch (responsePostProductoEmprendedor.statusCode) {
                case 200:
                  print("Caso 200 en Emi Web Producto Emprendedor");
                  //Tercero se recupera el id Emi Web del Producto Emprendedor mediante otro API
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
                  print("Respuesta Get Productos Emprendedor");
                  print(responseIdProductoEmprendedor.body);
                  switch(responseIdProductoEmprendedor.statusCode) {
                    case 200:
                      final responsePostProductosEmprendedorParse = getProdEmprendedorByEmprendedorEmiWebFromMap(
                      const Utf8Decoder().convert(responseIdProductoEmprendedor.bodyBytes));
                      for(var i = 0; i < responsePostProductosEmprendedorParse.payload!.toList().length; i++){
                        if (productoEmp.nombre == responsePostProductosEmprendedorParse.payload![i].producto &&
                            productoEmp.costo == responsePostProductosEmprendedorParse.payload![i].costoUnidadMedida &&
                            productoEmp.unidadMedida.target!.unidadMedida == responsePostProductosEmprendedorParse.payload![i].unidadMedida) {
                          //Se necesita hacer este paso para actualizar la información
                          productoEmp.idEmiWeb = responsePostProductosEmprendedorParse.payload![i].idProductoEmprendedor.toString();
                          dataBase.productosEmpBox.put(productoEmp);
                          print("Se hace put al producto emprendedor");
                          //Se marca como realizada en EmiWeb la instrucción en Bitacora
                          bitacora.executeEmiWeb = true;
                          dataBase.bitacoraBox.put(bitacora);
                          return true;
                        }
                      }
                      // No se encontró ningún producto con las caracerísticas establecidas
                      print("No se encontró ningún producto con las caracerísticas establecidas");
                      return false;
                    default:
                      // No se recuperó con éxito el id Emi Web del producto Emp
                      return false;
                  }
                default: //No se realizo con éxito el post del producto Emp
                  return false;
              } 
            default:
              //No se realizo con éxito el post de la imagen asociada
              return false;
          }  
        } else {
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
            print("Respuesta Post Producto Emprendedor");
            print(responsePostProductoEmprendedor.body);
            switch (responsePostProductoEmprendedor.statusCode) {
              case 200:
                print("Caso 200 en Emi Web Producto Emprendedor");
                //Tercero se recupera el id Emi Web del Producto Emprendedor mediante otro API
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
                print("Respuesta Get Productos Emprendedor");
                print(responseIdProductoEmprendedor.body);
                switch(responseIdProductoEmprendedor.statusCode) {
                  case 200:
                    final responsePostProductosEmprendedorParse = getProdEmprendedorByEmprendedorEmiWebFromMap(
                    const Utf8Decoder().convert(responseIdProductoEmprendedor.bodyBytes));
                    for(var i = 0; i < responsePostProductosEmprendedorParse.payload!.toList().length; i++){
                      if (productoEmp.nombre == responsePostProductosEmprendedorParse.payload![i].producto &&
                          productoEmp.costo == responsePostProductosEmprendedorParse.payload![i].costoUnidadMedida &&
                          productoEmp.unidadMedida.target!.unidadMedida == responsePostProductosEmprendedorParse.payload![i].unidadMedida) {
                        //Se necesita hacer este paso para actualizar la información
                        productoEmp.idEmiWeb = responsePostProductosEmprendedorParse.payload![i].idProductoEmprendedor.toString();
                        dataBase.productosEmpBox.put(productoEmp);
                        print("Se hace put al producto emprendedor");
                        //Se marca como realizada en EmiWeb la instrucción en Bitacora
                        bitacora.executeEmiWeb = true;
                        dataBase.bitacoraBox.put(bitacora);
                        return true;
                      }
                    }
                    // No se encontró ningún producto con las caracerísticas establecidas
                    print("No se encontró ningún producto con las caracerísticas establecidas");
                    return false;
                  default:
                    // No se recuperó con éxito el id Emi Web del producto Emp
                    return false;
                }
              default: //No se realizo con éxito el post del producto Emp
                return false;
            } 
          } else {
            //Ya se ha posteado anteriormente
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          }
        }
      } else {
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
          print("Respuesta Post Producto Emprendedor");
          print(responsePostProductoEmprendedor.body);
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
              print("Respuesta Get Productos Emprendedor");
              print(responseIdProductoEmprendedor.body);
              switch(responseIdProductoEmprendedor.statusCode) {
                case 200:
                  final responsePostProductosEmprendedorParse = getProdEmprendedorByEmprendedorEmiWebFromMap(
                  const Utf8Decoder().convert(responseIdProductoEmprendedor.bodyBytes));
                  for(var i = 0; i < responsePostProductosEmprendedorParse.payload!.toList().length; i++){
                    if (productoEmp.nombre == responsePostProductosEmprendedorParse.payload![i].producto &&
                        productoEmp.costo == responsePostProductosEmprendedorParse.payload![i].costoUnidadMedida &&
                        productoEmp.unidadMedida.target!.unidadMedida == responsePostProductosEmprendedorParse.payload![i].unidadMedida) {
                      //Se necesita hacer este paso para actualizar la información
                      productoEmp.idEmiWeb = responsePostProductosEmprendedorParse.payload![i].idProductoEmprendedor.toString();
                      dataBase.productosEmpBox.put(productoEmp);
                      print("Se hace put al producto emprendedor");
                      //Se marca como realizada en EmiWeb la instrucción en Bitacora
                      bitacora.executeEmiWeb = true;
                      dataBase.bitacoraBox.put(bitacora);
                      return true;
                    }
                  }
                  // No se encontró ningún producto con las caracerísticas establecidas
                  print("No se encontró ningún producto con las caracerísticas establecidas");
                  return false;
                default:
                  // No se recuperó con éxito el id Emi Web del producto Emp
                  return false;
              }
            default: //No se realizo con éxito el post del producto Emp
              return false;
          } 
        } else {
          //Ya se ha posteado anteriormente
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        }
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddProductoEmprendedor: $e");
      return false;
    }
}

  Future<bool> syncAddVenta(Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncAddVenta de Emi Web");
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
          final recuperarVentaUri =
            Uri.parse('$baseUrlEmiWebServices/ventas/filtros?idEmprendedor=${venta.emprendimiento.target!.emprendedor.target!.idEmiWeb}&archivado=false');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          final responseGetVenta = await get(recuperarVentaUri, 
          headers: headers);
          switch(responseGetVenta.statusCode) {
            case 200:
              final responseGetVentaParse = getVentaEmiWebFromMap(
              const Utf8Decoder().convert(responseGetVenta.bodyBytes));
              //Se recupera el id Emi Web para prod Vendidos
              for (var i = 0; i < venta.prodVendidos.length; i++) {
                venta.prodVendidos[i].idEmiWeb = responseGetVentaParse.payload!.ids!.first.toString();
                dataBase.productosVendidosBox.put(venta.prodVendidos[i]);
              }
              venta.idEmiWeb = responseGetVentaParse.payload!.ids!.first.toString();
              dataBase.ventasBox.put(venta);
              print("Se recupera el idEmiWeb para la venta");
              //Se marca como realizada en EmiWeb la instrucción en Bitacora
              bitacora.executeEmiWeb = true;
              dataBase.bitacoraBox.put(bitacora);
              return true;
            default:
              print("Error al recuperar Emi Web de la venta");
              return false;
          }
          default: //No se realizo con éxito el post
            print("Error en postear venta Emi Web");
            return false;
        }       
      } else {
        //Ya se ha posteado anteriormente
        //Se marca como realizada en EmiWeb la instrucción en Bitacora
        bitacora.executeEmiWeb = true;
        dataBase.bitacoraBox.put(bitacora);
        return true;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddVenta: $e");
      return false;
    }
}

  bool syncAddProductoVendido(Bitacora bitacora) {
    print("Estoy en El syncAddProductoVendido de Emi Web");
    try {
      //Se marca como realizada en EmiWeb la instrucción en Bitacora
      bitacora.executeEmiWeb = true;
      dataBase.bitacoraBox.put(bitacora);
      return true;
    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return false;
    }
  }

  Future<bool> syncAddInversion(Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en El syncAddInversion de Emi Web");
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
          //Se recupera el id Emi Web de la Inversión
          inversion.idEmiWeb = responsePostInversionParse.payload.toString();
          dataBase.inversionesBox.put(inversion);
          print("Se recupera el idEmiWeb de la inversión");
          //Creamos los prod Solicitados
          for(var i = 0; i < inversion.prodSolicitados.length; i++){
            if (inversion.prodSolicitados[i].imagen.target != null) {
              //El prod Solicitado está asociado a una imagen
              final crearImagenProdSolicitadoUri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
              final responsePostImagenProdSolicitado = await post(crearImagenProdSolicitadoUri, 
              headers: headers,
              body: jsonEncode({
                "idCatTipoDocumento": "8", //Prod Solicitado
                "nombreArchivo": inversion.prodSolicitados[i].imagen.target!.nombre,
                "archivo": inversion.prodSolicitados[i].imagen.target!.base64,
                "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
              }));
              switch (responsePostImagenProdSolicitado.statusCode) {
                case 200:
                  //Se recupera el id Emi Web de la imagen del Prod Solicitado
                  final responsePostImagenProdSolicitadoParse = postRegistroImagenExitosoEmiWebFromMap(
                  const Utf8Decoder().convert(responsePostImagenProdSolicitado.bodyBytes));
                  inversion.prodSolicitados[i].imagen.target!.idEmiWeb = responsePostImagenProdSolicitadoParse.payload.idDocumento.toString();             
                  dataBase.imagenesBox.put(inversion.prodSolicitados[i].imagen.target!);
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
                    "costoEstimado": inversion.prodSolicitados.toList()[i].costoEstimado,
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
                      i = inversion.prodSolicitados.length;
                      return false;
                  }
                default:
                  //No se postea con éxito la imagen del prod Solicitado
                  i = inversion.prodSolicitados.length;
                  return false;
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
                "costoEstimado": inversion.prodSolicitados.toList()[i].costoEstimado,
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
                  i = inversion.prodSolicitados.length;
                  return false;
              }
            }
          }
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        default:
          //Falló al postear la inversión
          return false;
        }       
      } else {
        //Ya se ha posteado anteriormente la inversión
        //Creamos los prod Solicitados
        for(var i = 0; i < inversion.prodSolicitados.length; i++){
          if (inversion.prodSolicitados[i].idEmiWeb == null) {
            if (inversion.prodSolicitados[i].imagen.target != null) {
              //El prod Solicitado está asociado a una imagen
              final crearImagenProdSolicitadoUri =
              Uri.parse('$baseUrlEmiWebServices/documentos/crear');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostImagenProdSolicitado = await post(crearImagenProdSolicitadoUri, 
              headers: headers,
              body: jsonEncode({
                "idCatTipoDocumento": "8", //Prod Solicitado
                "nombreArchivo": inversion.prodSolicitados[i].imagen.target!.nombre,
                "archivo": inversion.prodSolicitados[i].imagen.target!.base64,
                "idUsuario": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
              }));
              switch (responsePostImagenProdSolicitado.statusCode) {
                case 200:
                  //Se recupera el id Emi Web de la imagen del Prod Solicitado
                  final responsePostImagenProdSolicitadoParse = postRegistroImagenExitosoEmiWebFromMap(
                  const Utf8Decoder().convert(responsePostImagenProdSolicitado.bodyBytes));
                  inversion.prodSolicitados[i].imagen.target!.idEmiWeb = responsePostImagenProdSolicitadoParse.payload.idDocumento.toString();
                  dataBase.imagenesBox.put(inversion.prodSolicitados[i].imagen.target!);
                  print("Se recupera el idEmiWeb de la imagen prod solicitado");
                  final crearProdSolicitadosUri =
                    Uri.parse('$baseUrlEmiWebServices/productosSolicitados');
                  final responsePostProdSolicitado = await post(crearProdSolicitadosUri, 
                  headers: headers,
                  body: jsonEncode({   
                    "idInversion": inversion.idEmiWeb,
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
                    "costoEstimado": inversion.prodSolicitados.toList()[i].costoEstimado,
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
                      i = inversion.prodSolicitados.length;
                      return false;
                  }
                default:
                  //No se postea con éxito la imagen del prod Solicitado
                  i = inversion.prodSolicitados.length;
                  return false;
              }
            } else {
              //El prod Solicitado no está asociado a una imagen
              final crearProdSolicitadosUri =
                Uri.parse('$baseUrlEmiWebServices/productosSolicitados');
              final headers = ({
                "Content-Type": "application/json",
                'Authorization': 'Bearer $tokenGlobal',
              });
              final responsePostProdSolicitado = await post(crearProdSolicitadosUri, 
              headers: headers,
              body: jsonEncode({   
                "idInversion": inversion.idEmiWeb,
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
                "costoEstimado": inversion.prodSolicitados.toList()[i].costoEstimado,
              }));       
              switch (responsePostProdSolicitado.statusCode) {
                case 200:
                  //Se recupera el id Emi Web de la imagen del Prod Solicitado
                  final responsePostProdSolicitadoParse = postRegistroExitosoEmiWebFromMap(
                  const Utf8Decoder().convert(responsePostProdSolicitado.bodyBytes));
                  inversion.prodSolicitados.toList()[i].idEmiWeb = responsePostProdSolicitadoParse.payload!.id.toString();
                  dataBase.productosSolicitadosBox.put(inversion.prodSolicitados.toList()[i]);
                  continue;
                default:
                  //No se postea con éxito el prod Solicitado
                  i = inversion.prodSolicitados.length;
                  return false;
              }
            }
          }
        }
        //Se marca como realizada en EmiWeb la instrucción en Bitacora
        bitacora.executeEmiWeb = true;
        dataBase.bitacoraBox.put(bitacora);
        return true;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      print("Catch de syncAddInversion: $e");
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
              //Se marca como realizada en EmiWeb la instrucción en Bitacora
              bitacora.executeEmiWeb = true;
              dataBase.bitacoraBox.put(bitacora);
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

  // Future<bool> syncUpdateInversion(Inversiones inversion, Bitacora bitacora) async {
  //   print("Estoy en El syncUpdateInversion en Emi Web");
  //   try {
  //     final estadoActual = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findUnique();
  //     if (estadoActual != null) {
  //       // Primero creamos el API para realizar la actualización
  //         final actualizarEstasyncUpdateEstadoInversionUri =
  //           Uri.parse('$baseUrlEmiWebServices/inversion/estadoInversion');
  //         final headers = ({
  //           "Content-Type": "application/json",
  //           'Authorization': 'Bearer $tokenGlobal',
  //         });
  //         final responsePostUpdateEstasyncUpdateEstadoInversion = await put(actualizarEstasyncUpdateEstadoInversionUri, 
  //         headers: headers,
  //         body: jsonEncode({
  //           "idUsuarioRegistra": inversion.emprendimiento.target!.usuario.target!.idEmiWeb,
  //           "usuarioRegistra": "${inversion.emprendimiento.target!
  //           .usuario.target!.nombre} ${inversion.emprendimiento.target!
  //           .usuario.target!.apellidoP} ${inversion.emprendimiento.target!
  //           .usuario.target!.apellidoM}",
  //           "idInversiones": inversion.idEmiWeb,
  //           "idCatEstadoInversion": estadoActual.idEmiWeb,
  //         }));
  //         print(responsePostUpdateEstasyncUpdateEstadoInversion.statusCode);
  //         print(responsePostUpdateEstasyncUpdateEstadoInversion.body);
  //         print("Respuesta Post Update Inversión");
  //         switch (responsePostUpdateEstasyncUpdateEstadoInversion.statusCode) {
  //           case 200:
  //           print("Caso 200 en Emi Web Update Inversión");
  //           //Se actualiza el estado de la Inversión en ObjectBox
  //           final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
  //           if (statusSyncInversion != null) {
  //             statusSyncInversion.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la inversion
  //             dataBase.statusSyncBox.put(statusSyncInversion);
  //             inversion.estadoInversion.target = estadoActual;
  //             dataBase.inversionesBox.put(inversion);
  //           }
  //           //Se elimina la instrucción de la bitacora
  //           dataBase.bitacoraBox.remove(bitacora.id);
  //           return true;
  //           default: //No se realizo con éxito el post
  //             print("Error en actualizar inversion Emi Web");
  //             return false;
  //         }  
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print('ERROR - function syncUpdateInversion(): $e');
  //     return false;
  //   }
  // }

  Future<bool> syncUpdateEstadoInversion(Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEstadoInversion en Emi Web");
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
        final responsePostUpdateEstasyncUpdateEstadoInversion = await put(syncUpdateEstadoInversionUri, 
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
        print("Respuesta Post Update Estado Inversión");
        print(responsePostUpdateEstasyncUpdateEstadoInversion.body);
        switch (responsePostUpdateEstasyncUpdateEstadoInversion.statusCode) {
          case 200:
            print("Caso 200 en Emi Web Update Estado Inversión");
            //Se marca como realizada en EmiWeb la instrucción en Bitacora
            bitacora.executeEmiWeb = true;
            dataBase.bitacoraBox.put(bitacora);
            return true;
          default: //No se realizo con éxito el post de la actualización de estado de la inversión
            print("Error en actualizar estado inversion Emi Web");
            return false;
        }  
      } else {
        // No se encontró el estado actual da la inversión
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateEstadoInversion(): $e');
      return false;
    }
  }

    Future<bool> syncUpdateJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada1() en Emi Web");
    try {
      // Primero creamos el API para realizar la actualización
      final actualizarJornada1Uri =
        Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
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
        print("Caso 200 en Emi Web Update Jornada 1");
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar jornada 1 Emi Web");
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
      final actualizarJornada2Uri =
        Uri.parse('$baseUrlEmiWebServices/jornadas?id=${jornada.idEmiWeb!.split("?")[0]}&jornada=${jornada.numJornada}');
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      final responsePostUpdateJornada2 = await put(actualizarJornada2Uri, 
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
        "idUsuario": usuario.idEmiWeb,
        "nombreUsuario": usuario.nombre,
        "apellidoPaterno": usuario.apellidoP,
        "apellidoMaterno": usuario.apellidoM,
        "telefono": usuario.telefono,
      }));

      print(responsePutUpdateUsuario.statusCode);
      print(responsePutUpdateUsuario.body);
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

    Future<bool> syncUpdateImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenUsuario() en Emi Web");
    try {
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
        "nombreUsuario": "${imagen.usuario
            .target!.nombre} ${imagen.usuario
            .target!.apellidoP} ${imagen.usuario
            .target!.apellidoM}",
        "idCatTipoDocumento": "1", //Foto perfil Usuario
        "nombreArchivo": imagen.nombre,
        "archivo": imagen.base64,
      }));
      print(responsePostUpdateImagenUsuario.statusCode);
      print(responsePostUpdateImagenUsuario.body);
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
      print(responsePostAddImagenUsuario.statusCode);
      print(responsePostAddImagenUsuario.body);
      switch (responsePostAddImagenUsuario.statusCode) {
        case 200:
        print("Caso 200 en Emi Web Add Imagen Usuario");
          //Se recupera el id Emi Web
          final responsePostImagenUsuarioParse = postRegistroImagenExitosoEmiWebFromMap(
               const Utf8Decoder().convert(responsePostAddImagenUsuario.bodyBytes));
          imagen.idEmiWeb = responsePostImagenUsuarioParse.payload.idDocumento.toString();
          dataBase.imagenesBox.put(imagen);
          //Se marca como realizada en EmiWeb la instrucción en Bitacora
          bitacora.executeEmiWeb = true;
          dataBase.bitacoraBox.put(bitacora);
          return true;
        default: //No se realizo con éxito el post
          print("Error en actualizar imagen usuario Emi Web");
          return false;
      }  
    } catch (e) {
      print('ERROR - function syncAddImagenUsuario(): $e');
      return false;
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
            final responseListProdCotizados = getProdCotizadosEmiWebFromMap(
                  const Utf8Decoder().convert(response.bodyBytes));
            if(responseListProdCotizados.payload![int.parse(inversion.inversionXprodCotizados.last.idEmiWeb!) +1] != []){
              return true;
            } else{
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
                  final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
                  if (statusSyncInversion != null) {
                    statusSyncInversion.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la inversion
                    dataBase.statusSyncBox.put(statusSyncInversion);
                    inversion.estadoInversion.target = estadoInversion;
                    dataBase.inversionesBox.put(inversion);
                    return true;
                  }
                  else{
                    return false;
                  }
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
