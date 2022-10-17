import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';
import '../objectbox.g.dart';

class RolesPocketbaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  bool banderaExistoSync = false;
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

  Future<bool> getRolesPocketbase() async {
    banderaExistoSync = await getRoles();
    //Aplicamos una operación and para validar que no haya habido un catálogo con False
    exitoso = exitoso && banderaExistoSync;
    //Verificamos que no haya habido errores al sincronizar con las banderas
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

//Función para recuperar el catálogo de roles desde Pocketbase
  Future<bool> getRoles() async {
    try {
      //Se recupera toda la colección de roles en Pocketbase
      final records = await client.records.
      getFullList('roles', batch: 200, sort: '+rol');
      if (records.isNotEmpty) {
        //Existen datos de roles en Pocketbase
        final List<GetRoles> listRoles = [];
        for (var element in records) {
          listRoles.add(getRolesFromMap(element.toString()));
        }
        for (var i = 0; i < listRoles.length; i++) {
          //Se valida que el nuevo rol aún no existe en Objectbox
          final rolExistente = dataBase.rolesBox.query(Roles_.idDBR.equals(listRoles[i].id)).build().findUnique();
          if (rolExistente == null) {
            if (listRoles[i].id.isNotEmpty) {
              final nuevoRol = Roles(
              rol: listRoles[i].rol,
              idDBR: listRoles[i].id, 
              idEmiWeb: listRoles[i].idEmiWeb,
              );
              dataBase.rolesBox.put(nuevoRol);
              print('Rol Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (rolExistente.fechaRegistro != listRoles[i].updated) {
              //Se actualiza el registro en Objectbox
              rolExistente.rol = listRoles[i].rol;
              rolExistente.fechaRegistro = listRoles[i].updated!;
              dataBase.rolesBox.put(rolExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
