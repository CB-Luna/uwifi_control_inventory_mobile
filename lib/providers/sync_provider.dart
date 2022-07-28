import 'dart:convert';
import 'package:bizpro_app/database/entitys.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SyncProvider extends ChangeNotifier {
  //Image data
  bool fileSelected = false;
  String fileName = "";


    Future<bool?> syncEmprendimientos(List<Emprendimientos> emprendimientos) async {

    for (var i = 0; i < emprendimientos.length; i++) {
        try {

        var url = Uri.parse(
            '/planbuilder/api');

        final bodyMsg = jsonEncode({
            "apikey": "svsvs54sef5se4fsv",
            "action": "validateLOASigned",
            "id": emprendimientos[i].id,
            "imagen": emprendimientos[i].imagen,
            "nombre": emprendimientos[i].nombre,
            "descripcion": emprendimientos[i].descripcion,
            "fechaRegistro": emprendimientos[i].fechaRegistro,
            "activo": emprendimientos[i].activo,
            "archivado": emprendimientos[i].archivado,
          });

        var response = await http.post(url, body: bodyMsg);

        // var validateLOASigned = ValidateLOASigned.fromJson(response.body);

        // if (validateLOASigned.result == true) {
        //   return true;
        // }
        // else{
        //   return  false;
        // }  
        return true;

      } catch (e) {
        print('ERROR - function getDocumentLOAPortability(): $e');
        return false;
      }
      
    }
  }
}
