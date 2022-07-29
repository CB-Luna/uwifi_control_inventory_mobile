import 'dart:convert';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/models/getEmprendedores.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SyncProvider extends ChangeNotifier {

  bool buttonEmprendedores = false;
  bool buttonEmprendimientos = false;

  List<Emprendedores> verificarEstadoEmprendedores(List<Emprendedores> emprendedores) {
  final List<Emprendedores> emprendedoresToSync = [];
  for (var i = 0; i < emprendedores.length; i++) {
    if (emprendedores[i].statusSync.target!.status == "0E3hoVIByUxMUMZ") {
      emprendedoresToSync.add(emprendedores[i]);
    }
  }
  return emprendedoresToSync;
}

  Future<bool?> syncPostEmprendedores(List<Emprendedores> emprendedores) async {
  for (var i = 0; i < emprendedores.length; i++) {
      try {

      var url = Uri.parse('$baseUrl/api/collections/emprendedores/records');

      final bodyMsg = jsonEncode({
          "nombre_emprendedor": emprendedores[i].nombre,
          "apellido_p_emp": emprendedores[i].apellidos,
          "apellido_m_emp": emprendedores[i].apellidos,
          "nacimiento": emprendedores[i].nacimiento,
          "curp": emprendedores[i].curp,
          "integrantes_familia": [{
            "1": emprendedores[i].integrantesFamilia,
            "2": emprendedores[i].integrantesFamilia,
        }],
          "id_comunidad_fk": "dQq9FeC0o16Cdn9",
          "telefono": emprendedores[i].telefono,
          "comentarios": emprendedores[i].comentarios,
          "id_emprendimiento_fk": "",
          "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });

      var response = await http.post(url, body: bodyMsg);

      String? idDBR = await syncGetEmprendedor(emprendedores[i].nombre, emprendedores[i].curp);

      var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedores[i].id);
      if (updateEmprendedor != null && idDBR != null) {
        updateEmprendedor.statusSync.target!.status = "HoI36PzYw1wtbO1";
        updateEmprendedor.idDBR = idDBR;
        dataBase.emprendedoresBox.put(updateEmprendedor);
      }

    } catch (e) {
      print('ERROR - function getDocumentLOAPortability(): $e');
      return false;
    }
    
  }
  buttonEmprendimientos = true;
  return true;
}

  Future<String?> syncGetEmprendedor(String nombreEmprendedor, String curp) async {
      try {
      Item? emprendedor; 
      var url = Uri.parse('$baseUrl/api/collections/emprendedores/records?filter=(nombre_emprendedor= $nombreEmprendedor)');

      var response = await http.get(url);

      final responseGetEmprendedores = GetEmprendedores.fromJson(
          response.body);

      if(responseGetEmprendedores.items != null) {
        final emprendedores = responseGetEmprendedores.items;
        for (var i = 0; i < emprendedores!.length; i++) {
          if (emprendedores[i].curp == curp) {
            emprendedor = emprendedores[i];
          }
        }
        if (emprendedor != null) {
          return emprendedor.id;
        }
        else{
          return null;
        }

      } else{

        return null;
      }


    } catch (e) {
      print('ERROR - function getDocumentLOAPortability(): $e');
      return null;
    }

}

List<Emprendimientos> verificarEstadoEmprendimientos(List<Emprendimientos> emprendimientos) {
  final List<Emprendimientos> emprendimientosToSync = [];
  for (var i = 0; i < emprendimientos.length; i++) {
    if (emprendimientos[i].statusSync.target!.status == "0E3hoVIByUxMUMZ") {
      emprendimientosToSync.add(emprendimientos[i]);
    }
  }
  return emprendimientosToSync;
}

  Future<bool?> syncPostEmprendimientos(List<Emprendimientos> emprendimientos) async {
  for (var i = 0; i < emprendimientos.length; i++) {
      try {

      var url = Uri.parse('$baseUrl/api/collections/emprendimientos/records');

      final bodyMsg = jsonEncode({
          "nombre_emprendimiento": emprendimientos[i].nombre,
          "descripcion": emprendimientos[i].descripcion,
          "imagen": emprendimientos[i].imagen,
          "activo": emprendimientos[i].activo,
          "archivado": emprendimientos[i].archivado,
          "id_comunidad_fk": "rIBCo4NNt1ddTxe",
          "id_promotor_fk": "",
          "id_prioridad_fk": "yuEVuBv9rxLM4cR",
          "id_clasificacion_emp_fk": "N2fgbFPCkb8PwnO",
          "id_proveedor_fk": "",
          "id_fase_emp_fk": "shjfgnobnYBQkUo",
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimientos[i].emprendedor.target!.idDBR,
        });

      var response = await http.post(url, body: bodyMsg);

      var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientos[i].id);
      if (updateEmprendimiento != null) {
        updateEmprendimiento.statusSync.target!.status = "HoI36PzYw1wtbO1";
        dataBase.emprendimientosBox.put(updateEmprendimiento);
      }

    } catch (e) {
      print('ERROR - function getDocumentLOAPortability(): $e');
      return false;
    }
    
  }
  return true;

}
}
