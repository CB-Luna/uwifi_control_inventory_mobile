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
  String comentarios = "";
  String descripcion = "";
  List<String> imagenes = [];
  bool activo = true;
  String tipoProyecto = "";
  String proyecto =  "";

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    // numJornada = '';
    fechaRevision = null;
    fechaRegistro = null;
    tarea = "";
    comentarios = "";
    descripcion = "";
    imagenes = [];
    activo = true;
    tipoProyecto = "";
    proyecto = "";
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
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 1")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add1: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 1
      final nuevaInstruccionJornada = Bitacora(instrucciones: 'syncAddJornada1', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instrucciones: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 1", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
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
      comentarios: comentarios, 
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(imagenes: imagenes[i]); //Se crea el objeto imagenes para la Tarea
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 2")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add2: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 2
      final nuevaInstruccionJornada = Bitacora(instrucciones: 'syncAddJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instrucciones: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 2", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 2 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada2(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, String newComentarios, List<Imagenes>? oldImagenes, List<String> newImagenes, bool newActivo, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada2', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      updateTarea.activo = newActivo;
      //Se eliminan imagenes anteriores
      if (oldImagenes != null) {
        for (var i = 0; i < oldImagenes.length; i++) {
        dataBase.imagenesBox.remove(oldImagenes[i].id);
      }
      }
      //Se agregan las nuevas imagenes
      for (var i = 0; i < newImagenes.length; i++) {
        final nuevaImagenTarea = Imagenes(imagenes: newImagenes[i]); //Se crea el objeto imagenes para la Tarea
        int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
        updateTarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
      }
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      final updateJornada = dataBase.jornadasBox.get(id);
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
    print(dataBase.imagenesBox.getAll().length);
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
      comentarios: comentarios,
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(imagenes: imagenes[i]); //Se crea el objeto imagenes para la Tarea
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 3")).build().findFirst();
    //Se recupera el tipo proyecto y proyecto
    final catalogoProyecto = dataBase.catalogoProyectoBox.get(idCatalogoProyecto);
    if (emprendimiento != null && catalogoProyecto != null && faseEmp != null) {
      print("Fase de Add3: ${faseEmp.fase}");
      final nuevoSyncJornada = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Jornada 3
      final nuevaInstruccionJornada = Bitacora(instrucciones: 'syncAddJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instrucciones: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 3", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Se asigna una catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
      emprendimiento.catalogoProyecto.target = catalogoProyecto;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
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
    String newComentarios, List<String> newImagenes, List<Imagenes>? oldImagenes, int newIdProyecto, String newDescripcion, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada3', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      updateTarea.descripcion = newDescripcion;
      updateTarea.activo = newActivo;
      //Se eliminan imagenes anteriores
      if (oldImagenes != null) {
        for (var i = 0; i < oldImagenes.length; i++) {
        dataBase.imagenesBox.remove(oldImagenes[i].id);
      }
      }
      //Se agregan las nuevas imagenes
      for (var i = 0; i < newImagenes.length; i++) {
        final nuevaImagenTarea = Imagenes(imagenes: newImagenes[i]); //Se crea el objeto imagenes para la Tarea
        int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
        updateTarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
      }
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
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
      comentarios: comentarios,
      activo: activo,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      );
      print("Entro aca");
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(imagenes: imagenes[i]); //Se crea el objeto imagenes para la Tarea
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 4")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      print("Fase de Add4: ${faseEmp.fase}");
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
      final nuevaInstruccionJornada = Bitacora(instrucciones: 'syncAddJornada4', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instrucciones: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 4", usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.statusSync.target = nuevoSyncJornada;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      print('Jornada 4 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada4(int id, DateTime newFechaRegistro, String? newComentarios, List<String> newImagenes, List<Imagenes>? oldImagenes, bool newActivo, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateJornada4', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.comentarios = newComentarios;
      updateTarea.activo = newActivo;
      //Se eliminan imagenes anteriores
      if (oldImagenes != null) {
        for (var i = 0; i < oldImagenes.length; i++) {
        dataBase.imagenesBox.remove(oldImagenes[i].id);
      }
      }
      //Se agregan las nuevas imagenes
      for (var i = 0; i < newImagenes.length; i++) {
        final nuevaImagenTarea = Imagenes(imagenes: newImagenes[i]); //Se crea el objeto imagenes para la Tarea
        int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
        updateTarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
      }
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final statusSyncTarea = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateTarea.statusSync.target!.id)).build().findUnique();
      if (statusSyncTarea != null) {
          statusSyncTarea.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado de la tarea
          dataBase.statusSyncBox.put(statusSyncTarea);
        }
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
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