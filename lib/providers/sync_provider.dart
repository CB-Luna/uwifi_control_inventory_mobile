import 'dart:convert';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/models/getEmprendedores.dart';
import 'package:bizpro_app/models/response_post_emprendedor.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../objectbox.g.dart';

class SyncProvider extends ChangeNotifier {

  bool alreadySyncEmprendedores = false;
  bool alreadySyncEmprendimientos = false;

  bool procesoterminado = false;
  bool procesocargando = false;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    notifyListeners();
  }


  Future<void> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    print(instruccionesBitacora.length);
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      print(instruccionesBitacora[i].instrucciones);
      switch (instruccionesBitacora[i].instrucciones) {
        case "syncAddEmprendimiento":
        print("Entro aqui");
        final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.bitacora.equals(instruccionesBitacora[i].id)).build().findUnique();
          if(emprendimientoToSync!.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            if (alreadySyncEmprendedores) {
              await syncPostEmprendimiento(emprendimientoToSync);
            } else {
              final emprendedores = verificarEstadoEmprendedores(dataBase.emprendedoresBox.getAll());
              await syncPostEmprendedores(emprendedores);
              await syncPostEmprendimiento(emprendimientoToSync);    
            }     
          }          
          break;
        case "syncAddEmprendedor":
          var emprendedorToSync = dataBase.emprendedoresBox.query(Emprendedores_.bitacora.equals(instruccionesBitacora[i].id)).build().findUnique(); 
          var emprendedorPrueba = dataBase.emprendedoresBox.getAll();
          for (var i = 0; i < emprendedorPrueba.length; i++) {
            print("Status Emprendedor Prueba: ${emprendedorPrueba[i].statusSync.target!.status}");  
          print("IDBR Emprendedor Prueba: ${emprendedorPrueba[i].idDBR}");
          }
            print("Status Emprendedor Query: ${emprendedorToSync!.statusSync.target!.status}");
            print("IDBR Emprendedor Query: ${emprendedorToSync.idDBR}");
            if(emprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              break;
            } else {
                await syncPostEmprendedor(emprendedorToSync);  
              }          
          break;
        default:
         break;
      }
      
    }
    print("Proceso terminado");
    procesoterminado = true;
    procesocargando = false;
    notifyListeners();

  }

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
        print("Estoy en El syncPostEmprendedores");
        var url = Uri.parse('$baseUrl/api/collections/emprendedores/records');

        final bodyMsg = jsonEncode({
            "nombre_emprendedor": emprendedores[i].nombre,
            "apellidos_emp": emprendedores[i].apellidos,
            "nacimiento": "1995-06-21",
            "curp": emprendedores[i].curp,
            "integrantes_familia": int.parse(emprendedores[i].integrantesFamilia),
            "id_comunidad_fk": "dQq9FeC0o16Cdn9",
            "telefono": emprendedores[i].telefono,
            "comentarios": emprendedores[i].comentarios,
            "id_emprendimiento_fk": "",
            "id_status_sync_fk": "HoI36PzYw1wtbO1"
          });

         print("Body Message: $bodyMsg");
        
        var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyMsg,
        );

        print("Respuesta!!!!!!!!!!!!");

        print(response.body);

        var responsePostEmprendedor = ResponsePostEmprendedor.fromJson(response.body);
        String idDBR = responsePostEmprendedor.id;

        var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedores[i].id);
        if (updateEmprendedor != null && idDBR != null) {
          print("Entro al if de syncPostEmprendedores");
          print("Previo estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
          updateEmprendedor.statusSync.target!.status = "HoI36PzYw1wtbO1";
          print("Actualizacion de estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
          updateEmprendedor.idDBR = idDBR;

          dataBase.emprendedoresBox.put(updateEmprendedor);

          var emprendedoresPrueba = dataBase.emprendedoresBox.getAll();
          for (var i = 0; i < emprendedoresPrueba.length; i++) {
            print("Status Emprendedor Prueba: ${emprendedoresPrueba[i].statusSync.target!.status}");  
          print("IDBR Emprendedor Prueba: ${emprendedoresPrueba[i].idDBR}");
          }

          print(dataBase.emprendedoresBox.count());
        }

      } catch (e) {
        print('ERROR - function syncPostEmprendedores(): $e');
        return false;
      }
      
    }
    alreadySyncEmprendedores = true;
    return true;
}

  Future<bool?> syncPostEmprendedor(Emprendedores emprendedor) async {

        print("Estoy en El syncPostEmprendedor");

        try {

        var url = Uri.parse('$baseUrl/api/collections/emprendedores/records');

        final bodyMsg = jsonEncode({
            "nombre_emprendedor": emprendedor.nombre,
            "apellidos_emp": emprendedor.apellidos,
            "nacimiento": "1995-06-21", //TODO Validar Formato Nacimiento
            "curp": emprendedor.curp,
            "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
            "id_comunidad_fk": "dQq9FeC0o16Cdn9",
            "telefono": emprendedor.telefono,
            "comentarios": emprendedor.comentarios,
            "id_emprendimiento_fk": "",
            "id_status_sync_fk": "HoI36PzYw1wtbO1"
          });

        print("Body Message: $bodyMsg");
        
        var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyMsg,
        );

        print("Respuesta!!!!!!!!!!!!");

        print(response.body);

        var responsePostEmprendedor = ResponsePostEmprendedor.fromJson(response.body);
        String idDBR = responsePostEmprendedor.id;
        var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
        if (updateEmprendedor != null && idDBR != null) {
          updateEmprendedor.statusSync.target!.status = "HoI36PzYw1wtbO1";
          updateEmprendedor.idDBR = idDBR;
          dataBase.emprendedoresBox.put(updateEmprendedor);
        }

      } catch (e) {
        print('ERROR - function syncPostEmprendedor(): $e');
        return false;
      }

    return true;
}

