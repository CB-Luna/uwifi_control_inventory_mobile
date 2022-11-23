import 'package:bizpro_app/modelsPocketbase/temporals/get_emi_user_pocketbase_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_emprendimiento_pocketbase_temp.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';

class EmpExternosPocketbaseProvider extends ChangeNotifier {


//Función para recuperar los emprendimientos externos de Pocketbase
  Future<List<GetEmiUserPocketbasetemp>?> getEmiUsersPocketbase() async {
    try {
      //Se recupera toda la colección de usuarios en Pocketbase
      final recordsEmiUsers = await client.records.
      getFullList('emi_users', batch: 200, filter: "archivado='False'", sort: '+created');
      if (recordsEmiUsers.isNotEmpty) {
        //Existen datos de usuarios en Pocketbase
        //Se recupera toda la colección de emprendedores en Pocketbase
        final recordsEmprendedores = await client.records.
        getFullList('emprendedores', batch: 200,sort: '+created');
        if (recordsEmprendedores.isNotEmpty) {
          final recordsEmprendimientos = await client.records.
          getFullList('emprendimientos', batch: 200,sort: '+created');
          if (recordsEmprendimientos.isNotEmpty) {
            for (var elementEmprendimiento in recordsEmprendimientos) {
              var emprendimiento = getEmprendimientoPocketbaseTempFromMap(elementEmprendimiento.toString());
            }
          } else {
            //No existen datos de emprendimientos en Pocketbase
            return null;
          }
        } else {
          //No existen datos de emprendedores en Pocketbase
          return null;
        }
        final List<GetEmiUserPocketbasetemp> listUsuarios = [];
        // for (var element in records) {
        //   listUsuarios.add(getEmiUserPocketbasetempFromMap(element.toString()));
        // }
        return listUsuarios;
      } else {
        //No existen datos de usuarios en Pocketbase
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
