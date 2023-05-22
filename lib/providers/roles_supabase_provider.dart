import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_roles_supabase.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import '../objectbox.g.dart';

class RolesSupabaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
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

  Future<bool> getRolesSupabase() async {
    exitoso = await getRoles();
    //Verificamos que no haya habido errores al sincronizar
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

//Función para recuperar el catálogo de roles desde Supabase
  Future<bool> getRoles() async {
    String queryGetRoles = """
      query Query {
        rolCollection {
          edges {
            node {
              rol_id
              nombre
              created_at
            }
          }
        }
      }
      """;
    try {
      //Se recupera toda la colección de roles en Supabase
      final records = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetRoles),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );

      if (records.data != null) {
        //Existen datos de roles en Supabase
        print("****Roles: ${jsonEncode(records.data.toString())}");
        final responseListRoles = getRolesSupabaseFromMap(jsonEncode(records.data).toString());
        for (var element in responseListRoles.rolesCollection.edges) {
          //Se valida que el nuevo rol aún no existe en Objectbox
          final rolExistente = dataBase.rolesBox.query(Roles_.idDBR.equals(element.node.id)).build().findUnique();
          if (rolExistente == null) {
            final nuevoRol = Roles(
            rol: element.node.nombre,
            idDBR: element.node.id, 
            );
            dataBase.rolesBox.put(nuevoRol);
            //print('Rol Nuevo agregado exitosamente');
          } else {
              //Se actualiza el registro en Objectbox
              rolExistente.rol = element.node.nombre;
              dataBase.rolesBox.put(rolExistente);
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      print("Error getRoleSupabase: $e");
      return false;
    }
  }
}
