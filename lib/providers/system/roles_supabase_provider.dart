import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/models/get_user_supabase.dart';
import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';

class RolesSupabaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String message = "";

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


  Future<String> getRolesSupabase(GetUserSupabase user) async {
    message = await getRoles(user);
    //Verificamos que no haya habido errores al sincronizar
    if (message == "Okay") {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      notifyListeners();
      return message;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return message;
    }
  }

//Función para recuperar el catálogo de roles desde Supabase utilizando la información más reciente del Usuario
  Future<String> getRoles(GetUserSupabase user) async {
    try {
      //Se recupera toda la colección de roles en Supabase
      final recordsRoles = await supabase
          .from('role')
          .select();
        if (recordsRoles != null) {
          //Existen datos de roles en Supabase
          final responseListRoles = recordsRoles as List<dynamic>;
          for (var element in responseListRoles) {
            //Se valida que el nuevo rol aún no existe en Objectbox
            final rolExistente = dataBase.roleBox.query(Role_.idDBR.equals(element['role_id'].toString())).build().findUnique();
            if (rolExistente == null) {
              final newRole = Role(
              role: element['name'],
              idDBR: element['role_id'].toString(), 
              );
              dataBase.roleBox.put(newRole);
              //print('Rol Nuevo agregado exitosamente');
            } else {
                //Se actualiza el registro en Objectbox
                rolExistente.role = element['name'];
                dataBase.roleBox.put(rolExistente);
            }
          }
          return "Okay";
        } else {
          //No existen datos de estados en Pocketbase
          return "Not-Data";
        }
    } catch (e) {
      print("Error at 'getRoles': $e");
      return "$e";
    }
  }
}
