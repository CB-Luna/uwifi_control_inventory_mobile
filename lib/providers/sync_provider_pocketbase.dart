import 'package:bizpro_app/helpers/sync_instruction.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion.dart';
import 'package:bizpro_app/modelsPocketbase/get_inversion_x_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_inversion_pocketbase.dart';
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

  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora,
      List<InstruccionNoSincronizada> instruccionesFallidasEmiWeb) async {
    // Se recuperan instrucciones fallidas anteriores
    instruccionesFallidas = instruccionesFallidasEmiWeb;
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      print("La instrucción es: ${instruccionesBitacora[i].instruccion}");
      switch (instruccionesBitacora[i].instruccion) {
        case "syncAddImagenUsuario":
          print("Entro al caso de syncAddImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncAddImagenUsuario = await syncAddImagenUsuario(
                imagenToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenUsuario.exitoso) {
              banderasExistoSync.add(responseSyncAddImagenUsuario.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddImagenUsuario.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddImagenUsuario.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "La instrucción para agregar Imagen de Perfil del Usuario en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddEmprendedor":
          print("Entro al caso de syncAddEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(
              dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if (emprendedorToSync != null) {
            final responseSyncAddEmprendedor = await syncAddEmprendedor(
                emprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncAddEmprendedor.exitoso) {
              banderasExistoSync.add(responseSyncAddEmprendedor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddEmprendedor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento:
                      emprendedorToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddEmprendedor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar el Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddEmprendimiento":
          print("Entro al caso de syncAddEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendimientoToSync != null) {
            final responseSyncAddEmprendimiento =
                syncAddEmprendimiento(instruccionesBitacora[i]);
            if (responseSyncAddEmprendimiento.exitoso) {
              banderasExistoSync.add(responseSyncAddEmprendimiento.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddEmprendimiento.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendimientoToSync.nombre,
                  instruccion: responseSyncAddEmprendimiento.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar el Emprendimiento en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddJornada1":
          print("Entro al caso de syncAddJornada1 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncAddJornada1 =
                await syncAddJornada1(jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncAddJornada1.exitoso) {
              banderasExistoSync.add(responseSyncAddJornada1.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddJornada1.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddJornada1.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar la Jornada 1 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddJornada2":
          print("Entro al caso de syncAddJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncAddJornada2 =
                await syncAddJornada2(jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncAddJornada2.exitoso) {
              banderasExistoSync.add(responseSyncAddJornada2.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddJornada2.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddJornada2.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar la Jornada 2 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddImagenJornada2":
          print("Entro al caso de syncAddImagenJornada2 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncAddImagenJornada2 = await syncAddImagenJornada2(
                imagenToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenJornada2.exitoso) {
              banderasExistoSync.add(responseSyncAddImagenJornada2.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddImagenJornada2.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.tarea.target!.jornada.target!
                      .emprendimiento.target!.nombre,
                  instruccion: responseSyncAddImagenJornada2.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Imagen de la Jornada 2 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddJornada3":
          print("Entro al caso de syncAddJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncAddJornada3 =
                await syncAddJornada3(jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncAddJornada3.exitoso) {
              banderasExistoSync.add(responseSyncAddJornada3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddJornada3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddJornada3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar la Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddImagenJornada3":
          print("Entro al caso de syncAddImagenJornada3 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncAddImagenJornada3 = await syncAddImagenJornada3(
                imagenToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenJornada3.exitoso) {
              banderasExistoSync.add(responseSyncAddImagenJornada3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddImagenJornada3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.tarea.target!.jornada.target!
                      .emprendimiento.target!.nombre,
                  instruccion: responseSyncAddImagenJornada3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Imagen de la Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddProductoInversionJ3":
          print("Entro al caso de syncAddProductoInversionJ3 Pocketbase");
          final prodSolicitadoToSync = getFirstProdSolicitado(
              dataBase.productosSolicitadosBox.getAll(),
              instruccionesBitacora[i].id);
          if (prodSolicitadoToSync != null) {
            final responseSyncAddProductoInversionJ3 =
                await syncAddProductoInversionJ3(
                    prodSolicitadoToSync, instruccionesBitacora[i]);
            if (responseSyncAddProductoInversionJ3.exitoso) {
              banderasExistoSync
                  .add(responseSyncAddProductoInversionJ3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAddProductoInversionJ3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: prodSolicitadoToSync
                      .inversion.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddProductoInversionJ3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar un Producto Solicitado en la Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddJornada4":
          print("Entro al caso de syncAddJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncAddJornada4 =
                await syncAddJornada4(jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncAddJornada4.exitoso) {
              banderasExistoSync.add(responseSyncAddJornada4.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddJornada4.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddJornada4.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar la Jornada 4 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddImagenJornada4":
          print("Entro al caso de syncAddImagenJornada4 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncAddImagenJornada4 = await syncAddImagenJornada4(
                imagenToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenJornada4.exitoso) {
              banderasExistoSync.add(responseSyncAddImagenJornada4.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddImagenJornada4.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.tarea.target!.jornada.target!
                      .emprendimiento.target!.nombre,
                  instruccion: responseSyncAddImagenJornada4.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Imagen de la Jornada 4 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddConsultoria":
          print("Entro al caso de syncAddConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(
              dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if (consultoriaToSync != null) {
            final responseSyncAddConsultoria = await syncAddConsultoria(
                consultoriaToSync, instruccionesBitacora[i]);
            if (responseSyncAddConsultoria.exitoso) {
              banderasExistoSync.add(responseSyncAddConsultoria.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddConsultoria.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento:
                      consultoriaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddConsultoria.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Consultoría en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddProductoEmprendedor":
          print("Entro al caso de syncAddProductoEmprendedor Pocketbase");
          final productoEmpToSync = getFirstProductoEmprendedor(
              dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if (productoEmpToSync != null) {
            final responseSyncAddProductoEmp = await syncAddProductoEmprendedor(
                productoEmpToSync, instruccionesBitacora[i]);
            if (responseSyncAddProductoEmp.exitoso) {
              banderasExistoSync.add(responseSyncAddProductoEmp.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddProductoEmp.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento:
                      productoEmpToSync.emprendimientos.target!.nombre,
                  instruccion: responseSyncAddProductoEmp.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar un Producto del Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddImagenProductoEmprendedor":
          print("Entro al caso de syncAddImagenProductoEmprendedor Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncAddImagenProductoEmprendedor =
                await syncAddImagenProductoEmprendedor(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenProductoEmprendedor.exitoso) {
              banderasExistoSync
                  .add(responseSyncAddImagenProductoEmprendedor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAddImagenProductoEmprendedor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion:
                      responseSyncAddImagenProductoEmprendedor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "La instrucción para agregar una Imagen del Producto del Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddVenta":
          print("Entro al caso de syncAddVenta Pocketbase");
          final ventaToSync = getFirstVenta(
              dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if (ventaToSync != null) {
            final responseSyncAddVenta =
                await syncAddVenta(ventaToSync, instruccionesBitacora[i]);
            if (responseSyncAddVenta.exitoso) {
              banderasExistoSync.add(responseSyncAddVenta.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddVenta.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddVenta.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Venta en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddProductoVendido":
          print("Entro al caso de syncAddProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(
              dataBase.productosVendidosBox.getAll(),
              instruccionesBitacora[i].id);
          if (prodVendidoToSync != null) {
            final responseSyncAddProductoVendido = await syncAddProductoVendido(
                prodVendidoToSync, instruccionesBitacora[i]);
            if (responseSyncAddProductoVendido.exitoso) {
              banderasExistoSync.add(responseSyncAddProductoVendido.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddProductoVendido.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: prodVendidoToSync
                      .venta.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddProductoVendido.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar un Producto Vendido en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddSingleProductoVendido":
          print("Entro al caso de syncAddSingleProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(
              dataBase.productosVendidosBox.getAll(),
              instruccionesBitacora[i].id);
          if (prodVendidoToSync != null) {
            final responseSyncAddSingleProductoVendido =
                await syncAddSingleProductoVendido(
                    prodVendidoToSync, instruccionesBitacora[i]);
            if (responseSyncAddSingleProductoVendido.exitoso) {
              banderasExistoSync
                  .add(responseSyncAddSingleProductoVendido.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAddSingleProductoVendido.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: prodVendidoToSync
                          .venta.target?.emprendimiento.target?.nombre ??
                      "SIN EMPRENDIMIENTO",
                  instruccion: responseSyncAddSingleProductoVendido.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar un Producto Vendido en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddInversion":
          print("Entro al caso de syncAddInversion Pocketbase");
          final inversionToSync = getFirstInversion(
              dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if (inversionToSync != null) {
            final responseSyncAddInversion = await syncAddInversion(
                inversionToSync, instruccionesBitacora[i]);
            if (responseSyncAddInversion.exitoso) {
              banderasExistoSync.add(responseSyncAddInversion.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddInversion.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddInversion.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar una Inversión en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateFaseEmprendimiento":
          print("Entro al caso de syncUpdateFaseEmprendimiento Pocketbase");
          final emprendimientoToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendimientoToSync != null) {
            final responseSyncUpdateFaseEmprendimiento =
                await syncUpdateFaseEmprendimiento(
                    emprendimientoToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateFaseEmprendimiento.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateFaseEmprendimiento.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateFaseEmprendimiento.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendimientoToSync.nombre,
                  instruccion: responseSyncUpdateFaseEmprendimiento.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Fase del Emprendimiento a ${instruccionesBitacora[i].instruccionAdicional} en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateImagenUsuario":
          print("Entro al caso de syncUpdateImagenUsuario Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncUpdateImagenUsuario =
                await syncUpdateImagenUsuario(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateImagenUsuario.exitoso) {
              print("La respuesta es: $responseSyncUpdateImagenUsuario");
              banderasExistoSync.add(responseSyncUpdateImagenUsuario.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateImagenUsuario.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncUpdateImagenUsuario.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "La instrucción para actualizar Imagen de Perfil del Usuario en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateNameEmprendimiento":
          final emprendimientoToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendimientoToSync != null) {
            print("Entro aqui en el else");
            if (emprendimientoToSync.idDBR != null) {
              print("Ya ha sido enviado al backend");
              syncUpdateNameEmprendimiento(emprendimientoToSync);
            } else {
              print("No ha sido enviado al backend");
            }
          }
          continue;
        case "syncUpdateEmprendedor":
          print("Entro al caso de syncUpdateEmprendedor Pocketbase");
          final emprendedorToSync = getFirstEmprendedor(
              dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if (emprendedorToSync != null) {
            final responseSyncUpdateEmprendedor = await syncUpdateEmprendedor(
                emprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateEmprendedor.exitoso) {
              banderasExistoSync.add(responseSyncUpdateEmprendedor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateEmprendedor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendedorToSync.nombre,
                  instruccion: responseSyncUpdateEmprendedor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              // instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            // instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateEmprendimiento":
          print("Entro al caso de syncUpdateEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendedorToSync != null) {
            final responseSyncUpdateEmprendimiento =
                await syncUpdateEmprendimiento(
                    emprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateEmprendimiento.exitoso) {
              banderasExistoSync.add(responseSyncUpdateEmprendimiento.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateEmprendimiento.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendedorToSync.nombre,
                  instruccion: responseSyncUpdateEmprendimiento.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Emprendimiento en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateJornada1":
          print("Entro al caso de syncUpdateJornada1 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncUpdateJornada1 = await syncUpdateJornada1(
                jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateJornada1.exitoso) {
              banderasExistoSync.add(responseSyncUpdateJornada1.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateJornada1.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateJornada1.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Jornada 1 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateJornada2":
          print("Entro al caso de syncUpdateJornada2 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncUpdateJornada2 = await syncUpdateJornada2(
                jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateJornada2.exitoso) {
              banderasExistoSync.add(responseSyncUpdateJornada2.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateJornada2.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateJornada2.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Jornada 2 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateImagenJornada2":
          print("Entro al caso de syncUpdateImagenJornada2 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncUpdateImagenJornada2 =
                await syncUpdateImagenJornada2(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateImagenJornada2.exitoso) {
              banderasExistoSync.add(responseSyncUpdateImagenJornada2.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateImagenJornada2.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateImagenJornada2.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Imagen en Jornada 2 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateJornada3":
          print("Entro al caso de syncUpdateJornada3 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncUpdateJornada3 = await syncUpdateJornada3(
                jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateJornada3.exitoso) {
              banderasExistoSync.add(responseSyncUpdateJornada3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateJornada3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateJornada3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateImagenJornada3":
          print("Entro al caso de syncUpdateImagenJornada3 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncUpdateImagenJornada3 =
                await syncUpdateImagenJornada3(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateImagenJornada3.exitoso) {
              banderasExistoSync.add(responseSyncUpdateImagenJornada3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateImagenJornada3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateImagenJornada3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Imagen en Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateProductoInversionJ3":
          print("Entro al caso de syncUpdateProductoInversionJ3 Pocketbase");
          final prodSolicitadoToSync = getFirstProdSolicitado(
              dataBase.productosSolicitadosBox.getAll(),
              instruccionesBitacora[i].id);
          if (prodSolicitadoToSync != null) {
            final responseSyncUpdateProductoInversionJ3 =
                await syncUpdateProductoInversionJ3(
                    prodSolicitadoToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateProductoInversionJ3.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateProductoInversionJ3.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateProductoInversionJ3.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: prodSolicitadoToSync
                      .inversion.target!.emprendimiento.target!.nombre,
                  instruccion:
                      responseSyncUpdateProductoInversionJ3.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Producto Solicitado en Inversión de la Jornada 3 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateJornada4":
          print("Entro al caso de syncUpdateJornada4 Pocketbase");
          final jornadaToSync = getFirstJornada(
              dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if (jornadaToSync != null) {
            final responseSyncUpdateJornada4 = await syncUpdateJornada4(
                jornadaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateJornada4.exitoso) {
              banderasExistoSync.add(responseSyncUpdateJornada4.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateJornada4.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: jornadaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateJornada4.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar la Imagen en Jornada 4 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateImagenJornada4":
          print("Entro al caso de syncUpdateImagenJornada4 Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncUpdateImagenJornada4 =
                await syncUpdateImagenJornada4(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateImagenJornada4.exitoso) {
              banderasExistoSync.add(responseSyncUpdateImagenJornada4.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateImagenJornada4.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: imagenToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateImagenJornada4.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Producto Solicitado en Inversión de la Jornada 4 en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDeleteImagenJornada":
          print("Entro al caso de syncDeleteImagenJornada Pocketbase");
          final responseSyncDeleteImagenJornada =
              await syncDeleteImagenJornada(instruccionesBitacora[i]);
          if (responseSyncDeleteImagenJornada.exitoso) {
            banderasExistoSync.add(responseSyncDeleteImagenJornada.exitoso);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(responseSyncDeleteImagenJornada.exitoso);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: instruccionesBitacora[i].emprendimiento,
                instruccion: responseSyncDeleteImagenJornada.descripcion,
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDeleteProductoInversionJ3":
          print("Entro al caso de syncDeleteProductoInversionJ3 Pocketbase");
          final responseSyncDeleteProductoInversionJ3 =
              await syncDeleteProductoInversionJ3(instruccionesBitacora[i]);
          if (responseSyncDeleteProductoInversionJ3.exitoso) {
            banderasExistoSync
                .add(responseSyncDeleteProductoInversionJ3.exitoso);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync
                .add(responseSyncDeleteProductoInversionJ3.exitoso);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: instruccionesBitacora[i].emprendimiento,
                instruccion: responseSyncDeleteProductoInversionJ3.descripcion,
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateTareaConsultoria":
          print("Entro al caso de syncUpdateTareaConsultoria Pocketbase");
          final tareaToSync = getFirstTarea(
              dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if (tareaToSync != null) {
            final responseSyncUpdateTareaConsultoria =
                await syncUpdateTareaConsultoria(
                    tareaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateTareaConsultoria.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateTareaConsultoria.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateTareaConsultoria.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: tareaToSync
                      .consultoria.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateTareaConsultoria.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Tarea en Consultoría en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateUsuario":
          print("Entro al caso de syncUpdateUsuario Pocketbase");
          final usuarioToSync = getFirstUsuario(
              dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if (usuarioToSync != null) {
            final responseSyncUpdateUsuario = await syncUpdateUsuario(
                usuarioToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateUsuario.exitoso) {
              banderasExistoSync.add(responseSyncUpdateUsuario.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateUsuario.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncUpdateUsuario.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "La instrucción para actualizar información de Usuario en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateEstadoInversion":
          print("Entro al caso de syncUpdateEstadoInversion Pocketbase");
          final inversionToSync = getFirstInversion(
              dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if (inversionToSync != null) {
            final responseSyncUpdateEstadoInversion =
                await syncUpdateEstadoInversion(
                    inversionToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateEstadoInversion.exitoso) {
              banderasExistoSync.add(responseSyncUpdateEstadoInversion.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateEstadoInversion.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateEstadoInversion.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar el Estado de la Inversión en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateProductoEmprendedor":
          print("Entro al caso de syncUpdateProductoEmprendedor Pocketbase");
          final productoEmprendedorToSync = getFirstProductoEmprendedor(
              dataBase.productosEmpBox.getAll(), instruccionesBitacora[i].id);
          if (productoEmprendedorToSync != null) {
            final responseSyncUpdateProductoEmprendedor =
                await syncUpdateProductoEmprendedor(
                    productoEmprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateProductoEmprendedor.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateProductoEmprendedor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateProductoEmprendedor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: productoEmprendedorToSync.nombre,
                  instruccion:
                      responseSyncUpdateProductoEmprendedor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar el Producto del Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateImagenProductoEmprendedor":
          print(
              "Entro al caso de syncUpdateImagenProductoEmprendedor Pocketbase");
          final imagenToSync = getFirstImagen(
              dataBase.imagenesBox.getAll(), instruccionesBitacora[i].id);
          if (imagenToSync != null) {
            final responseSyncUpdateImagenProdEmprendedor =
                await syncUpdateImagenProductoEmprendedor(
                    imagenToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateImagenProdEmprendedor.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateImagenProdEmprendedor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateImagenProdEmprendedor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion:
                      responseSyncUpdateImagenProdEmprendedor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "La instrucción para actualizar la Imagen del Producto del Emprendedor en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateProductoVendido":
          print("Entro al caso de syncUpdateProductoVendido Pocketbase");
          final prodVendidoToSync = getFirstProductoVendido(
              dataBase.productosVendidosBox.getAll(),
              instruccionesBitacora[i].id);
          if (prodVendidoToSync != null) {
            final responseSyncUpdateProductoVendido =
                await syncUpdateProductoVendido(
                    prodVendidoToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateProductoVendido.exitoso) {
              banderasExistoSync.add(responseSyncUpdateProductoVendido.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateProductoVendido.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: prodVendidoToSync
                      .venta.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateProductoVendido.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar el Producto Vendido en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateVenta":
          print("Entro al caso de syncUpdateVenta Pocketbase");
          final ventaToSync = getFirstVenta(
              dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if (ventaToSync != null) {
            final responseSyncUpdateVenta =
                await syncUpdateVenta(ventaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateVenta.exitoso) {
              banderasExistoSync.add(responseSyncUpdateVenta.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateVenta.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncUpdateVenta.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar información de Venta en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncUpdateProductosVendidosVenta":
          print("Entro al caso de syncUpdateProductosVendidosVenta Pocketbase");
          final ventaToSync = getFirstVenta(
              dataBase.ventasBox.getAll(), instruccionesBitacora[i].id);
          if (ventaToSync != null) {
            final responseSyncUpdateProductosVendidosVenta =
                await syncUpdateProductosVendidosVenta(
                    ventaToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateProductosVendidosVenta.exitoso) {
              banderasExistoSync
                  .add(responseSyncUpdateProductosVendidosVenta.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncUpdateProductosVendidosVenta.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: ventaToSync.emprendimiento.target!.nombre,
                  instruccion:
                      responseSyncUpdateProductosVendidosVenta.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para actualizar Total de Venta en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncArchivarEmprendimiento":
          print("Entro al caso de syncArchivarEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendedorToSync != null) {
            final responseSyncArchivarEmprendimiento =
                await syncArchivarEmprendimiento(
                    emprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncArchivarEmprendimiento.exitoso) {
              banderasExistoSync
                  .add(responseSyncArchivarEmprendimiento.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncArchivarEmprendimiento.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendedorToSync.nombre,
                  instruccion: responseSyncArchivarEmprendimiento.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para archivar Emprendimiento en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDesarchivarEmprendimiento":
          print("Entro al caso de syncDesarchivarEmprendimiento Pocketbase");
          final emprendedorToSync = getFirstEmprendimiento(
              dataBase.emprendimientosBox.getAll(),
              instruccionesBitacora[i].id);
          if (emprendedorToSync != null) {
            final responseSyncDesarchivarEmprendimiento =
                await syncDesarchivarEmprendimiento(
                    emprendedorToSync, instruccionesBitacora[i]);
            if (responseSyncDesarchivarEmprendimiento.exitoso) {
              banderasExistoSync
                  .add(responseSyncDesarchivarEmprendimiento.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncDesarchivarEmprendimiento.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: emprendedorToSync.nombre,
                  instruccion:
                      responseSyncDesarchivarEmprendimiento.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para desarchivar el Emprendimiento en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncArchivarConsultoria":
          print("Entro al caso de syncArchivarConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(
              dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if (consultoriaToSync != null) {
            final responseSyncArchivarConsultoria =
                await syncArchivarConsultoria(
                    consultoriaToSync, instruccionesBitacora[i]);
            if (responseSyncArchivarConsultoria.exitoso) {
              banderasExistoSync.add(responseSyncArchivarConsultoria.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncArchivarConsultoria.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento:
                      consultoriaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncArchivarConsultoria.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para archivar la Consultoría en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDesarchivarConsultoria":
          print("Entro al caso de syncDesarchivarConsultoria Pocketbase");
          final consultoriaToSync = getFirstConsultoria(
              dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if (consultoriaToSync != null) {
            final responseSyncDesarchivarConsultoria =
                await syncDesarchivarConsultoria(
                    consultoriaToSync, instruccionesBitacora[i]);
            if (responseSyncDesarchivarConsultoria.exitoso) {
              banderasExistoSync
                  .add(responseSyncDesarchivarConsultoria.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncDesarchivarConsultoria.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento:
                      consultoriaToSync.emprendimiento.target!.nombre,
                  instruccion: responseSyncDesarchivarConsultoria.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para desarchivar la Consultoría en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAcceptInversionXProdCotizado":
          print("Entro al caso de syncAcceptInversionXProdCotizado Pocketbase");
          final inversionXproductoCotizadoToSync =
              getFirstInversionXProductosCotizados(
                  dataBase.inversionesXprodCotizadosBox.getAll(),
                  instruccionesBitacora[i].id);
          if (inversionXproductoCotizadoToSync != null) {
            final responseSyncAcceptInversionXProductoCotizado =
                await syncAcceptInversionesXProductosCotizados(
                    inversionXproductoCotizadoToSync, instruccionesBitacora[i]);
            if (responseSyncAcceptInversionXProductoCotizado.exitoso) {
              banderasExistoSync
                  .add(responseSyncAcceptInversionXProductoCotizado.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAcceptInversionXProductoCotizado.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: inversionXproductoCotizadoToSync
                      .inversion.target!.emprendimiento.target!.nombre,
                  instruccion:
                      responseSyncAcceptInversionXProductoCotizado.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para aceptar la Cotización de la Inversión en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAcceptProdCotizado":
          print("Entro al caso de syncAcceptProdCotizado Pocketbase");
          final productoCotizadoToSync = getFirstProductoCotizado(
              dataBase.productosCotBox.getAll(), instruccionesBitacora[i].id);
          if (productoCotizadoToSync != null) {
            final responseSyncAcceptProductoCotizado =
                await syncAcceptProdCotizado(
                    productoCotizadoToSync, instruccionesBitacora[i]);
            if (responseSyncAcceptProductoCotizado.exitoso) {
              banderasExistoSync
                  .add(responseSyncAcceptProductoCotizado.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAcceptProductoCotizado.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: productoCotizadoToSync.inversionXprodCotizados
                      .target!.inversion.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncAcceptProductoCotizado.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para aceptar Producto Cotizado en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDeleteProductoVendido":
          print("Entro al caso de syncDeleteProductoVendido Pocketbase");
          final responseSyncDeleteProductoVendido =
              await syncDeleteProductoVendido(instruccionesBitacora[i]);
          if (responseSyncDeleteProductoVendido.exitoso) {
            banderasExistoSync.add(responseSyncDeleteProductoVendido.exitoso);
            continue;
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(responseSyncDeleteProductoVendido.exitoso);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: instruccionesBitacora[i].emprendimiento,
                instruccion: responseSyncDeleteProductoVendido.descripcion,
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncDeleteProductoSolicitado":
          final idDBRProdSolicitado = instruccionesBitacora[i].idDBR;
          print("Entro aqui en el DeleteProductoSolicitado");
          if (idDBRProdSolicitado != null) {
            //TODO Hacer el método para eliminar en backend
          } else {
            print("No se había sincronizado");
          }
          continue;
        case "syncAddPagoInversion":
          print("Entro al caso de syncAddPagoInversion Pocketbase");
          final pagoToSync = getFirstPago(
              dataBase.pagosBox.getAll(), instruccionesBitacora[i].id);
          if (pagoToSync != null) {
            final responseSyncAddPago = await syncAddPagoInversion(
                pagoToSync, instruccionesBitacora[i]);
            if (responseSyncAddPago.exitoso) {
              banderasExistoSync.add(responseSyncAddPago.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddPago.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: pagoToSync
                      .inversion.target!.emprendimiento.target!.nombre,
                  instruccion: responseSyncAddPago.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar Pago a la Inversión en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
            continue;
          }
        case "syncAddImagenesEntregaInversion":
          print("Entro al caso de syncAddImagenesEntregaInversion Pocketbase");
          final inversionToSync = getFirstInversion(
              dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if (inversionToSync != null) {
            final responseSyncAddImagenesEntregaInversion =
                await syncAddImagenesEntregaInversion(
                    inversionToSync, instruccionesBitacora[i]);
            if (responseSyncAddImagenesEntregaInversion.exitoso) {
              banderasExistoSync
                  .add(responseSyncAddImagenesEntregaInversion.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync
                  .add(responseSyncAddImagenesEntregaInversion.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  emprendimiento: inversionToSync.emprendimiento.target!.nombre,
                  instruccion:
                      responseSyncAddImagenesEntregaInversion.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              // instruccionesFallidas.add(instruccionNoSincronizada);
              print(instruccionNoSincronizada.instruccion);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                emprendimiento: "No encontrado",
                instruccion:
                    "La instrucción para agregar Imágenes de Firma de Recibido y Producto Entregado a la Inversión en el Servidor Local no pudo ejecutarse.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            // instruccionesFallidas.add(instruccionNoSincronizada);
            print(instruccionNoSincronizada.instruccion);
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

  Usuarios? getFirstUsuario(
      List<Usuarios> usuarios, int idInstruccionesBitacora) {
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

  Emprendedores? getFirstEmprendedor(
      List<Emprendedores> emprendedores, int idInstruccionesBitacora) {
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

  Emprendimientos? getFirstEmprendimiento(
      List<Emprendimientos> emprendimientos, int idInstruccionesBitacora) {
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

  Imagenes? getFirstImagen(
      List<Imagenes> imagenes, int idInstruccionesBitacora) {
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

  Jornadas? getFirstJornada(
      List<Jornadas> jornadas, int idInstruccionesBitacora) {
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

  Inversiones? getFirstInversion(
      List<Inversiones> inversiones, int idInstruccionesBitacora) {
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

  ProdSolicitado? getFirstProdSolicitado(
      List<ProdSolicitado> prodSolicitado, int idInstruccionesBitacora) {
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

  Consultorias? getFirstConsultoria(
      List<Consultorias> consultorias, int idInstruccionesBitacora) {
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

  ProductosEmp? getFirstProductoEmprendedor(
      List<ProductosEmp> productosEmp, int idInstruccionesBitacora) {
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

  Ventas? getFirstVenta(List<Ventas> ventas, int idInstruccionesBitacora) {
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

  ProdVendidos? getFirstProductoVendido(
      List<ProdVendidos> prodVendidos, int idInstruccionesBitacora) {
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

  Tareas? getFirstTarea(List<Tareas> tareas, int idInstruccionesBitacora) {
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

  Pagos? getFirstPago(List<Pagos> pagos, int idInstruccionesBitacora) {
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

  ProdCotizados? getFirstProductoCotizado(
      List<ProdCotizados> prodCotizados, int idInstruccionesBitacora) {
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

  InversionesXProdCotizados? getFirstInversionXProductosCotizados(
      List<InversionesXProdCotizados> inversionXprodCotizados,
      int idInstruccionesBitacora) {
    for (var i = 0; i < inversionXprodCotizados.length; i++) {
      if (inversionXprodCotizados[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < inversionXprodCotizados[i].bitacora.length; j++) {
          if (inversionXprodCotizados[i].bitacora[j].id ==
              idInstruccionesBitacora) {
            return inversionXprodCotizados[i];
          }
        }
      }
    }
    return null;
  }

  Future<SyncInstruction> syncAddEmprendedor(
      Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncAddEmprendedor de Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final emprendimientoToSync = dataBase.emprendimientosBox
            .query(Emprendimientos_.emprendedor.equals(emprendedor.id))
            .build()
            .findUnique();
        final faseInscricto = dataBase.fasesEmpBox
            .query(FasesEmp_.fase.equals("Inscrito"))
            .build()
            .findUnique();
        if (emprendimientoToSync != null && faseInscricto != null) {
          if (emprendedor.idDBR == null) {
            //Primero creamos el emprendedor asociado al emprendimiento
            final recordEmprendedor =
                await client.records.create('emprendedores', body: {
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
              final recordEmprendimiento =
                  await client.records.create('emprendimientos', body: {
                "nombre_emprendimiento": emprendimientoToSync.nombre,
                "descripcion": emprendimientoToSync.descripcion,
                "activo": emprendimientoToSync.activo,
                "archivado": emprendimientoToSync.archivado,
                "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
                "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk":
                    emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                var updateEmprendimiento =
                    dataBase.emprendimientosBox.get(emprendimientoToSync.id);
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
                  return SyncInstruction(exitoso: true, descripcion: "");
                } else {
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', emprendimiento asociado no encontrado en el dispositivo para asignarle id del Servidor Local.");
                }
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', no se pudo recuperar id desde Servidor Local para el emprendimiento asociado al emprendedor creado.");
              }
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', no se pudo recuperar id desde Servidor Local para el emprendedor creado.");
            }
          } else {
            if (emprendimientoToSync.idDBR == null) {
              //Segundo creamos el emprendimiento
              final recordEmprendimiento =
                  await client.records.create('emprendimientos', body: {
                "nombre_emprendimiento": emprendimientoToSync.nombre,
                "descripcion": emprendimientoToSync.descripcion,
                "activo": emprendimientoToSync.activo,
                "archivado": emprendimientoToSync.archivado,
                "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
                "id_prioridad_fk": "yuEVuBv9rxLM4cR",
                "id_proveedor_fk": "",
                "id_fase_emp_fk": faseInscricto.idDBR,
                "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                "id_emprendedor_fk":
                    emprendimientoToSync.emprendedor.target!.idDBR,
                "id_emi_web": emprendimientoToSync.idEmiWeb,
              });
              if (recordEmprendimiento.id.isNotEmpty) {
                String idDBR = recordEmprendimiento.id;
                var updateEmprendimiento =
                    dataBase.emprendimientosBox.get(emprendimientoToSync.id);
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
                  return SyncInstruction(exitoso: true, descripcion: "");
                } else {
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', emprendimiento asociado no encontrado en el dispositivo para asignarle id del Servidor Local.");
                }
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', no se pudo recuperar id desde Servidor Local para el emprendedor creado.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}', emprendimiento y fase correspondiente no encontrados en el dispositivo.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}' en el Servidor Local, detalles: $e");
    }
  }

  SyncInstruction syncAddEmprendimiento(Bitacora bitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se marca como realizada en Pocketbase la instrucción en Bitacora
      bitacora.executePocketbase = true;
      dataBase.bitacoraBox.put(bitacora);
      if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
        //Se elimina la instrucción de la bitacora
        dataBase.bitacoraBox.remove(bitacora.id);
      }
      return SyncInstruction(exitoso: true, descripcion: "");
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Emprendimiento en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddJornada1(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada1");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox
            .query(Tareas_.id.equals(jornada.tarea.target!.id))
            .build()
            .findUnique();
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
            "jornada": true,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la jornada
              final recordJornada =
                  await client.records.create('jornadas', body: {
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Jornada 1, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Jornada 1, no se pudo recuperar id desde Servidor Local para la tarea asociada a la jornada creada.");
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada
              final recordJornada =
                  await client.records.create('jornadas', body: {
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Jornada 1, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Jornada 1, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddJornada1(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Jornada 1 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddJornada2(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada2");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox
            .query(Tareas_.id.equals(jornada.tarea.target!.id))
            .build()
            .findUnique();
        if (tareaToSync != null) {
          if (tareaToSync.idDBR == null) {
            // Creamos y enviamos las imágenes de la jornada
            for (var i = 0;
                i < jornada.tarea.target!.imagenes.toList().length;
                i++) {
              if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                final recordImagen =
                    await client.records.create('imagenes', body: {
                  "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                  "id_emi_web":
                      jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                  "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                });
                jornada.tarea.target!.imagenes.toList()[i].idDBR =
                    recordImagen.id;
                dataBase.imagenesBox
                    .put(jornada.tarea.target!.imagenes.toList()[i]);
                idsDBRImagenes
                    .add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
              } else {
                idsDBRImagenes
                    .add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
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
            "jornada": true,
            });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la jornada
              final recordJornada =
                  await client.records.create('jornadas', body: {
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Jornada 2, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Jornada 2, no se pudo recuperar id desde Servidor Local para la tarea asociada a la jornada creada.");
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo creamos la jornada
              final recordJornada =
                  await client.records.create('jornadas', body: {
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Jornada 2, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Jornada 2, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddJornada2(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Jornada 2 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenJornada2(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada2");
    print(imagen.idEmiWeb);
    final List<String> idsDBRImagenes = [];

    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada2 =
              await client.records.create('imagenes', body: {
            "nombre": imagen.nombre,
            "base64": imagen.base64,
            //Como reemplazar cadenas sin distincion de mayusculas y minusculas.
            // No funciona el replaceALL
            "id_emi_web": imagen.idEmiWeb,
          });

          if (recordImagenJornada2.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            imagen.idDBR = recordImagenJornada2.id;
            dataBase.imagenesBox.put(imagen);
            for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
              idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
            }
            final recordTareaJornada2 = await client.records
                .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              //No se pudo hacer la acutalización de la tarea
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imagen en Jornada 2, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
            }
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 2, no se pudo recuperar id desde Servidor Local para la imagen de la jornada creada.");
          }
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
            idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
          }
          final recordTareaJornada2 = await client.records
              .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo hacer la acutalización de la tarea
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 2, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada2(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Imagen en Jornada 2 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddJornada3(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada3");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox
            .query(Tareas_.id.equals(jornada.tarea.target!.id))
            .build()
            .findUnique();
        if (tareaToSync != null) {
          if (tareaToSync.idDBR == null) {
            final inversionJornada3 = dataBase.inversionesBox
                .get(jornada.emprendimiento.target?.idInversionJornada ?? -1);
            final newEstadoInversion = dataBase.estadoInversionBox
                .query(EstadoInversion_.estado.equals("Solicitada"))
                .build()
                .findFirst();
            if (inversionJornada3 != null && newEstadoInversion != null) {
              // Creamos y enviamos las imágenes de la jornada
              for (var i = 0;
                  i < jornada.tarea.target!.imagenes.toList().length;
                  i++) {
                if (jornada.tarea.target!.imagenes.toList()[i].idDBR == null) {
                  final recordImagen =
                      await client.records.create('imagenes', body: {
                    "nombre": jornada.tarea.target!.imagenes.toList()[i].nombre,
                    "id_emi_web":
                        jornada.tarea.target!.imagenes.toList()[i].idEmiWeb,
                    "base64": jornada.tarea.target!.imagenes.toList()[i].base64,
                  });
                  jornada.tarea.target!.imagenes.toList()[i].idDBR =
                      recordImagen.id;
                  dataBase.imagenesBox
                      .put(jornada.tarea.target!.imagenes.toList()[i]);
                  idsDBRImagenes
                      .add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
                } else {
                  idsDBRImagenes
                      .add(jornada.tarea.target!.imagenes.toList()[i].idDBR!);
                }
              }
              if (inversionJornada3.idDBR == null) {
                // Creamos y enviamos los productos asociados a la inversión
                final recordInversion =
                    await client.records.create('inversiones', body: {
                  "id_emprendimiento_fk":
                      inversionJornada3.emprendimiento.target!.idDBR,
                  "id_estado_inversion_fk": newEstadoInversion.idDBR,
                  "porcentaje_pago": inversionJornada3.porcentajePago,
                  "monto_pagar": inversionJornada3.montoPagar,
                  "saldo": inversionJornada3.saldo,
                  "total_inversion": inversionJornada3.totalInversion,
                  "inversion_recibida": true,
                  "pago_recibido": false,
                  "producto_entregado": false,
                  "id_emi_web": "0",
                  "jornada_3": inversionJornada3.jornada3,
                });
                if (recordInversion.id.isNotEmpty) {
                  //Se recupera el idDBR de la inversion
                  inversionJornada3.idDBR = recordInversion.id;
                  dataBase.inversionesBox.put(inversionJornada3);
                  // Creamos y enviamos las imágenes de los prod Solicitados
                  for (var i = 0;
                      i < inversionJornada3.prodSolicitados.toList().length;
                      i++) {
                    if (inversionJornada3.prodSolicitados.toList()[i].idDBR ==
                        null) {
                      if (inversionJornada3.prodSolicitados
                              .toList()[i]
                              .imagen
                              .target !=
                          null) {
                        // El prod Solicitado está asociado a una imagen
                        final recordProdSolicitado = await client.records
                            .create('productos_proyecto', body: {
                          "producto": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .producto,
                          "marca_sugerida": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .marcaSugerida,
                          "descripcion": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .descripcion,
                          "proveedo_sugerido": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .proveedorSugerido,
                          "cantidad": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .cantidad,
                          "costo_estimado": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .costoEstimado,
                          "id_familia_prod_fk": inversionJornada3
                              .prodSolicitados
                              .toList()[i]
                              .familiaProducto
                              .target!
                              .idDBR,
                          "id_tipo_empaque_fk": inversionJornada3
                              .prodSolicitados
                              .toList()[i]
                              .tipoEmpaques
                              .target!
                              .idDBR,
                          "id_inversion_fk": inversionJornada3.idDBR,
                          "id_emi_web": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .idEmiWeb,
                          // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                        });
                        if (recordProdSolicitado.id.isNotEmpty) {
                          //Se recupera el idDBR del prod Solicitado
                          inversionJornada3.prodSolicitados.toList()[i].idDBR =
                              recordProdSolicitado.id;
                          dataBase.productosSolicitadosBox.put(
                              inversionJornada3.prodSolicitados.toList()[i]);
                        } else {
                          //No se pudo postear el producto Solicitado a Pocketbase
                          return SyncInstruction(
                              exitoso: false,
                              descripcion:
                                  "Falló al agregar Jornada 3, no se pudo recuperar id del producto solicitado '${inversionJornada3.prodSolicitados.toList()[i].producto}' en la inversión de la jornada creada");
                        }
                      } else {
                        // El prod Solicitado no está asociado a una imagen
                        final recordProdSolicitado = await client.records
                            .create('productos_proyecto', body: {
                          "producto": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .producto,
                          "marca_sugerida": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .marcaSugerida,
                          "descripcion": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .descripcion,
                          "proveedo_sugerido": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .proveedorSugerido,
                          "cantidad": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .cantidad,
                          "costo_estimado": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .costoEstimado,
                          "id_familia_prod_fk": inversionJornada3
                              .prodSolicitados
                              .toList()[i]
                              .familiaProducto
                              .target!
                              .idDBR,
                          "id_tipo_empaque_fk": inversionJornada3
                              .prodSolicitados
                              .toList()[i]
                              .tipoEmpaques
                              .target!
                              .idDBR,
                          "id_inversion_fk": inversionJornada3.idDBR,
                          "id_emi_web": inversionJornada3.prodSolicitados
                              .toList()[i]
                              .idEmiWeb,
                          // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                        });
                        if (recordProdSolicitado.id.isNotEmpty) {
                          //Se recupera el idDBR del prod Solicitado
                          inversionJornada3.prodSolicitados.toList()[i].idDBR =
                              recordProdSolicitado.id;
                          dataBase.productosSolicitadosBox.put(
                              inversionJornada3.prodSolicitados.toList()[i]);
                        } else {
                          //No se pudo postear el producto Solicitado a Pocketbase
                          return SyncInstruction(
                              exitoso: false,
                              descripcion:
                                  "Falló al agregar Jornada 3, no se pudo recuperar id del producto solicitado '${inversionJornada3.prodSolicitados.toList()[i].producto}' en la inversión de la jornada creada");
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
                  "jornada": true,
                  });
                  if (recordTarea.id.isNotEmpty) {
                    //Se recupera el idDBR de la tarea
                    tareaToSync.idDBR = recordTarea.id;
                    dataBase.tareasBox.put(tareaToSync);
                    //Segundo actualizamos el catalogoProyecto del emprendimiento
                    final emprendimiento = dataBase.emprendimientosBox
                        .query(Emprendimientos_.id
                            .equals(jornada.emprendimiento.target!.id))
                        .build()
                        .findUnique();
                    if (emprendimiento != null) {
                      final recordCatalogoProyecto = await client.records
                          .update('emprendimientos',
                              emprendimiento.idDBR.toString(),
                              body: {
                            "id_nombre_proyecto_fk":
                                emprendimiento.catalogoProyecto.target!.idDBR,
                          });
                      if (recordCatalogoProyecto.id.isNotEmpty) {
                        //Tercero creamos la jornada
                        final recordJornada =
                            await client.records.create('jornadas', body: {
                          "num_jornada": jornada.numJornada,
                          "id_tarea_fk": tareaToSync.idDBR,
                          "proxima_visita":
                              jornada.fechaRevision.toUtc().toString(),
                          "id_emprendimiento_fk":
                              jornada.emprendimiento.target!.idDBR,
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
                          if (bitacora.executeEmiWeb &&
                              bitacora.executePocketbase) {
                            //Se elimina la instrucción de la bitacora
                            dataBase.bitacoraBox.remove(bitacora.id);
                          }
                          return SyncInstruction(
                              exitoso: true, descripcion: "");
                        } else {
                          // No se pudo postear la jornada
                          return SyncInstruction(
                              exitoso: false,
                              descripcion:
                                  "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la jornada creada.");
                        }
                      } else {
                        //No se pudo actualizar el catálogo proyecto del emprendimiento
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Jornada 3, no se pudo validar cambio desde Servidor Local para la actualización de Tipo de Proyecto en el emprendimiento.");
                      }
                    } else {
                      //No se pudo recuperar el emprendimiento
                      return SyncInstruction(
                          exitoso: false,
                          descripcion:
                              "Falló al agregar Jornada 3, emprendimiento asociado no encontrado en el dispositivo para asignarle el nuevo Tipo de Proyecto en el Servidor Local.");
                    }
                  } else {
                    // No se pudo postear la tarea
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la tarea asociada a la jornada creada.");
                  }
                } else {
                  //No se pudo postear la inversión en Pocketbase
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la inversión asociada a la jornada creada.");
                }
              } else {
                // Creamos y enviamos las imágenes de los prod Solicitados
                for (var i = 0;
                    i < inversionJornada3.prodSolicitados.toList().length;
                    i++) {
                  if (inversionJornada3.prodSolicitados.toList()[i].idDBR ==
                      null) {
                    if (inversionJornada3.prodSolicitados
                            .toList()[i]
                            .imagen
                            .target !=
                        null) {
                      // El prod Solicitado está asociado a una imagen
                      final recordProdSolicitado = await client.records
                          .create('productos_proyecto', body: {
                        "producto": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .producto,
                        "marca_sugerida": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .marcaSugerida,
                        "descripcion": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .descripcion,
                        "proveedo_sugerido": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .proveedorSugerido,
                        "cantidad": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .cantidad,
                        "costo_estimado": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .costoEstimado,
                        "id_familia_prod_fk": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .familiaProducto
                            .target!
                            .idDBR,
                        "id_tipo_empaque_fk": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .tipoEmpaques
                            .target!
                            .idDBR,
                        "id_inversion_fk": inversionJornada3.idDBR,
                        "id_emi_web": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .idEmiWeb,
                        // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        inversionJornada3.prodSolicitados.toList()[i].idDBR =
                            recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox
                            .put(inversionJornada3.prodSolicitados.toList()[i]);
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Jornada 3, no se pudo recuperar id del producto solicitado '${inversionJornada3.prodSolicitados.toList()[i].producto}' en la inversión de la jornada creada");
                      }
                    } else {
                      // El prod Solicitado no está asociado a una imagen
                      final recordProdSolicitado = await client.records
                          .create('productos_proyecto', body: {
                        "producto": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .producto,
                        "marca_sugerida": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .marcaSugerida,
                        "descripcion": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .descripcion,
                        "proveedo_sugerido": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .proveedorSugerido,
                        "cantidad": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .cantidad,
                        "costo_estimado": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .costoEstimado,
                        "id_familia_prod_fk": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .familiaProducto
                            .target!
                            .idDBR,
                        "id_tipo_empaque_fk": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .tipoEmpaques
                            .target!
                            .idDBR,
                        "id_inversion_fk": inversionJornada3.idDBR,
                        "id_emi_web": inversionJornada3.prodSolicitados
                            .toList()[i]
                            .idEmiWeb,
                        // "id_imagen_fk": inversionJornada3.prodSolicitados.toList()[i].imagen.target!.idDBR,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        inversionJornada3.prodSolicitados.toList()[i].idDBR =
                            recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox
                            .put(inversionJornada3.prodSolicitados.toList()[i]);
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Jornada 3, no se pudo recuperar id del producto solicitado '${inversionJornada3.prodSolicitados.toList()[i].producto}' en la inversión de la jornada creada");
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
                "jornada": true,
                });
                if (recordTarea.id.isNotEmpty) {
                  //Se recupera el idDBR de la tarea
                  tareaToSync.idDBR = recordTarea.id;
                  dataBase.tareasBox.put(tareaToSync);
                  //Segundo actualizamos el catalogoProyecto del emprendimiento
                  final emprendimiento = dataBase.emprendimientosBox
                      .query(Emprendimientos_.id
                          .equals(jornada.emprendimiento.target!.id))
                      .build()
                      .findUnique();
                  if (emprendimiento != null) {
                    final recordCatalogoProyecto = await client.records.update(
                        'emprendimientos', emprendimiento.idDBR.toString(),
                        body: {
                          "id_nombre_proyecto_fk":
                              emprendimiento.catalogoProyecto.target!.idDBR,
                        });
                    if (recordCatalogoProyecto.id.isNotEmpty) {
                      //Tercero creamos la jornada
                      final recordJornada =
                          await client.records.create('jornadas', body: {
                        "num_jornada": jornada.numJornada,
                        "id_tarea_fk": tareaToSync.idDBR,
                        "proxima_visita":
                            jornada.fechaRevision.toUtc().toString(),
                        "id_emprendimiento_fk":
                            jornada.emprendimiento.target!.idDBR,
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
                        if (bitacora.executeEmiWeb &&
                            bitacora.executePocketbase) {
                          //Se elimina la instrucción de la bitacora
                          dataBase.bitacoraBox.remove(bitacora.id);
                        }
                        return SyncInstruction(exitoso: true, descripcion: "");
                      } else {
                        // No se pudo postear la jornada
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la jornada creada.");
                      }
                    } else {
                      //No se pudo actualizar el catálogo proyecto del emprendimiento
                      return SyncInstruction(
                          exitoso: false,
                          descripcion:
                              "Falló al agregar Jornada 3, no se pudo validar cambio desde Servidor Local para la actualización de Tipo de Proyecto en el emprendimiento.");
                    }
                  } else {
                    //No se pudo recuperar el emprendimiento
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al agregar Jornada 3, emprendimiento asociado no encontrado en el dispositivo para asignarle el nuevo Tipo de Proyecto en el Servidor Local.");
                  }
                } else {
                  // No se pudo postear la tarea
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la tarea asociada a la jornada creada.");
                }
              }
            } else {
              // No se pudo recuperar la inversión asociada a la jornada 3
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Jornada 3, inversión asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
            }
          } else {
            if (jornada.idDBR == null) {
              //Segundo actualizamos el catalogoProyecto del emprendimiento
              final emprendimiento = dataBase.emprendimientosBox
                  .query(Emprendimientos_.id
                      .equals(jornada.emprendimiento.target!.id))
                  .build()
                  .findUnique();
              if (emprendimiento != null) {
                final recordCatalogoProyecto = await client.records.update(
                    'emprendimientos', emprendimiento.idDBR.toString(),
                    body: {
                      "id_nombre_proyecto_fk":
                          emprendimiento.catalogoProyecto.target!.idDBR,
                    });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  //Tercero creamos la jornada
                  final recordJornada =
                      await client.records.create('jornadas', body: {
                    "num_jornada": jornada.numJornada,
                    "id_tarea_fk": tareaToSync.idDBR,
                    "proxima_visita": jornada.fechaRevision.toUtc().toString(),
                    "id_emprendimiento_fk":
                        jornada.emprendimiento.target!.idDBR,
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
                    return SyncInstruction(exitoso: true, descripcion: "");
                  } else {
                    // No se pudo postear la jornada
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al agregar Jornada 3, no se pudo recuperar id desde Servidor Local para la jornada creada.");
                  }
                } else {
                  //No se pudo actualizar el catálogo proyecto del emprendimiento
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar Jornada 3, no se pudo validar cambio desde Servidor Local para la actualización de Tipo de Proyecto en el emprendimiento.");
                }
              } else {
                //No se pudo recuperar el emprendimiento
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Jornada 3, emprendimiento asociado no encontrado en el dispositivo para asignarle el nuevo Tipo de Proyecto en el Servidor Local.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          // No hay ninguna tarea asociada a la jornada
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Jornada 3, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddJornada3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenJornada3(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada3");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada3 =
              await client.records.create('imagenes', body: {
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
            final recordTareaJornada3 = await client.records
                .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              //No se pudo hacer la acutalización de la tarea
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imagen en Jornada 3, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
            }
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 3, no se pudo recuperar id desde Servidor Local para la imagen de la jornada creada.");
          }
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
            idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
          }
          final recordTareaJornada3 = await client.records
              .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo hacer la acutalización de la tarea
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 3, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Imagen en Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddProductoInversionJ3(
      ProdSolicitado prodSolicitado, Bitacora bitacora) async {
    print("Estoy en syncAddProductoInversionJ3");
    try {
      if (!bitacora.executePocketbase) {
        if (prodSolicitado.idDBR == null) {
          //No se ha posteado la prodSolicitado en Emi Web
          final recordProdSolicitado =
              await client.records.create('productos_proyecto', body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo postear el producto Solicitado a Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Producto Solicitado '${prodSolicitado.producto}' en Jornada 3, no se pudo recuperar id del producto solicitado '${prodSolicitado.producto}' en la inversión de la jornada 3.");
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddProductoInversionJ3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Producto Solicitado '${prodSolicitado.producto}' en Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateProductoInversionJ3(
      ProdSolicitado prodSolicitado, Bitacora bitacora) async {
    print("Estoy en syncUpdateProductoInversionJ3");
    try {
      if (!bitacora.executePocketbase) {
        final recordProdSolicitado = await client.records.update(
            'productos_proyecto', prodSolicitado.idDBR.toString(),
            body: {
              "producto": prodSolicitado.producto,
              "marca_sugerida": prodSolicitado.marcaSugerida,
              "descripcion": prodSolicitado.descripcion,
              "proveedo_sugerido": prodSolicitado.proveedorSugerido,
              "cantidad": prodSolicitado.cantidad,
              "costo_estimado": prodSolicitado.costoEstimado,
              "id_familia_prod_fk":
                  prodSolicitado.familiaProducto.target!.idDBR,
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          //No se pudo actualizar el producto Solicitado a Pocketbase
          return SyncInstruction(exitoso: false, descripcion: "Falló al actualizar Producto Solicitado '${prodSolicitado.producto}' en Jornada 3, no se pudo actualizar información del producto solicitado '${prodSolicitado.producto}' en la inversión de la jornada 3.");
        }   
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        } 
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoInversionJ3(): $e');
      return SyncInstruction(exitoso: false, descripcion: "Falló en proceso de sincronizar actualización de Producto Solicitado '${prodSolicitado.producto}' en Jornada 3 en el Servidor Local, detalles: $e");
    }
}

  Future<SyncInstruction> syncAddJornada4(Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en syncAddJornada4");
    final List<String> idsDBRImagenes = [];
    final listJornadas = jornada.emprendimiento.target!.jornadas.toList();
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        if (tareaToSync != null) {  
          if (tareaToSync.idDBR == null) {
            //Antes finalizamos las jornadas previas 
            for (var i = 0; i < listJornadas.length; i++) {
              if (listJornadas[i].numJornada != "4") {
                final recordJornada = await client.records.update('jornadas', listJornadas[i].idDBR.toString(), body: {
                    "completada": true,
                    "id_status_sync_fk": "gdjz1oQlrSvQ8PB",
                  }); 
                if (recordJornada.id.isNotEmpty) {
                  continue;
                }
                else{
                  //No se pudo actualizar jornada en Pocketbase
                  return SyncInstruction(exitoso: false, descripcion: "Falló al agregar Jornada 4, no se pudo recuperar id desde Servidor Local para finalizar la jornada '${listJornadas[i].numJornada}'");
                } 
              }
            }
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
            "jornada": true,
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(exitoso: false, descripcion: "Falló al agregar Jornada 4, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              return SyncInstruction(exitoso: false, descripcion: "Falló al agregar Jornada 4, no se pudo recuperar id desde Servidor Local para la tarea asociada a la jornada creada.");
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(exitoso: false, descripcion: "Falló al agregar Jornada 4, no se pudo recuperar id desde Servidor Local para la jornada creada.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              } 
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
          } else {
          return SyncInstruction(exitoso: false, descripcion: "Falló al agregar Jornada 4, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddJornada4(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Jornada 4 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenJornada4(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenJornada4");
    final List<String> idsDBRImagenes = [];
    try {
      if (!bitacora.executePocketbase) {
        if (imagen.idDBR == null) {
          //No se ha posteado la imagen en Emi Web
          final recordImagenJornada4 =
              await client.records.create('imagenes', body: {
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
            final recordTareaJornada4 = await client.records
                .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              //No se pudo hacer la acutalización de la tarea
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imagen en Jornada 4, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
            }
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 4, no se pudo recuperar id desde Servidor Local para la imagen de la jornada creada.");
          }
        } else {
          //Ya se posteo la imagen en Emi Web
          for (var i = 0; i < imagen.tarea.target!.imagenes.length; i++) {
            idsDBRImagenes.add(imagen.tarea.target!.imagenes[i].idDBR!);
          }
          final recordTareaJornada4 = await client.records
              .update('tareas', imagen.tarea.target!.idDBR!, body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo hacer la acutalización de la tarea
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen en Jornada 4, no se pudo recuperar id desde Servidor Local para la tarea asociada a la imagen de la jornada creada.");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenJornada4(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Imagen en Jornada 4 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddConsultoria(
      Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en syncAddConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final tareaToSync = dataBase.tareasBox
            .query(Tareas_.id.equals(consultoria.tareas.first.id))
            .build()
            .findUnique();
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
            "jornada": false,
          });
            if (recordTarea.id.isNotEmpty) {
              //Se recupera el idDBR de la tarea
              tareaToSync.idDBR = recordTarea.id;
              dataBase.tareasBox.put(tareaToSync);
              //Segundo creamos la consultoria
              final recordConsultoria =
                  await client.records.create('consultorias', body: {
                "id_emprendimiento_fk":
                    consultoria.emprendimiento.target!.idDBR,
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                // No se postea con éxito la consultoría
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Consultoría con última tarea '${consultoria.tareas.last.tarea}', no se pudo recuperar id desde Servidor Local para la consultoría creada.");
              }
            } else {
              // No se postea con éxito la tarea
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Consultoría, no se pudo recuperar id desde Servidor Local para la tarea '${tareaToSync.tarea}' asociada a la consultoría creada.");
            }
          } else {
            if (consultoria.idDBR == null) {
              //Segundo creamos la consultoria
              final recordConsultoria =
                  await client.records.create('consultorias', body: {
                "id_emprendimiento_fk":
                    consultoria.emprendimiento.target!.idDBR,
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                // No se postea con éxito la consultoría
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Consultoría con última tarea '${consultoria.tareas.last.tarea}', no se pudo recuperar id desde Servidor Local para la consultoría creada.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          // No se encontró una tarea asociada a la consultoría
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Consultoría, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddConsultoria(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Consultoría con última tarea '${consultoria.tareas.last.tarea}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddProductoEmprendedor(
      ProductosEmp productoEmp, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoEmp");
    try {
      if (!bitacora.executePocketbase) {
        final imagenToSync = dataBase.imagenesBox
            .query(Imagenes_.id.equals(productoEmp.imagen.target?.id ?? -1))
            .build()
            .findUnique();
        if (imagenToSync != null) {
          print("SÍ HAY IMAGEN ASOCIADA");
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
              final recordProductoEmp =
                  await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk":
                    productoEmp.emprendimientos.target!.idDBR,
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                // No se pudo postear el producto Emp
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Producto del Emprendedor '${productoEmp.nombre}', no se pudo recuperar id desde Servidor Local para el producto del emprendedor creado.");
              }
            } else {
              // No se pudo postear la imagen asociada al producto Emp
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Producto del Emprendedor '${productoEmp.nombre}', no se pudo recuperar id desde Servidor Local para la imagen del producto del emprendedor creado.");
            }
          } else {
            if (productoEmp.idDBR == null) {
              //Segundo creamos el producto Emp
              final recordProductoEmp =
                  await client.records.create('productos_emp', body: {
                "nombre_prod_emp": productoEmp.nombre,
                "descripcion": productoEmp.descripcion,
                "id_und_medida_fk": productoEmp.unidadMedida.target!.idDBR,
                "costo_prod_emp": productoEmp.costo,
                "id_emprendimiento_fk":
                    productoEmp.emprendimientos.target!.idDBR,
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                // No se pudo postear el producto Emp
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Producto del Emprendedor '${productoEmp.nombre}', no se pudo recuperar id desde Servidor Local para el producto del emprendedor creado.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          print("NO HAY IMAGEN ASOCIADA");
          // No hay imagen asociada al producto Emp
          if (productoEmp.idDBR == null) {
            print("Info productos");
            print(productoEmp.nombre);
            print(productoEmp.descripcion);
            print(productoEmp.unidadMedida.target!.idDBR);
            print(productoEmp.costo);
            print(productoEmp.emprendimientos.target!.idDBR);
            print(productoEmp.archivado);
            print(productoEmp.idEmiWeb);
            //Primero creamos el producto Emp
            final recordProductoEmp =
                await client.records.create('productos_emp', body: {
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
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              // No se pudo postear el producto Emp
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Producto del Emprendedor '${productoEmp.nombre}', no se pudo recuperar id desde Servidor Local para el producto del emprendedor creado.");
            }
          } else {
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return SyncInstruction(exitoso: true, descripcion: "");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print("Orale es CATCH");
      print('ERROR - function syncAddProductoEmp(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Producto del Emprendedor '${productoEmp.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenProductoEmprendedor(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenProductoEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final recordImagenProductoEmprendedor =
            await client.records.create('imagenes', body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al agregar Imagen del Producto del Emprendedor '${imagen.productosEmp.target?.nombre}', no se pudo recuperar id desde Servidor Local para la imagen del producto del emprendedor creado.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenProductoEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta Imagen del Producto del Emprendedor '${imagen.productosEmp.target?.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddVenta(Ventas venta, Bitacora bitacora) async {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            // Falló al postear la venta en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Venta con ID Local '${venta.id}', no se pudo recuperar id desde Servidor Local para el producto del emprendedor creado.");
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddVenta(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta Venta con ID Local '${venta.id}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddProductoVendido(
      ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en El syncAddProductoVendido");
    try {
      if (!bitacora.executePocketbase) {
        if (productoVendido.idDBR == null) {
          //Primero creamos el producto Vendido
          final recordProdVendido =
              await client.records.create('prod_vendidos', body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            // Falló al postear el producto Vendido en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Producto Vendido '${productoVendido.nombreProd}', no se pudo recuperar id desde Servidor Local para el producto vendido creado.");
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddProductoVendido(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta Producto Vendido '${productoVendido.nombreProd}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddSingleProductoVendido(
      ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en El syncAddSingleProductoVendido");
    try {
      if (!bitacora.executePocketbase) {
        if (productoVendido.idDBR == null) {
          //Primero creamos el producto Vendido
          final recordProdVendido =
              await client.records.create('prod_vendidos', body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            // Falló al postear el producto Vendido en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Producto Vendido '${productoVendido.nombreProd}', no se pudo recuperar id desde Servidor Local para el producto vendido creado.");
          }
        } else {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddSingleProductoVendido(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta Producto Vendido '${productoVendido.nombreProd}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddInversion(
      Inversiones inversion, Bitacora bitacora) async {
    try {
      print("Estoy en syncAddInversion");
      if (!bitacora.executePocketbase) {
        if (inversion.idDBR == null) {
          //Primero creamos la inversion
          //Se busca el estado de inversión 'Solicitada'
          final newEstadoInversion = dataBase.estadoInversionBox
              .query(EstadoInversion_.estado.equals("Solicitada"))
              .build()
              .findFirst();
          if (newEstadoInversion != null) {
            final recordInversion =
                await client.records.create('inversiones', body: {
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
              "jornada_3": inversion.jornada3,
            });
            if (recordInversion.id.isNotEmpty) {
              //Se recupera el idDBR de la inversion
              inversion.idDBR = recordInversion.id;
              dataBase.inversionesBox.put(inversion);
              //Segundo creamos los productos solicitados asociados a la inversion
              final prodSolicitadosToSync = inversion.prodSolicitados.toList();
              if (prodSolicitadosToSync.isNotEmpty) {
                for (var i = 0; i < prodSolicitadosToSync.length; i++) {
                  // Se verifica que no se haya posteado el prod Solicitado anteriormente
                  if (prodSolicitadosToSync[i].idDBR == null) {
                    // Creamos y enviamos las imágenes de los prod Solicitados
                    if (prodSolicitadosToSync[i].imagen.target != null) {
                      // El prod Solicitado está asociado a una imagen
                      final recordImagen =
                          await client.records.create('imagenes', body: {
                        "nombre":
                            prodSolicitadosToSync[i].imagen.target!.nombre,
                        "id_emi_web":
                            prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                        "base64":
                            prodSolicitadosToSync[i].imagen.target!.base64,
                      });
                      if (recordImagen.id.isNotEmpty) {
                        prodSolicitadosToSync[i].imagen.target!.idDBR =
                            recordImagen.id;
                        dataBase.imagenesBox
                            .put(prodSolicitadosToSync[i].imagen.target!);
                        final recordProdSolicitado = await client.records
                            .create('productos_solicitados', body: {
                          "producto": prodSolicitadosToSync[i].producto,
                          "marca_sugerida":
                              prodSolicitadosToSync[i].marcaSugerida,
                          "descripcion": prodSolicitadosToSync[i].descripcion,
                          "proveedo_sugerido":
                              prodSolicitadosToSync[i].proveedorSugerido,
                          "cantidad": prodSolicitadosToSync[i].cantidad,
                          "costo_estimado":
                              prodSolicitadosToSync[i].costoEstimado,
                          "id_familia_prod_fk": prodSolicitadosToSync[i]
                              .familiaProducto
                              .target!
                              .idDBR,
                          "id_tipo_empaques_fk": prodSolicitadosToSync[i]
                              .tipoEmpaques
                              .target!
                              .idDBR,
                          "id_inversion_fk": inversion.idDBR,
                          "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                          "id_imagen_fk":
                              prodSolicitadosToSync[i].imagen.target!.idDBR,
                        });
                        print("No postea productos");
                        if (recordProdSolicitado.id.isNotEmpty) {
                          //Se recupera el idDBR del prod Solicitado
                          prodSolicitadosToSync[i].idDBR =
                              recordProdSolicitado.id;
                          dataBase.productosSolicitadosBox
                              .put(prodSolicitadosToSync[i]);
                        } else {
                          //No se pudo postear el producto Solicitado a Pocketbase
                          return SyncInstruction(
                              exitoso: false,
                              descripcion:
                                  "Falló al agregar Producto Solicitado '${prodSolicitadosToSync[i].producto}' en Inversión con ID Local ${inversion.id}, no se pudo recuperar id desde Servidor Local para el producto solicitado creado.");
                        }
                      } else {
                        // No se pudo postear la imagen del prod Solicitado a Pocketbase
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Imagen del Producto Solicitado '${prodSolicitadosToSync[i].producto}' en Inversión con ID Local ${inversion.id}, no se pudo recuperar id desde Servidor Local para la imagen del producto solicitado creado.");
                      }
                    } else {
                      // El prod Solicitado no está asociado a una imagen
                      final recordProdSolicitado = await client.records
                          .create('productos_solicitados', body: {
                        "producto": prodSolicitadosToSync[i].producto,
                        "marca_sugerida":
                            prodSolicitadosToSync[i].marcaSugerida,
                        "descripcion": prodSolicitadosToSync[i].descripcion,
                        "proveedo_sugerido":
                            prodSolicitadosToSync[i].proveedorSugerido,
                        "cantidad": prodSolicitadosToSync[i].cantidad,
                        "costo_estimado":
                            prodSolicitadosToSync[i].costoEstimado,
                        "id_familia_prod_fk": prodSolicitadosToSync[i]
                            .familiaProducto
                            .target!
                            .idDBR,
                        "id_tipo_empaques_fk":
                            prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                        "id_inversion_fk": inversion.idDBR,
                        "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                      });
                      if (recordProdSolicitado.id.isNotEmpty) {
                        //Se recupera el idDBR del prod Solicitado
                        prodSolicitadosToSync[i].idDBR =
                            recordProdSolicitado.id;
                        dataBase.productosSolicitadosBox
                            .put(prodSolicitadosToSync[i]);
                      } else {
                        //No se pudo postear el producto Solicitado a Pocketbase
                        return SyncInstruction(
                            exitoso: false,
                            descripcion:
                                "Falló al agregar Producto Solicitado '${prodSolicitadosToSync[i].producto}' en Inversión con Id Local ${inversion.id}, no se pudo recuperar id del producto solicitado '${prodSolicitadosToSync[i].producto}' en la inversión creada.");
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
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                //No se encontraron productos Solicitados asociados a la inversión
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Inversión con Id Local '${inversion.id}', no se encontraron los productos solicitados asociados en el dispositivo.");
              }
            } else {
              //No se pudo postear la inversión en Pocketbase
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Inversión con Id Local '${inversion.id}', no se pudo recuperar id desde Servidor Local para la inversión creada.");
            }
          } else {
            //No se pudo encontrar el estado de la inversión
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Inversión con Id Local '${inversion.id}', no se pudo encontrar el registro para estado de Inversión 'Solicitada' en el dispositivo.");
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
                  final recordImagen =
                      await client.records.create('imagenes', body: {
                    "nombre": prodSolicitadosToSync[i].imagen.target!.nombre,
                    "id_emi_web":
                        prodSolicitadosToSync[i].imagen.target!.idEmiWeb,
                    "base64": prodSolicitadosToSync[i].imagen.target!.base64,
                  });
                  if (recordImagen.id.isNotEmpty) {
                    prodSolicitadosToSync[i].imagen.target!.idDBR =
                        recordImagen.id;
                    dataBase.imagenesBox
                        .put(prodSolicitadosToSync[i].imagen.target!);
                    final recordProdSolicitado = await client.records
                        .create('productos_solicitados', body: {
                      "producto": prodSolicitadosToSync[i].producto,
                      "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                      "descripcion": prodSolicitadosToSync[i].descripcion,
                      "proveedo_sugerido":
                          prodSolicitadosToSync[i].proveedorSugerido,
                      "cantidad": prodSolicitadosToSync[i].cantidad,
                      "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                      "id_familia_prod_fk": prodSolicitadosToSync[i]
                          .familiaProducto
                          .target!
                          .idDBR,
                      "id_tipo_empaques_fk":
                          prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                      "id_inversion_fk": inversion.idDBR,
                      "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                      "id_imagen_fk":
                          prodSolicitadosToSync[i].imagen.target!.idDBR,
                    });
                    if (recordProdSolicitado.id.isNotEmpty) {
                      //Se recupera el idDBR del prod Solicitado
                      prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                      dataBase.productosSolicitadosBox
                          .put(prodSolicitadosToSync[i]);
                    } else {
                      //No se pudo postear el producto Solicitado a Pocketbase
                      return SyncInstruction(
                          exitoso: false,
                          descripcion:
                              "Falló al agregar Producto Solicitado '${prodSolicitadosToSync[i].producto}' en Inversión con Id Local ${inversion.id}, no se pudo recuperar id del producto solicitado '${prodSolicitadosToSync[i].producto}' en la inversión creada.");
                    }
                  } else {
                    // No se pudo postear la imagen del prod Solicitado a Pocketbase
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al agregar Imagen del Producto Solicitado '${prodSolicitadosToSync[i].producto}' en Inversión con ID Local ${inversion.id}, no se pudo recuperar id desde Servidor Local para la imagen del producto solicitado creado.");
                  }
                } else {
                  // El prod Solicitado no está asociado a una imagen
                  final recordProdSolicitado = await client.records
                      .create('productos_solicitados', body: {
                    "producto": prodSolicitadosToSync[i].producto,
                    "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                    "descripcion": prodSolicitadosToSync[i].descripcion,
                    "proveedo_sugerido":
                        prodSolicitadosToSync[i].proveedorSugerido,
                    "cantidad": prodSolicitadosToSync[i].cantidad,
                    "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                    "id_familia_prod_fk":
                        prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                    "id_tipo_empaques_fk":
                        prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                    "id_inversion_fk": inversion.idDBR,
                    "id_emi_web": prodSolicitadosToSync[i].idEmiWeb,
                  });
                  if (recordProdSolicitado.id.isNotEmpty) {
                    //Se recupera el idDBR del prod Solicitado
                    prodSolicitadosToSync[i].idDBR = recordProdSolicitado.id;
                    dataBase.productosSolicitadosBox
                        .put(prodSolicitadosToSync[i]);
                  } else {
                    //No se pudo postear el producto Solicitado a Pocketbase
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al agregar Producto Solicitado '${prodSolicitadosToSync[i].producto}' en en Inversión con Id Local ${inversion.id}, no se pudo recuperar id del producto solicitado '${prodSolicitadosToSync[i].producto}' en la inversión creada.");
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se encontraron productos Solicitados asociados a la inversión
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Inversión con Id Local '${inversion.id}' productos solicitados asociados no encontrados en el dispositivo.");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddInversion(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta Inversión con Id Local '${inversion.id}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenUsuario(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en syncAddImagenUsuario");
    try {
      if (bitacora.executeEmiWeb) {
        if (!bitacora.executePocketbase) {
          final recordImagenUsuario =
              await client.records.create('imagenes', body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imagen de Perfil del Usuario, no se pudo recuperar id desde Servidor Local para la imagen creada.");
          }
        } else {
          if (bitacora.executeEmiWeb) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        // No se ha agregado imagen del usuario en Emi Web
        return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló al agregar Imagen de Perfil del Usuario, no se ha recuperado el id de la imagen de Perfil del Usuario desde Emi Web para poder agregarla en Servidor Local.");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenUsuario(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en el proceso de sincronizar alta de Imagen de Perfil del Usuario en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateImagenUsuario(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenUsuario en Pocketbase");
    try {
      if (bitacora.executeEmiWeb) {
        if (!bitacora.executePocketbase) {
          final record = await client.records
              .update('imagenes', imagen.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Imagen de Perfil del Usuario, no se pudo recuperar id desde Servidor Local para la imagen actualizada.");
          }
        } else {
          if (bitacora.executeEmiWeb) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        // No se ha actualizado imagen del usuario en Emi Web
        return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló al actualizar Imagen de Perfil del Usuario, no se ha actualizado imagen del Usuario en Emi Web para poder actualizar en Servidor Local.");
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenUsuario(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Imagen de Perfil del Usuario en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateFaseEmprendimiento(
      Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final faseActual = dataBase.fasesEmpBox
            .query(FasesEmp_.fase.equals(bitacora.instruccionAdicional!))
            .build()
            .findUnique();
        if (faseActual != null) {
          print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");
          print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

          final record = await client.records.update(
              'emprendimientos', emprendimiento.idDBR.toString(),
              body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Fase del Emprendimiento, no se pudo actualizar a la Fase '${faseActual.fase}' en Servidor Local.");
          }
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Fase del Emprendimiento, no se pudo encontrar el registro de la Fase '${bitacora.instruccionAdicional}' en el dispositivo.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Fase '${bitacora.instruccionAdicional}' del Emprendimiento en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateEstadoInversion(
      Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEstadoInversion en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final estadoActual = dataBase.estadoInversionBox
            .query(
                EstadoInversion_.estado.equals(bitacora.instruccionAdicional!))
            .build()
            .findUnique();
        if (estadoActual != null) {
          final record = await client.records
              .update('inversiones', inversion.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            // No se pudo hacer la actualización del estado de la inversión en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Estado de Inversión con id Emi Web ${inversion.idEmiWeb}, no se pudo actualizar a estado '${estadoActual.estado}' a Inversión en Servidor Local.");
          }
        } else {
          // No se encontro el estado actual de la inversión
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Estado de Inversión con id Emi Web ${inversion.idEmiWeb}, no se pudo encontrar el Estado Actual de la Inversión en el dispositivo.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateEstadoInversion(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización Estado de Inversión con id Emi Web ${inversion.idEmiWeb} en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateEmprendimiento(
      Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('emprendimientos', emprendimiento.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Emprendimiento, no se pudo actualizar la información del Emprendimiento ${emprendimiento.nombre} en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateEmprendedimiento(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Emprendimiento '${emprendimiento.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<bool?> syncUpdateNameEmprendimiento(
      Emprendimientos emprendimiento) async {
    print("Estoy en El syncUpdateNameEmprendimiento");
    try {
      final record = await client.records
          .update('emprendimientos', emprendimiento.idDBR.toString(), body: {
        "nombre_emprendimiento": emprendimiento.nombre,
        "id_status_sync_fk": "HoI36PzYw1wtbO1",
      });

      if (record.id.isNotEmpty) {
        var updateEmprendimiento =
            dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento != null) {}
      } else {
        return false;
      }
      return true;
    } catch (e) {
      print('ERROR - function syncUpdateNameEmprendimiento(): $e');
      return false;
    }
  }

  Future<SyncInstruction> syncUpdateEmprendedor(
      Emprendedores emprendedor, Bitacora bitacora) async {
    print("Estoy en El syncUpdateEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('emprendedores', emprendedor.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Emprendedor, no se pudo actualizar la información del Emprendedor '${emprendedor.nombre} ${emprendedor.apellidos}'en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Emprendedor en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateJornada1(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada1");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records
            .update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
          "tarea": jornada.tarea.target!.tarea,
          "fecha_revision":
              jornada.tarea.target!.fechaRevision.toUtc().toString(),
          "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records
              .update('jornadas', jornada.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo actualizar jornada en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Jornada 1, no se pudo actualizar la información de la Jornada 1 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Jornada 1, no se pudo actualizar la información de la tarea '${jornada.tarea.target!.tarea}' asociada a la Jornada 1 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de la Jornada 1 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateJornada2(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada2");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records
            .update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
          "tarea": jornada.tarea.target!.tarea,
          "comentarios": jornada.tarea.target!.comentarios,
          "fecha_revision":
              jornada.tarea.target!.fechaRevision.toUtc().toString(),
          "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records
              .update('jornadas', jornada.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo actualizar jornada en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Jornada 2, no se pudo actualizar la información de la Jornada 2 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Jornada 2, no se pudo actualizar la información de la tarea '${jornada.tarea.target!.tarea}' asociada a la Jornada 2 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada2(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de la Jornada 2 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateImagenJornada2(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada2 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('imagenes', imagen.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Imagen en Jornada 2, no se pudo actualizar la información de la Jornada 2 en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada2(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Imagen en Jornada 2 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateJornada3(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada3");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records
            .update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
          "tarea": jornada.tarea.target!.tarea,
          "comentarios": jornada.tarea.target!.comentarios,
          "descripcion": jornada.tarea.target!.descripcion,
          "fecha_revision":
              jornada.tarea.target!.fechaRevision.toUtc().toString(),
          "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records
              .update('jornadas', jornada.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo actualizar jornada en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Jornada 3, no se pudo actualizar la información de la Jornada 3 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Jornada 3, no se pudo actualizar la información de la tarea '${jornada.tarea.target!.tarea}' asociada a la Jornada 3 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de la Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateImagenJornada3(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada3 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('imagenes', imagen.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Imagen en Jornada 3, no se pudo actualizar la información de la Jornada 3 en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Imagen en Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateJornada4(
      Jornadas jornada, Bitacora bitacora) async {
    print("Estoy en El syncUpdateJornada4");
    try {
      if (!bitacora.executePocketbase) {
        //Primero actualizamos la tarea
        final recordTarea = await client.records
            .update('tareas', jornada.tarea.target!.idDBR.toString(), body: {
          "tarea": jornada.tarea.target!.tarea,
          "comentarios": jornada.tarea.target!.comentarios,
          "fecha_revision":
              jornada.tarea.target!.fechaRevision.toUtc().toString(),
          "id_status_sync_fk": "gdjz1oQlrSvQ8PB"
        });
        if (recordTarea.id.isNotEmpty) {
          //Segundo actualizamos la jornada
          final recordJornada = await client.records
              .update('jornadas', jornada.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            //No se pudo actualizar jornada en Pocketbase
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Jornada 4, no se pudo actualizar la información de la Jornada 4 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
          }
        } else {
          //No se pudo actualizar tarea en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Jornada 4, no se pudo actualizar la información de la tarea '${jornada.tarea.target!.tarea}' asociada a la Jornada 4 del Emprendimiento ${jornada.emprendimiento.target?.nombre} en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateJornada4(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de la Jornada 4 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateImagenJornada4(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenJornada4 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('imagenes', imagen.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Imagen en Jornada 4, no se pudo actualizar la información de la Jornada 4 en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenJornada4(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Imagen en Jornada 4 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateTareaConsultoria(
      Tareas tarea, Bitacora bitacora) async {
    print("Estoy en El syncUpdateTareaConsultoria");
    List<String> tareasConsultoria = [];
    try {
      if (!bitacora.executePocketbase) {
        if (tarea.imagenes.toList().isNotEmpty) {
          print("SI ES NOT EMPTY");
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
                "id_imagenes_fk": recordImagen.id,
                "id_emi_web": tarea.idEmiWeb,
                "jornada": false,
              });
              if (recordTarea.id.isNotEmpty) {
                //Tercero actualizamos los idsDBR de la consultoria
                final consultoria =
                    dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
                if (consultoria != null) {
                  for (var element in consultoria.tareas.toList()) {
                    if (element.idDBR != null) {
                      tareasConsultoria.add(element.idDBR!);
                    }
                  }
                  tareasConsultoria.add(recordTarea.id);
                  final recordConsultoria = await client.records.update(
                      'consultorias', consultoria.idDBR.toString(),
                      body: {
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
                    return SyncInstruction(exitoso: true, descripcion: "");
                  } else {
                    //No se pudo actualizar la consultoría con la nueva tarea
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al actualizar Consultoría con tarea '${tarea.tarea}, no se pudo actualizar la información de la Consultoría en Servidor Local.");
                  }
                } else {
                  //No se encontró la consultoría en ObjectBox
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar tarea '${tarea.tarea}' en Consultoría, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
                }
              } else {
                //No se pudo postear la tarea nueva
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar '${tarea.tarea}' en Consultoría, no se pudo recuperar id desde Servidor Local para la tarea asociada a la consultoría creada.");
              }
            } else {
              // No se pudo postear la imagen asociada al producto Emp
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imagen del la Consultoría con tarea '${tarea.tarea}', no se pudo recuperar id desde Servidor Local para la imagen de la tarea de la consultoría creada.");
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
                "id_imagenes_fk": tarea.imagenes.first.idDBR,
                "id_emi_web": tarea.idEmiWeb,
                "jornada": false,
              });
              if (recordTarea.id.isNotEmpty) {
                //Tercero actualizamos los idsDBR de la consultoria
                final consultoria =
                    dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
                if (consultoria != null) {
                  for (var element in consultoria.tareas.toList()) {
                    if (element.idDBR != null) {
                      tareasConsultoria.add(element.idDBR!);
                    }
                  }
                  tareasConsultoria.add(recordTarea.id);
                  final recordConsultoria = await client.records.update(
                      'consultorias', consultoria.idDBR.toString(),
                      body: {
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
                    return SyncInstruction(exitoso: true, descripcion: "");
                  } else {
                    //No se pudo actualizar la consultoría con la nueva tarea
                    return SyncInstruction(
                        exitoso: false,
                        descripcion:
                            "Falló al actualizar Consultoría con tarea '${tarea.tarea}, no se pudo actualizar la información de la Consultoría en Servidor Local.");
                  }
                } else {
                  //No se encontró la consultoría en ObjectBox
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al agregar tarea '${tarea.tarea}' en Consultoría, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
                }
              } else {
                //No se pudo postear la tarea nueva
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar '${tarea.tarea}' en Consultoría, no se pudo recuperar id desde Servidor Local para la tarea asociada a la consultoría creada.");
              }
            } else {
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            }
          }
        } else {
          print("NO ES NOT EMPTY");
          if (tarea.idDBR == null) {
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
              "jornada": false,
            });
            if (recordTarea.id.isNotEmpty) {
              //Tercero actualizamos los idsDBR de la consultoria
              final consultoria =
                  dataBase.consultoriasBox.get(tarea.consultoria.target!.id);
              if (consultoria != null) {
                for (var element in consultoria.tareas.toList()) {
                  if (element.idDBR != null) {
                    tareasConsultoria.add(element.idDBR!);
                  }
                }
                tareasConsultoria.add(recordTarea.id);
                final recordConsultoria = await client.records.update(
                    'consultorias', consultoria.idDBR.toString(),
                    body: {
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
                  return SyncInstruction(exitoso: true, descripcion: "");
                } else {
                  //No se pudo actualizar la consultoría con la nueva tarea
                  return SyncInstruction(
                      exitoso: false,
                      descripcion:
                          "Falló al actualizar Consultoría con tarea '${tarea.tarea}, no se pudo actualizar la información de la Consultoría en Servidor Local.");
                }
              } else {
                //No se encontró la consultoría en ObjectBox
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar tarea '${tarea.tarea}' en Consultoría, tarea asociada no encontrada en el dispositivo para asignarle id del Servidor Local.");
              }
            } else {
              //No se pudo postear la tarea nueva
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar '${tarea.tarea}' en Consultoría, no se pudo recuperar id desde Servidor Local para la tarea asociada a la consultoría creada.");
            }
          } else {
            if (bitacora.executeEmiWeb) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return SyncInstruction(exitoso: true, descripcion: "");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateTareaConsultoria(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de tarea '${tarea.tarea}'en Consultoría en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateUsuario(
      Usuarios usuario, Bitacora bitacora) async {
    print("Estoy en El syncUpdateUsuario");
    try {
      if (bitacora.executeEmiWeb) {
        if (!bitacora.executePocketbase) {
          final record = await client.records
              .update('emi_users', usuario.idDBR.toString(), body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al actualizar Usuario '${usuario.nombre} ${usuario.apellidoM} ${usuario.apellidoP}', no se pudo actualizar la información del Usuario en Servidor Local.");
          }
        } else {
          if (bitacora.executeEmiWeb) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        // No se ha actualizado datos del usuario en Emi Web
        return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar actualización de Usuario '${usuario.nombre} ${usuario.apellidoM} ${usuario.apellidoP}' en el Servidor Local, la información en Emi Web aún no ha sido actualizada.");
      }
    } catch (e) {
      print('ERROR - function syncUpdateUsuario(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Usuario '${usuario.nombre} ${usuario.apellidoM} ${usuario.apellidoP}' en el Servidor Local, detalles: $e");
    }
  }

  void deleteBitacora() {
    dataBase.bitacoraBox.removeAll();
    notifyListeners();
  }

  Future<SyncInstruction> syncUpdateProductoEmprendedor(
      ProductosEmp prodEmprendedor, Bitacora bitacora) async {
    print("Estoy en El syncUpdateProductoEmprendedor");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('productos_emp', prodEmprendedor.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Producto de Emprendedor '${prodEmprendedor.nombre}', no se pudo actualizar la información del Producto de Emprendedor en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Producto de Emprendedor '${prodEmprendedor.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateImagenProductoEmprendedor(
      Imagenes imagen, Bitacora bitacora) async {
    print("Estoy en El syncUpdateImagenProductoEmprendedor en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        final recordImagen = await client.records
            .update('imagenes', imagen.idDBR.toString(), body: {
          "nombre": imagen.nombre,
          "base64": imagen.base64,
        });
        if (recordImagen.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Imagen del Producto de Emprendedor '${imagen.productosEmp.target?.nombre}', no se pudo actualizar la Imagen del Producto de Emprendedor en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateImagenProductoEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Imagen del Producto de Emprendedor '${imagen.productosEmp.target?.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateVenta(
      Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncUpdateVenta");
    try {
      if (!bitacora.executePocketbase) {
        final recordVenta =
            await client.records.update('ventas', venta.idDBR!, body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          // Falló al actualizar la venta en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Información de Venta con id Local '${venta.id}', no se pudo actualizar la Venta en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateVenta(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Información de Venta con id Local '${venta.id}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateProductosVendidosVenta(
      Ventas venta, Bitacora bitacora) async {
    print("Estoy en El syncUpdateProductosVendidosVenta");
    try {
      if (!bitacora.executePocketbase) {
        final recordVenta =
            await client.records.update('ventas', venta.idDBR!, body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          // Falló al actualizar la venta en Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Total en Venta con id Local '${venta.id}', no se pudo actualizar la Venta en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductosVendidosVenta(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Total en Venta con id Local '${venta.id}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAcceptInversionesXProductosCotizados(
      InversionesXProdCotizados inversionXprodCotizados,
      Bitacora bitacora) async {
    print("Estoy en syncAcceptInversionesXProductosCotizados");
    try {
      if (!bitacora.executePocketbase) {
        final recordInversionXProdCotizados = await client.records.update(
            'inversion_x_prod_cotizados',
            inversionXprodCotizados.idDBR.toString(),
            body: {
              "aceptado": inversionXprodCotizados.aceptado,
            });
        if (recordInversionXProdCotizados.id.isNotEmpty) {
          //Se actualiza monto, saldo y total de inversión
          final recordInversion = await client.records.update('inversiones',
              inversionXprodCotizados.inversion.target!.idDBR.toString(),
              body: {
                "id_estado_inversion_fk": inversionXprodCotizados
                    .inversion.target!.estadoInversion.target!.idDBR,
                "monto_pagar":
                    inversionXprodCotizados.inversion.target!.montoPagar,
                "saldo": inversionXprodCotizados.inversion.target!.saldo,
                "total_inversion":
                    inversionXprodCotizados.inversion.target!.totalInversion,
              });
          if (recordInversion.id.isNotEmpty) {
            //Se marca como realizada en Pocketbase la instrucción en Bitacora
            bitacora.executePocketbase = true;
            dataBase.bitacoraBox.put(bitacora);
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al aceptar Cotización para la Inversión con ID Emi Web '${inversionXprodCotizados.inversion.target?.idEmiWeb}', no se pudo actualizar infomación de la Inversión en Servidor Local.");
          }
        } else {
          //No se pudo aceptar la inversion x prod cotizados a Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al aceptar Cotización para la Inversión con ID Emi Web '${inversionXprodCotizados.inversion.target?.idEmiWeb}', no se pudo aceptar la Cotización en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAcceptInversionesXProductosCotizados(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar aceptación de la Cotización para la Inversión con ID Emi Web '${inversionXprodCotizados.inversion.target?.idEmiWeb}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAcceptProdCotizado(
      ProdCotizados prodCotizado, Bitacora bitacora) async {
    print("Estoy en syncAcceptProductoCotizado");
    try {
      if (!bitacora.executePocketbase) {
        final recordProdCotizados = await client.records.update(
            'productos_cotizados', prodCotizado.idDBR.toString(),
            body: {
              "aceptado": true,
              "cantidad": prodCotizado.cantidad,
              "costo_total": prodCotizado.costoTotal,
            });
        if (recordProdCotizados.id.isNotEmpty) {
          //Se marca como realizada en Pocketbase la instrucción en Bitacora
          bitacora.executePocketbase = true;
          dataBase.bitacoraBox.put(bitacora);
          if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
          }
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          //No se pudo aceptar el prod cotizado a Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al aceptar Producto Cotizado '${prodCotizado.productosProv.target?.nombre}', no se pudo aceptar Producto Cotizado en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAcceptProductoCotizado(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar aceptación del Producto Cotizado '${prodCotizado.productosProv.target?.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddPagoInversion(
      Pagos pago, Bitacora bitacora) async {
    print("Estoy en syncAddPagoInversion");
    try {
      if (!bitacora.executePocketbase) {
        if (pago.idDBR == null) {
          //Primero creamos el pago
          final pagoTarea = await client.records.create('pagos', body: {
            "monto_abonado": pago.montoAbonado,
            "fecha_movimiento": pago.fechaMovimiento.toUtc().toString(),
            "id_inversion_fk": pago.inversion.target!.idDBR,
            "id_usuario_fk": pago
                .inversion.target!.emprendimiento.target!.usuario.target!.idDBR,
            "id_emi_web": pago.idEmiWeb,
          });
          if (pagoTarea.id.isNotEmpty) {
            //Se recupera el idDBR del pago
            pago.idDBR = pagoTarea.id;
            dataBase.pagosBox.put(pago);
            //Segundo actualizamos la inversión
            final recordInversion = await client.records.update(
                'inversiones', pago.inversion.target!.idDBR.toString(),
                body: {
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
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Pago de la Inversión con ID Emi Web '${pago.inversion.target?.idEmiWeb}', no se pudo actualizar Total de la Inversión en Servidor Local.");
            }
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Pago de la Inversión con ID Emi Web '${pago.inversion.target?.idEmiWeb}', no se pudo agregar Pago de la Inversión en Servidor Local.");
          }
        } else {
          //Segundo actualizamos la inversión
          final recordInversion = await client.records.update(
              'inversiones', pago.inversion.target!.idDBR.toString(),
              body: {
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
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Pago de la Inversión con ID Emi Web '${pago.inversion.target?.idEmiWeb}', no se pudo actualizar Total de la Inversión en Servidor Local.");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddPagoInversion(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Pago de la Inversión con ID Emi Web '${pago.inversion.target?.idEmiWeb}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncUpdateProductoVendido(
      ProdVendidos productoVendido, Bitacora bitacora) async {
    print("Estoy en syncUpdateProductoVendido");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('prod_vendidos', productoVendido.idDBR!, body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          //No se pudo actualizar el producto Solicitado a Pocketbase
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al actualizar Producto Vendido '${productoVendido.nombreProd}', no se pudo actualizar la información del Producto Vendido en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncUpdateProductoVendido(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización del Producto Vendido '${productoVendido.nombreProd}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncArchivarEmprendimiento(
      Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncArchivarEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('emprendimientos', emprendimiento.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al archivar Emprendimiento '${emprendimiento.nombre}', no se pudo archivar el Emprendimiento en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncArchivarEmprendimiento(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar archivado del Emprendimiento '${emprendimiento.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncDesarchivarEmprendimiento(
      Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncDesarchivarEmprendimiento");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('emprendimientos', emprendimiento.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al desarchivar Emprendimiento '${emprendimiento.nombre}', no se pudo desarchivar el Emprendimiento en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncDesarchivarEmprendimiento(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar desarchivado del Emprendimiento '${emprendimiento.nombre}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncArchivarConsultoria(
      Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en El syncArchivarConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('consultorias', consultoria.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al archivar Consultoría con tarea '${consultoria.tareas.last.tarea}', no se pudo archivar la Consultoría en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncArchivarConsultoria(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar archivado de la Consultoría con tarea '${consultoria.tareas.last.tarea}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncDesarchivarConsultoria(
      Consultorias consultoria, Bitacora bitacora) async {
    print("Estoy en El syncDesarchivarConsultoria");
    try {
      if (!bitacora.executePocketbase) {
        final record = await client.records
            .update('consultorias', consultoria.idDBR.toString(), body: {
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
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Falló al desarchivar Consultoría con tarea '${consultoria.tareas.last.tarea}', no se pudo desarchivar la Consultoría en Servidor Local.");
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncDesarchivarConsultoria(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar desarchivado de la Consultoría con tarea '${consultoria.tareas.last.tarea}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncDeleteImagenJornada(Bitacora bitacora) async {
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
        return SyncInstruction(exitoso: true, descripcion: "");
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncDelteImagenJornada(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar baja Imagen '${bitacora.instruccionAdicional}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncDeleteProductoInversionJ3(
      Bitacora bitacora) async {
    print(
        "Estoy en El syncDelteProdusyncDeleteProductoInversionJ3 en Pocketbase");
    try {
      if (!bitacora.executePocketbase) {
        await client.records
            .delete('productos_proyecto', bitacora.idDBR.toString());
        //Se marca como realizada en Pocketbase la instrucción en Bitacora
        bitacora.executePocketbase = true;
        dataBase.bitacoraBox.put(bitacora);
        if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncDeleteProductoInversionJ3(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar baja Producto '${bitacora.instruccionAdicional}' en Inversión Jornada 3 en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncDeleteProductoVendido(Bitacora bitacora) async {
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
        return SyncInstruction(exitoso: true, descripcion: "");
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncDeleteProductoVendido(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar baja Producto '${bitacora.instruccionAdicional}' en el Servidor Local, detalles: $e");
    }
  }

  Future<SyncInstruction> syncAddImagenesEntregaInversion(
      Inversiones inversion, Bitacora bitacora) async {
    print("Estoy en syncAddImagenesEntregaInversion");
    try {
      if (!bitacora.executePocketbase) {
        if (inversion.imagenFirmaRecibido.target!.idDBR == null) {
          //Primero creamos la imagen de firma de recibo
          final recordImagenFirmaRecibido =
              await client.records.create('imagenes', body: {
            "nombre": inversion.imagenFirmaRecibido.target!.nombre,
            "id_emi_web": inversion.imagenFirmaRecibido.target!.idEmiWeb,
            "base64": inversion.imagenFirmaRecibido.target!.base64,
          });

          if (recordImagenFirmaRecibido.id.isNotEmpty) {
            //Se recupera el idDBR de la imagen
            inversion.imagenFirmaRecibido.target!.idDBR =
                recordImagenFirmaRecibido.id;
            dataBase.imagenesBox.put(inversion.imagenFirmaRecibido.target!);
            //Segundo creamos la imagen de Producto Entregado
            final recordImagenProductoEntregado =
                await client.records.create('imagenes', body: {
              "nombre": inversion.imagenProductoEntregado.target!.nombre,
              "id_emi_web": inversion.imagenProductoEntregado.target!.idEmiWeb,
              "base64": inversion.imagenProductoEntregado.target!.base64,
            });

            if (recordImagenProductoEntregado.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              inversion.imagenProductoEntregado.target!.idDBR =
                  recordImagenProductoEntregado.id;
              dataBase.imagenesBox
                  .put(inversion.imagenProductoEntregado.target!);
              //Se actualiza Inversión en Pocketbase
              final recordInversion = await client.records
                  .update('inversiones', inversion.idDBR!, body: {
                "id_imagen_firma_recibido_fk": recordImagenFirmaRecibido.id,
                "id_imagen_producto_entregado_fk":
                    recordImagenProductoEntregado.id,
              });
              if (recordInversion.id.isNotEmpty) {
                //Se marca como realizada en Pocketbase la instrucción en Bitacora
                bitacora.executePocketbase = true;
                dataBase.bitacoraBox.put(bitacora);
                if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                  //Se elimina la instrucción de la bitacora
                  dataBase.bitacoraBox.remove(bitacora.id);
                }
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Falló al agregar Imágenes Firma de Recibido y Producto Entregado en la inversión con Id Emi Web '${inversion.idEmiWeb}' en el Servidor Local, no se pudieron asociar las Imágenes a la Inversión.");
              }
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imágenes Firma de Recibido y Producto Entregado en la inversión con Id Emi Web '${inversion.idEmiWeb}' en el Servidor Local, no se pudo recuperar Id del Sevidor Local para la Imagen de Producto Entregado.");
            }
          } else {
            return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló al agregar Imágenes Firma de Recibido y Producto Entregado en la inversión con Id Emi Web '${inversion.idEmiWeb}' en el Servidor Local, no se pudo recuperar Id del Sevidor Local para la Imagen de Firma de Recibido.");
          }
        } else {
          if (inversion.imagenProductoEntregado.target!.idDBR == null) {
            //Segundo creamos la imagen de Producto Entregado
            final recordImagenProductoEntregado =
                await client.records.create('imagenes', body: {
              "nombre": inversion.imagenProductoEntregado.target!.nombre,
              "id_emi_web": inversion.imagenProductoEntregado.target!.idEmiWeb,
              "base64": inversion.imagenProductoEntregado.target!.base64,
            });

            if (recordImagenProductoEntregado.id.isNotEmpty) {
              //Se recupera el idDBR de la imagen
              inversion.imagenProductoEntregado.target!.idDBR =
                  recordImagenProductoEntregado.id;
              dataBase.imagenesBox
                  .put(inversion.imagenProductoEntregado.target!);
              //Se marca como realizada en Pocketbase la instrucción en Bitacora
              bitacora.executePocketbase = true;
              dataBase.bitacoraBox.put(bitacora);
              if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
                //Se elimina la instrucción de la bitacora
                dataBase.bitacoraBox.remove(bitacora.id);
              }
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló al agregar Imágenes Firma de Recibido y Producto Entregado en la inversión con Id Emi Web '${inversion.idEmiWeb}' en el Servidor Local, no se pudo recuperar Id del Sevidor Local para la Imagen de Producto Entregado.");
            }
          } else {
            if (bitacora.executeEmiWeb && bitacora.executePocketbase) {
              //Se elimina la instrucción de la bitacora
              dataBase.bitacoraBox.remove(bitacora.id);
            }
            return SyncInstruction(exitoso: true, descripcion: "");
          }
        }
      } else {
        if (bitacora.executeEmiWeb) {
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(bitacora.id);
        }
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      print('ERROR - function syncAddImagenesEntregaInversion(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Imágenes Firma de Recibido y Producto Entregado en la inversión con Id Emi Web '${inversion.idEmiWeb}' en el Servidor Local, detalles: $e");
    }
  }

// PROCESO DE OBTENCIÓN DE PRODUCTOS COTIZADOS

  Future<bool> executeProductosCotizadosPocketbase(
      Emprendimientos emprendimiento, Inversiones inversion) async {
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

  Future<bool> getproductosCotizadosPocketbase(
      Emprendimientos emprendimiento, Inversiones inversion) async {
    //¿Como recupero la inversionXprodCotizado? Si no está en Objectbox, sólo en pocketBase y Emi Web
    //Se obtiene el último inversionXprodCotizado en Pocketbase
    final recordsInversionXProdCotizado = await client.records.getFullList(
        'inversion_x_prod_cotizados',
        batch: 200,
        filter: "id_inversion_fk='${inversion.idDBR}'",
        sort: "-created");
    if (recordsInversionXProdCotizado.isNotEmpty) {
      final inversionXprodCotizadosParse = getInversionXProdCotizadosFromMap(
          recordsInversionXProdCotizado[0].toString());
      //Obtenemos los productos cotizados
      final recordInversion =
          await client.records.getOne('inversiones', inversion.idDBR!);
      final recordProdCotizados = await client.records.getFullList(
          'productos_cotizados',
          batch: 200,
          filter:
              "id_inversion_x_prod_cotizados_fk='${inversionXprodCotizadosParse.id}'");
      if (recordProdCotizados.isEmpty || recordInversion.id.isEmpty) {
        //No se encontró la inversión ni los productos cotizados
        return false;
      } else {
        final GetInversion inversionParse =
            getInversionFromMap(recordInversion.toString());
        final estadoInversion = dataBase.estadoInversionBox
            .query(EstadoInversion_.idDBR
                .equals(inversionParse.idEstadoInversionFk))
            .build()
            .findUnique();
        if (estadoInversion != null) {
          if (estadoInversion.estado == "En Cotización") {
            final List<GetProdCotizados> listProdCotizados = [];
            for (var element in recordProdCotizados) {
              listProdCotizados
                  .add(getProdCotizadosFromMap(element.toString()));
            }
            print("Dentro de En Cotización");
            print("****Informacion productos cotizados****");
            // Se recupera el idDBR de la instancia de inversion x prod Cotizados
            if (inversion.inversionXprodCotizados.last.idEmiWeb == null) {
              // Se debe actualizar la IversionXprodCotizados
              inversion.inversionXprodCotizados.last.idDBR =
                  inversionXprodCotizadosParse.id;
              inversion.inversionXprodCotizados.last.idEmiWeb =
                  inversionXprodCotizadosParse.idEmiWeb;
              for (var i = 0; i < recordProdCotizados.length; i++) {
                //Se valida que el nuevo prod Cotizado aún no existe en Objectbox
                final prodCotizadoExistente = dataBase.productosCotBox
                    .query(ProdCotizados_.idDBR.equals(listProdCotizados[i].id))
                    .build()
                    .findUnique();
                if (prodCotizadoExistente == null) {
                  final nuevoProductoCotizado = ProdCotizados(
                    cantidad: listProdCotizados[i].cantidad,
                    costoTotal: listProdCotizados[i].costoTotal,
                    idDBR: listProdCotizados[i].id,
                    aceptado: listProdCotizados[i].aceptado,
                    idEmiWeb: listProdCotizados[i].idEmiWeb,
                    costoUnitario: listProdCotizados[i].costoTotal /
                        listProdCotizados[i].cantidad, 
                    idEmprendimiento: emprendimiento.id,
                  );
                  final productoProv = dataBase.productosProvBox
                      .query(ProductosProv_.idDBR
                          .equals(listProdCotizados[i].idProductoProvFk))
                      .build()
                      .findUnique();
                  if (productoProv != null) {
                    nuevoProductoCotizado.inversionXprodCotizados.target =
                        inversion.inversionXprodCotizados.last;
                    nuevoProductoCotizado.productosProv.target = productoProv;
                    dataBase.productosCotBox.put(nuevoProductoCotizado);
                    inversion.inversionXprodCotizados.last.prodCotizados
                        .add(nuevoProductoCotizado);
                    dataBase.inversionesXprodCotizadosBox
                        .put(inversion.inversionXprodCotizados.last);
                  } else {
                    return false;
                  }
                }
              }
              //Se actualiza el estado de la inversión en ObjectBox
              final newEstadoInversion = dataBase.estadoInversionBox
                  .query(EstadoInversion_.estado.equals("En Cotización"))
                  .build()
                  .findFirst();
              if (newEstadoInversion != null) {
                inversion.estadoInversion.target = newEstadoInversion;
                dataBase.inversionesXprodCotizadosBox
                    .put(inversion.inversionXprodCotizados.last);
                dataBase.inversionesBox.put(inversion);
                print("Inversion updated succesfully");
                return true;
              } else {
                return false;
              }
            } else {
              // Se debe crear una nuevaIversionXprodCotizados
              final nuevaIversionXprodCotizados = InversionesXProdCotizados(
                idDBR: inversionXprodCotizadosParse.id,
                idEmiWeb: inversionXprodCotizadosParse.idEmiWeb, 
                idEmprendimiento: emprendimiento.id,
              );
              for (var i = 0; i < recordProdCotizados.length; i++) {
                //Se valida que el nuevo prod Cotizado aún no existe en Objectbox
                final prodCotizadoExistente = dataBase.productosCotBox
                    .query(ProdCotizados_.idDBR.equals(listProdCotizados[i].id))
                    .build()
                    .findUnique();
                if (prodCotizadoExistente == null) {
                  final nuevoProductoCotizado = ProdCotizados(
                    cantidad: listProdCotizados[i].cantidad,
                    costoTotal: listProdCotizados[i].costoTotal,
                    idDBR: listProdCotizados[i].id,
                    aceptado: listProdCotizados[i].aceptado,
                    idEmiWeb: listProdCotizados[i].idEmiWeb,
                    costoUnitario: listProdCotizados[i].costoTotal /
                        listProdCotizados[i].cantidad, 
                    idEmprendimiento: emprendimiento.id,
                  );
                  final productoProv = dataBase.productosProvBox
                      .query(ProductosProv_.idDBR
                          .equals(listProdCotizados[i].idProductoProvFk))
                      .build()
                      .findUnique();
                  if (productoProv != null) {
                    nuevoProductoCotizado.inversionXprodCotizados.target =
                        nuevaIversionXprodCotizados;
                    nuevoProductoCotizado.productosProv.target = productoProv;
                    dataBase.productosCotBox.put(nuevoProductoCotizado);
                    nuevaIversionXprodCotizados.prodCotizados
                        .add(nuevoProductoCotizado);
                    dataBase.inversionesXprodCotizadosBox
                        .put(nuevaIversionXprodCotizados);
                  } else {
                    return false;
                  }
                }
              }
              //Se actualiza el estado de la inversión en ObjectBox
              final newEstadoInversion = dataBase.estadoInversionBox
                  .query(EstadoInversion_.estado.equals("En Cotización"))
                  .build()
                  .findFirst();
              if (newEstadoInversion != null) {
                inversion.estadoInversion.target = newEstadoInversion;
                nuevaIversionXprodCotizados.inversion.target =
                    inversion; //Posible solución al error de PAGOS SCREEN
                dataBase.inversionesXprodCotizadosBox
                    .put(nuevaIversionXprodCotizados);
                inversion.inversionXprodCotizados
                    .add(nuevaIversionXprodCotizados);
                dataBase.inversionesBox.put(inversion);
                print("Inversion updated succesfully");
                return true;
              } else {
                return false;
              }
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