//   Future<String?> syncGetEmprendedor(String nombreEmprendedor, String curp) async {
//       try {
//       Item? emprendedor; 
//       var url = Uri.parse('$baseUrl/api/collections/emprendedores/records?filter=(nombre_emprendedor= $nombreEmprendedor)');

//       var response = await http.get(url);

//       print("Antes del fromJason en syncGetEmprendedor");
//       final responseGetEmprendedores = GetEmprendedores.fromJson(
//           response.body);
//       print("Despues del fromJason en syncGetEmprendedor");
//       if(responseGetEmprendedores.items != null) {
//         print("Si hice el Get");
//         final emprendedores = responseGetEmprendedores.items;
//         for (var i = 0; i < emprendedores!.length; i++) {
//           if (emprendedores[i].curp == curp) {
//             emprendedor = emprendedores[i];
//           }
//         }
//         if (emprendedor != null) {
//           return emprendedor.id;
//         }
//         else{
//           return null;
//         }

//       } else{
//         print("No hice el Get");
//         return null;
//       }


//     } catch (e) {
//       print('ERROR - function syncGetEmprendedor(): $e');
//       return null;
//     }

// }


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
    print("Estoy en El syncPostEmprendimientos");
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

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyMsg,
        );

      var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientos[i].id);
      if (updateEmprendimiento != null) {
        updateEmprendimiento.statusSync.target!.status = "HoI36PzYw1wtbO1";
        dataBase.emprendimientosBox.put(updateEmprendimiento);
      }

    } catch (e) {
      print('ERROR - function syncPostEmprendimientos(): $e');
      return false;
    }
    
  }
  return true;

}

  Future<bool?> syncPostEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncPostEmprendimiento");
      try {

      var url = Uri.parse('$baseUrl/api/collections/emprendimientos/records');

      final bodyMsg = jsonEncode({
          "nombre_emprendimiento": emprendimiento.nombre,
          "descripcion": emprendimiento.descripcion,
          "imagen": emprendimiento.imagen,
          "activo": emprendimiento.activo,
          "archivado": emprendimiento.archivado,
          "id_comunidad_fk": "rIBCo4NNt1ddTxe",
          "id_promotor_fk": "",
          "id_prioridad_fk": "yuEVuBv9rxLM4cR",
          "id_clasificacion_emp_fk": "N2fgbFPCkb8PwnO",
          "id_proveedor_fk": "",
          "id_fase_emp_fk": "shjfgnobnYBQkUo",
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimiento.emprendedor.target!.idDBR,
        });

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: bodyMsg,
        );
      print("Se postea emprendimientos");
      var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
      if (updateEmprendimiento != null) {
        updateEmprendimiento.statusSync.target!.status = "HoI36PzYw1wtbO1"; 
        dataBase.emprendimientosBox.put(updateEmprendimiento);
        print("Se actualiza emprendimiento");
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncPostEmprendimiento(): $e');
      return false;
    }

}
}
