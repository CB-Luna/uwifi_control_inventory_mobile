import 'package:bizpro_app/modelsPocketbase/temporals/get_emi_user_pocketbase_temp.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';

class EmpExternosPocketbaseProvider extends ChangeNotifier {


//Función para recuperar los emprendimientos externos de Pocketbase
  Future<List<GetEmiUserPocketbasetemp>?> getEmiUsersPocketbase() async {
    try {
      //Se recupera toda la colección de roles en Pocketbase
      final records = await client.records.
      getFullList('emi_users', batch: 200, sort: '+created');
      if (records.isNotEmpty) {
        //Existen datos de roles en Pocketbase
        final List<GetEmiUserPocketbasetemp> listUsuarios = [];
        for (var element in records) {
          listUsuarios.add(getEmiUserPocketbasetempFromMap(element.toString()));
        }
        return listUsuarios;
      } else {
        //No existen datos de estados en Pocketbase
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
