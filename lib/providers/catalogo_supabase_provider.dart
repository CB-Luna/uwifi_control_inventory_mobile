import 'dart:convert';
import 'dart:io';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';
import '../objectbox.g.dart';

class CatalogoSupabaseProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  List<bool> banderasExistoSync = [];
  bool exitoso = true;
  bool usuarioExit = false;
  var uuid = Uuid();

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

  Future<void> getCatalogos() async {
    banderasExistoSync.add(await getEstatus());
    banderasExistoSync.add(await getTipoServicios());
    banderasExistoSync.add(await getTipoProductos());

    for (var element in banderasExistoSync) {
      //Aplicamos una operación and para validar que no haya habido un catálogo con False
      exitoso = exitoso && element;
    }
    //Verificamos que no haya habido errores al sincronizar con las banderas
    if (exitoso) {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      banderasExistoSync.clear();
      notifyListeners();
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExistoSync.clear();
      notifyListeners();
    }
  }

//Función 1: Función para recuperar el catálogo de estatus desde Supabase
  Future<bool> getEstatus() async {
    try {
      List<String?> listaEstatusAEliminar = [];
      //Se recupera toda la colección de estatus en Supabase
      final records = await supabaseClient
        .from('estatus')
        .select('id, estatus, avance');
      //Se recupera toda la colección de estatus en ObjectBox
      final estatusObjectBox = dataBase.estatusBox.getAll();
      for (var element in estatusObjectBox) {
        listaEstatusAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de estatus en Supabase
        final listEstatus = records as List<dynamic>;
        for (var estatus in listEstatus) {
          //Se valida que el nuevo estatus aún no existe en Objectbox
          final estatusExistente = dataBase.estatusBox
              .query(Estatus_.idDBR.equals(estatus['id'].toString()))
              .build()
              .findUnique();
          if (estatusExistente == null) {
            final nuevoEstatus = Estatus(
              avance: estatus['avance'],
              estatus: estatus['estatus'],
              idDBR: estatus['id'].toString(),
            );
            dataBase.estatusBox.put(nuevoEstatus);
            listaEstatusAEliminar.remove(estatus['id'].toString());
          } else {
            //Se actualiza el registro en Objectbox
            estatusExistente.avance = estatus['avance'];
            estatusExistente.estatus = estatus['estatus'];
            dataBase.estatusBox.put(estatusExistente);
            listaEstatusAEliminar.remove(estatus['id'].toString());
          }
        }
        if (listaEstatusAEliminar.isNotEmpty) {
          for (var element in listaEstatusAEliminar) {
            final estatusExistente = dataBase.estatusBox
                .query(Estatus_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (estatusExistente != null) {
              estatusExistente.avance = 0.0;
              estatusExistente.estatus = "Sin estatus";
              dataBase.estatusBox.put(estatusExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estatus en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función 2: Función para recuperar el catálogo de tipo de servicios desde Supabase
  Future<bool> getTipoServicios() async {
    try {
      List<String?> listaTipoServicioAEliminar = [];
      //Se recupera toda la colección de servicios en Supabase
      final records = await supabaseClient
        .from('tipo_servicios')
        .select('id, tipoServicio, imagen, costo');
      //Se recupera toda la colección de servicios en ObjectBox
      final tipoServicioObjectBox = dataBase.tipoServicioBox.getAll();
      for (var element in tipoServicioObjectBox) {
        listaTipoServicioAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de tipo de servicio en Supabase
        final listTipoServicio = records as List<dynamic>;
        for (var tipoServicio in listTipoServicio) {
          //Se valida que el nuevo tipo de servicio aún no existe en Objectbox
          final tipoServicioExistente = dataBase.tipoServicioBox
              .query(TipoServicio_.idDBR.equals(tipoServicio['id'].toString()))
              .build()
              .findUnique();
          if (tipoServicioExistente == null) {
            final uInt8ListImagen = base64Decode(tipoServicio['imagen']);
            final tempDir = await getTemporaryDirectory();
            File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
            file.writeAsBytesSync(uInt8ListImagen);
            final nuevoTipoServicio = TipoServicio(
              tipoServicio: tipoServicio['tipoServicio'],
              imagen: tipoServicio['imagen'],
              path: file.path,
              costo: tipoServicio['costo'],
              idDBR: tipoServicio['id'].toString(),
            );
            dataBase.tipoServicioBox.put(nuevoTipoServicio);
            listaTipoServicioAEliminar.remove(tipoServicio['id'].toString());
          } else {
            //Se actualiza el registro en Objectbox
            final uInt8ListImagen = base64Decode(tipoServicio['imagen']);
            final tempDir = await getTemporaryDirectory();
            File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
            file.writeAsBytesSync(uInt8ListImagen);
            tipoServicioExistente.tipoServicio = tipoServicio['tipoServicio'];
            tipoServicioExistente.imagen = tipoServicio['imagen'];
            tipoServicioExistente.path = file.path;
            tipoServicioExistente.costo = tipoServicio['costo'];
            dataBase.tipoServicioBox.put(tipoServicioExistente);
            listaTipoServicioAEliminar.remove(tipoServicio['id'].toString());
          }
        }
        if (listaTipoServicioAEliminar.isNotEmpty) {
          for (var element in listaTipoServicioAEliminar) {
            final serviciosExistente = dataBase.tipoServicioBox
                .query(TipoServicio_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (serviciosExistente != null) {
              dataBase.tipoServicioBox.remove(serviciosExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de tipo de servicio en Supabase
        return false;
      }
    } catch (e) {
      print("Error en getEstatus: $e");
      return false;
    }
  }

//Función 3: Función para recuperar el catálogo de tipo de productos desde Supabase
  Future<bool> getTipoProductos() async {
    try {
      List<String?> listaTipoProductoAEliminar = [];
      //Se recupera toda la colección de productos en Supabase
      final records = await supabaseClient
        .from('tipo_productos')
        .select('id, tipoProducto, costo');
      //Se recupera toda la colección de productos en ObjectBox
      final tipoProductoObjectBox = dataBase.tipoProductoBox.getAll();
      for (var element in tipoProductoObjectBox) {
        listaTipoProductoAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de tipo de producto en Supabase
        final listTipoProducto = records as List<dynamic>;
        for (var tipoProducto in listTipoProducto) {
          //Se valida que el nuevo tipo de producto aún no existe en Objectbox
          final tipoProductoExistente = dataBase.tipoProductoBox
              .query(TipoProducto_.idDBR.equals(tipoProducto['id'].toString()))
              .build()
              .findUnique();
          if (tipoProductoExistente == null) {
            final nuevoTipoProducto = TipoProducto(
              tipoProducto: tipoProducto['tipoProducto'],
              costo: tipoProducto['costo'],
              idDBR: tipoProducto['id'].toString(),
            );
            dataBase.tipoProductoBox.put(nuevoTipoProducto);
            listaTipoProductoAEliminar.remove(tipoProducto['id'].toString());
          } else {
            //Se actualiza el registro en Objectbox
            tipoProductoExistente.tipoProducto = tipoProducto['tipoProducto'];
            tipoProductoExistente.costo = tipoProducto['costo'];
            dataBase.tipoProductoBox.put(tipoProductoExistente);
            listaTipoProductoAEliminar.remove(tipoProducto['id'].toString());
          }
        }
        if (listaTipoProductoAEliminar.isNotEmpty) {
          for (var element in listaTipoProductoAEliminar) {
            final productosExistente = dataBase.tipoProductoBox
                .query(TipoProducto_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (productosExistente != null) {
              dataBase.tipoProductoBox.remove(productosExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de tipo de producto en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de productos proyecto desde Pocketbase
  Future<bool> getInfoUsuarioPerfil() async {
    try {
      // Se recupera el usuario por id
      final updateUsuario = dataBase.usuariosBox
          .query(Usuarios_.correo.equals("${prefs.getString("userId")}"))
          .build()
          .findUnique();
      if (updateUsuario != null) {
        return true;
      } else {
        // No se encontró el usuario a actualizar en ObjectBox
        //print("No se encontro usuario en ObjectBox");
        return false;
      }
    } catch (e) {
      //print("Catch error Pocketbase Info usuario: $e");
      return false;
    }
  }
}
