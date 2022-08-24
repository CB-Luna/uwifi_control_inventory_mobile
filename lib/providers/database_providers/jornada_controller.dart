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
  DateTime? fechaRegistro = DateTime.now();
  String tarea = "";
  String observacion = "";
  String descripcion = "";
  String imagen = "";
  bool activo = true;

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    // numJornada = '';
    fechaRevision = null;
    fechaRegistro = null;
    tarea = "";
    observacion = "";
    descripcion = "";
    imagen = "";
    activo = true;
  }


  void addJornada1(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevaTarea = Tareas(
      tarea: tarea,
      descripcion: "Creación Jornada 1",
      observacion: "Se crea la jornada 1",
      porcentaje: 1,
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro);
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

  void updateJornada1(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, bool newActivo, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada1', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.activo = newActivo;
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }


  void addJornada2(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: "Creación Jornada 2", 
      observacion: (observacion == "" || observacion.isEmpty) ? "Comentarios Jornada 2" : observacion, 
      porcentaje: 1, 
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    final nuevasImagenesTarea = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    nuevaTarea.image.target = nuevasImagenesTarea;
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

  void updateJornada2(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, String newComentarios, String newImagen, bool newActivo, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.observacion = newComentarios;
      updateTarea.activo = newActivo;
      final imagenTarea = dataBase.imagenesBox.query(Imagenes_.id.equals(updateTarea.image.target!.id)).build().findUnique();
      if (imagenTarea != null) {
          imagenTarea.imagenes = newImagen; //Se actualiza la imagen de la tarea
          dataBase.imagenesBox.put(imagenTarea);
        }
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }

  void addJornada3(int idEmprendimiento, int idCatalogoProyecto, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: descripcion, 
      observacion: (observacion == "" || observacion.isEmpty) ? "Comentarios Jornada 3" : observacion, 
      porcentaje: 1, 
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    final nuevasImagenesTarea = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    nuevaTarea.image.target = nuevasImagenesTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    //Se recupera el tipo proyecto y proyecto
    final catalogoProyecto = dataBase.catalogoProyectoBox.get(idCatalogoProyecto);
    if (emprendimiento != null && catalogoProyecto != null) {
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

  void updateJornada3(int id, int idEmprendimiento, DateTime newFechaRegistro, String newTarea, bool newActivo, DateTime newFechaRevision, 
    String newComentarios, String newImagen, int newIdProyecto, String newDescripcion, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.observacion = newComentarios;
      updateTarea.descripcion = newDescripcion;
      updateTarea.activo = newActivo;
      final imagenTarea = dataBase.imagenesBox.query(Imagenes_.id.equals(updateTarea.image.target!.id)).build().findUnique();
      if (imagenTarea != null) {
          imagenTarea.imagenes = newImagen; //Se actualiza la imagen de la tarea
          dataBase.imagenesBox.put(imagenTarea);
        }
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
        statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
        dataBase.statusSyncBox.put(statusSyncTarea);
      }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateJornada.statusSync.target!.id)).build().findUnique();
        if (statusSyncJornada != null) {
          statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la jornada
          dataBase.statusSyncBox.put(statusSyncJornada);
        }
        dataBase.jornadasBox.put(updateJornada);
        final updateEmprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
        final updateCatalogoProyecto = dataBase.catalogoProyectoBox.get(newIdProyecto);
        if (updateEmprendimiento != null && updateCatalogoProyecto != null) {
          //Se actualiza un catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
          updateEmprendimiento.catalogoProyecto.target = updateCatalogoProyecto;
          //Indispensable para que se muestre en la lista de jornadas
          dataBase.emprendimientosBox.put(updateEmprendimiento);
          // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
          final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
          if (statusSync != null) {
            statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
            dataBase.statusSyncBox.put(statusSync);
          }
          updateJornada.bitacora.add(nuevaInstruccion);
          notifyListeners();
          print('Jornada 3 actualizada exitosamente');
        }
      }
    }
  }

  void addJornada4(int idEmprendimiento, int numJornada) {
    print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevaTarea = Tareas(
      tarea: "Creación Jornada 4",
      descripcion: "Creación Jornada 4",
      observacion: (observacion == "" || observacion.isEmpty) ? "Comentarios Jornada 4" : observacion,
      porcentaje: 1,
      activo: false,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
      print("Entro aca");
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      // Se actualiza el estado activo de las tareas de las jornadas anteriores
      jornadas = emprendimiento.jornadas.toList();
      for (var i = 0; i < jornadas.length; i++) {
        var updateTarea = jornadas[i].tarea.target;
        if (updateTarea != null) {
          updateTarea.activo = false;
          final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(jornadas[i].tarea.target!.statusSync.target!.id)).build().findUnique();
          if (statusSyncTarea != null) {
              statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
              dataBase.statusSyncBox.put(statusSyncTarea);
            }
          dataBase.tareasBox.put(updateTarea);
        }
        print('Tarea de jornada ${i + 1} actualizada exitosamente');
      }
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