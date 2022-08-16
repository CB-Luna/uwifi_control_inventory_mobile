import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class JornadaController extends ChangeNotifier {

  List<Jornadas> jornadas = [];

  GlobalKey<FormState> jornadaFormKey = GlobalKey<FormState>();

  //Jornada
  // String numJornada = '';
  DateTime? fechaRevision = DateTime.now();
  String tarea = "";
  String observacion = "";
  String descripcion = "";
  String imagen = "";

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    // numJornada = '';
    fechaRevision = null;
    tarea = "";
    observacion = "";
    descripcion = "";
    imagen = "";
  }


  void addJornada1(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
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
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }
  void addJornada2(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision!,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: "Creación Jornada 2", 
      observacion: observacion, 
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
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void addJornada3(int idEmprendimiento, int idCatalogoProyecto, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision!,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: descripcion, 
      observacion: observacion, 
      porcentaje: 1, 
      fechaRevision: fechaRevision!,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    //Se recupera el tipo proyecto y proyecto
    final catalogoProyecto = dataBase.catalogoProyectoBox.get(idCatalogoProyecto);
    if (emprendimiento != null) {
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 3
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccion);
      //Se asigna una catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
      emprendimiento.catalogoProyecto.target = catalogoProyecto;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 3 agregada exitosamente');
      
      // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void addJornada4(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: DateTime.now(),
      );
    final nuevaTarea = Tareas(
      tarea: "Creación Jornada 4",
      descripcion: "Creación Jornada 4",
      observacion: "observacion",
      porcentaje: 1,
      fechaRevision: DateTime.now());
      print("Entro aca");
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      print("Entro aca");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 1
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada4', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 4 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
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