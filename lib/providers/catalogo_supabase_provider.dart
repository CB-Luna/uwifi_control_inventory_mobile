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
    banderasExistoSync.add(await getTecnicosMecanicos());
    banderasExistoSync.add(await getMarcas());
    banderasExistoSync.add(await getModelos());
    banderasExistoSync.add(await getAnios());
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


//Función 1: Función para recuperar el catálogo de técnicos mecánicos desde Supabase
  Future<bool> getTecnicosMecanicos() async {
    try {
      List<String?> listaTecnicosMecanicosAEliminar = [];
      //Se recupera toda la colección de tecnicosMecanicos en Supabase
      // Hace una consulta utilizando la cláusula WHERE con la función ->>
      // const queryTecnicosMecanicos = ''' select 
      //   nombre,
      //   apellido_p,
      //   apellido_m,
      //   celular,
      //   telefono,
      //   rfc,
      //   domicilio,
      //   email,
      //   id,
      //   imagen,
      //   rol_fk 
      //   FROM users
      //   WHERE rol ->> 'rol' = 'Técnico-Mecánico'
      // ''';
      final recordsTecnicosMecanicos = await supabaseClient.from('users').select().eq('rol_fk', '2');
      //Se recupera toda la colección de tecnicosMecanicos en ObjectBox
      final tecnicosMecanicosObjectBox = 
        dataBase.usuariosBox.query(
            Usuarios_.rol.equals(dataBase.rolesBox.query(
                Roles_.rol.equals("Técnico-Mecánico"))
                .build().findFirst()?.id ?? 0)).build().find();
      for (var element in tecnicosMecanicosObjectBox) {
        listaTecnicosMecanicosAEliminar.add(element.idDBR);
      }
      if (recordsTecnicosMecanicos != null) {
        //Existen datos de tecnicosMecanicos en Supabase
        final listTecnicosMecanicos = recordsTecnicosMecanicos as List<dynamic>;
        for (var tecnicoMecanico in listTecnicosMecanicos) {
          //Se valida que el nuevo tecnicosMecanicos aún no existe en Objectbox
          final tecnicosMecanicosExistente = dataBase.usuariosBox
              .query(Usuarios_.idDBR.equals(tecnicoMecanico['id'].toString()))
              .build()
              .findUnique();
          if (tecnicosMecanicosExistente == null) {
            final nuevoTecnicoMecanico = Usuarios(
              nombre: tecnicoMecanico['nombre'],
              apellidoP: tecnicoMecanico['apellido_p'],
              apellidoM: tecnicoMecanico['apellido_m'],
              celular: tecnicoMecanico['celular'],
              telefono: tecnicoMecanico['telefono'],
              domicilio: tecnicoMecanico['domicilio'],
              correo: tecnicoMecanico['email'],
              idDBR: tecnicoMecanico['id'],
              imagen: tecnicoMecanico['imagen'],
              password: "default",
              interno: tecnicoMecanico['interno'],
            );
            if (tecnicoMecanico['imagen'] != null) {
              final uInt8ListImagen = base64Decode(tecnicoMecanico['imagen']);
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
              file.writeAsBytesSync(uInt8ListImagen);
              nuevoTecnicoMecanico.path = file.path;
            } 
            // //Se agregan los roles
            // for (var i = 0; i < rolesIdDBR.length; i++) {
            //   final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
            //   if (nuevoRol != null) {
            //     nuevoUsuario.roles.add(nuevoRol);
            //   }
            // }
            //Se asiga el rol actual que ocupará
            final rolActual = dataBase.rolesBox.query(Roles_.idDBR.equals(tecnicoMecanico['rol_fk'].toString())).build().findUnique(); //Se recupera el rol actual del Usuario
            if (rolActual != null) {
              nuevoTecnicoMecanico.rol.target = rolActual;
              dataBase.usuariosBox.put(nuevoTecnicoMecanico);
            }
            dataBase.usuariosBox.put(nuevoTecnicoMecanico);
            listaTecnicosMecanicosAEliminar.remove(tecnicoMecanico['id'].toString());
            notifyListeners();
          } else {
            //Se actualiza el registro en Objectbox
              tecnicosMecanicosExistente.nombre = tecnicoMecanico['nombre'];
              tecnicosMecanicosExistente.apellidoP = tecnicoMecanico['apellido_p'];
              tecnicosMecanicosExistente.apellidoM = tecnicoMecanico['apellido_m'];
              tecnicosMecanicosExistente.celular = tecnicoMecanico['celular'];
              tecnicosMecanicosExistente.telefono = tecnicoMecanico['telefono'];
              tecnicosMecanicosExistente.domicilio = tecnicoMecanico['domicilio'];
              tecnicosMecanicosExistente.correo = tecnicoMecanico['email'];
              tecnicosMecanicosExistente.imagen = tecnicoMecanico['imagen'];
              tecnicosMecanicosExistente.idDBR = tecnicoMecanico['id'];
              tecnicosMecanicosExistente.interno = tecnicoMecanico['interno'];
            if (tecnicoMecanico['imagen'] != null) {
              final uInt8ListImagen = base64Decode(tecnicoMecanico['imagen']);
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
              file.writeAsBytesSync(uInt8ListImagen);
              tecnicosMecanicosExistente.path = file.path;
            } 
            // //Se agregan los roles
            // for (var i = 0; i < rolesIdDBR.length; i++) {
            //   final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
            //   if (nuevoRol != null) {
            //     nuevoUsuario.roles.add(nuevoRol);
            //   }
            // }
            //Se asiga el rol actual que ocupará
            final rolActual = dataBase.rolesBox.query(Roles_.idDBR.equals(tecnicoMecanico['rol_fk'].toString())).build().findUnique(); //Se recupera el rol actual del Usuario
            if (rolActual != null) {
              tecnicosMecanicosExistente.rol.target = rolActual;
            }
            dataBase.usuariosBox.put(tecnicosMecanicosExistente);
            listaTecnicosMecanicosAEliminar.remove(tecnicoMecanico['id'].toString());
            notifyListeners();
          }
        }
        if (listaTecnicosMecanicosAEliminar.isNotEmpty) {
          for (var element in listaTecnicosMecanicosAEliminar) {
            final tecnicosMecanicosExistente = dataBase.usuariosBox
                .query(Usuarios_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (tecnicosMecanicosExistente != null) {
              dataBase.usuariosBox.remove(tecnicosMecanicosExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de tecnicosMecanicos en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función 2: Función para recuperar el catálogo de marca desde Supabase
  Future<bool> getMarcas() async {
    try {
      List<String?> listaMarcasAEliminar = [];
      //Se recupera toda la colección de estatus en Supabase
      final records = await supabaseClient
        .from('marca')
        .select('id, marca, created_at');
      //Se recupera toda la colección de marca en ObjectBox
      final marcaObjectBox = dataBase.marcaBox.getAll();
      for (var element in marcaObjectBox) {
        listaMarcasAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de marca en Supabase
        final listMarcas = records as List<dynamic>;
        for (var marca in listMarcas) {
          //Se valida que el nuevo marca aún no existe en Objectbox
          final marcaExistente = dataBase.marcaBox
              .query(Marca_.idDBR.equals(marca['id'].toString()))
              .build()
              .findUnique();
          if (marcaExistente == null) {
            final nuevaMarca = Marca(
              fechaRegistro: DateTime.parse(marca['created_at']),
              marca: marca['marca'],
              idDBR: marca['id'].toString(),
            );
            dataBase.marcaBox.put(nuevaMarca);
            listaMarcasAEliminar.remove(marca['id'].toString());
          } else {
            //Se actualiza el registro en Objectbox
            marcaExistente.fechaRegistro = DateTime.parse(marca['created_at']);
            marcaExistente.marca = marca['marca'];
            dataBase.marcaBox.put(marcaExistente);
            listaMarcasAEliminar.remove(marca['id'].toString());
          }
        }
        if (listaMarcasAEliminar.isNotEmpty) {
          for (var element in listaMarcasAEliminar) {
            final marcaExistente = dataBase.marcaBox
                .query(Marca_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (marcaExistente != null) {
              dataBase.marcaBox.remove(marcaExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de marca en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función 3: Función para recuperar el catálogo de modelos desde Supabase
  Future<bool> getModelos() async {
    try {
      List<String?> listaModelosAEliminar = [];
      //Se recupera toda la colección de estatus en Supabase
      final records = await supabaseClient
        .from('modelo')
        .select('id, modelo, created_at, id_marca_fk');
      //Se recupera toda la colección de modelo en ObjectBox
      final modeloObjectBox = dataBase.modeloBox.getAll();
      for (var element in modeloObjectBox) {
        listaModelosAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de modelo en Supabase
        final listModelos = records as List<dynamic>;
        for (var modelo in listModelos) {
          //Se valida que el nuevo modelo aún no existe en Objectbox
          final modeloExistente = dataBase.modeloBox
              .query(Modelo_.idDBR.equals(modelo['id'].toString()))
              .build()
              .findUnique();
          if (modeloExistente == null) {
            //Se recupera la marca del modelo
            final marca = dataBase.marcaBox
              .query(Marca_.idDBR.equals(modelo['id_marca_fk'].toString()))
              .build()
              .findUnique();
            if (marca != null) {
              final nuevoModelo = Modelo(
                fechaRegistro: DateTime.parse(modelo['created_at']),
                modelo: modelo['modelo'],
                idDBR: modelo['id'].toString(),
              );
              nuevoModelo.marca.target = marca;
              marca.modelos.add(nuevoModelo);
              dataBase.marcaBox.put(marca);
              dataBase.modeloBox.put(nuevoModelo);
              listaModelosAEliminar.remove(modelo['id'].toString());
            } else {
              return false;
            }
          } else {
            //Se actualiza el registro en Objectbox
            final marcaExistente = dataBase.marcaBox
              .query(Marca_.idDBR.equals(modeloExistente.marca.target!.idDBR.toString()))
              .build()
              .findUnique();
            if (marcaExistente != null) {
              if (marcaExistente.idDBR == modelo['id_marca_fk']) {
                  modeloExistente.fechaRegistro = DateTime.parse(modelo['created_at']);
                  modeloExistente.modelo = modelo['modelo'];
                  dataBase.modeloBox.put(modeloExistente);
                  listaModelosAEliminar.remove(modelo['id'].toString());
              } else {
                //Se cambio la marca del modelo
                marcaExistente.modelos.remove(modeloExistente);
                dataBase.marcaBox.put(marcaExistente);
                //Se recupera la nueva Marca
                final nuevaMarca = dataBase.marcaBox
                .query(Marca_.idDBR.equals(modelo['id_marca_fk'].toString()))
                .build()
                .findUnique();
                if (nuevaMarca != null) {
                  //Se reasigna el modelo a la nueva marca
                  nuevaMarca.modelos.add(modeloExistente);
                  dataBase.marcaBox.put(nuevaMarca);

                  //Se reasigna el modelo a la nueva marca
                  modeloExistente.marca.target = nuevaMarca;
                  modeloExistente.fechaRegistro = DateTime.parse(modelo['created_at']);
                  modeloExistente.modelo = modelo['modelo'];
                  dataBase.modeloBox.put(modeloExistente);
                  listaModelosAEliminar.remove(modelo['id'].toString());
                } else {
                  return false;
                }
              }
            } else {
              return false;
            }
          }
        }
        if (listaModelosAEliminar.isNotEmpty) {
          for (var element in listaModelosAEliminar) {
            final modeloExistente = dataBase.modeloBox
                .query(Modelo_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (modeloExistente != null) {
              dataBase.modeloBox.remove(modeloExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de modelo en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función 4: Función para recuperar el catálogo de años desde Supabase
  Future<bool> getAnios() async {
    try {
      List<String?> listaAniosAEliminar = [];
      //Se recupera toda la colección de estatus en Supabase
      final records = await supabaseClient
        .from('anio')
        .select('id, anio, created_at, id_modelo_fk');
      //Se recupera toda la colección de anio en ObjectBox
      final anioObjectBox = dataBase.anioBox.getAll();
      for (var element in anioObjectBox) {
        listaAniosAEliminar.add(element.idDBR);
      }
      if (records != null) {
        //Existen datos de anio en Supabase
        final listAnios = records as List<dynamic>;
        for (var anio in listAnios) {
          //Se valida que el nuevo anio aún no existe en Objectbox
          final anioExistente = dataBase.anioBox
              .query(Anio_.idDBR.equals(anio['id'].toString()))
              .build()
              .findUnique();
          if (anioExistente == null) {
            //Se recupera la modelo del anio
            final modelo = dataBase.modeloBox
              .query(Modelo_.idDBR.equals(anio['id_modelo_fk'].toString()))
              .build()
              .findUnique();
            if (modelo != null) {
              final nuevoAnio = Anio(
                fechaRegistro: DateTime.parse(anio['created_at']),
                anio: anio['anio'],
                idDBR: anio['id'].toString(),
              );
              nuevoAnio.modelo.target = modelo;
              modelo.anios.add(nuevoAnio);
              dataBase.modeloBox.put(modelo);
              dataBase.anioBox.put(nuevoAnio);
              listaAniosAEliminar.remove(anio['id'].toString());
            } else {
              return false;
            }
          } else {
            //Se actualiza el registro en Objectbox
            final modeloExistente = dataBase.modeloBox
              .query(Modelo_.idDBR.equals(anioExistente.modelo.target!.idDBR.toString()))
              .build()
              .findUnique();
            if (modeloExistente != null) {
              if (modeloExistente.idDBR == anio['id_modelo_fk']) {
                  anioExistente.fechaRegistro = DateTime.parse(anio['created_at']);
                  anioExistente.anio = anio['anio'];
                  dataBase.anioBox.put(anioExistente);
                  listaAniosAEliminar.remove(anio['id'].toString());
              } else {
                //Se cambio la modelo del año
                modeloExistente.anios.remove(anioExistente);
                dataBase.modeloBox.put(modeloExistente);
                //Se recupera la nueva Modelo
                final nuevoModelo = dataBase.modeloBox
                .query(Modelo_.idDBR.equals(anio['id_modelo_fk'].toString()))
                .build()
                .findUnique();
                if (nuevoModelo != null) {
                  //Se reasigna el año a la nueva modelo
                  nuevoModelo.anios.add(anioExistente);
                  dataBase.modeloBox.put(nuevoModelo);

                  //Se reasigna el año a la nueva modelo
                  anioExistente.modelo.target = nuevoModelo;
                  anioExistente.fechaRegistro = DateTime.parse(anio['created_at']);
                  anioExistente.anio = anio['anio'];
                  dataBase.anioBox.put(anioExistente);
                  listaAniosAEliminar.remove(anio['id'].toString());
                } else {
                  return false;
                }
              }
            } else {
              return false;
            }
          }
        }
        if (listaAniosAEliminar.isNotEmpty) {
          for (var element in listaAniosAEliminar) {
            final anioExistente = dataBase.anioBox
                .query(Anio_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (anioExistente != null) {
              dataBase.anioBox.remove(anioExistente.id);
            }
          }
        }
        return true;
      } else {
        //No existen datos de año en Supabase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función 5: Función para recuperar el catálogo de estatus desde Supabase
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

//Función 6: Función para recuperar el catálogo de tipo de servicios desde Supabase
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

//Función 8: Función para recuperar el catálogo de tipo de productos desde Supabase
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
