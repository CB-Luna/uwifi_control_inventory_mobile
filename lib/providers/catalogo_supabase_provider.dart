import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';

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
    banderasExistoSync.add(await getRoles());
    banderasExistoSync.add(await getStatus());
    banderasExistoSync.add(await getCompanies());

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


//Function 1: Recover Roles
  Future<bool> getRoles() async {
    try {
      List<String?> listaTecnicosMecanicosAEliminar = [];
      final recordsTecnicosMecanicos = await supabase.from('users').select().eq('rol_fk', '2');
      //Se recupera toda la colección de tecnicosMecanicos en ObjectBox
      final tecnicosMecanicosObjectBox = 
        dataBase.usersBox.query(
            Users_.role.equals(dataBase.roleBox.query(
                Role_.role.equals("Técnico-Mecánico"))
                .build().findFirst()?.id ?? 0)).build().find();
      for (var element in tecnicosMecanicosObjectBox) {
        listaTecnicosMecanicosAEliminar.add(element.idDBR);
      }
      if (recordsTecnicosMecanicos != null) {
        //Existen datos de tecnicosMecanicos en Supabase
        final listTecnicosMecanicos = recordsTecnicosMecanicos as List<dynamic>;
        for (var tecnicoMecanico in listTecnicosMecanicos) {
          //Se valida que el nuevo tecnicosMecanicos aún no existe en Objectbox
          final tecnicosMecanicosExistente = dataBase.usersBox
              .query(Users_.idDBR.equals(tecnicoMecanico['id'].toString()))
              .build()
              .findUnique();
          if (tecnicosMecanicosExistente == null) {
            // final nuevoTecnicoMecanico = Users(
            //   name: tecnicoMecanico['nombre'],
            //   lastName: tecnicoMecanico['apellido_p'],
            //   middleName: tecnicoMecanico['apellido_m'],
            //   mobilePhone: tecnicoMecanico['celular'],
            //   homePhone: tecnicoMecanico['telefono'],
            //   address: tecnicoMecanico['domicilio'],
            //   correo: tecnicoMecanico['email'],
            //   idDBR: tecnicoMecanico['id'],
            //   image: tecnicoMecanico['imagen'],
            //   password: "default",
            //   birthDate: DateTime.now(),
            // );
            // //Se agregan los roles
            // for (var i = 0; i < rolesIdDBR.length; i++) {
            //   final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
            //   if (nuevoRol != null) {
            //     nuevoUsuario.roles.add(nuevoRol);
            //   }
            // }
            //Se asiga el rol actual que ocupará
            // final rolActual = dataBase.roleBox.query(Role_.idDBR.equals(tecnicoMecanico['rol_fk'].toString())).build().findUnique(); //Se recupera el rol actual del Usuario
            // if (rolActual != null) {
            //   nuevoTecnicoMecanico.role.target = rolActual;
            //   dataBase.usersBox.put(nuevoTecnicoMecanico);
            // }
            // dataBase.usersBox.put(nuevoTecnicoMecanico);
            // listaTecnicosMecanicosAEliminar.remove(tecnicoMecanico['id'].toString());
            notifyListeners();
          } else {
            //Se actualiza el registro en Objectbox
            // //Se agregan los roles
            // for (var i = 0; i < rolesIdDBR.length; i++) {
            //   final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
            //   if (nuevoRol != null) {
            //     nuevoUsuario.roles.add(nuevoRol);
            //   }
            // }
            //Se asiga el rol actual que ocupará
            final rolActual = dataBase.roleBox.query(Role_.idDBR.equals(tecnicoMecanico['rol_fk'].toString())).build().findUnique(); //Se recupera el rol actual del Usuario
            if (rolActual != null) {
              tecnicosMecanicosExistente.role.target = rolActual;
            }
            dataBase.usersBox.put(tecnicosMecanicosExistente);
            listaTecnicosMecanicosAEliminar.remove(tecnicoMecanico['id'].toString());
            notifyListeners();
          }
        }
        if (listaTecnicosMecanicosAEliminar.isNotEmpty) {
          for (var element in listaTecnicosMecanicosAEliminar) {
            final tecnicosMecanicosExistente = dataBase.usersBox
                .query(Users_.idDBR.equals(element!))
                .build()
                .findUnique();
            if (tecnicosMecanicosExistente != null) {
              dataBase.usersBox.remove(tecnicosMecanicosExistente.id);
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

//Function 2: Recover Status
  Future<bool> getStatus() async {
    try {
      // List<String?> listaMarcasAEliminar = [];
      // //Se recupera toda la colección de estatus en Supabase
      // final records = await supabaseClient
      //   .from('marca')
      //   .select('id, marca, created_at');
      // //Se recupera toda la colección de marca en ObjectBox
      // final marcaObjectBox = dataBase.marcaBox.getAll();
      // for (var element in marcaObjectBox) {
      //   listaMarcasAEliminar.add(element.idDBR);
      // }
      // if (records != null) {
      //   //Existen datos de marca en Supabase
      //   final listMarcas = records as List<dynamic>;
      //   for (var marca in listMarcas) {
      //     //Se valida que el nuevo marca aún no existe en Objectbox
      //     final marcaExistente = dataBase.marcaBox
      //         .query(Marca_.idDBR.equals(marca['id'].toString()))
      //         .build()
      //         .findUnique();
      //     if (marcaExistente == null) {
      //       final nuevaMarca = Marca(
      //         fechaRegistro: DateTime.parse(marca['created_at']),
      //         marca: marca['marca'],
      //         idDBR: marca['id'].toString(),
      //       );
      //       dataBase.marcaBox.put(nuevaMarca);
      //       listaMarcasAEliminar.remove(marca['id'].toString());
      //     } else {
      //       //Se actualiza el registro en Objectbox
      //       marcaExistente.fechaRegistro = DateTime.parse(marca['created_at']);
      //       marcaExistente.marca = marca['marca'];
      //       dataBase.marcaBox.put(marcaExistente);
      //       listaMarcasAEliminar.remove(marca['id'].toString());
      //     }
      //   }
      //   if (listaMarcasAEliminar.isNotEmpty) {
      //     for (var element in listaMarcasAEliminar) {
      //       final marcaExistente = dataBase.marcaBox
      //           .query(Marca_.idDBR.equals(element!))
      //           .build()
      //           .findUnique();
      //       if (marcaExistente != null) {
      //         dataBase.marcaBox.remove(marcaExistente.id);
      //       }
      //     }
      //   }
      //   return true;
      // } else {
      //   //No existen datos de marca en Supabase
      //   return false;
      // }
      return true;
    } catch (e) {
      return false;
    }
  }

//Function 3: Recover Companies
  Future<bool> getCompanies() async {
    try {
      // List<String?> listaModelosAEliminar = [];
      // //Se recupera toda la colección de estatus en Supabase
      // final records = await supabaseClient
      //   .from('modelo')
      //   .select('id, modelo, created_at, id_marca_fk');
      // //Se recupera toda la colección de modelo en ObjectBox
      // final modeloObjectBox = dataBase.modeloBox.getAll();
      // for (var element in modeloObjectBox) {
      //   listaModelosAEliminar.add(element.idDBR);
      // }
      // if (records != null) {
      //   //Existen datos de modelo en Supabase
      //   final listModelos = records as List<dynamic>;
      //   for (var modelo in listModelos) {
      //     //Se valida que el nuevo modelo aún no existe en Objectbox
      //     final modeloExistente = dataBase.modeloBox
      //         .query(Modelo_.idDBR.equals(modelo['id'].toString()))
      //         .build()
      //         .findUnique();
      //     if (modeloExistente == null) {
      //       //Se recupera la marca del modelo
      //       final marca = dataBase.marcaBox
      //         .query(Marca_.idDBR.equals(modelo['id_marca_fk'].toString()))
      //         .build()
      //         .findUnique();
      //       if (marca != null) {
      //         final nuevoModelo = Modelo(
      //           fechaRegistro: DateTime.parse(modelo['created_at']),
      //           modelo: modelo['modelo'],
      //           idDBR: modelo['id'].toString(),
      //         );
      //         nuevoModelo.marca.target = marca;
      //         marca.modelos.add(nuevoModelo);
      //         dataBase.marcaBox.put(marca);
      //         dataBase.modeloBox.put(nuevoModelo);
      //         listaModelosAEliminar.remove(modelo['id'].toString());
      //       } else {
      //         return false;
      //       }
      //     } else {
      //       //Se actualiza el registro en Objectbox
      //       final marcaExistente = dataBase.marcaBox
      //         .query(Marca_.idDBR.equals(modeloExistente.marca.target!.idDBR.toString()))
      //         .build()
      //         .findUnique();
      //       if (marcaExistente != null) {
      //         if (marcaExistente.idDBR == modelo['id_marca_fk']) {
      //             modeloExistente.fechaRegistro = DateTime.parse(modelo['created_at']);
      //             modeloExistente.modelo = modelo['modelo'];
      //             dataBase.modeloBox.put(modeloExistente);
      //             listaModelosAEliminar.remove(modelo['id'].toString());
      //         } else {
      //           //Se cambio la marca del modelo
      //           marcaExistente.modelos.remove(modeloExistente);
      //           dataBase.marcaBox.put(marcaExistente);
      //           //Se recupera la nueva Marca
      //           final nuevaMarca = dataBase.marcaBox
      //           .query(Marca_.idDBR.equals(modelo['id_marca_fk'].toString()))
      //           .build()
      //           .findUnique();
      //           if (nuevaMarca != null) {
      //             //Se reasigna el modelo a la nueva marca
      //             nuevaMarca.modelos.add(modeloExistente);
      //             dataBase.marcaBox.put(nuevaMarca);

      //             //Se reasigna el modelo a la nueva marca
      //             modeloExistente.marca.target = nuevaMarca;
      //             modeloExistente.fechaRegistro = DateTime.parse(modelo['created_at']);
      //             modeloExistente.modelo = modelo['modelo'];
      //             dataBase.modeloBox.put(modeloExistente);
      //             listaModelosAEliminar.remove(modelo['id'].toString());
      //           } else {
      //             return false;
      //           }
      //         }
      //       } else {
      //         return false;
      //       }
      //     }
      //   }
      //   if (listaModelosAEliminar.isNotEmpty) {
      //     for (var element in listaModelosAEliminar) {
      //       final modeloExistente = dataBase.modeloBox
      //           .query(Modelo_.idDBR.equals(element!))
      //           .build()
      //           .findUnique();
      //       if (modeloExistente != null) {
      //         dataBase.modeloBox.remove(modeloExistente.id);
      //       }
      //     }
      //   }
      //   return true;
      // } else {
      //   //No existen datos de modelo en Supabase
      //   return false;
      // }
      return true;
    } catch (e) {
      return false;
    }
  }


}
