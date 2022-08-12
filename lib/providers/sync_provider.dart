import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';

import 'package:bizpro_app/models/response_post_emprendedor.dart';

import 'package:http/http.dart' as http;

import '../objectbox.g.dart';

class SyncProvider extends ChangeNotifier {
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
          // final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.bitacora.equals(instruccionesBitacora[i].id)).build().findUnique();
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            if (dataBase.variablesUsuarioBox.get(prefs.getInt("idVariablesUser")!)!.emprendedores) { //Validar que ya se haya sync emprendedores 
              await syncAddEmprendimiento(emprendimientoToSync);
            } else {
              final emprendedores = verificarEstadoEmprendedores(dataBase.emprendedoresBox.getAll());
              await syncAddEmprendedores(emprendedores);
              await syncAddEmprendimiento(emprendimientoToSync);    
            }     
          } 
          }         
          break;
        case "syncAddEmprendedor":
          print("${dataBase.emprendedoresBox.getAll().length}");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
          var emprendedorPrueba = dataBase.emprendedoresBox.getAll();
          for (var i = 0; i < emprendedorPrueba.length; i++) {
            print("Status Emprendedor Prueba: ${emprendedorPrueba[i].statusSync.target!.status}");  
            print("IDBR Emprendedor Prueba: ${emprendedorPrueba[i].idDBR}");
            }
            print("Status Emprendedor Query: ${emprendedorToSync.statusSync.target!.status}");
            print("IDBR Emprendedor Query: ${emprendedorToSync.idDBR}");
            if(emprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") { 
              break;
            } else {
                await syncAddEmprendedor(emprendedorToSync);  
              }          
          break;
          }
          break;
        case "syncUpdateEmprendimiento":
          var bitacoraList = dataBase.bitacoraBox.getAll();
          for (var i = 0; i < bitacoraList.length; i++) {
            print("bitacora ID: ${bitacoraList[i].id}");  
            print("Instrucciones: ${bitacoraList[i].instrucciones}");
            }
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (emprendimientoToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateEmprendimiento(emprendimientoToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncAddJornada1":
          print("Entro aqui");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddJornada(jornadaToSync);
          } 
          }         
          break;
        case "syncAddJornada2":
          print("Entro aqui");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddJornada(jornadaToSync);
          } 
          }         
          break;
        default:
         break;
      }
      
    }
    print("Proceso terminado");
    procesoterminado = true;
    procesocargando = false;
    //Se elimina el contenido de la Bitacora
    dataBase.bitacoraBox.removeAll();
    notifyListeners();

  }

  Emprendedores? getFirstEmprendedor(List<Emprendedores> emprendedores, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendedores.length; i++) {
      if (emprendedores[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendedores[i].bitacora.length; j++) {
          if (emprendedores[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendedores[i];
          } 
        }
      }
    }
    return null;
  }

  Emprendimientos? getFirstEmprendimiento(List<Emprendimientos> emprendimientos, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendimientos.length; i++) {
      if (emprendimientos[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendimientos[i].bitacora.length; j++) {
          if (emprendimientos[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendimientos[i];
          } 
        }
      }
    }
    return null;
  }
  Jornadas? getFirstJornada(List<Jornadas> jornadas, int idInstruccionesBitacora)
  {
    for (var i = 0; i < jornadas.length; i++) {
      if (jornadas[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < jornadas[i].bitacora.length; j++) {
          if (jornadas[i].bitacora[j].id == idInstruccionesBitacora) {
            return jornadas[i];
          } 
        }
      }
    }
    return null;
  }

  Future<bool?> syncAddJornada(Jornadas jornada) async {
    print("Estoy en syncAddJornada");
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(jornada.tarea.target!.id)).build().findUnique();
        try {
        //Primero creamos la tarea asociada a la jornada
        if (tareaToSync != null) {  
          print("Datos");
          print(tareaToSync.tarea);
          print(tareaToSync.descripcion);
          print(tareaToSync.fechaRevision.toUtc().toString());
          print(tareaToSync.observacion);
          print(tareaToSync.porcentaje.toString());
          final recordTarea = await client.records.create('tareas', body: {
            "tarea": tareaToSync.tarea,
            "descripcion": tareaToSync.descripcion,
            "observacion": tareaToSync.observacion,
            "porcentaje": tareaToSync.porcentaje,
            "fecha_revision": tareaToSync.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1"
          });
          if (recordTarea.id.isNotEmpty) {
          //Se actualiza el estado de la tarea
          String idDBRTarea = recordTarea.id;
          final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(tareaToSync.statusSync.target!.id)).build().findUnique();
          if (statusSyncTarea != null) {
            statusSyncTarea.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSyncTarea);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
            print("Actualizacion de estado de la Tarea");
          }
          //Se recupera el idDBR de la tarea
          final updateTarea = dataBase.tareasBox.query(Tareas_.id.equals(tareaToSync.id)).build().findUnique();
          if (updateTarea != null) {
            updateTarea.idDBR = idDBRTarea;
            dataBase.tareasBox.put(updateTarea);
            print("Se recupera el idDBR de la Tarea");
          }
          }
          //Segundo creamos la jornada  
          print("Datos");
          print(jornada.numJornada);
          print(recordTarea.id);
          print(jornada.fechaRevision.toUtc().toString());
          print("Nombre Emp ${jornada.emprendimiento.target?.nombre}");
          print("IdDBR Emprendimiento ${jornada.emprendimiento.target?.idDBR}");
          final recordJornada = await client.records.create('jornadas', body: {
            "num_jornada": jornada.numJornada,
            "id_tarea_fk": recordTarea.id,
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_emprendimiento_fk": jornada.emprendimiento.target!.idDBR,
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
          });

          if (recordJornada.id.isNotEmpty) {
            //Se actualiza el estado de la jornada
            String idDBRJornada = recordJornada.id;
            final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornada.statusSync.target!.id)).build().findUnique();
            if (statusSyncJornada != null) {
              statusSyncJornada.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSyncJornada);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
              print("Actualizacion de estado de la Jornada");
            }
            //Se recupera el idDBR de la jornada
            final updateJornada = dataBase.jornadasBox.query(Jornadas_.id.equals(jornada.id)).build().findUnique();
            if (updateJornada != null) {
              updateJornada.idDBR = idDBRJornada;
              dataBase.jornadasBox.put(updateJornada);
              print("Se recupera el idDBR de la jornada");
            }
          }
          return true;
      }
      } catch (e) {
        print('ERROR - function syncAddJornada(): $e');
        return false;
      }
    
    return null;
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

  Future<bool?> syncAddEmprendedores(List<Emprendedores> emprendedores) async {
    for (var i = 0; i < emprendedores.length; i++) {
        try {

        final record = await client.records.create('emprendedores', body: {
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

        if (record.id.isNotEmpty) {
          print("Emprededor created succesfully");
          String idDBR = record.id;

          var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedores[i].id);
          if (updateEmprendedor != null && idDBR != null) {
            print("Entro al if de syncAddEmprendedores");
            print("Previo estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
            }
            updateEmprendedor.idDBR = idDBR;
            dataBase.emprendedoresBox.put(updateEmprendedor);
            print("Actualizacion de estado del Emprendedor");

            var emprendedoresPrueba = dataBase.emprendedoresBox.getAll();
            for (var i = 0; i < emprendedoresPrueba.length; i++) {
            print("Status Emprendedor Prueba: ${emprendedoresPrueba[i].statusSync.target!.status}");  
            print("IDBR Emprendedor Prueba: ${emprendedoresPrueba[i].idDBR}");
            }
            print("Se hace el conteo de la tabla Emprendedores");
            print(dataBase.emprendedoresBox.count());
        }
        }
      } catch (e) {
        print('ERROR - function syncAddEmprendedores(): $e');
        return false;
      }
      
    }
    final updateVariableUser = dataBase.variablesUsuarioBox.get(prefs.getInt("idVariablesUser")!);
    if (updateVariableUser != null) {
      updateVariableUser.emprendedores = true;
      dataBase.variablesUsuarioBox.put(updateVariableUser);
    }
    
    return true;
}

  Future<bool?> syncAddEmprendedor(Emprendedores emprendedor) async {

        print("Estoy en El syncAddEmprendedor");

        try {

        final record = await client.records.create('emprendimientos', body: {
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

        if (record.id.isNotEmpty) {
          String idDBR = record.id;
          print("Emprendedor created succesfully");
          var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
          if (updateEmprendedor != null) {
            print("Entro al if de syncAddEmprendedor");
            print("Previo estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
            }
            updateEmprendedor.idDBR = idDBR;
            dataBase.emprendedoresBox.put(updateEmprendedor);
            print("Recuperacion de idDBR del Emprendedor");

            var emprendedoresPrueba = dataBase.emprendedoresBox.getAll();
            for (var i = 0; i < emprendedoresPrueba.length; i++) {
            print("Status Emprendedor Prueba: ${emprendedoresPrueba[i].statusSync.target!.status}");  
            print("IDBR Emprendedor Prueba: ${emprendedoresPrueba[i].idDBR}");
            }
            print("Se hace el conteo de la tabla Emprendedores");
            print(dataBase.emprendedoresBox.count());
          }
        }

      } catch (e) {
        print('ERROR - function syncAddEmprendedor(): $e');
        return false;
      }

    return true;
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

  Future<bool?> syncAddEmprendimientos(List<Emprendimientos> emprendimientos) async {
    print("Estoy en El syncAddEmprendimientos");
  for (var i = 0; i < emprendimientos.length; i++) {
      try {

      print("ID Promotor: ${emprendimientos[i].usuario.target!.idDBR}");

      final record = await client.records.create('emprendimientos', body: {
          "nombre_emprendimiento": emprendimientos[i].nombre,
          "descripcion": emprendimientos[i].descripcion,
          "imagen": emprendimientos[i].imagen,
          "activo": emprendimientos[i].activo,
          "archivado": emprendimientos[i].archivado,
          "id_comunidad_fk": emprendimientos[i].comunidad.target!.idDBR,
          "id_promotor_fk": emprendimientos[i].usuario.target!.idDBR,
          "id_prioridad_fk": "yuEVuBv9rxLM4cR",
          "id_clasificacion_emp_fk": "N2fgbFPCkb8PwnO",
          "id_proveedor_fk": "",
          "id_fase_emp_fk": "shjfgnobnYBQkUo",
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimientos[i].emprendedor.target!.idDBR,
      });

      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Emprendimiento created succesfully");
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientos[i].id);
        if (updateEmprendimiento != null) {
          print("Previo estado del Emprendimiento: ${updateEmprendimiento.statusSync.target!.status}");
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSync);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
          }
          updateEmprendimiento.idDBR = idDBR;
          dataBase.emprendimientosBox.put(updateEmprendimiento);
          print("Recuperacion de idDBR del Emprendimiento");

          var emprendimientosPrueba = dataBase.emprendimientosBox.getAll();
          for (var i = 0; i < emprendimientosPrueba.length; i++) {
          print("Status Emprendimiento Prueba: ${emprendimientosPrueba[i].statusSync.target!.status}");  
          print("IDBR Emprendimiento Prueba: ${emprendimientosPrueba[i].idDBR}");
          }
        }
      }

    } catch (e) {
      print('ERROR - function syncAddEmprendimientos(): $e');
      return false;
    }
    
  }
  return true;

}

  Future<bool?> syncAddEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncAddEmprendimiento");
      try {

      var url = Uri.parse('$baseUrl/api/collections/emprendimientos/records');

      print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");

      print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

      final record = await client.records.create('emprendimientos', body: {
          "nombre_emprendimiento": emprendimiento.nombre,
          "descripcion": emprendimiento.descripcion,
          "imagen": emprendimiento.imagen,
          "activo": emprendimiento.activo,
          "archivado": emprendimiento.archivado,
          "id_comunidad_fk": emprendimiento.comunidad.target!.idDBR,
          "id_promotor_fk": emprendimiento.usuario.target!.idDBR,
          "id_prioridad_fk": "yuEVuBv9rxLM4cR",
          "id_clasificacion_emp_fk": "N2fgbFPCkb8PwnO",
          "id_proveedor_fk": "",
          "id_fase_emp_fk": "shjfgnobnYBQkUo",
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimiento.emprendedor.target!.idDBR,
      });

      if (record.id.isNotEmpty) {
        String idDBR = record.id;
        print("Emprendimiento created succesfully");
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento != null) {
          print("Previo estado del Emprendimiento: ${updateEmprendimiento.statusSync.target!.status}");
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1";
              dataBase.statusSyncBox.put(statusSync);
              print("Se hace el conteo de la tabla statusSync");
              print(dataBase.statusSyncBox.count());
            }
          updateEmprendimiento.idDBR = idDBR;
          dataBase.emprendimientosBox.put(updateEmprendimiento);
          print("Recuperacion de estado del Emprendimiento");

          var emprendimientosPrueba = dataBase.emprendimientosBox.getAll();
          for (var i = 0; i < emprendimientosPrueba.length; i++) {
          print("Status Emprendimiento Prueba: ${emprendimientosPrueba[i].statusSync.target!.status}");  
          print("IDBR Emprendimiento Prueba: ${emprendimientosPrueba[i].idDBR}");
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }

}


  Future<bool?> syncUpdateEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncUpdateEmprendimiento");
    try {
      print("ID Promotor: ${emprendimiento.usuario.target!.idDBR}");

      print("ID Emprendedor: ${emprendimiento.emprendedor.target!.idDBR}");

      final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
          "nombre_emprendimiento": emprendimiento.nombre,
          "descripcion": emprendimiento.descripcion,
          "imagen": emprendimiento.imagen,
          "activo": emprendimiento.activo,
          "archivado": emprendimiento.archivado,
          "id_comunidad_fk": emprendimiento.comunidad.target!.idDBR,
          "id_promotor_fk": emprendimiento.usuario.target!.idDBR,
          "id_prioridad_fk": "yuEVuBv9rxLM4cR",
          "id_clasificacion_emp_fk": "N2fgbFPCkb8PwnO",
          "id_proveedor_fk": "",
          "id_fase_emp_fk": "shjfgnobnYBQkUo",
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
          "id_emprendedor_fk": emprendimiento.emprendedor.target!.idDBR,
      }); 

      if (record.id.isNotEmpty) {
        print("Emprendimiento updated succesfully");
        var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimiento.id);
        if (updateEmprendimiento  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateEmprendimiento(): $e');
      return false;
    }

  } 
void deleteBitacora() {
  dataBase.bitacoraBox.removeAll();
  notifyListeners();
}
}
