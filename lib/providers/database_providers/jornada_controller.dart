import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_instruccion_imagen_temporal.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
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
  List<SaveImagenesLocal> imagenesLocal = [];
  List<SaveInstruccionImagenTemporal> instruccionesImagenesTemp = [];
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
    imagenesLocal = [];
    instruccionesImagenesTemp = [];
    activo = true;
    tipoProyecto = "";
    proyecto = "";
  }


  void addJornada1(int idEmprendimiento, int numJornada) {
    //print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false, 
      idEmprendimiento: idEmprendimiento,
      );
    final nuevaTarea = Tareas(
      tarea: tarea,
      descripcion: "Creación Jornada 1",
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro, 
      idEmprendimiento: idEmprendimiento);
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 1")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      //print("Fase de Add1: ${faseEmp.fase}");
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada1', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 1", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      //print('Jornada 1 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    //print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada1(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, bool newCompletada, int idTarea, int idEmprendimiento) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada1', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        //print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }


  void addJornada2(int idEmprendimiento, int numJornada) {
    //print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false, 
      idEmprendimiento: idEmprendimiento,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: "Creación Jornada 2", 
      comentarios: comentarios, 
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro, 
      idEmprendimiento: idEmprendimiento,
      );
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64, 
        idEmprendimiento: idEmprendimiento,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 2")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      //print("Fase de Add2: ${faseEmp.fase}");
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada2', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 2", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      //print('Jornada 2 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    //print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada2(int id, DateTime newFechaRegistro, DateTime newFechaRevision, String newTarea, String newComentarios, bool newCompletada, int idTarea, int idEmprendimiento) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada2', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      final updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        //print('Jornada actualizada exitosamente');
      }
    }
    notifyListeners();
  }

  void updateImagenesJornada(Tareas tarea, List<SaveInstruccionImagenTemporal> listInstruccionesImagenesTemp, int idEmprendimiento) {
    for (var i = 0; i < listInstruccionesImagenesTemp.length; i++) {
      switch (listInstruccionesImagenesTemp[i].instruccion) {
        case "syncAddImagenJornada2":
          final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenJornada2', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final nuevaImagenTarea = Imagenes(
            imagenes: listInstruccionesImagenesTemp[i].imagenLocal.path,
            nombre: listInstruccionesImagenesTemp[i].imagenLocal.nombre,
            path: listInstruccionesImagenesTemp[i].imagenLocal.path,
            base64: listInstruccionesImagenesTemp[i].imagenLocal.base64, 
            idEmprendimiento: idEmprendimiento,
            ); //Se crea el objeto imagenes para la Tarea
          nuevaImagenTarea.tarea.target = tarea;
          nuevaImagenTarea.bitacora.add(nuevaInstruccion);
          int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
          tarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
          dataBase.tareasBox.put(tarea);
          continue;
        case "syncUpdateImagenJornada2":
          final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenJornada2', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final updateImagen = dataBase.imagenesBox.get(listInstruccionesImagenesTemp[i].imagenLocal.id!);
          if(updateImagen != null) {
            updateImagen.imagenes = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.nombre = listInstruccionesImagenesTemp[i].imagenLocal.nombre;
            updateImagen.path = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.base64 = listInstruccionesImagenesTemp[i].imagenLocal.base64;
            updateImagen.bitacora.add(nuevaInstruccion);
            dataBase.imagenesBox.put(updateImagen);
            continue;
          } else {
            continue;
          }
        case "syncAddImagenJornada3":
          final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenJornada3', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final nuevaImagenTarea = Imagenes(
            imagenes: listInstruccionesImagenesTemp[i].imagenLocal.path,
            nombre: listInstruccionesImagenesTemp[i].imagenLocal.nombre,
            path: listInstruccionesImagenesTemp[i].imagenLocal.path,
            base64: listInstruccionesImagenesTemp[i].imagenLocal.base64, 
            idEmprendimiento: idEmprendimiento,
            ); //Se crea el objeto imagenes para la Tarea
          nuevaImagenTarea.tarea.target = tarea;
          nuevaImagenTarea.bitacora.add(nuevaInstruccion);
          int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
          tarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
          dataBase.tareasBox.put(tarea);
          continue;
        case "syncUpdateImagenJornada3":
          final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenJornada3', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final updateImagen = dataBase.imagenesBox.get(listInstruccionesImagenesTemp[i].imagenLocal.id!);
          if(updateImagen != null) {
            updateImagen.imagenes = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.nombre = listInstruccionesImagenesTemp[i].imagenLocal.nombre;
            updateImagen.path = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.base64 = listInstruccionesImagenesTemp[i].imagenLocal.base64;
            updateImagen.bitacora.add(nuevaInstruccion);
            dataBase.imagenesBox.put(updateImagen);
            continue;
          } else {
            continue;
          }
        case "syncAddImagenJornada4":
          final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenJornada4', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final nuevaImagenTarea = Imagenes(
            imagenes: listInstruccionesImagenesTemp[i].imagenLocal.path,
            nombre: listInstruccionesImagenesTemp[i].imagenLocal.nombre,
            path: listInstruccionesImagenesTemp[i].imagenLocal.path,
            base64: listInstruccionesImagenesTemp[i].imagenLocal.base64, 
            idEmprendimiento: idEmprendimiento,
            ); //Se crea el objeto imagenes para la Tarea
          nuevaImagenTarea.tarea.target = tarea;
          nuevaImagenTarea.bitacora.add(nuevaInstruccion);
          int idNuevaTarea = dataBase.imagenesBox.put(nuevaImagenTarea);
          tarea.imagenes.add(dataBase.imagenesBox.get(idNuevaTarea)!);
          dataBase.tareasBox.put(tarea);
          continue;
        case "syncUpdateImagenJornada4":
          final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenJornada4', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final updateImagen = dataBase.imagenesBox.get(listInstruccionesImagenesTemp[i].imagenLocal.id!);
          if(updateImagen != null) {
            updateImagen.imagenes = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.nombre = listInstruccionesImagenesTemp[i].imagenLocal.nombre;
            updateImagen.path = listInstruccionesImagenesTemp[i].imagenLocal.path;
            updateImagen.base64 = listInstruccionesImagenesTemp[i].imagenLocal.base64;
            updateImagen.bitacora.add(nuevaInstruccion);
            dataBase.imagenesBox.put(updateImagen);
            continue;
          } else {
            continue;
          }
        case "syncDeleteImagenJornada":
          final deleteImagen = dataBase.imagenesBox.query(Imagenes_.id.equals(listInstruccionesImagenesTemp[i].imagenLocal.id ?? -1)).build().findUnique();
          if(deleteImagen != null) {
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncDeleteImagenJornada', 
              instruccionAdicional: listInstruccionesImagenesTemp[i].instruccionAdicional, 
              usuario: prefs.getString("userId")!,
              idDBR: deleteImagen.idDBR,
              idEmiWeb: deleteImagen.idEmiWeb,
              emprendimiento: deleteImagen.tarea.target!.jornada.target!.emprendimiento.target!.nombre, idEmprendimiento: idEmprendimiento,
            ); //Se crea la nueva instruccion a realizar en bitacora
            deleteImagen.bitacora.add(nuevaInstruccion);
            // Se elimina imagen de ObjectBox
            dataBase.imagenesBox.remove(deleteImagen.id);
            continue;
          } else {
            continue;
          }
        default:
          continue;
      }
    }
  }

  void addJornada3(int idEmprendimiento, int idCatalogoProyecto, int numJornada) {
    //print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false, 
      idEmprendimiento: idEmprendimiento,
      );
    final nuevaTarea = Tareas(
      tarea: tarea, 
      descripcion: descripcion, 
      comentarios: comentarios,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro, 
      idEmprendimiento: idEmprendimiento,
      );
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64, 
        idEmprendimiento: idEmprendimiento,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 3")).build().findFirst();
    //Se recupera el tipo proyecto y proyecto
    final catalogoProyecto = dataBase.catalogoProyectoBox.get(idCatalogoProyecto);
    if (emprendimiento != null && catalogoProyecto != null && faseEmp != null) {
      //print("Fase de Add3: ${faseEmp.fase}");
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada3', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 3", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      //Se asigna una catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
      emprendimiento.catalogoProyecto.target = catalogoProyecto;
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      //print('Jornada 3 agregada exitosamente');
      // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    //print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada3(int id, int idEmprendimiento, DateTime newFechaRegistro, String newTarea, bool newCompletada, DateTime newFechaRevision, 
    String newComentarios, int newIdProyecto, String newDescripcion, int idTarea) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada3', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.fechaRevision = newFechaRevision;
      updateTarea.tarea = newTarea;
      updateTarea.comentarios = newComentarios;
      updateTarea.descripcion = newDescripcion;
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.fechaRevision = newFechaRevision;
        updateJornada.completada = newCompletada;
        dataBase.jornadasBox.put(updateJornada);
        final updateEmprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
        final updateCatalogoProyecto = dataBase.catalogoProyectoBox.get(newIdProyecto);
        if (updateEmprendimiento != null && updateCatalogoProyecto != null) {
          //Se actualiza un catalogoProyecto(Proyecto) al emprendimiento, como por default catalogoProuyecto ya tiene un clasificacion emprendimiento
          updateEmprendimiento.catalogoProyecto.target = updateCatalogoProyecto;
          //Indispensable para que se muestre en la lista de jornadas
          dataBase.emprendimientosBox.put(updateEmprendimiento);
          // Se actualiza el estado del emprendimiento porque se cambia su clasificacionEmp
          updateJornada.bitacora.add(nuevaInstruccion);
          notifyListeners();
          //print('Jornada 3 actualizada exitosamente');
        }
      }
    }
  }

  void addJornada4(int idEmprendimiento, int numJornada) {
    //print("Numero jornada: $numJornada");
    final nuevaJornada = Jornadas(
      numJornada: numJornada.toString(),
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro,
      completada: false, 
      idEmprendimiento: idEmprendimiento,
      );
    final nuevaTarea = Tareas(
      tarea: "Creación Jornada 4",
      descripcion: "Creación Jornada 4",
      comentarios: comentarios,
      fechaRevision: fechaRevision ?? DateTime.now(),
      fechaRegistro: fechaRegistro, 
      idEmprendimiento: idEmprendimiento,
      );
      //print("Entro aca");
    //Se agregan las imagenes a la Tarea
    for (var i = 0; i < imagenes.length; i++) {
      final nuevaImagenTarea = Imagenes(
        imagenes: imagenes[i],
        nombre: imagenesLocal[i].nombre,
        path: imagenesLocal[i].path,
        base64: imagenesLocal[i].base64, 
        idEmprendimiento: idEmprendimiento,
        ); //Se crea el objeto imagenes para la Tarea
      nuevaImagenTarea.tarea.target = nuevaTarea;
      nuevaTarea.imagenes.add(nuevaImagenTarea);
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Jornada 4")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      //print("Fase de Add4: ${faseEmp.fase}");
      // Se actualiza el estado activo de las jornadas anteriores
      jornadas = emprendimiento.jornadas.toList();
      for (var i = 0; i < jornadas.length; i++) {
        jornadas[i].completada = true;
        dataBase.jornadasBox.put(jornadas[i]);
        //print('Jornada ${i + 1} actualizada exitosamente');
      }
      //print("Entro aca");
      final nuevaInstruccionJornada = Bitacora(instruccion: 'syncAddJornada4', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Jornada 4", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      nuevaJornada.tarea.target = nuevaTarea;
      nuevaJornada.emprendimiento.target = emprendimiento;
      nuevaJornada.bitacora.add(nuevaInstruccionJornada);
      nuevaTarea.jornada.target = nuevaJornada;
      //Indispensable para que se muestre en la lista de jornadas
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.jornadas.add(nuevaJornada);
      dataBase.emprendimientosBox.put(emprendimiento);
      jornadas.add(nuevaJornada);
      //print('Jornada 4 agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
    //print("Data base de jornadas: ${dataBase.jornadasBox.getAll().length}");
  }

  void updateJornada4(int id, DateTime newFechaRegistro, String? newComentarios, bool newCompletada, int idTarea, int idEmprendimiento) {
    var updateTarea  = dataBase.tareasBox.get(idTarea);
    if (updateTarea != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateJornada4', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateTarea.fechaRegistro = newFechaRegistro;
      updateTarea.comentarios = newComentarios;
      //Se actualiza la tarea con las nuevas imagenes
      dataBase.tareasBox.put(updateTarea);
      dataBase.tareasBox.put(updateTarea);
      var updateJornada = dataBase.jornadasBox.get(id);
      if (updateJornada !=  null) {
        updateJornada.fechaRegistro = newFechaRegistro;
        updateJornada.completada = newCompletada;
        updateJornada.bitacora.add(nuevaInstruccion);
        dataBase.jornadasBox.put(updateJornada);
        //print('Jornada actualizada exitosamente');
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