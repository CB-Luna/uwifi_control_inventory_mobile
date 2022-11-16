import 'package:bizpro_app/modelsPocketbase/get_inversion.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion_x_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/instruccion_no_sincronizada.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_cotizados.dart';

class SyncProviderPocketbase extends ChangeNotifier {
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


  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora, List<InstruccionNoSincronizada> instruccionesFallidasEmiWeb) async {
    // Se recuperan instrucciones fallidas anteriores
    instruccionesFallidas = instruccionesFallidasEmiWeb;
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      print("La instrucción es: ${instruccionesBitacora[i].instruccion}");
      switch (instruccionesBitacora[i].instruccion) {
        case "syncAddImagenUsuario":
          print("Entro al caso de syncAddImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenUsuario = await syncAddImagenUsuario(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenUsuario) {
              banderasExistoSync.add(boolSyncAddImagenUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Agregar Imagen de Perfil Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Agregar Imagen de Perfil Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddEmprendedor":
          print("Entro al caso de syncAddEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncAddEmprendedor = await syncAddEmprendedor(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncAddEmprendedor) {
              banderasExistoSync.add(boolSyncAddEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Emprendedor al Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Emprendedor al Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddEmprendimiento":
          print("Entro al caso de syncAddEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            final boolSyncAddEmprendimiento = syncAddEmprendimiento(instruccionesBitacora[i]);
            if (boolSyncAddEmprendimiento) {
              banderasExistoSync.add(boolSyncAddEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendimientoToSync.nombre,
                instruccion: "Agregar Emprendimiento Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Emprendimiento Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada1":
          print("Entro al caso de syncAddJornada1 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada1 = await syncAddJornada1(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada1) {
              banderasExistoSync.add(boolSyncAddJornada1);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada1);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 1 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 1 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada2":
          print("Entro al caso de syncAddJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada2 = await syncAddJornada2(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada2) {
              banderasExistoSync.add(boolSyncAddJornada2);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada2);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 2 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 2 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddImagenJornada2":
          print("Entro al caso de syncAddImagenJornada2 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenJornada2 = await syncAddImagenJornada2(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenJornada2) {
              banderasExistoSync.add(boolSyncAddImagenJornada2);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenJornada2);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Imagen Jornada 2 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Imagen Jornada 2 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada3":
          print("Entro al caso de syncAddJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada3 = await syncAddJornada3(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada3) {
              banderasExistoSync.add(boolSyncAddJornada3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddImagenJornada3":
          print("Entro al caso de syncAddImagenJornada3 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenJornada3 = await syncAddImagenJornada3(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenJornada3) {
              banderasExistoSync.add(boolSyncAddImagenJornada3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenJornada3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Imagen Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Imagen Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddProductoInversionJ3":
          print("Entro al caso de syncAddProductoInversionJ3 Pocketbase");
          final prodSolicitadoToSync = getFirstProdSolicitado(dataBase.productosSolicitadosBox.getAll(), instruccionesBitacora[i].id);
          if(prodSolicitadoToSync != null){
            final boolSyncAddProductoInversionJ3 = await syncAddProductoInversionJ3(prodSolicitadoToSync, instruccionesBitacora[i]);
            if (boolSyncAddProductoInversionJ3) {
              banderasExistoSync.add(boolSyncAddProductoInversionJ3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddProductoInversionJ3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodSolicitadoToSync.inversion.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Producto Inversión Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Producto Inversión Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddJornada4":
          print("Entro al caso de syncAddJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncAddJornada4 = await syncAddJornada4(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncAddJornada4) {
              banderasExistoSync.add(boolSyncAddJornada4);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddJornada4);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Jornada 4 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Jornada 4 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddImagenJornada4":
          print("Entro al caso de syncAddImagenJornada4 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenJornada4 = await syncAddImagenJornada4(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenJornada4) {
              banderasExistoSync.add(boolSyncAddImagenJornada4);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenJornada4);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.tarea.target!.jornada.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Imagen Jornada 4 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Imagen Jornada 4 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddConsultoria":
          print("Entro al caso de syncAddConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            final boolSyncAddConsultoria = await syncAddConsultoria(consultoriaToSync, instruccionesBitacora[i]);
            if (boolSyncAddConsultoria) {
              banderasExistoSync.add(boolSyncAddConsultoria);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddConsultoria);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: consultoriaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Consultoría Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Consultoría Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddProductoEmprendedor":
          print("Entro al caso de syncAddProductoEmprendedor Pocketbase");
          final productoEmpToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if(productoEmpToSync != null){
            final boolSyncAddProductoEmp = await syncAddProductoEmprendedor(productoEmpToSync, instruccionesBitacora[i]);
            if (boolSyncAddProductoEmp) {
              banderasExistoSync.add(boolSyncAddProductoEmp);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddProductoEmp);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: productoEmpToSync.emprendimientos.target!.nombre,
                instruccion: "Agregar Producto Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Producto Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddImagenProductoEmprendedor":
          print("Entro al caso de syncAddImagenProductoEmprendedor Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncAddImagenProductoEmprendedor = await syncAddImagenProductoEmprendedor(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenProductoEmprendedor) {
              banderasExistoSync.add(boolSyncAddImagenProductoEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenProductoEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Agregar Imagen del Producto Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Agregar Imagen del Producto Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddVenta":
          print("Entro al caso de syncAddVenta Pocketbase");
          final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if(ventaToSync != null){
            final boolSyncAddVenta = await syncAddVenta(ventaToSync, instruccionesBitacora[i]);
            if (boolSyncAddVenta) {
              banderasExistoSync.add(boolSyncAddVenta);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddVenta);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Venta Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Venta Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddProductoVendido":
          print("Entro al caso de syncAddProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
          if(prodVendidoToSync != null){
            final boolSyncAddProductoVendido = await syncAddProductoVendido(prodVendidoToSync, instruccionesBitacora[i]);
            if (boolSyncAddProductoVendido) {
              banderasExistoSync.add(boolSyncAddProductoVendido);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddProductoVendido);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodVendidoToSync.venta.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Producto Vendido Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Producto Vendido Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddSingleProductoVendido":
          print("Entro al caso de syncAddSingleProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
          if(prodVendidoToSync != null){
            final boolSyncAddSingleProductoVendido = await syncAddSingleProductoVendido(prodVendidoToSync, instruccionesBitacora[i]);
            if (boolSyncAddSingleProductoVendido) {
              banderasExistoSync.add(boolSyncAddSingleProductoVendido);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddSingleProductoVendido);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodVendidoToSync.venta.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar un Producto Vendido en Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar un Producto Vendido en Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddInversion":
          print("Entro al caso de syncAddInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            final boolSyncAddInversion = await syncAddInversion(inversionToSync, instruccionesBitacora[i]);
            if (boolSyncAddInversion) {
              banderasExistoSync.add(boolSyncAddInversion);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddInversion);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Inversión Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Inversión Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateFaseEmprendimiento":
          print("Entro al caso de syncUpdateFaseEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            final boolSyncUpdateFaseEmprendimiento = await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateFaseEmprendimiento) {
              banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateFaseEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendimientoToSync.nombre,
                instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Fase Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenUsuario":
          print("Entro al caso de syncUpdateImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenUsuario = await syncUpdateImagenUsuario(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenUsuario) {
              print("La respuesta es: $boolSyncUpdateImagenUsuario");
              banderasExistoSync.add(boolSyncUpdateImagenUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Actualización Imagen de Perfil Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }     
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Actualización Imagen de Perfil Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateNameEmprendimiento":
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (emprendimientoToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateNameEmprendimiento(emprendimientoToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateEmprendedor":
          print("Entro al caso de syncUpdateEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncUpdateEmprendedor = await syncUpdateEmprendedor(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateEmprendedor) {
              banderasExistoSync.add(boolSyncUpdateEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.nombre,
                instruccion: "Actualización Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateEmprendimiento":
          print("Entro al caso de syncUpdateEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncUpdateEmprendimiento = await syncUpdateEmprendimiento(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateEmprendimiento) {
              banderasExistoSync.add(boolSyncUpdateEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.nombre,
                instruccion: "Actualización Emprendimiento Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Emprendimiento Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateJornada1":
        print("Entro al caso de syncUpdateJornada1 Pocketbase");
         final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncUpdateJornada1 = await syncUpdateJornada1(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateJornada1) {
              banderasExistoSync.add(boolSyncUpdateJornada1);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateJornada1);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Jornada 1 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Jornada 1 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateJornada2":
          print("Entro al caso de syncUpdateJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncUpdateJornada2 = await syncUpdateJornada2(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateJornada2) {
              banderasExistoSync.add(boolSyncUpdateJornada2);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateJornada2);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Jornada 2 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Jornada 2 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenJornada2":
          print("Entro al caso de syncUpdateImagenJornada2 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenJornada2 = await syncUpdateImagenJornada2(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenJornada2) {
              banderasExistoSync.add(boolSyncUpdateImagenJornada2);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenJornada2);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Imagen Jornada 2 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Imagen Jornada 2 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateJornada3":
          print("Entro al caso de syncUpdateJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncUpdateJornada3 = await syncUpdateJornada3(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateJornada3) {
              banderasExistoSync.add(boolSyncUpdateJornada3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateJornada3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenJornada3":
          print("Entro al caso de syncUpdateImagenJornada3 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenJornada3 = await syncUpdateImagenJornada3(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenJornada3) {
              banderasExistoSync.add(boolSyncUpdateImagenJornada3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenJornada3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Imagen Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Imagen Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateProductoInversionJ3":
          print("Entro al caso de syncUpdateProductoInversionJ3 Pocketbase");
          final prodSolicitadoToSync = getFirstProdSolicitado(dataBase.productosSolicitadosBox.getAll(), instruccionesBitacora[i].id);
          if(prodSolicitadoToSync != null){
            final boolSyncUpdateProductoInversionJ3 = await syncUpdateProductoInversionJ3(prodSolicitadoToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateProductoInversionJ3) {
              banderasExistoSync.add(boolSyncUpdateProductoInversionJ3);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateProductoInversionJ3);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodSolicitadoToSync.inversion.target!.emprendimiento.target!.nombre,
                instruccion: "Actualización Producto Inversión Jornada 3 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Producto Inversión Jornada 3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateJornada4":
          print("Entro al caso de syncUpdateJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            final boolSyncUpdateJornada4 = await syncUpdateJornada4(jornadaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateJornada4) {
              banderasExistoSync.add(boolSyncUpdateJornada4);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateJornada4);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Jornada 4 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Jornada 4 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenJornada4":
          print("Entro al caso de syncUpdateImagenJornada4 Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenJornada4 = await syncUpdateImagenJornada4(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenJornada4) {
              banderasExistoSync.add(boolSyncUpdateImagenJornada4);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenJornada4);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Imagen Jornada 4 Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Imagen Jornada 4 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDeleteImagenJornada":
          print("Entro al caso de syncDeleteImagenJornada Pocketbase");
          final boolSyncDeleteImagenJornada = await syncDeleteImagenJornada(instruccionesBitacora[i]);
          if (boolSyncDeleteImagenJornada) {
            banderasExistoSync.add(boolSyncDeleteImagenJornada);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(boolSyncDeleteImagenJornada);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: instruccionesBitacora[i].emprendimiento,
              instruccion: "Eliminar ${instruccionesBitacora[i].instruccionAdicional} Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDeleteProductoInversionJ3":
          print("Entro al caso de syncDeleteProductoInversionJ3 Pocketbase");
          final boolSyncDeleteProductoInversionJ3 = await syncDeleteProductoInversionJ3(instruccionesBitacora[i]);
          if (boolSyncDeleteProductoInversionJ3) {
            banderasExistoSync.add(boolSyncDeleteProductoInversionJ3);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(boolSyncDeleteProductoInversionJ3);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: instruccionesBitacora[i].emprendimiento,
              instruccion: "Eliminar Producto Inversión J3 Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateTareaConsultoria":
          print("Entro al caso de syncUpdateTareaConsultoria Pocketbase");
          final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if(tareaToSync != null){
            final boolSyncUpdateTareaConsultoria = await syncUpdateTareaConsultoria(tareaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateTareaConsultoria) {
              banderasExistoSync.add(boolSyncUpdateTareaConsultoria);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateTareaConsultoria);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: tareaToSync.consultoria.target!.emprendimiento.target!.nombre,
                instruccion: "Actualización Tarea Consultoría Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Tarea Consultoría Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateEstadoConsultoria":
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            if(consultoriaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              continue;
            } else {
              print("Entro aqui en el else");
              if (consultoriaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateEstadoConsultoria(consultoriaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          continue;
        case "syncUpdateUsuario":
          print("Entro al caso de syncUpdateUsuario Pocketbase");
          final usuarioToSync = getFirstUsuario(dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if(usuarioToSync != null){
            final boolSyncUpdateUsuario = await syncUpdateUsuario(usuarioToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateUsuario) {
              print("La respuesta es: $boolSyncUpdateUsuario");
              banderasExistoSync.add(boolSyncUpdateUsuario);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateUsuario);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Actualización Datos Usuario Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Actualización Datos Usuario Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateEstadoInversion":
          print("Entro al caso de syncUpdateEstadoInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            final boolSyncUpdateEstadoInversion = await syncUpdateEstadoInversion(inversionToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateEstadoInversion) {
              banderasExistoSync.add(boolSyncUpdateEstadoInversion);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateEstadoInversion);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                instruccion: "Actualizar Estado Inversión Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualizar Estado Inversión Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateProductoEmprendedor":
          print("Entro al caso de syncUpdateProductoEmprendedor Pocketbase");
          final productoEmprendedorToSync = getFirstProductoEmprendedor(dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if(productoEmprendedorToSync != null){
            final boolSyncUpdateProductoEmprendedor = await syncUpdateProductoEmprendedor(productoEmprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateProductoEmprendedor) {
              banderasExistoSync.add(boolSyncUpdateProductoEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateProductoEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: productoEmprendedorToSync.nombre,
                instruccion: "Actualización Producto Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Producto Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateImagenProductoEmprendedor":
          print("Entro al caso de syncUpdateImagenProductoEmprendedor Pocketbase");
          final imagenToSync = getFirstImagen(dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if(imagenToSync != null){
            final boolSyncUpdateImagenProdEmprendedor = await syncUpdateImagenProductoEmprendedor(imagenToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateImagenProdEmprendedor) {
              print("La respuesta es: $boolSyncUpdateImagenProdEmprendedor");
              banderasExistoSync.add(boolSyncUpdateImagenProdEmprendedor);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateImagenProdEmprendedor);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Actualización Imagen del Producto Emprendedor Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }     
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              instruccion: "Actualización Imagen del Producto Emprendedor Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateProductoVendido":
          print("Entro al caso de syncUpdateProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(dataBase.productosVendidosBox.getAll(), instruccionesBitacora[i].id);
          if(prodVendidoToSync != null){
            final boolSyncUpdateProductoVendido = await syncUpdateProductoVendido(prodVendidoToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateProductoVendido) {
              banderasExistoSync.add(boolSyncUpdateProductoVendido);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateProductoVendido);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: prodVendidoToSync.venta.target!.emprendimiento.target!.nombre,
                instruccion: "Actualización Producto Vendido Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Producto Vendido Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateVenta":
          print("Entro al caso de syncUpdateVenta Pocketbase");
          final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if(ventaToSync != null){
            final boolSyncUpdateVenta = await syncUpdateVenta(ventaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateVenta) {
              banderasExistoSync.add(boolSyncUpdateVenta);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateVenta);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Venta Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Venta Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncUpdateProductosVendidosVenta":
          print("Entro al caso de syncUpdateProductosVendidosVenta Pocketbase");
          final ventaToSync = getFirstVenta(dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if(ventaToSync != null){
            final boolSyncUpdateProductosVendidosVenta = await syncUpdateProductosVendidosVenta(ventaToSync, instruccionesBitacora[i]);
            if (boolSyncUpdateProductosVendidosVenta) {
              banderasExistoSync.add(boolSyncUpdateProductosVendidosVenta);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncUpdateProductosVendidosVenta);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                instruccion: "Actualización Productos Vendidos Venta Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Actualización Productos Vendidos Venta Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncArchivarEmprendimiento":
          print("Entro al caso de syncArchivarEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncArchivarEmprendimiento = await syncArchivarEmprendimiento(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncArchivarEmprendimiento) {
              banderasExistoSync.add(boolSyncArchivarEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncArchivarEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.nombre,
                instruccion: "Archivar Emprendimiento Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Archivar Emprendimiento Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDesarchivarEmprendimiento":
          print("Entro al caso de syncDesarchivarEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            final boolSyncDesarchivarEmprendimiento = await syncDesarchivarEmprendimiento(emprendedorToSync, instruccionesBitacora[i]);
            if (boolSyncDesarchivarEmprendimiento) {
              banderasExistoSync.add(boolSyncDesarchivarEmprendimiento);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncDesarchivarEmprendimiento);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: emprendedorToSync.nombre,
                instruccion: "Desarchivar Emprendimiento Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Desarchivar Emprendimiento Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncArchivarConsultoria":
          print("Entro al caso de syncArchivarConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            final boolSyncArchivarConsultoria = await syncArchivarConsultoria(consultoriaToSync, instruccionesBitacora[i]);
            if (boolSyncArchivarConsultoria) {
              banderasExistoSync.add(boolSyncArchivarConsultoria);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncArchivarConsultoria);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: consultoriaToSync.emprendimiento.target!.nombre,
                instruccion: "Archivar Consultoria Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Archivar Consultoria Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDesarchivarConsultoria":
          print("Entro al caso de syncDesarchivarConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            final boolSyncDesarchivarConsultoria = await syncDesarchivarConsultoria(consultoriaToSync, instruccionesBitacora[i]);
            if (boolSyncDesarchivarConsultoria) {
              banderasExistoSync.add(boolSyncDesarchivarConsultoria);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncDesarchivarConsultoria);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: consultoriaToSync.emprendimiento.target!.nombre,
                instruccion: "Desarchivar Consultoria Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Desarchivar Consultoria Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAcceptInversionXProdCotizado":
          print("Entro al caso de syncAcceptInversionXProdCotizado Pocketbase");
          final inversionXproductoCotizadoToSync = getFirstInversionXProductosCotizados(dataBase.inversionesXprodCotizadosBox.getAll(), instruccionesBitacora[i].id);
          if(inversionXproductoCotizadoToSync != null){
            final boolSyncAcceptInversionXProductoCotizado = await syncAcceptInversionesXProductosCotizados(inversionXproductoCotizadoToSync, instruccionesBitacora[i]);
            if (boolSyncAcceptInversionXProductoCotizado) {
              banderasExistoSync.add(boolSyncAcceptInversionXProductoCotizado);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAcceptInversionXProductoCotizado);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: inversionXproductoCotizadoToSync.inversion.target!.emprendimiento.target!.nombre,
                instruccion: "Aceptar Inversion por Productos Cotizados Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Aceptar Inversion por Productos Cotizados Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAcceptProdCotizado":
          print("Entro al caso de syncAcceptProdCotizado Pocketbase");
          final productoCotizadoToSync = getFirstProductoCotizado(dataBase.productosCotBox.getAll(), instruccionesBitacora[i].id);
          if(productoCotizadoToSync != null){
            final boolSyncAcceptProductoCotizado = await syncAcceptProdCotizado(productoCotizadoToSync, instruccionesBitacora[i]);
            if (boolSyncAcceptProductoCotizado) {
              banderasExistoSync.add(boolSyncAcceptProductoCotizado);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAcceptProductoCotizado);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: productoCotizadoToSync.inversionXprodCotizados.target!.inversion.target!.emprendimiento.target!.nombre,
                instruccion: "Aceptar Producto Cotizado Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Aceptar Producto Cotizado Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDeleteProductoVendido":
          print("Entro al caso de syncDeleteProductoVendido Pocketbase");
          final boolSyncDeleteProductoVendido = await syncDeleteProductoVendido(instruccionesBitacora[i]);
          if (boolSyncDeleteProductoVendido) {
            banderasExistoSync.add(boolSyncDeleteProductoVendido);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(boolSyncDeleteProductoVendido);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: instruccionesBitacora[i].emprendimiento,
              instruccion: "Eliminar Producto Vendido Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncDeleteProductoSolicitado":
          final idDBRProdSolicitado = instruccionesBitacora[i].idDBR;
          print("Entro aqui en el DeleteProductoSolicitado");
          if(idDBRProdSolicitado != null)
          {
            //TODO Hacer el método para eliminar en backend
          } else{
            print("No se había sincronizado");
          }
          continue;
        case "syncAddPagoInversion":
          print("Entro al caso de syncAddPagoInversion Pocketbase");
          final pagoToSync = getFirstPago(dataBase.pagosBox.getAll(), instruccionesBitacora[i].id);
          if(pagoToSync != null){
            final boolSyncAddPago = await syncAddPagoInversion(pagoToSync, instruccionesBitacora[i]);
            if (boolSyncAddPago) {
              banderasExistoSync.add(boolSyncAddPago);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddPago);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: pagoToSync.inversion.target!.emprendimiento.target!.nombre,
                instruccion: "Agregar Pago Inversión Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Pago Inversión Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddImagenesEntregaInversion":
          print("Entro al caso de syncAddImagenesEntregaInversion Pocketbase");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            final boolSyncAddImagenesEntregaInversion = await syncAddImagenesEntregaInversion(inversionToSync, instruccionesBitacora[i]);
            if (boolSyncAddImagenesEntregaInversion) {
              banderasExistoSync.add(boolSyncAddImagenesEntregaInversion);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(boolSyncAddImagenesEntregaInversion);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                instruccion: "Agregar Imágenes Entrega Inversión Servidor", 
                fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }      
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
              emprendimiento: "No encontrado",
              instruccion: "Agregar Imágenes Entrega Inversión Servidor", 
              fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
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
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      banderasExistoSync.clear();
      notifyListeners();
      return exitoso;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExistoSync.clear();
      notifyListeners();
      return exitoso;
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


  Future<bool> syncAddEmprendedor(Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncAddEmprendedor de Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.emprendedor.equals(emprendedor.id)).build().findUnique();
        final faseInscricto = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Inscrito")).build().findUnique();
        if (emprendimientoToSync != null && faseInscricto != null) {
          if (emprendedor.idDBR == null) {
            //Primero creamos el emprendedor asociado al emprendimiento
            final recordEmprendedor = await client.records.create('emprendedores', body: {
                "nombre_emprendedor": emprendedor.nombre,
                "apellidos_emp": emprendedor.apellidos,
                "curp": emprendedor.curp,
                "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
                "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
                "telefono": emprendedor.telefono,
                "comentarios": emprendedor.comentarios,
                "id_emprendimiento_fk": "",
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emi_web": emprendedor.idEmiWeb,
            });

            if (recordEmprendedor.id.isNotEmpty) {
              String idDBR = recordEmprendedor.id;
              //Se recupera el idDBR del emprendedor
              emprendedor.idDBR = idDBR;
              dataBase.emprendedoresBox.put(emprendedor);
              //Segundo creamos el emprendimiento
              final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                "nombre_emprendimiento": emprendimientoToSync.nombre,
                "descripcion": emprendimientoToSync.descripcion,
                "activo": emprendimientoToSync.activo,
                "archivado": emprendimientoToSync.archivado,
                "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
                "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
                if (updateEmprendimiento != null) {
                  //Se recupera el idDBR del emprendimiento
                  updateEmprendimiento.idDBR = idDBR;
                  dataBase.emprendimientosBox.put(updateEmprendimiento);
                  //Se marca como realizada en Pocketbase la instrucción en Bitacora
                  bitacora.executePocketbase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(bitacora.id);
                  } 
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
          } else {
            if (emprendimientoToSync.idDBR == null) {
              //Segundo creamos el emprendimiento
              final recordEmprendimiento = await client.records.create('emprendimientos', body: {
                "nombre_emprendimiento": emprendimientoToSync.nombre,
                "descripcion": emprendimientoToSync.descripcion,
                "activo": emprendimientoToSync.activo,
                "archivado": emprendimientoToSync.archivado,
                "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
                "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                "id_proveedor_fk": "",
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
                if (updateEmprendimiento != null) {
                  //Se recupera el idDBR del emprendimiento
                  updateEmprendimiento.idDBR = idDBR;
                  dataBase.emprendimientosBox.put(updateEmprendimiento);
                  //Se marca como realizada en Pocketbase la instrucción en Bitacora
                  bitacora.executePocketbase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(bitacora.id);
                  } 
                  return true;
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          return false;
        } 
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
  } catch (e) {
    print('ERROR - function syncAddEmprendedor(): $e');
    return false;
  }
}

 bool syncAddEmprendimiento(Bitacora bitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se marca como realizada en Pocketbase la instrucción en Bitacora
      bitacora.executePocketbase = true;
      dataBase.bitacoraBox.put(bitacora);
      if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(bitacora.id);
      } 
      return true;
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }
  }

  Future<bool> syncAddJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada1");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb!.split("?")[0],
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });

              if (recordJornada.id.isNotEmpty) {
                //Se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });

              if (recordJornada.id.isNotEmpty) {
                //Se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada1(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada2(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada2");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } 
            }
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb!.split("?")[0],
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });
              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });

              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada2(): $e');
      return false;
    }
}

  Future<bool> syncAddImagenJornada2(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada2");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada2 = await client.records.create('imagenes', body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
            "id_emi_web": imagen.idEmiWeb,
          });
          if (recordImagenJornada2.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            imagen.idDBR = recordImagenJornada2.id;
            dataBase.imagenesBox.put(imagen);
            for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada2 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada2.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
          } else {
            return false;
          }       
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada2 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada2.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada2(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada3(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada3");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            final inversionJornada3 = dataBase.inversionesBox.get(jornada.emprendimiento.target?.idInversionJornada ?? -1);
            final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
            if (inversionJornada3 != null && newEstadoInversion != null) {
              // Creamos y enviamos las imágenes de la jornada
              for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
                if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                  final recordImagen = await client.records.create('imagenes', body: {
                    "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                    "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                    "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                  });
                  jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                  dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                  idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
                } else {
                  idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
                } 
              }
              if (inversionJornada3.idDBR == null) {
                // Creamos y enviamos los productos asociados a la inversión
                final recordInversion = await client.records.create('inversiones', body: {
                  "id_emprendimiento_fk": inversionJornada3.emprendimiento.target!.idDBR,
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                  "porcentaje_pago": inversionJornada3.porcentajePago,
                  "monto_pagar": inversionJornada3.montoPagar,
                  "saldo": inversionJornada3.saldo,
                  "total_inversion": inversionJornada3.totalInversion,
                  "inversion_recibida": true,
                  "pago_recibido": false,
                  "producto_entregado": false,
                  "id_emi_web": "0",
                });
                if (recordInversion.id.isNotEmpty) {     
                  //Se recupera el idDBR de la inversion
                  inversionJornada3.idDBR = recordInversion.id;
                  dataBase.inversionesBox.put(inversionJornada3);    
                  // Creamos y enviamos las imágenes de los prod Solicitados
                  for (var i = 0; i < inversionJornada3.prodSolicitados.toList().length; i++) {
                    if (inversionJornada3.prodSolicitados.toList()[i].idDBR == null) {
                      if (inversionJornada3.prodSolicitados.toList()[i].imagen.target != null) {
                        // El prod Solicitado está asociado a una imagen
                        final recordProdSolicitado = await client.records.create('productos_proyecto', body: {
                          "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                          "marca_sugerida": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                          "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                          "proveedo_sugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                          "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                          "costo_estimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                          "id_familia_prod_fk": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idDBR,
                          "id_tipo_empaque_fk": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idDBR,
                          "id_inversion_fk": inversionJornada3.idDBR,
                          "id_emi_web": inversionJornada3.prodSolicitados.toList()[i].idEmiWeb,
                          // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                        });
                        if (recordProdSolicitado.id.isNotEmpty) {
                          //Se recupera el idDBR del prod Solicitado
                          inversionJornada3.prodSolicitados.toList()[i].idDBR = recordProdSolicitado.id;
                          dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                        } else {
                          //No se pudo postear el producto Solicitado a Pocketbase
                          return false;
                        }
                      } else {
                        // El prod Solicitado no está asociado a una imagen
                        final recordProdSolicitado = await client.records.create('productos_proyecto', body: {
                          "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                          "marca_sugerida": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                          "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                          "proveedo_sugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                          "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                          "costo_estimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                          "id_familia_prod_fk": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idDBR,
                          "id_tipo_empaque_fk": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idDBR,
                          "id_inversion_fk": inversionJornada3.idDBR,
                          "id_emi_web": inversionJornada3.prodSolicitados.toList()[i].idEmiWeb,
                          // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                        });
                        if (recordProdSolicitado.id.isNotEmpty) {
                          //Se recupera el idDBR del prod Solicitado
                          inversionJornada3.prodSolicitados.toList()[i].idDBR = recordProdSolicitado.id;
                          dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                        } else {
                          //No se pudo postear el producto Solicitado a Pocketbase
                          return false;
                        }
                      }   
                    }
                  }
                  //Primero creamos la tarea asociada a la jornada
                  final recordTarea = await client.records.create('tareas', body: {
                  "tarea": tareaToSync.tarea,
                  "descripcion": tareaToSync.descripcion,
                  "comentarios": tareaToSync.comentarios,
                  "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  "id_emi_web": tareaToSync.idEmiWeb!.split("?")[0],
                  "id_imagenes_fk": idsDBRImagenes,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Se recupera el idDBR de la tarea
                    tareaToSync.idDBR = recordTarea.id;
                    dataBase.tareasBox.put(tareaToSync);
                    //Segundo actualizamos el catalogoProyecto del emprendimiento
                    final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
                    if (emprendimiento != null) {
                      final recordCatalogoProyecto = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                        "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                      });
                      if (recordCatalogoProyecto.id.isNotEmpty) {
                        //Tercero creamos la jornada  
                        final recordJornada = await client.records.create('jornadas', body: {
                          "num_jornada": jornada.numJornada,
                          "id_tarea_fk": tareaToSync.idDBR,
                          "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                          "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                          "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                          "completada": jornada.completada,
                          "id_emi_web": jornada.idEmiWeb!.split("?")[0],
                        });

                        if (recordJornada.id.isNotEmpty) {
                          //Cuarto se recupera el idDBR de la jornada
                          jornada.idDBR = recordJornada.id;
                          dataBase.jornadasBox.put(jornada);
                          //Se marca como realizada en Pocketbase la instrucción en Bitacora
                          bitacora.executePocketbase = true;
                          dataBase.bitacoraBox.put(bitacora);
                          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                            //Se elimina la instrucción de la bitacora
                            dataBase.bitacoraBox.remove(bitacora.id);
                          } 
                          return true;
                        } else {
                          // No se pudo postear la jornada
                          return false;
                        } 
                      } else {
                        //No se pudo actualizar el catálogo proyecto del emprendimiento
                        return false;
                      }
                    } else {
                      //No se pudo recuperar el emprendimiento
                      return false;
                    }
                  } else {
                    // No se pudo postear la tarea
                    return false;
                  }
                } else {
                  //No se pudo postear la inversión en Pocketbase
                  return false;
                } 
              } else {
                // Creamos y enviamos las imágenes de los prod Solicitados
                for (var i = 0; i < inversionJornada3.prodSolicitados.toList().length; i++) {
                  if (inversionJornada3.prodSolicitados.toList()[i].idDBR == null) {
                    if (inversionJornada3.prodSolicitados.toList()[i].imagen.target != null) {
                      // El prod Solicitado está asociado a una imagen
                      final recordProdSolicitado = await client.records.create('productos_proyecto', body: {
                        "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                        "marca_sugerida": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                        "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                        "proveedo_sugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                        "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                        "costo_estimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                        "id_familia_prod_fk": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idDBR,
                        "id_tipo_empaque_fk": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idDBR,
                        "id_inversion_fk": inversionJornada3.idDBR,
                        "id_emi_web": inversionJornada3.prodSolicitados.toList()[i].idEmiWeb,
                        // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        inversionJornada3.prodSolicitados.toList()[i].idDBR = recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return false;
                      }
                    } else {
                      // El prod Solicitado no está asociado a una imagen
                      final recordProdSolicitado = await client.records.create('productos_proyecto', body: {
                        "producto": inversionJornada3.prodSolicitados.toList()[i].producto,
                        "marca_sugerida": inversionJornada3.prodSolicitados.toList()[i].marcaSugerida,
                        "descripcion": inversionJornada3.prodSolicitados.toList()[i].descripcion,
                        "proveedo_sugerido": inversionJornada3.prodSolicitados.toList()[i].proveedorSugerido,
                        "cantidad": inversionJornada3.prodSolicitados.toList()[i].cantidad,
                        "costo_estimado": inversionJornada3.prodSolicitados.toList()[i].costoEstimado,
                        "id_familia_prod_fk": inversionJornada3.prodSolicitados.toList()[i].familiaProducto.target!.idDBR,
                        "id_tipo_empaque_fk": inversionJornada3.prodSolicitados.toList()[i].tipoEmpaques.target!.idDBR,
                        "id_inversion_fk": inversionJornada3.idDBR,
                        "id_emi_web": inversionJornada3.prodSolicitados.toList()[i].idEmiWeb,
                        // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        inversionJornada3.prodSolicitados.toList()[i].idDBR = recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox.put(inversionJornada3.prodSolicitados.toList()[i]);
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return false;
                      }
                    }   
                  }
                }
                //Primero creamos la tarea asociada a la jornada
                final recordTarea = await client.records.create('tareas', body: {
                "tarea": tareaToSync.tarea,
                "descripcion": tareaToSync.descripcion,
                "comentarios": tareaToSync.comentarios,
                "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emi_web": tareaToSync.idEmiWeb!.split("?")[0],
                "id_imagenes_fk": idsDBRImagenes,
                });
                if (recordTarea.id.isNotEmpty) {
                  //Se recupera el idDBR de la tarea
                  tareaToSync.idDBR = recordTarea.id;
                  dataBase.tareasBox.put(tareaToSync);
                  //Segundo actualizamos el catalogoProyecto del emprendimiento
                  final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
                  if (emprendimiento != null) {
                    final recordCatalogoProyecto = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                      "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                    });
                    if (recordCatalogoProyecto.id.isNotEmpty) {
                      //Tercero creamos la jornada  
                      final recordJornada = await client.records.create('jornadas', body: {
                        "num_jornada": jornada.numJornada,
                        "id_tarea_fk": tareaToSync.idDBR,
                        "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                        "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                        "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                        "completada": jornada.completada,
                        "id_emi_web": jornada.idEmiWeb!.split("?")[0],
                      });

                      if (recordJornada.id.isNotEmpty) {
                        //Cuarto se recupera el idDBR de la jornada
                        jornada.idDBR = recordJornada.id;
                        dataBase.jornadasBox.put(jornada);
                        //Se marca como realizada en Pocketbase la instrucción en Bitacora
                        bitacora.executePocketbase = true;
                        dataBase.bitacoraBox.put(bitacora);
                        if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                          //Se elimina la instrucción de la bitacora
                          dataBase.bitacoraBox.remove(bitacora.id);
                        } 
                        return true;
                      } else {
                        // No se pudo postear la jornada
                        return false;
                      } 
                    } else {
                      //No se pudo actualizar el catálogo proyecto del emprendimiento
                      return false;
                    }
                  } else {
                    //No se pudo recuperar el emprendimiento
                    return false;
                  }
                } else {
                  // No se pudo postear la tarea
                  return false;
                }
              }
            } else {
              // No se pudo recuperar la inversión asociada a la jornada 3
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo actualizamos el catalogoProyecto del emprendimiento
              final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
              if (emprendimiento != null) {
                final recordCatalogoProyecto = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
                  "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
                });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  //Tercero creamos la jornada  
                  final recordJornada = await client.records.create('jornadas', body: {
                    "num_jornada": jornada.numJornada,
                    "id_tarea_fk": tareaToSync.idDBR,
                    "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                    "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                    "completada": jornada.completada,
                    "id_emi_web": jornada.idEmiWeb!.split("?")[0],
                  });

                  if (recordJornada.id.isNotEmpty) {
                    //Cuarto se recupera el idDBR de la jornada
                    jornada.idDBR = recordJornada.id;
                    dataBase.jornadasBox.put(jornada);
                    //Se marca como realizada en Pocketbase la instrucción en Bitacora
                    bitacora.executePocketbase = true;
                    dataBase.bitacoraBox.put(bitacora);
                    if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                      //Se elimina la instrucción de la bitacora
                      dataBase.bitacoraBox.remove(bitacora.id);
                    } 
                    return true;
                  } else {
                    // No se pudo postear la jornada
                    return false;
                  } 
                } else {
                  //No se pudo actualizar el catálogo proyecto del emprendimiento
                  return false;
                }
              } else {
                //No se pudo recuperar el emprendimiento
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          } 
        } else {
          // No hay ninguna tarea asociada a la jornada
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada3(): $e');
      return false;
    }
}

  Future<bool> syncAddImagenJornada3(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada3");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada3 = await client.records.create('imagenes', body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
            "id_emi_web": imagen.idEmiWeb,
          });
          if (recordImagenJornada3.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            imagen.idDBR = recordImagenJornada3.id;
            dataBase.imagenesBox.put(imagen);
            for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada3 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada3.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
          } else {
            return false;
          }       
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada3 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada3.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada3(): $e');
      return false;
    }
}

  Future<bool> syncAddProductoInversionJ3(ProdSolicitado prodSolicitado, Bitacora bitacora) async {
    print("Estoy en syncAddProductoInversionJ3");
    try {
      if (!bitacora.executePocketbase) {
        if (prodSolicitado.idDBR == null) {
          //No se ha posteado la prodSolicitado en Emi Web
          final recordProdSolicitado = await client.records.create('productos_proyecto', body: {
            "producto": prodSolicitado.producto,
            "marca_sugerida": prodSolicitado.marcaSugerida,
            "descripcion": prodSolicitado.descripcion,
            "proveedo_sugerido": prodSolicitado.proveedorSugerido,
            "cantidad": prodSolicitado.cantidad,
            "costo_estimado": prodSolicitado.costoEstimado,
            "id_familia_prod_fk": prodSolicitado.familiaProducto.target!.idDBR,
            "id_tipo_empaque_fk": prodSolicitado.tipoEmpaques.target!.idDBR,
            "id_inversion_fk": prodSolicitado.inversion.target!.idDBR,
            "id_emi_web": prodSolicitado.idEmiWeb,
            // "id_imagen_fk": prodSolicitado.imagen.target!.idDBR,
          });
          if (recordProdSolicitado.id.isNotEmpty) {
            //Se recupera el idDBR del prod Solicitado
            prodSolicitado.idDBR = recordProdSolicitado.id;
            dataBase.productosSolicitadosBox.put(prodSolicitado);
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            //No se pudo postear el producto Solicitado a Pocketbase
            return false;
          }   
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddProductoInversionJ3(): $e');
      return false;
    }
}

  Future<bool> syncUpdateProductoInversionJ3(ProdSolicitado prodSolicitado, Bitacora bitacora) async {
    print("Estoy en syncUpdateProductoInversionJ3");
    try {
      if (!bitacora.executePocketbase) {
        final recordProdSolicitado = await client.records.update('productos_proyecto', prodSolicitado.idDBR.toString(), body: {
          "producto": prodSolicitado.producto,
          "marca_sugerida": prodSolicitado.marcaSugerida,
          "descripcion": prodSolicitado.descripcion,
          "proveedo_sugerido": prodSolicitado.proveedorSugerido,
          "cantidad": prodSolicitado.cantidad,
          "costo_estimado": prodSolicitado.costoEstimado,
          "id_familia_prod_fk": prodSolicitado.familiaProducto.target!.idDBR,
          "id_tipo_empaque_fk": prodSolicitado.tipoEmpaques.target!.idDBR,
          // "id_imagen_fk": prodSolicitado.imagen.target!.idDBR,
        });
        if (recordProdSolicitado.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          //No se pudo actualizar el producto Solicitado a Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoInversionJ3(): $e');
      return false;
    }
}

  Future<bool> syncAddJornada4(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada4");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0; i < jornada.tarea.target!.imagenes.toList().length; i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web": jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR = recordImagen.id;
                dataBase.imagenesBox.put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes.add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } 
            }
            //Primero creamos la tarea asociada a la jornada
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb!.split("?")[0],
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });

              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada  
              final recordJornada = await client.records.create('jornadas', body: {
                "num_jornada": jornada.numJornada,
                "id_tarea_fk": tareaToSync.idDBR,
                "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "completada": jornada.completada,
                "id_emi_web": jornada.idEmiWeb!.split("?")[0],
              });

              if (recordJornada.id.isNotEmpty) {
                //Tercero se recupera el idDBR de la jornada
                jornada.idDBR = recordJornada.id;
                dataBase.jornadasBox.put(jornada);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
          } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddJornada4(): $e');
      return false;
    }
  }

  Future<bool> syncAddImagenJornada4(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada4");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada4 = await client.records.create('imagenes', body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
            "id_emi_web": imagen.idEmiWeb,
          });
          if (recordImagenJornada4.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            imagen.idDBR = recordImagenJornada4.id;
            dataBase.imagenesBox.put(imagen);
            for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada4 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada4.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
          } else {
            return false;
          }       
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada4 = await client.records.update('tareas', imagen.tarea.target!.idDBR!, body: {
            "id_imagenes_fk": idsDBRImagenes,
            });
            if (recordTareaJornada4.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              //No se pudo hacer la acutalización de la tarea
              return false;
            }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada4(): $e');
      return false;
    }
}

  Future<bool> syncAddConsultoria(Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en syncAddConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(consultoria.tareas.first.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            //Primero creamos la tarea asociada a la consultoría
            final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "comentarios": tareaToSync.comentarios,
            "id_porcentaje_fk": tareaToSync.porcentaje.target!.idDBR,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
            "id_emi_web": tareaToSync.idEmiWeb,
          });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la consultoria
              final recordConsultoria = await client.records.create('consultorias', body: {
                "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
                "id_tarea_fk": [recordTarea.id],
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
                "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
                "id_emi_web": consultoria.idEmiWeb,
              });

              if (recordConsultoria.id.isNotEmpty) {
                //Se recupera el idDBR de la consultoría
                consultoria.idDBR = recordConsultoria.id;
                dataBase.consultoriasBox.put(consultoria);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                // No se postea con éxito la consultoría
                return false;
              }
            } else {
              // No se postea con éxito la tarea
              return false;
            }
          } else {
            if (consultoria.idDBR == null) {
              //Segundo creamos la consultoria
              final recordConsultoria = await client.records.create('consultorias', body: {
                "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
                "id_tarea_fk": [tareaToSync.idDBR],
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
                "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
                "id_emi_web": consultoria.idEmiWeb,
              });

              if (recordConsultoria.id.isNotEmpty) {
                //Se recupera el idDBR de la consultoría
                consultoria.idDBR = recordConsultoria.id;
                dataBase.consultoriasBox.put(consultoria);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                // No se postea con éxito la consultoría
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          // No se encontró una tarea asociada a la consultoría
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddConsultoria(): $e');
      return false;
    }
  }

  Future<bool> syncAddProductoEmprendedor(ProductosEmp productoEmp, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoEmp");
    try {
      if (!bitacora.executePocketbase) {
        final imagenToSync = dataBase.imagenesBox.query(Imagenes_.id.equals(productoEmp.imagen.target?.id ?? -1)).build().findUnique();
        if (imagenToSync != null) {  
          if (imagenToSync.idDBR == null) {
            //Primero creamos la imagen asociada al producto Emp
            final recordImagen = await client.records.create('imagenes', body: {
              "nombre": imagenToSync.nombre,
              "id_emi_web": imagenToSync.idEmiWeb,
              "base64": imagenToSync.base64,
            });
            if (recordImagen.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              imagenToSync.idDBR = recordImagen.id;
              dataBase.imagenesBox.put(imagenToSync);
              //Segundo creamos el producto Emp 
              final recordProductoEmp = await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
                "archivado": productoEmp.archivado,
                "id_imagen_fk": imagenToSync.idDBR,
                "id_emi_web": productoEmp.idEmiWeb,
              });
              if (recordProductoEmp.id.isNotEmpty) {
                productoEmp.idDBR = recordProductoEmp.id;
                dataBase.productosEmpBox.put(productoEmp);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              }
              else{
                // No se pudo postear el producto Emp
                return false;
              }    
            } else {
              // No se pudo postear la imagen asociada al producto Emp
              return false;
            }
          } else {
            if (productoEmp.idDBR == null) {
              //Segundo creamos el producto Emp 
              final recordProductoEmp = await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
                "archivado": productoEmp.archivado,
                "id_imagen_fk": imagenToSync.idDBR,
                "id_emi_web": productoEmp.idEmiWeb,
              });
              if (recordProductoEmp.id.isNotEmpty) {
                productoEmp.idDBR = recordProductoEmp.id;
                dataBase.productosEmpBox.put(productoEmp);
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              }
              else{
                // No se pudo postear el producto Emp
                return false;
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          // No hay imagen asociada al producto Emp
          if (productoEmp.idDBR == null) {
            //Primero creamos el producto Emp 
            final recordProductoEmp = await client.records.create('productos_emp', body: {
              "nombre_prod_emp": productoEmp.nombre,
              "descripcion": productoEmp.descripcion,
              "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
              "costo_prod_emp": productoEmp.costo,
              "id_emprendimiento_fk": productoEmp.emprendimientos.target!.idDBR,
              "archivado": productoEmp.archivado,
              "id_emi_web": productoEmp.idEmiWeb,
            });
            if (recordProductoEmp.id.isNotEmpty) {
              productoEmp.idDBR = recordProductoEmp.id;
              dataBase.productosEmpBox.put(productoEmp);
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
            else{
              // No se pudo postear el producto Emp
              return false;
            }
          } else {
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddProductoEmp(): $e');
      return false;
    }
  }


  Future<bool> syncAddImagenProductoEmprendedor(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenProductoEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final recordImagenProductoEmprendedor = await client.records.create('imagenes', body: {
         "nombre": imagen.nombre,
         "base64": imagen.base64,
         "id_emi_web": imagen.idEmiWeb,
        });
        if (recordImagenProductoEmprendedor.id.isNotEmpty) {
          //Se recupera el idDBR de la imagen
          imagen.idDBR = recordImagenProductoEmprendedor.id;
          dataBase.imagenesBox.put(imagen);
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          return false;
        }  
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenProductoEmprendedor(): $e');
      return false;
    }
}

  Future<bool> syncAddVenta(Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncAddVenta");
    try {
      if (!bitacora.executePocketbase) {
        if (venta.idDBR == null) {
          //Primero creamos la venta
          final recordVenta = await client.records.create('ventas', body: {
              "id_emprendimiento_fk": venta.emprendimiento.target!.idDBR,
              "fecha_inicio": venta.fechaInicio.toUtc().toString(),
              "fecha_termino": venta.fechaTermino.toUtc().toString(),
              "total": venta.total,
              "archivado": venta.archivado,
              "id_emi_web": venta.idEmiWeb,
          });
          if (recordVenta.id.isNotEmpty) {
            //Se recupera el idDBR de la venta
            venta.idDBR = recordVenta.id;
            dataBase.ventasBox.put(venta);
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            // Falló al postear la venta en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddVenta(): $e');
      return false;
    }
  }

  Future<bool> syncAddProductoVendido(ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoVendido");
      try {
        if (!bitacora.executePocketbase) {
        if (productoVendido.idDBR == null) {
          //Primero creamos el producto Vendido
          final recordProdVendido = await client.records.create('prod_vendidos', body: {
              "id_productos_emp_fk": productoVendido.productoEmp.target!.idDBR,
              "cantidad_vendida": productoVendido.cantVendida,
              "subTotal": productoVendido.subtotal,
              "precio_venta": productoVendido.precioVenta,
              "id_venta_fk": productoVendido.venta.target!.idDBR,
              "id_emi_web": productoVendido.idEmiWeb,
              "costo": productoVendido.costo,
              "descripcion": productoVendido.descripcion,
              "id_und_medida_fk": productoVendido.unidadMedida.target!.idDBR,
              "nombre_prod": productoVendido.nombreProd,
          });
          if (recordProdVendido.id.isNotEmpty) {
            //Se recupera el idDBR del prod Vendido
            productoVendido.idDBR = recordProdVendido.id;
            dataBase.productosVendidosBox.put(productoVendido);
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            // Falló al postear el producto Vendido en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return false;
    }
  }

  Future<bool> syncAddSingleProductoVendido(ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en El syncAddSingleProductoVendido");
      try {
        if (!bitacora.executePocketbase) {
        if (productoVendido.idDBR == null) {
          //Primero creamos el producto Vendido
          final recordProdVendido = await client.records.create('prod_vendidos', body: {
              "id_productos_emp_fk": productoVendido.productoEmp.target!.idDBR,
              "cantidad_vendida": productoVendido.cantVendida,
              "subTotal": productoVendido.subtotal,
              "precio_venta": productoVendido.precioVenta,
              "id_venta_fk": productoVendido.venta.target!.idDBR,
              "id_emi_web": productoVendido.idEmiWeb,
              "costo": productoVendido.costo,
              "descripcion": productoVendido.descripcion,
              "id_und_medida_fk": productoVendido.unidadMedida.target!.idDBR,
              "nombre_prod": productoVendido.nombreProd,
          });
          if (recordProdVendido.id.isNotEmpty) {
            //Se recupera el idDBR del prod Vendido
            productoVendido.idDBR = recordProdVendido.id;
            dataBase.productosVendidosBox.put(productoVendido);
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            // Falló al postear el producto Vendido en Pocketbase
            return false;
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddSingleProductoVendido(): $e');
      return false;
    }
  }

  Future<bool> syncAddInversion(Inversiones inversion, Bitacora bitacora) async {
    try {
      print("Estoy en syncAddInversion");
      if (!bitacora.executePocketbase) {
        if (inversion.idDBR == null) {
          //Primero creamos la inversion  
          //Se busca el estado de inversión 'Solicitada'
          final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
          if (newEstadoInversion != null) {
            final recordInversion = await client.records.create('inversiones', body: {
              "id_emprendimiento_fk": inversion.emprendimiento.target!.idDBR,
              "id_estado_inversion_fk": newEstadoInversion.idDBR,
              "porcentaje_pago": inversion.porcentajePago,
              "monto_pagar": inversion.montoPagar,
              "saldo": inversion.saldo,
              "total_inversion": inversion.totalInversion,
              "inversion_recibida": true,
              "pago_recibido": false,
              "producto_entregado": false,
              "id_emi_web": inversion.idEmiWeb,
            });

          if (recordInversion.id.isNotEmpty) {     
            //Se recupera el idDBR de la inversion
            inversion.idDBR = recordInversion.id;
            dataBase.inversionesBox.put(inversion);    
            //Segundo creamos los productos solicitados asociados a la inversion
            final prodSolicitadosToSync = inversion.prodSolicitados.toList();
            if (prodSolicitadosToSync.isNotEmpty) {  
              for (var i = 0; i < prodSolicitadosToSync.length; i++) {
                // Creamos y enviamos las imágenes de los prod Solicitados
                if (prodSolicitadosToSync[i].imagen.target != null) {
                  // El prod Solicitado está asociado a una imagen
                  final recordImagen = await client.records.create('imagenes', body: {
                    "nombre": prodSolicitadosToSync[i].imagen.target!.nombre,
                    "id_emi_web": prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                    "base64": prodSolicitadosToSync[i].imagen.target!.base64,
                  });
                if (recordImagen.id.isNotEmpty) {
                  prodSolicitadosToSync[i].imagen.target!.idDBR = recordImagen.id;
                  dataBase.imagenesBox.put(prodSolicitadosToSync[i].imagen.target!);
                  final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                    "producto": prodSolicitadosToSync[i].producto,
                    "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                    "descripcion": prodSolicitadosToSync[i].descripcion,
                    "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                    "cantidad": prodSolicitadosToSync[i].cantidad,
                    "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                    "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                    "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                    "id_inversion_fk": inversion.idDBR,
                    "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                    "id_imagen_fk": prodSolicitadosToSync[i].imagen.target!.idDBR,
                  });
                  if (recordProdSolicitado.id.isNotEmpty) {
                    //Se recupera el idDBR del prod Solicitado
                    prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                    dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                  } else {
                    //No se pudo postear el producto Solicitado a Pocketbase
                    return false;
                  }
                } else {
                  // No se pudo postear la imagen del prod Solicitado a Pocketbase
                  return false;
                }
                } else {
                  // El prod Solicitado no está asociado a una imagen
                  final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                    "producto": prodSolicitadosToSync[i].producto,
                    "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                    "descripcion": prodSolicitadosToSync[i].descripcion,
                    "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                    "cantidad": prodSolicitadosToSync[i].cantidad,
                    "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                    "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                    "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                    "id_inversion_fk": inversion.idDBR,
                    "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                  });
                  if (recordProdSolicitado.id.isNotEmpty) {
                    //Se recupera el idDBR del prod Solicitado
                    prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                    dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                  } else {
                    //No se pudo postear el producto Solicitado a Pocketbase
                    return false;
                  }
                  }
                }
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                } 
                return true;
              } else {
                //No se encontraron productos Solicitados asociados a la inversión
                return false;
              }
          } else {
            //No se pudo postear la inversión en Pocketbase
            return false;
          }
        } else {
          //No se pudo encontrar el estado de la inversión
          return false;
        }
      } else {
        //Segundo creamos los productos solicitados asociados a la inversion
        final prodSolicitadosToSync = inversion.prodSolicitados.toList();
        if (prodSolicitadosToSync.isNotEmpty) {  
          for (var i = 0; i < prodSolicitadosToSync.length; i++) {
            // Se verifica que no se haya posteado el prod Solicitado anteriormente
            if (prodSolicitadosToSync[i].idDBR == null) {
              // Creamos y enviamos las imágenes de los prod Solicitados
              if (prodSolicitadosToSync[i].imagen.target != null) {
                // El prod Solicitado está asociado a una imagen
                final recordImagen = await client.records.create('imagenes', body: {
                  "nombre": prodSolicitadosToSync[i].imagen.target!.nombre,
                  "id_emi_web": prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                  "base64": prodSolicitadosToSync[i].imagen.target!.base64,
                });
                if (recordImagen.id.isNotEmpty) {
                  prodSolicitadosToSync[i].imagen.target!.idDBR = recordImagen.id;
                  dataBase.imagenesBox.put(prodSolicitadosToSync[i].imagen.target!);
                  final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                    "producto": prodSolicitadosToSync[i].producto,
                    "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                    "descripcion": prodSolicitadosToSync[i].descripcion,
                    "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                    "cantidad": prodSolicitadosToSync[i].cantidad,
                    "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                    "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                    "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                    "id_inversion_fk": inversion.idDBR,
                    "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                    "id_imagen_fk": prodSolicitadosToSync[i].imagen.target!.idDBR,
                  });
                  if (recordProdSolicitado.id.isNotEmpty) {
                    //Se recupera el idDBR del prod Solicitado
                    prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                    dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                  } else {
                    //No se pudo postear el producto Solicitado a Pocketbase
                    return false;
                  }
                } else {
                  // No se pudo postear la imagen del prod Solicitado a Pocketbase
                  return false;
                }
              } else {
                // El prod Solicitado no está asociado a una imagen
                final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                  "producto": prodSolicitadosToSync[i].producto,
                  "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                  "descripcion": prodSolicitadosToSync[i].descripcion,
                  "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                  "cantidad": prodSolicitadosToSync[i].cantidad,
                  "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                  "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                  "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                  "id_inversion_fk": inversion.idDBR,
                  "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                });
                if (recordProdSolicitado.id.isNotEmpty) {
                  //Se recupera el idDBR del prod Solicitado
                  prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                  dataBase.productosSolicitadosBox.put(prodSolicitadosToSync[i]);
                } else {
                  //No se pudo postear el producto Solicitado a Pocketbase
                  return false;
                }
              }
            }
          }
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          //No se encontraron productos Solicitados asociados a la inversión
          return false;
        }
      }
    } else {
      if (bitacora.executeEmiWeb) {
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(bitacora.id);
      } 
      return true;
    }
  } catch (e) {
    print('ERROR - function syncAddInversion(): $e');
    return false;
  }
}

  Future<bool> syncAddImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenUsuario");
    try {
      if (!bitacora.executePocketbase) {
        final recordImagenUsuario = await client.records.create('imagenes', body: {
         "nombre": imagen.nombre,
         "base64": imagen.base64,
         "id_emi_web": imagen.idEmiWeb,
        });
        if (recordImagenUsuario.id.isNotEmpty) {
          //Se recupera el idDBR de la imagen
          imagen.idDBR = recordImagenUsuario.id;
          dataBase.imagenesBox.put(imagen);
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          return false;
        }  
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenUsuario(): $e');
      return false;
    }
}

  Future<bool> syncUpdateImagenUsuario(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenUsuario en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenUsuario(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateFaseEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final faseActual = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(bitacora.instruccionAdicional!)).build().findUnique();
        if (faseActual != null) {
          print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");
          print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

          final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
              "id_fase_emp_fk": faseActual.idDBR,
          }); 

          if (record.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            return false;
          }
        } else {
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateEstadoInversion(Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEstadoInversion en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final estadoActual = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals(bitacora.instruccionAdicional!)).build().findUnique();
        if (estadoActual != null) {

          final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
              "id_estado_inversion_fk": estadoActual.idDBR,
          }); 

          if (record.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else {
            // No se pudo hacer la actualización del estado de la inversión en Pocketbase
            return false;
          }
        } else {
          // No se encontro el estado actual de la inversión
          return false;
        } 
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateEstadoInversion(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
          "nombre_emprendimiento": emprendimiento.nombre,
          "descripcion": emprendimiento.descripcion,
      }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }

    } catch (e) {
      print('ERROR - function syncUpdateEmprendedimiento(): $e');
      return false;
    }
  } 


  Future<bool?> syncUpdateNameEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncUpdateNameEmprendimiento");
    try {

      final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
        "nombre_emprendimiento": emprendimiento.nombre,
        "id_status_sync_fk": "HoI36PzYw1wtbO1",
      }); 

      if (record.id.isNotEmpty) {
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateNameEmprendimiento(): $e');
      return false;
    }

  } 

  Future<bool> syncUpdateEmprendedor(Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emprendedores', emprendedor.idDBR.toString(), body: {
            "nombre_emprendedor": emprendedor.nombre,
            "apellidos_emp": emprendedor.apellidos,
            "curp": emprendedor.curp,
            "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
            "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
            "telefono": emprendedor.telefono,
            "comentarios": emprendedor.comentarios,
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
        }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateEmprendedor(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada1(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada1");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records.update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
        "tarea": jornada.tarea.target!.tarea,
        "fecha_revision": jornada.tarea.target!.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "completada": jornada.completada,
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
          }); 
          if (recordJornada.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            //No se pudo actualizar jornada en Pocketbase
            return false;
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada2(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada2");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records.update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
        "tarea": jornada.tarea.target!.tarea,
        "comentarios": jornada.tarea.target!.comentarios,
        "fecha_revision": jornada.tarea.target!.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "completada": jornada.completada,
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
          }); 
          if (recordJornada.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            //No se pudo actualizar jornada en Pocketbase
            return false;
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada2(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateImagenJornada2(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada2 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada2(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada3(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada3");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records.update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
        "tarea": jornada.tarea.target!.tarea,
        "comentarios": jornada.tarea.target!.comentarios,
        "descripcion": jornada.tarea.target!.descripcion,
        "fecha_revision": jornada.tarea.target!.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "completada": jornada.completada,
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
          }); 
          if (recordJornada.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            //No se pudo actualizar jornada en Pocketbase
            return false;
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada3(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateImagenJornada3(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada3 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada3(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateJornada4(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada4");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records.update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
        "tarea": jornada.tarea.target!.tarea,
        "comentarios": jornada.tarea.target!.comentarios,
        "fecha_revision": jornada.tarea.target!.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "completada": jornada.completada,
            "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
          }); 
          if (recordJornada.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return true;
          }
          else{
            //No se pudo actualizar jornada en Pocketbase
            return false;
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada4(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateImagenJornada4(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada4 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada4(): $e');
      return false;
    }
  } 


  Future<bool?> syncUpdateEstadoConsultoria(Consultorias consultoria) async {
    print("Estoy en El syncUpdateEstadoConsultoria");
    try {
      final record = await client.records.update('consultorias', consultoria.idDBR! ,
      body: {
          "id_ambito_fk": consultoria.ambitoConsultoria.target!.idDBR,
          "id_area_circulo_fk": consultoria.areaCirculo.target!.idDBR,
          "archivado": consultoria.archivado,
      });
      if (record.id.isNotEmpty) {
        var updateConsultoria = dataBase.consultoriasBox.get(consultoria.id);
        if (record.id.isNotEmpty && updateConsultoria != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateConsultoria.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
            }
          return true;
        }
        else {
          return false;
        }
      }
      else{
        return false;
      }

    } catch (e) {
      print('ERROR - function syncUpdateEstadoConsultoria(): $e');
      return false;
    }

  } 

  Future<bool> syncUpdateTareaConsultoria(Tareas tarea, Bitacora bitacora) async {
    print("Estoy en El syncUpdateTareaConsultoria");
    List<String> tareasConsultoria = [];
    try {
      if (!bitacora.executePocketbase) {
        if (tarea.imagenes.isNotEmpty) {  
          if (tarea.imagenes.first.idDBR == null) {
            //Primero creamos la imagen asociada al producto Emp
            final recordImagen = await client.records.create('imagenes', body: {
              "nombre": tarea.imagenes.first.nombre,
              "id_emi_web": tarea.imagenes.first.idEmiWeb,
              "base64": tarea.imagenes.first.base64,
            });
            if (recordImagen.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              tarea.imagenes.first.idDBR = recordImagen.id;
              dataBase.imagenesBox.put(tarea.imagenes.first);
              //Segundo creamos la tarea asociada a la consultoria
              final recordTarea = await client.records.create('tareas', body: {
                "tarea": tarea.tarea,
                "descripcion": tarea.descripcion,
                "comentarios": tarea.comentarios,
                "id_porcentaje_fk": tarea.porcentaje.target!.idDBR,
                "fecha_revision": tarea.fechaRevision.toUtc().toString(),
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emi_web": tarea.idEmiWeb,
              });
              if (recordTarea.id.isNotEmpty) {
                //Tercero actualizamos los idsDBR de la consultoria
                final consultoria = dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
                if (consultoria != null) {
                  for (var element in consultoria.tareas.toList()) {
                    if (element.idDBR != null) {
                      tareasConsultoria.add(element.idDBR!);
                    }
                  }
                  tareasConsultoria.add(recordTarea.id);
                  final recordConsultoria = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
                    "id_tarea_fk": tareasConsultoria,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  }); 
                  if (recordConsultoria.id.isNotEmpty) {
                    print("Consultoria updated succesfully");
                    //Se recupera el idDBR de la tarea
                    tarea.idDBR = recordTarea.id;
                    dataBase.tareasBox.put(tarea);
                    print("Se recupera el idDBR de la Tarea");
                    //Se marca como realizada en Pocketbase la instrucción en Bitacora
                    bitacora.executePocketbase = true;
                    dataBase.bitacoraBox.put(bitacora);
                    if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                      //Se elimina la instrucción de la bitacora
                      dataBase.bitacoraBox.remove(bitacora.id);
                    }
                    return true;
                  } else {
                    //No se pudo actualizar la consultoría con la nueva tarea
                    return false;
                  }
                } else {
                  //No se encontró la consultoría en ObjectBox
                  return false;
                }
              } else {
                //No se pudo postear la tarea nueva
                return false;
              }   
            } else {
              // No se pudo postear la imagen asociada al producto Emp
              return false;
            }
          } else {
            if (tarea.idDBR == null) {
              //Segundo creamos la tarea asociada a la consultoria
              final recordTarea = await client.records.create('tareas', body: {
                "tarea": tarea.tarea,
                "descripcion": tarea.descripcion,
                "comentarios": tarea.comentarios,
                "id_porcentaje_fk": tarea.porcentaje.target!.idDBR,
                "fecha_revision": tarea.fechaRevision.toUtc().toString(),
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emi_web": tarea.idEmiWeb,
              });
              if (recordTarea.id.isNotEmpty) {
                //Tercero actualizamos los idsDBR de la consultoria
                final consultoria = dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
                if (consultoria != null) {
                  for (var element in consultoria.tareas.toList()) {
                    if (element.idDBR != null) {
                      tareasConsultoria.add(element.idDBR!);
                    }
                  }
                  tareasConsultoria.add(recordTarea.id);
                  final recordConsultoria = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
                    "id_tarea_fk": tareasConsultoria,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  }); 
                  if (recordConsultoria.id.isNotEmpty) {
                    print("Consultoria updated succesfully");
                    //Se recupera el idDBR de la tarea
                    tarea.idDBR = recordTarea.id;
                    dataBase.tareasBox.put(tarea);
                    print("Se recupera el idDBR de la Tarea");
                    //Se marca como realizada en Pocketbase la instrucción en Bitacora
                    bitacora.executePocketbase = true;
                    dataBase.bitacoraBox.put(bitacora);
                    if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                      //Se elimina la instrucción de la bitacora
                      dataBase.bitacoraBox.remove(bitacora.id);
                    }
                    return true;
                  } else {
                    //No se pudo actualizar la consultoría con la nueva tarea
                    return false;
                  }
                } else {
                  //No se encontró la consultoría en ObjectBox
                  return false;
                }
              } else {
                //No se pudo postear la tarea nueva
                return false;
              }   
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            }
          }
        } else {
          if (tarea.imagenes.first.idDBR == null) {
            // No hay imagen asociada al producto Emp
            //Segundo creamos la tarea asociada a la consultoria
            final recordTarea = await client.records.create('tareas', body: {
              "tarea": tarea.tarea,
              "descripcion": tarea.descripcion,
              "comentarios": tarea.comentarios,
              "id_porcentaje_fk": tarea.porcentaje.target!.idDBR,
              "fecha_revision": tarea.fechaRevision.toUtc().toString(),
              "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
              "id_emi_web": tarea.idEmiWeb,
            });
            if (recordTarea.id.isNotEmpty) {
              //Tercero actualizamos los idsDBR de la consultoria
              final consultoria = dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
              if (consultoria != null) {
                for (var element in consultoria.tareas.toList()) {
                  if (element.idDBR != null) {
                    tareasConsultoria.add(element.idDBR!);
                  }
                }
                tareasConsultoria.add(recordTarea.id);
                final recordConsultoria = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
                  "id_tarea_fk": tareasConsultoria,
                  "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                }); 
                if (recordConsultoria.id.isNotEmpty) {
                  print("Consultoria updated succesfully");
                  //Se recupera el idDBR de la tarea
                  tarea.idDBR = recordTarea.id;
                  dataBase.tareasBox.put(tarea);
                  print("Se recupera el idDBR de la Tarea");
                  //Se marca como realizada en Pocketbase la instrucción en Bitacora
                  bitacora.executePocketbase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                    //Se elimina la instrucción de la bitacora
                    dataBase.bitacoraBox.remove(bitacora.id);
                  }
                  return true;
                } else {
                  //No se pudo actualizar la consultoría con la nueva tarea
                  return false;
                }
              } else {
                //No se encontró la consultoría en ObjectBox
                return false;
              }
            } else {
              //No se pudo postear la tarea nueva
              return false;
            }   
          } else {
            if (bitacora.executeEmiWeb) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateTareaConsultoria(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateUsuario(Usuarios usuario, Bitacora bitacora) async {
    print("Estoy en El syncUpdateUsuario");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emi_users', usuario.idDBR.toString(), body: {
          "nombre_usuario": usuario.nombre,
          "apellido_p": usuario.apellidoP,
          "apellido_m": usuario.apellidoM,
          "telefono": usuario.telefono,
          "id_status_sync_fk": "HoI36PzYw1wtbO1"
        }); 

        if (record.id.isNotEmpty) {
          print("Usuario updated succesfully");
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateUsuario(): $e');
      return false;
    }

  } 

void deleteBitacora() {
  dataBase.bitacoraBox.removeAll();
  notifyListeners();
}

  Future<bool> syncUpdateProductoEmprendedor(ProductosEmp prodEmprendedor, Bitacora bitacora) async {
    print("Estoy en El syncUpdateProductoEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('productos_emp', prodEmprendedor.idDBR.toString(), body: {
            "nombre_prod_emp": prodEmprendedor.nombre,
            "descripcion": prodEmprendedor.descripcion,
            "id_und_medida_fk": prodEmprendedor.unidadMedida.target!.idDBR,
            "costo_prod_emp": prodEmprendedor.costo,
            "archivado": prodEmprendedor.archivado,
            // "id_imagen_fk": "RELATION_RECORD_ID",
        }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoEmprendedor(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateImagenProductoEmprendedor(Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenProductoEmprendedor en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('imagenes', imagen.idDBR.toString(), body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
        }); 
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenProductoEmprendedor(): $e');
      return false;
    }
  } 

  Future<bool> syncUpdateVenta(Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncUpdateVenta");
    try {
      if (!bitacora.executePocketbase) {
        final recordVenta = await client.records.update('ventas', venta.idDBR!, body: {
            "fecha_inicio": venta.fechaInicio.toUtc().toString(),
            "fecha_termino": venta.fechaTermino.toUtc().toString(),
            "total": venta.total,
        });
        if (recordVenta.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          // Falló al actualizar la venta en Pocketbase
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateVenta(): $e');
      return false;
    }
  }

  Future<bool> syncUpdateProductosVendidosVenta(Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncUpdateProductosVendidosVenta");
    try {
      if (!bitacora.executePocketbase) {
        final recordVenta = await client.records.update('ventas', venta.idDBR!, body: {
            "total": venta.total,
        });
        if (recordVenta.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          // Falló al actualizar la venta en Pocketbase
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductosVendidosVenta(): $e');
      return false;
    }
  }

  Future<bool> syncAcceptInversionesXProductosCotizados(InversionesXProdCotizados inversionXprodCotizados, Bitacora bitacora) async {
    print("Estoy en syncAcceptInversionesXProductosCotizados");
    try {
      if (!bitacora.executePocketbase) {
        final recordInversionXProdCotizados = await client.records.update('inversion_x_prod_cotizados', inversionXprodCotizados.idDBR.toString(), body: {
          "aceptado": inversionXprodCotizados.aceptado,
        });
        if (recordInversionXProdCotizados.id.isNotEmpty) {
          //Se actualiza monto, saldo y total de inversión
          final recordInversion = await client.records.update('inversiones', inversionXprodCotizados.inversion.target!.idDBR.toString(), body: {
            "id_estado_inversion_fk": inversionXprodCotizados.inversion.target!.estadoInversion.target!.idDBR,
            "monto_pagar": inversionXprodCotizados.inversion.target!.montoPagar,
            "saldo": inversionXprodCotizados.inversion.target!.saldo,
            "total_inversion": inversionXprodCotizados.inversion.target!.totalInversion,
          }); 
          if (recordInversion.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            return false;
          }
        } else {
          //No se pudo aceptar la inversion x prod cotizados a Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAcceptInversionesXProductosCotizados(): $e');
      return false;
    }
  }

    Future<bool> syncAcceptProdCotizado(ProdCotizados prodCotizado, Bitacora bitacora) async {
    print("Estoy en syncAcceptProductoCotizado");
    try {
      if (!bitacora.executePocketbase) {
        final recordProdCotizados = await client.records.update('productos_cotizados', prodCotizado.idDBR.toString(), body: {
          "aceptado": true,
        });
        if (recordProdCotizados.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          //No se pudo aceptar el prod cotizado a Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAcceptProductoCotizado(): $e');
      return false;
    }
  }

  Future<bool> syncAddPagoInversion(Pagos pago, Bitacora bitacora) async {
    print("Estoy en syncAddPagoInversion");
    try {
      if (!bitacora.executePocketbase) {
        if (pago.idDBR == null) {
          //Primero creamos el pago
          final pagoTarea = await client.records.create('pagos', body: {
          "monto_abonado": pago.montoAbonado,
          "fecha_movimiento": pago.fechaMovimiento.toUtc().toString(),
          "id_inversion_fk": pago.inversion.target!.idDBR,
          "id_usuario_fk": pago.inversion.target!.emprendimiento.target!.usuario.target!.idDBR,
          "id_emi_web": pago.idEmiWeb,
          });
          if (pagoTarea.id.isNotEmpty) {
            //Se recupera el idDBR del pago
            pago.idDBR = pagoTarea.id;
            dataBase.pagosBox.put(pago);
            //Segundo actualizamos la inversión   
            final recordInversion = await client.records.update('inversiones', pago.inversion.target!.idDBR.toString(),body: {
              "monto_pagar": pago.inversion.target!.montoPagar,
              "saldo": pago.inversion.target!.saldo,
            });

            if (recordInversion.id.isNotEmpty) {
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          //Segundo actualizamos la inversión   
          final recordInversion = await client.records.update('inversiones', pago.inversion.target!.idDBR.toString(),body: {
            "monto_pagar": pago.inversion.target!.montoPagar,
            "saldo": pago.inversion.target!.saldo,
          });

          if (recordInversion.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          } else {
            return false;
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddPagoInversion(): $e');
      return false;
    }
}

  Future<bool> syncUpdateProductoVendido(ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en syncUpdateProductoVendido");
    try {
      if (!bitacora.executePocketbase) {
        print("${productoVendido.cantVendida}");
        print("${productoVendido.subtotal}");
        print("${productoVendido.precioVenta}");
        print("${productoVendido.idEmiWeb}");
        print("Falla ?");
        print("Falla ? ${productoVendido.idDBR!}");
        final record = await client.records.update('prod_vendidos', productoVendido.idDBR!,
        body: {
            "cantidad_vendida": productoVendido.cantVendida,
            "subTotal": productoVendido.subtotal,
            "precio_venta": productoVendido.precioVenta,
            "id_emi_web": productoVendido.idEmiWeb,
        });
        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          } 
          return true;
        } else {
          //No se pudo actualizar el producto Solicitado a Pocketbase
          return false;
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoVendido(): $e');
      return false;
    }
  }

  Future<bool> syncArchivarEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncArchivarEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
          "archivado": true,
      }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }

    } catch (e) {
      print('ERROR - function syncArchivarEmprendimiento(): $e');
      return false;
    }
  } 

  Future<bool> syncDesarchivarEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncDesarchivarEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
          "archivado": false,
      }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }

    } catch (e) {
      print('ERROR - function syncDesarchivarEmprendimiento(): $e');
      return false;
    }
  } 

  Future<bool> syncArchivarConsultoria(Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en El syncArchivarConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
          "archivado": true,
      }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }

    } catch (e) {
      print('ERROR - function syncArchivarConsultoria(): $e');
      return false;
    }
  } 

  Future<bool> syncDesarchivarConsultoria(Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en El syncDesarchivarConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
          "archivado": false,
      }); 

        if (record.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return true;
        }
        else{
          return false;
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }

    } catch (e) {
      print('ERROR - function syncDesarchivarConsultoria(): $e');
      return false;
    }
  } 

//   Future<bool> syncUpdateInversion(Inversiones inversion, Bitacora bitacora) async {
//     try {
//       print("Estoy en syncUpdateInversion"); 
//       //Se busca el estado de inversión 'Solicitada'
//       final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
//       if (newEstadoInversion != null) {
//         print("Datos inversion");
//         print(inversion.estadoInversion);
//         print(inversion.porcentajePago);
//         print(inversion.montoPagar);
//         final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
//           "id_estado_inversion_fk": newEstadoInversion.idDBR,
//         }); 
//         if (record.id.isNotEmpty) {
//           bitacora.executePocketbase = true;
//           dataBase.bitacoraBox.put(bitacora);
//           print("Se marca como realizada en Pocketbase la instrucción en Bitacora");
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         return false;
//       }
//       } catch (e) {
//         print('ERROR - function syncUpdateInversion(): $e');
//         return false;
//       }
// }

  Future<bool> syncDeleteImagenJornada(Bitacora bitacora) async {
    print("Estoy en El syncDelteImagenJornada en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        await client.records.delete('imagenes', bitacora.idDBR.toString()); 
        //Se marca como realizada en Pocketbase la instrucción en Bitacora
        bitacora.executePocketbase = true;
        dataBase.bitacoraBox.put(bitacora);
        if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncDelteImagenJornada(): $e');
      return false;
    }
  } 

  Future<bool> syncDeleteProductoInversionJ3(Bitacora bitacora) async {
    print("Estoy en El syncDelteProdusyncDeleteProductoInversionJ3 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        await client.records.delete('productos_proyecto', bitacora.idDBR.toString()); 
        //Se marca como realizada en Pocketbase la instrucción en Bitacora
        bitacora.executePocketbase = true;
        dataBase.bitacoraBox.put(bitacora);
        if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncDeleteProductoInversionJ3(): $e');
      return false;
    }
  } 

 Future<bool> syncDeleteProductoVendido(Bitacora bitacora) async {
    print("Estoy en El syncDelteOroductoVendido en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        await client.records.delete('prod_vendidos', bitacora.idDBR.toString()); 
        //Se marca como realizada en Pocketbase la instrucción en Bitacora
        bitacora.executePocketbase = true;
        dataBase.bitacoraBox.put(bitacora);
        if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return true;
      }
    } catch (e) {
      print('ERROR - function syncDeleteProductoVendido(): $e');
      return false;
    }
  } 

  Future<bool?> syncDeleteProductoSolicitado(String idDBRProductoSolicitado) async {
    try {
      print("Estoy en syncDeleteProductoSolicitado"); 
      //Validamos que el elemento exista en el backend
      final record = await client.records.getOne('productos_solicitados', idDBRProductoSolicitado); 
      if (record.id.isNotEmpty) {
        //Se puede eliminar el producto solicitado en el backend
        await client.records.delete('productos_solicitados', idDBRProductoSolicitado); 
        print("Producto Solicitado deleted succesfully");
        return true;
        }
      } catch (e) {
        print('ERROR - function syncDeleteProductoSolicitado(): $e');
        return false;
      }
    return null;
}

  Future<bool> syncAddImagenesEntregaInversion(Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en syncAddImagenesEntregaInversion");
    try {
      if (!bitacora.executePocketbase) {
        if (inversion.imagenFirmaRecibido.target!.idDBR == null) {
          //Primero creamos la imagen de firma de recibo
          final recordImagenFirmaRecibido = await client.records.create('imagenes', body: {
            "nombre": inversion.imagenFirmaRecibido.target!.nombre,
            "id_emi_web": inversion.imagenFirmaRecibido.target!.idEmiWeb,
            "base64": inversion.imagenFirmaRecibido.target!.base64,
          });

          if (recordImagenFirmaRecibido.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            inversion.imagenFirmaRecibido.target!.idDBR = recordImagenFirmaRecibido.id;
            dataBase.imagenesBox.put(inversion.imagenFirmaRecibido.target!);
            //Segundo creamos la imagen de Producto Entregado 
            final recordImagenProductoEntregado = await client.records.create('imagenes', body: {
              "nombre": inversion.imagenProductoEntregado.target!.nombre,
              "id_emi_web": inversion.imagenProductoEntregado.target!.idEmiWeb,
              "base64": inversion.imagenProductoEntregado.target!.base64,
            });

            if (recordImagenProductoEntregado.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              inversion.imagenProductoEntregado.target!.idDBR = recordImagenProductoEntregado.id;
              dataBase.imagenesBox.put(inversion.imagenProductoEntregado.target!);
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          if (inversion.imagenProductoEntregado.target!.idDBR == null) {
            //Segundo creamos la imagen de Producto Entregado 
            final recordImagenProductoEntregado = await client.records.create('imagenes', body: {
              "nombre": inversion.imagenProductoEntregado.target!.nombre,
              "id_emi_web": inversion.imagenProductoEntregado.target!.idEmiWeb,
              "base64": inversion.imagenProductoEntregado.target!.base64,
            });

            if (recordImagenProductoEntregado.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              inversion.imagenProductoEntregado.target!.idDBR = recordImagenProductoEntregado.id;
              dataBase.imagenesBox.put(inversion.imagenProductoEntregado.target!);
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return true;
            } else {
              return false;
            }
          } else {
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            } 
            return true;
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return true;
      }
    } catch (e) {
      print('ERROR - function syncAddImagenesEntregaInversion(): $e');
      return false;
    }
}

// PROCESO DE OBTENCIÓN DE PRODUCTOS COTIZADOS 

  Future<bool> executeProductosCotizadosPocketbase(Emprendimientos emprendimiento, Inversiones inversion) async {
    exitoso = await getproductosCotizadosPocketbase(emprendimiento, inversion);
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
  }

  Future<bool> getproductosCotizadosPocketbase(Emprendimientos emprendimiento, Inversiones inversion) async {
    //¿Como recupero la inversionXprodCotizado? Si no está en Objectbox, sólo en pocketBase y Emi Web
    //Se obtiene el último inversionXprodCotizado en Pocketbase
    final recordsInversionXProdCotizado = await client.records.
    getFullList('inversion_x_prod_cotizados', 
    batch: 200, 
    filter: "id_inversion_fk='${
      inversion.idDBR
      }'",
    sort: "-created");
    if (recordsInversionXProdCotizado.isNotEmpty) {
    for (var element in recordsInversionXProdCotizado) {
    }
    final inversionXprodCotizadosParse =  getInversionXProdCotizadosFromMap(recordsInversionXProdCotizado[0].toString());
    //Obtenemos los productos cotizados
    final recordInversion = await client.records.
    getOne('inversiones', 
    inversion.idDBR!);
    final recordProdCotizados = await client.records.
    getFullList('productos_cotizados', 
    batch: 200, 
    filter: "id_inversion_x_prod_cotizados_fk='${
      inversionXprodCotizadosParse.id
      }'");
    if (recordProdCotizados.isEmpty || recordInversion.id.isEmpty) {
      //No se encontró la inversión ni los productos cotizados
      return false;
    } else {
      final GetInversion inversionParse = getInversionFromMap(recordInversion.toString());
      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(inversionParse.idEstadoInversionFk)).build().findUnique();
      if (estadoInversion != null) {
        if (estadoInversion.estado == "En Cotización") {
          final List<GetProdCotizados> listProdCotizados = [];
          for (var element in recordProdCotizados) {
            listProdCotizados.add(getProdCotizadosFromMap(element.toString()));
          }
          print("Dentro de En Cotización");
          print("****Informacion productos cotizados****");
          // Se recupera el idDBR de la instancia de inversion x prod Cotizados
          final nuevaIversionXprodCotizados = InversionesXProdCotizados(
            idDBR: inversionXprodCotizadosParse.id,
            idEmiWeb: inversionXprodCotizadosParse.idEmiWeb,
          );
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1");
          nuevaIversionXprodCotizados.statusSync.target = nuevoSync;
          for (var i = 0; i < recordProdCotizados.length; i++) {
            //Se valida que el nuevo prod Cotizado aún no existe en Objectbox
            final prodCotizadoExistente = dataBase.productosCotBox.query(ProdCotizados_.idDBR.equals(listProdCotizados[i].id)).build().findUnique();
            if (prodCotizadoExistente == null) {
              final nuevoProductoCotizado = ProdCotizados(
              cantidad: listProdCotizados[i].cantidad,
              costoTotal: listProdCotizados[i].costoTotal,
              idDBR: listProdCotizados[i].id,
              aceptado: listProdCotizados[i].aceptado,
              idEmiWeb: listProdCotizados[i].idEmiWeb,
              );
              final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
              final productoProv = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(listProdCotizados[i].idProductoProvFk)).build().findUnique();
              if (productoProv != null) {
                nuevoProductoCotizado.statusSync.target = nuevoSync;
                nuevoProductoCotizado.inversionXprodCotizados.target = nuevaIversionXprodCotizados;
                nuevoProductoCotizado.productosProv.target = productoProv;
                dataBase.productosCotBox.put(nuevoProductoCotizado);
                nuevaIversionXprodCotizados.prodCotizados.add(nuevoProductoCotizado);
                dataBase.inversionesXprodCotizadosBox.put(nuevaIversionXprodCotizados);
              } else {
                return false;
              }
            } else {

            }
          }
          //Se actualiza el estado de la inversión en ObjectBox
          final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En Cotización")).build().findFirst();
          if (newEstadoInversion != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
              dataBase.statusSyncBox.put(statusSync);
              inversion.estadoInversion.target = newEstadoInversion;
              nuevaIversionXprodCotizados.inversion.target = inversion; //Posible solución al error de PAGOS SCREEN
              dataBase.inversionesXprodCotizadosBox.put(nuevaIversionXprodCotizados);
              inversion.inversionXprodCotizados.add(nuevaIversionXprodCotizados);
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
          print("No se encuentar en Cotización la inversión");
          return false;
        }
      } else {
        return false;
      }
    }
    } else {
      //No se encontró ninguna inversión x prod Cotizado
      return false;
    }
  }
}
