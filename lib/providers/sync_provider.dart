import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/models/get_prod_cotizados.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:bizpro_app/util/util.dart';


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
          break;
        case "syncAddEmprendedor":
          print("${dataBase.emprendedoresBox.getAll().length}");
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
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
        case "syncUpdateNameEmprendimiento":
          final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
          if(emprendimientoToSync != null){
            if(emprendimientoToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (emprendimientoToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateNameEmprendimiento(emprendimientoToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncUpdateEmprendedor":
          final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
          if(emprendedorToSync != null){
            if(emprendedorToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (emprendedorToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateEmprendedor(emprendedorToSync);
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
            
            await syncAddJornada12y4(jornadaToSync);
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
            
            await syncAddJornada12y4(jornadaToSync);
          } 
          }         
          break;
        case "syncAddJornada3":
          print("Entro aqui");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddJornada3(jornadaToSync);
          } 
          }         
          break;
        case "syncAddJornada4":
          print("Entro aqui");
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddJornada12y4(jornadaToSync);
          } 
          }         
          break;
        case "syncUpdateJornada1":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada1(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncUpdateJornada2":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada2(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncUpdateJornada3":
          final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
          if(jornadaToSync != null){
            if(jornadaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (jornadaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateJornada3(jornadaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncAddConsultoria":
          print("Entro aqui");
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            if(consultoriaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddConsultoria(consultoriaToSync);
          } 
          }         
          break;
        case "syncUpdateConsultoria":
          final consultoriaToSync = getFirstConsultoria(dataBase.consultoriasBox.getAll(), instruccionesBitacora[i].id);
          if(consultoriaToSync != null){
            if(consultoriaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (consultoriaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateConsultoria(consultoriaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }  
          break;
        case "syncAddTareaConsultoria":
          print("Entro aqui");
          final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if(tareaToSync != null){
            if(tareaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddTareaConsultoria(tareaToSync);
          } 
          }         
          break;
        case "syncUpdateTareaConsultoria":
          final tareaToSync = getFirstTarea(dataBase.tareasBox.getAll(), instruccionesBitacora[i].id);
          if(tareaToSync != null){
            if(tareaToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (tareaToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateTareaConsultoria(tareaToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }
          break;
        case "syncUpdateUsuario":
          final usuarioToSync = getFirstUsuario(dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if(usuarioToSync != null){
            if(usuarioToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
              print("Entro aqui en el if");
              break;
            } else {
              print("Entro aqui en el else");
              if (usuarioToSync.idDBR != null) {
                print("Ya ha sido enviado al backend");
                syncUpdateUsuario(usuarioToSync);
              } else {
                print("No ha sido enviado al backend");
              }
            }   
          }
          break;
        case "syncAddInversion":
          print("Entro aqui");
          final inversionToSync = getFirstInversion(dataBase.inversionesBox.getAll(), instruccionesBitacora[i].id);
          if(inversionToSync != null){
            if(inversionToSync.statusSync.target!.status == "HoI36PzYw1wtbO1") {
            print("Entro aqui en el if");
            break;
          } else {
            print("Entro aqui en el else");
            
            await syncAddInversion(inversionToSync);
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

  Usuarios? getFirstUsuario(List<Usuarios> usuarios, int idInstruccionesBitacora)
  {
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < usuarios[i].bitacora.length; j++) {
          if (usuarios[i].bitacora[j].id == idInstruccionesBitacora) {
            return usuarios[i];
          } 
        }
      }
    }
    return null;
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
  Inversiones? getFirstInversion(List<Inversiones> inversiones, int idInstruccionesBitacora)
  {
    for (var i = 0; i < inversiones.length; i++) {
      if (inversiones[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < inversiones[i].bitacora.length; j++) {
          if (inversiones[i].bitacora[j].id == idInstruccionesBitacora) {
            return inversiones[i];
          } 
        }
      }
    }
    return null;
  }
  Consultorias? getFirstConsultoria(List<Consultorias> consultorias, int idInstruccionesBitacora)
  {
    for (var i = 0; i < consultorias.length; i++) {
      if (consultorias[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < consultorias[i].bitacora.length; j++) {
          if (consultorias[i].bitacora[j].id == idInstruccionesBitacora) {
            return consultorias[i];
          } 
        }
      }
    }
    return null;
  }
  Tareas? getFirstTarea(List<Tareas> tareas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < tareas.length; i++) {
        if (tareas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < tareas[i].bitacora.length; j++) {
            if (tareas[i].bitacora[j].id == idInstruccionesBitacora) {
              return tareas[i];
            } 
          }
        }
      }
      return null;
    }
  Future<bool?> syncAddJornada12y4(Jornadas jornada) async {
    print("Estoy en syncAddJornada12y4");
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
          // if (jornada.numJornada == "2") {
          //   print("Lo que se mandan al backends en image: ${tareaToSync.image.target!.imagenes}");
          //   //Luego se mandan las imagenes al backend
          //   await client.records.create('image_test', body: {
          //     "image": tareaToSync.image.target!.imagenes,
          //   });
          // }
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
        print('ERROR - function syncAddJornada12y4(): $e');
        return false;
      }
    
    return null;
}

  Future<bool?> syncAddJornada3(Jornadas jornada) async {
    print("Estoy en syncAddJornada3");
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
          //Luego se mandan las imagenes al backend
          // await client.records.create('image_test', body: {
          //   "image": tareaToSync.image.target!.imagenes,
          // });
          //Segundo actualizamos el catalogoProyecto del emprendimiento
          final emprendimiento = dataBase.emprendimientosBox.query(Emprendimientos_.id.equals(jornada.emprendimiento.target!.id)).build().findUnique();
          if (emprendimiento != null) {
            final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
              "id_nombre_proyecto_fk": emprendimiento.catalogoProyecto.target!.idDBR,
              "id_status_sync_fk": "HoI36PzYw1wtbO1",
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
        print('ERROR - function syncAddJornada3(): $e');
        return false;
      }
    
    return null;
}


  Future<bool?> syncAddConsultoria(Consultorias consultoria) async {
    print("Estoy en syncAddConsultoria");
    final tareaToSync = consultoria.tareas.last;
    try {
    //Primero creamos las tareas asociadas a la consultoria
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

      //Segundo actualizamos el ambito de la consultoria
      //   final record = await client.records.update('emprendimientos', consultoria.idDBR.toString(), body: {
      //     "id_nombre_proyecto_fk": consultoria.catalogoProyecto.target!.idDBR,
      //     "id_status_sync_fk": "HoI36PzYw1wtbO1",
      //   }); 
      //   if (record.id.isNotEmpty) {
      //   print("Consultoria updated succesfully");
      //   var updateEmprendimiento = dataBase.emprendimientosBox.get(consultoria.id);
      //   if (updateEmprendimiento != null) {
      //     final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
      //     if (statusSync != null) {
      //       statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
      //       dataBase.statusSyncBox.put(statusSync);
      //   }
      // }
      // }
    //Tercero creamos la consultoria
    final recordConsultoria = await client.records.create('consultorias', body: {
      "id_emprendimiento_fk": consultoria.emprendimiento.target!.idDBR,
      "id_tarea_fk": recordTarea.id,
      "id_status_sync_fk": "HoI36PzYw1wtbO1",
    });

    if (recordConsultoria.id.isNotEmpty) {
      //Se actualiza el estado de la consultoria
      String idDBRConsultoria = recordConsultoria.id;
      final statusSyncConsultoria = dataBase.statusSyncBox.query(StatusSync_.id.equals(consultoria.statusSync.target!.id)).build().findUnique();
      if (statusSyncConsultoria != null) {
        statusSyncConsultoria.status = "HoI36PzYw1wtbO1";
        dataBase.statusSyncBox.put(statusSyncConsultoria);
        print("Se hace el conteo de la tabla statusSync");
        print(dataBase.statusSyncBox.count());
        print("Actualizacion de estado de la Consultoria");
      }
      //Se recupera el idDBR de la consultoria
      final updateConsultoria = dataBase.consultoriasBox.query(Consultorias_.id.equals(consultoria.id)).build().findUnique();
      if (updateConsultoria != null) {
        updateConsultoria.idDBR = idDBRConsultoria;
        dataBase.consultoriasBox.put(updateConsultoria);
        print("Se recupera el idDBR de la consultoria");
      }
    }
    return true;
      } catch (e) {
        print('ERROR - function syncAddConsultoria(): $e');
        return false;
      }
    
    return null;
}

 Future<bool?> syncAddTareaConsultoria(Tareas tarea) async {
    print("Estoy en syncAddTareaConsultoria");
        final tareaToSync = dataBase.tareasBox.query(Tareas_.id.equals(tarea.id)).build().findUnique();
        List<String> updateListIdTareas = [];
        final updateTareasToSync = tarea.consultoria.target!.tareas.toList();
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
            //Segundo actualizamos la consultoria  
            for (var i = 0; i < updateTareasToSync.length; i++) {
              if (updateTareasToSync[i].idDBR != null) {
                updateListIdTareas.add(updateTareasToSync[i].idDBR!);
              }
            }
            updateListIdTareas.add(idDBRTarea);
            final recordConsultoria = await client.records.update('consultorias', tareaToSync.consultoria.target!.idDBR.toString() , body: {
              "id_tarea_fk": jsonEncode(updateListIdTareas),
              "id_status_sync_fk": "HoI36PzYw1wtbO1",
            });
            if (recordConsultoria.id.isNotEmpty) {
              print("Se agrega éxitosamente la nueva Tarea en consultoría");
            }
          }

          return true;
      }
      } catch (e) {
        print('ERROR - function syncAddTareaConsultoria(): $e');
        return false;
      }
    
    return null;
}


  Future<bool?> syncAddEmprendedor(Emprendedores emprendedor) async {
    print("Estoy en El syncAddEmprendedor");
    try {
      //Primero creamos el emprendedor asociado al emprendimiento
      final recordEmprendedor = await client.records.create('emprendedores', body: {
          "nombre_emprendedor": emprendedor.nombre,
          "apellidos_emp": emprendedor.apellidos,
          "nacimiento": "1995-06-21", //TODO Validar Formato Nacimiento
          "curp": emprendedor.curp,
          "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
          "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
          "telefono": emprendedor.telefono,
          "comentarios": emprendedor.comentarios,
          "id_emprendimiento_fk": "",
          "id_status_sync_fk": "HoI36PzYw1wtbO1"
      });

      if (recordEmprendedor.id.isNotEmpty) {
        String idDBR = recordEmprendedor.id;
        print("Emprendedor created succesfully");
        var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
        if (updateEmprendedor != null) {
          print("Entro al if de syncAddEmprendedor");
          print("Previo estado del Emprendedor: ${updateEmprendedor.statusSync.target!.status}");
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
          //Se actualiza el estado del emprendedor
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSync);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
          }
          //Se recupera el idDBR del emprendedor
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
        //Segundo creamos el emprendimiento
        final emprendimientoToSync = dataBase.emprendimientosBox.query(Emprendimientos_.emprendedor.equals(emprendedor.id)).build().findUnique();
        if (emprendimientoToSync != null) {
          final recordEmprendimiento = await client.records.create('emprendimientos', body: {
            "nombre_emprendimiento": emprendimientoToSync.nombre,
            "descripcion": emprendimientoToSync.descripcion,
            "imagen": emprendimientoToSync.imagen,
            "activo": emprendimientoToSync.activo,
            "archivado": emprendimientoToSync.archivado,
            "id_comunidad_fk": emprendimientoToSync.comunidad.target!.idDBR,
            "id_promotor_fk": emprendimientoToSync.usuario.target!.idDBR,
            "id_prioridad_fk": "yuEVuBv9rxLM4cR",
            "id_nombre_proyecto_fk": "xXVloemN098DiKW",
            "id_proveedor_fk": "",
            "id_fase_emp_fk": "shjfgnobnYBQkUo",
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
            "id_emprendedor_fk": emprendimientoToSync.emprendedor.target!.idDBR,
          });
          if (recordEmprendimiento.id.isNotEmpty) {
            String idDBR = recordEmprendimiento.id;
            print("Emprendimiento created succesfully");
            var updateEmprendimiento = dataBase.emprendimientosBox.get(emprendimientoToSync.id);
            if (updateEmprendimiento != null) {
              print("Previo estado del Emprendimiento: ${updateEmprendimiento.statusSync.target!.status}");
              final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
              //Se actualiza el estado del emprendimiento
              if (statusSync != null) {
                statusSync.status = "HoI36PzYw1wtbO1";
                dataBase.statusSyncBox.put(statusSync);
                print("Se hace el conteo de la tabla statusSync");
                print(dataBase.statusSyncBox.count());
              }
              //Se recupera el idDBR del emprendimiento
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
          return true;
        }
      }

  } catch (e) {
    print('ERROR - function syncAddEmprendedor(): $e');
    return false;
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
          "id_nombre_proyecto_fk": "xXVloemN098DiKW",
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

  Future<bool?> syncUpdateNameEmprendimiento(Emprendimientos emprendimiento) async {

    print("Estoy en El syncUpdateNameEmprendimiento");
    try {

      final record = await client.records.update('emprendimientos', emprendimiento.idDBR.toString(), body: {
        "nombre_emprendimiento": emprendimiento.nombre,
        "id_status_sync_fk": "HoI36PzYw1wtbO1",
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
      print('ERROR - function syncUpdateNameEmprendimiento(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateEmprendedor(Emprendedores emprendedor) async {

    print("Estoy en El syncUpdateEmprendedor");
    try {
      print("ID Emprendedor: ${emprendedor.idDBR}");

      final record = await client.records.update('emprendedores', emprendedor.idDBR.toString(), body: {
          "nombre_emprendedor": emprendedor.nombre,
          "apellidos_emp": emprendedor.apellidos,
          "nacimiento": "1995-06-21", //TODO Validar Formato Nacimiento
          "curp": emprendedor.curp,
          "integrantes_familia": int.parse(emprendedor.integrantesFamilia),
          "id_comunidad_fk": emprendedor.comunidad.target!.idDBR,
          "telefono": emprendedor.telefono,
          "comentarios": emprendedor.comentarios,
          "id_status_sync_fk": "HoI36PzYw1wtbO1",
      }); 

      if (record.id.isNotEmpty) {
        print("Emprendedor updated succesfully");
        var updateEmprendedor = dataBase.emprendedoresBox.get(emprendedor.id);
        if (updateEmprendedor  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendedor
            dataBase.statusSyncBox.put(statusSync);
          }
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateEmprendedor(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada1(Jornadas jornada) async {
    print("Estoy en El syncUpdatJornada1");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada1(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada2(Jornadas jornada) async {
    print("Estoy en El syncUpdatJornada2");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "observacion": updateTarea.observacion,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada2(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateJornada3(Jornadas jornada) async {
    print("Estoy en El syncUpdateJornada3");
    try {
      //Primero actualizamos la tarea
      final updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (updateTarea != null) {
        final recordTarea = await client.records.update('tareas', updateTarea.idDBR.toString(), body: {
        "tarea": updateTarea.tarea,
        "observacion": updateTarea.observacion,
        "descripcion": updateTarea.descripcion,
        "fecha_revision": updateTarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
        });
        if (recordTarea.id.isNotEmpty) {
          print("Tarea updated succesfully");
          var updateTarea = dataBase.tareasBox.get(jornada.tarea.target!.id);
          if (updateTarea  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        //Segundo actualizamos la jornada
        final recordJornada = await client.records.update('jornadas', jornada.idDBR.toString(), body: {
            "proxima_visita": jornada.fechaRevision.toUtc().toString(),
            "id_status_sync_fk": "HoI36PzYw1wtbO1",
        }); 

        if (recordJornada.id.isNotEmpty) {
          print("Jornada updated succesfully");
          var updateJornada = dataBase.jornadasBox.get(jornada.id);
          if (updateJornada  != null) {
            final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
            if (statusSync != null) {
              statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la jornada
              dataBase.statusSyncBox.put(statusSync);
            }
          }
        }
        else{
          return false;
        }
      }
      else{
        return false;
      }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateJornada3(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateConsultoria(Consultorias consultoria) async {
    print("Estoy en El syncUpdateConsultoria");
    try {
        //Actualizamos sólo la consultoria
        // final recordConsultoria = await client.records.update('consultorias', consultoria.idDBR.toString(), body: {
        //     "proxima_visita": consultoria.fechaRevision.toUtc().toString(),
        //     "id_status_sync_fk": "HoI36PzYw1wtbO1",
        // }); 

        // if (recordConsultoria.id.isNotEmpty) {
        //   print("Consultoria updated succesfully");
        //   var updateConsultoria = dataBase.consultoriasBox.get(consultoria.id);
        //   if (updateConsultoria != null) {
        //     final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateConsultoria.statusSync.target!.id)).build().findUnique();
        //     if (statusSync != null) {
        //       statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado de la consultoria
        //       dataBase.statusSyncBox.put(statusSync);
        //     }
        //   // }
        // }
        // else{
        //   return false;
        // }
      return true;

    } catch (e) {
      print('ERROR - function syncUpdateConsultoria(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateTareaConsultoria(Tareas tarea) async {

    print("Estoy en El syncUpdateTareaConsultoria");
    try {

      final record = await client.records.update('tareas', tarea.idDBR.toString(), body: {
        "tarea": tarea.tarea,
        "descripcion": tarea.descripcion,
        "observacion": tarea.observacion,
        "porcentaje": tarea.porcentaje,
        "fecha_revision": tarea.fechaRevision.toUtc().toString(),
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
      }); 

      if (record.id.isNotEmpty) {
        print("Tarea updated succesfully");
        var updateTarea = dataBase.emprendimientosBox.get(tarea.id);
        if (updateTarea  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
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
      print('ERROR - function syncUpdateTareaConsultoria(): $e');
      return false;
    }

  } 

  Future<bool?> syncUpdateUsuario(Usuarios usuario) async {
    print("Estoy en El syncUpdateUsuario");
    try {

      final record = await client.records.update('emi_users', usuario.idDBR.toString(), body: {
        "nombre_usuario": usuario.nombre,
        "apellido_p": usuario.apellidoP,
        "apellido_m": usuario.apellidoM,
        "telefono": usuario.telefono,
        "id_rol_fk": usuario.rol.target!.idDBR,
        "avatar": usuario.image.target?.imagenes,
        "id_status_sync_fk": "HoI36PzYw1wtbO1"
      }); 

      if (record.id.isNotEmpty) {
        print("usuario updated succesfully");
        var updateUsuario = dataBase.usuariosBox.get(usuario.id);
        if (updateUsuario  != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateUsuario.statusSync.target!.id)).build().findUnique();
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
      print('ERROR - function syncUpdateUsuario(): $e');
      return false;
    }

  } 
void deleteBitacora() {
  dataBase.bitacoraBox.removeAll();
  notifyListeners();
}

  Future<bool?> syncAddInversion(Inversiones inversion) async {
    try {
      print("Estoy en syncAddInversion");
      //Primero creamos la inversion  
      //Se busca el estado de inversión 'En cotización'
      final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("En cotización")).build().findFirst();
      if (newEstadoInversion != null) {
        print("Datos inversion");
        print(inversion.estadoInversion);
        print(inversion.porcentajePago);
        print(inversion.montoPagar);
        final recordInversion = await client.records.create('inversiones', body: {
          "id_emprendimiento_fk": inversion.emprendimiento.target!.idDBR,
          "id_estado_inversion_fk": newEstadoInversion.idDBR,
          "porcentaje_pago": inversion.porcentajePago,
          "monto_pagar": inversion.montoPagar,
          "saldo": inversion.saldo,
          "total_inversion": inversion.totalInversion,
          "inversion_recibida": true,
          "pago_recibido": false,
          "producto_entregado": false
        });

        if (recordInversion.id.isNotEmpty) {
          //Se actualiza el estado de la inversion
          String idDBRInversion = recordInversion.id;
          final statusSyncInversion = dataBase.statusSyncBox.query(StatusSync_.id.equals(inversion.statusSync.target!.id)).build().findUnique();
          if (statusSyncInversion != null) {
            statusSyncInversion.status = "HoI36PzYw1wtbO1";
            dataBase.statusSyncBox.put(statusSyncInversion);
            print("Se hace el conteo de la tabla statusSync");
            print(dataBase.statusSyncBox.count());
            print("Actualizacion de estado de la inversion");
          }
          //Se recupera el idDBR de la inversion y el estado-inversion de la misma
          final updateInversion = dataBase.inversionesBox.query(Inversiones_.id.equals(inversion.id)).build().findUnique();
          if (updateInversion != null) {
            updateInversion.idDBR = idDBRInversion;
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
            print("Se recupera el idDBR de la inversion y su estado-inversión");
          }
        }
        //Segundo creamos los productos solicitados asociados a la inversion
        //Se recupera la inversion con los últimos cambios
        final actualInversion = dataBase.inversionesBox.get(inversion.id);
        if (actualInversion != null) {
          final prodSolicitadosToSync = actualInversion.prodSolicitados.toList();
          if (prodSolicitadosToSync.isNotEmpty) {  
            for (var i = 0; i < prodSolicitadosToSync.length; i++) {
              print("Datos Prod Solicitados");
              print(prodSolicitadosToSync[i].producto);
              print(prodSolicitadosToSync[i].cantidad);
              print(prodSolicitadosToSync[i].costoEstimado);
              final recordProdSolicitado = await client.records.create('productos_solicitados', body: {
                "producto": prodSolicitadosToSync[i].producto,
                "marca_sugerida": prodSolicitadosToSync[i].marcaSugerida,
                "descripcion": prodSolicitadosToSync[i].descripcion,
                "proveedo_sugerido": prodSolicitadosToSync[i].proveedorSugerido,
                "cantidad": prodSolicitadosToSync[i].cantidad,
                "costo_estimado": prodSolicitadosToSync[i].costoEstimado,
                "id_familia_prod_fk": prodSolicitadosToSync[i].familiaProducto.target!.idDBR,
                "id_tipo_empaques_fk": prodSolicitadosToSync[i].tipoEmpaques.target!.idDBR,
                "id_inversion_fk": prodSolicitadosToSync[i].inversion.target!.idDBR,
              });
              if (recordProdSolicitado.id.isNotEmpty) {
              //Se actualiza el estado del prod Solicitado
              String idDBRProdSolicitado = recordProdSolicitado.id;
              final statusSyncProdSolicitado = dataBase.statusSyncBox.query(StatusSync_.id.equals(prodSolicitadosToSync[i].statusSync.target!.id)).build().findUnique();
              if (statusSyncProdSolicitado != null) {
                statusSyncProdSolicitado.status = "HoI36PzYw1wtbO1";
                dataBase.statusSyncBox.put(statusSyncProdSolicitado);
                print("Se hace el conteo de la tabla statusSync");
                print(dataBase.statusSyncBox.count());
                print("Actualizacion de estado del Prod Solicitado");
              }
              //Se recupera el idDBR del prod Solicitado
              final updateProdSolicitado = dataBase.productosSolicitadosBox.query(ProdSolicitado_.id.equals(prodSolicitadosToSync[i].id)).build().findUnique();
              if (updateProdSolicitado != null) {
                updateProdSolicitado.idDBR = idDBRProdSolicitado;
                dataBase.productosSolicitadosBox.put(updateProdSolicitado);
                print("Se recupera el idDBR del Prod Solicitado");
              }
              }
            }
          }
        }
      }
      } catch (e) {
        print('ERROR - function syncAddInversion(): $e');
        return false;
      }
    
    return null;
}
//TODO VALIDAR QUE HAYA INFO EN EK BACKEND
  Future<bool> validateLengthCotizacion(Inversiones inversion) async {
    print("Id Inversion: ${inversion.idDBR}");
    final records = await client.records.
    getFullList('productos_cotizados', batch: 200, sort: '+producto', filter: "id_inversion_fk='${inversion.idDBR}'");
    if (records.isEmpty) {
      return false;
    } else {
      print("No está vacio");
      print("tamaño: ${records.length}");
      return true;
    }
  }

  Future<void> getCotizacion(Emprendimientos emprendimiento, Inversiones inversion) async {
    //obtenemos los productos cotizados
    print("Tamaño ProdCotizados al principio: ${dataBase.productosCotBox.getAll().length}");
    final records = await client.records.
    getFullList('productos_cotizados', batch: 200, sort: '+producto', filter: "id_inversion_fk='${inversion.idDBR}'");
    final List<GetProdCotizados> listProdCotizados = [];
    for (var element in records) {
      listProdCotizados.add(getProdCotizadosFromMap(element.toString()));
    }
    listProdCotizados.sort((a, b) => removeDiacritics(a.producto).compareTo(removeDiacritics(b.producto)));
    print("****Informacion productos cotizados****");
    print(records.length);
    for (var i = 0; i < records.length; i++) {
      print(listProdCotizados[i].producto);
      if (listProdCotizados[i].id.isNotEmpty) {
      final nuevoProductoCotizado = ProdCotizados(
      producto: listProdCotizados[i].producto,
      cantidad: listProdCotizados[i].cantidad,
      costo: listProdCotizados[i].costoTotal,
      estado: listProdCotizados[i].estado,
      idDBR: listProdCotizados[i].id,
      );
      final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
      nuevoProductoCotizado.statusSync.target = nuevoSync;
      nuevoProductoCotizado.inversion.target = inversion;
      dataBase.productosCotBox.put(nuevoProductoCotizado);
      inversion.prodCotizados.add(nuevoProductoCotizado);
      dataBase.inversionesBox.put(inversion);
      print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
      print('Prod Cotizado agregado exitosamente');
      print("Tamaño ProdCotizados al final: ${dataBase.productosCotBox.getAll().length}");
      }
    }
    //Se actualiza el estado de la inversión
    final newEstadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Cotizada")).build().findFirst();
    if (newEstadoInversion != null) {
      final record = await client.records.update('inversiones', inversion.idDBR.toString(), body: {
        "id_estado_inversion_fk": newEstadoInversion.idDBR,
      }); 
      if (record.id.isNotEmpty) {
      print("Inversion updated succesfully");
      var updateInversion = dataBase.inversionesBox.get(inversion.id);
      if (updateInversion != null) {
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateInversion.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "HoI36PzYw1wtbO1"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
            updateInversion.estadoInversion.target = newEstadoInversion;
            dataBase.inversionesBox.put(updateInversion);
          }
        }
      }
    }
    procesoterminado = true;
    procesocargando = false;
    notifyListeners();
  }
}
