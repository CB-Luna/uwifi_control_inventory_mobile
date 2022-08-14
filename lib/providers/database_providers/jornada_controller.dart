import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class JornadaController extends ChangeNotifier {

  List<Jornadas> jornadas = [];

  GlobalKey<FormState> jornadaFormKey = GlobalKey<FormState>();

  //Jornada
  String numJornada = '';
  DateTime? fechaRevision = DateTime.now();
  String tarea = "";
  String obervacion = "";
  String descripcion = "";
  String imagen = "";

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    numJornada = '';
    fechaRevision = null;
    tarea = "";
  }


  void addJornada1(int idEmprendimiento) {
    final nuevaJornada = Jornadas(
      numJornada: numJornada,
      fechaRevision: fechaRevision!,
      );
    final nuevaTarea = Tareas(
      tarea: tarea,
      descripcion: "Creación Jornada 1",
      observacion: "Se crea la jornada 1",
      porcentaje: 1,
      fechaRevision: fechaRevision!);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 1
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada1', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 1 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }
  void addJornada2(int idEmprendimiento) {
    final nuevaJornada = Jornadas(
      numJornada: numJornada,
      fechaRevision: fechaRevision!,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: "Creación Jornada 2", 
      observacion: obervacion, 
      porcentaje: 1, 
      fechaRevision: fechaRevision!,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 2
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 2 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void addJornada3(int idEmprendimiento, int idClasificacionEmp, int idFamiliaInversion) {
    final nuevaJornada = Jornadas(
      numJornada: numJornada,
      fechaRevision: fechaRevision!,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: descripcion, 
      observacion: obervacion, 
      porcentaje: 1, 
      fechaRevision: fechaRevision!,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    //Se recupera el tipo proyecto y proyecto
    final clasificacionEmp = dataBase.clasificacionesEmpBox.get(idClasificacionEmp);
    final familiaInversion = dataBase.familiaInversionBox.get(idFamiliaInversion);
    if (emprendimiento != null) {
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 3
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.jornadas.add(nuevaJornada);
      //Se asigna una clasificacionEmp(Tipo Proyecto) al emprendimiento
      emprendimiento.clasificacionEmp.target = clasificacionEmp;
      // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 3 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void remove(Jornadas jornada) {
    dataBase.jornadasBox.remove(jornada.id);
    notifyListeners(); 
  }

  getAll() {
    jornadas = dataBase.jornadasBox.getAll();
    notifyListeners();
  }

  void getJornadasActualUser(List<Emprendimientos> emprendimientos) {
    jornadas = [];
    emprendimientos.forEach((element) {
      element.jornadas.forEach(
        (element) {jornadas.add(element);
        });
    });
  }
  void getJornadasByEmprendimiento(Emprendimientos emprendimiento) {
    jornadas = [];
    jornadas = emprendimiento.jornadas.toList();
  }
  
}