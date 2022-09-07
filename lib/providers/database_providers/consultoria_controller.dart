import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class ConsultoriaController extends ChangeNotifier {

  List<Consultorias> consultorias = [];

  GlobalKey<FormState> consultoriaFormKey = GlobalKey<FormState>();

  //Consultorias
  DateTime? fechaRevision = DateTime.now();
  String tarea = "";
  String observacion = "";
  String descripcion = "";
  String avanceObservado = "";
  String porcentaje = "";
  String imagen = "";
  bool activo = true;

  bool validateForm(GlobalKey<FormState> consultoriaKey) {
    return consultoriaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    tarea = "";
    observacion = "";
    descripcion = "";
    avanceObservado = "";
    porcentaje = "";
    fechaRevision =  null;
    activo = true;
    imagen = "";
    notifyListeners();
  }

  void add(int idEmprendimiento, int numConsultoria, int idAmbito, int idAreaCirculo) {
    final nuevaConsultoria = Consultorias();
    final nuevaTarea = Tareas(
    tarea: tarea,
    descripcion: "Creación de Consultoría",
    observacion: "Se crea consultoría",
    porcentaje: 1,
    fechaRevision: fechaRevision!);
    //Se agrega la imagen a la Tarea
    final nuevaImagenTarea = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para la Tarea
    nuevaTarea.imagenes.add(nuevaImagenTarea);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Consultoría")).build().findFirst();
    if (faseEmp != null) {
      print("Fase: ${faseEmp.fase}");
    } else {
      print("Hay error en esta fase"); 
    }
    //Se recupera el ambito y el area del circulo
    final ambito = dataBase.ambitoConsultoriaBox.get(idAmbito);
    final areaCirculo = dataBase.areaCirculoBox.get(idAreaCirculo);
    if (emprendimiento != null && ambito != null && areaCirculo != null && faseEmp != null) {
      final nuevoSyncConsultoria = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Consultoria
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddConsultoria', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaConsultoria.statusSync.target = nuevoSyncConsultoria;
      //Se asigna un ambito y un area del circulo a la nuevaConsultoria
      nuevaConsultoria.ambitoConsultoria.target = ambito;
      nuevaConsultoria.areaCirculo.target = areaCirculo;
      nuevaConsultoria.tareas.add(nuevaTarea);
      nuevaConsultoria.emprendimiento.target = emprendimiento;
      nuevaConsultoria.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de consultorias
      emprendimiento.consultorias.add(nuevaConsultoria);
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseEmp.toList().forEach((element) {print(element.fase);});
      dataBase.emprendimientosBox.put(emprendimiento);
      consultorias.add(nuevaConsultoria);
      print('Consultoria agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void updateConsultoria(int id, int idOldTarea) {
    var oldTarea  = dataBase.tareasBox.get(idOldTarea);
    if (oldTarea != null) {
      final nuevaTarea = Tareas(
      tarea: tarea == "" ? oldTarea.tarea : tarea,
      descripcion: "Actualización de Consultoría",
      observacion: observacion,
      porcentaje: int.parse(porcentaje),
      activo: activo,
      fechaRevision: fechaRevision!);
      //Se agrega la imagen a la Tarea
      final nuevaImagenTarea = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para la Tarea
      nuevaTarea.imagenes.add(nuevaImagenTarea);
      var updateConsultoria = dataBase.consultoriasBox.get(id);
      if (updateConsultoria !=  null) {
        //Se agrega la nueva tarea
        updateConsultoria.tareas.add(nuevaTarea);
        final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateConsultoria', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        final statusSyncConsultoria = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateConsultoria.statusSync.target!.id)).build().findUnique();
        if (statusSyncConsultoria != null) {
          statusSyncConsultoria.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la consultoria
          dataBase.statusSyncBox.put(statusSyncConsultoria);
        }
        updateConsultoria.bitacora.add(nuevaInstruccion);
        dataBase.consultoriasBox.put(updateConsultoria);
        print('Consultoria actualizada exitosamente');
        clearInformation(); //Se limpia información para usar el mismo controller en otro registro
        notifyListeners();
      }
    }
  }

  void addTareaConsultoria(int idConsultoria) {
    final nuevaTarea = Tareas(
    tarea: tarea,
    descripcion: descripcion,
    observacion: (observacion == "" || observacion.isEmpty) ? "Comentarios Consultoría" : observacion,
    porcentaje: 1,
    activo: activo,
    fechaRevision: fechaRevision!);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    // final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final updateConsultoria = dataBase.consultoriasBox.get(idConsultoria);
    if (updateConsultoria != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddTareaConsultoria', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se agrega una nueva Tarea a la consultoria
      updateConsultoria.tareas.add(nuevaTarea);
      dataBase.consultoriasBox.put(updateConsultoria);
      consultorias.add(updateConsultoria);
      nuevaTarea.bitacora.add(nuevaInstruccion);
      print('Consultoria actualizada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void updateTareaConsultoria(int idTarea, String newTarea, DateTime newFechaRevision, String newComentarios, String newDescripcion, bool newActivo) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateTareaConsultoria', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.observacion = newComentarios;
      updateTarea.descripcion = newDescripcion;
      updateTarea.activo = newActivo;
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
        statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
        dataBase.statusSyncBox.put(statusSyncTarea);
      }
      updateTarea.bitacora.add(nuevaInstruccion);
      dataBase.tareasBox.put(updateTarea);
      notifyListeners();
      print('Tarea Consultoria actualizada exitosamente');
    }
  }

  void remove(Consultorias consultoria) {
    dataBase.consultoriasBox.remove(consultoria.id);
    notifyListeners(); 
  }

  getAll() {
    consultorias = dataBase.consultoriasBox.getAll();
    notifyListeners();
  }
  
}