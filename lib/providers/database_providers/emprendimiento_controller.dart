import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class EmprendimientoController extends ChangeNotifier {
  Emprendimientos? emprendimiento;
  int? idEmprendimiento;
  GlobalKey<FormState> emprendimientoFormKey = GlobalKey<FormState>();

  //Emprendimiento
  Imagenes? imagenLocal;
  String imagen = '';
  String nombre = '';
  String descripcion = '';

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> emprendimientoKey) {
    return emprendimientoKey.currentState!.validate() ? true : false;
  }

  void clearInformation() {
    imagenLocal = null;
    imagen = '';
    nombre = '';
    descripcion = '';
    idEmprendimiento = null;
    emprendimiento = null;
    notifyListeners();
  }

  void add() {
    final faseEmp = dataBase.fasesEmpBox
        .query(FasesEmp_.fase.equals("Inscrito"))
        .build()
        .findFirst(); //Agregamos fase actual al emprendimiento
    if (faseEmp != null) {
      final nuevoEmprendimiento = Emprendimientos(
        faseActual: faseEmp.fase,
        faseAnterior: faseEmp.fase,
        nombre: nombre,
        descripcion: descripcion,
        activo: true,
        archivado: false,
      );
      nuevoEmprendimiento.imagen.target = imagenLocal;
      nuevoEmprendimiento.faseEmp
          .add(faseEmp); //Agregamos fase actual al emprendimiento

      //Agregamos el emprendimiento en objectBox y recuperamos el Id
      idEmprendimiento = dataBase.emprendimientosBox.put(nuevoEmprendimiento);
      emprendimiento = nuevoEmprendimiento;
      final nuevaInstruccion = Bitacora(
          instruccion: 'syncAddEmprendimiento',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: idEmprendimiento ??
              0); //Se crea la nueva instruccion a realizar en bitacora
      nuevoEmprendimiento.bitacora.add(nuevaInstruccion);
      print('Emprendimiento agregado exitosamente');
      notifyListeners();
    }
  }

  void update(int id, String newNombre, String newDescripcion) {
    var updateEmprendimiento = dataBase.emprendimientosBox.get(id);
    final nuevaInstruccion = Bitacora(
        instruccion: 'syncUpdateEmprendimiento',
        usuario: prefs.getString("userId")!,
        idEmprendimiento:
            id); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendimiento != null) {
      updateEmprendimiento.nombre = newNombre;
      updateEmprendimiento.descripcion = newDescripcion;
      updateEmprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(updateEmprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
    notifyListeners();
  }

  void updateImagen(int idImagen, Imagenes newImagen, int idEmprendimiento) {
    if (idImagen != -1) {
      final updateImagen = dataBase.imagenesBox.get(idImagen);
      final nuevaInstruccion = Bitacora(
          instruccion: 'syncUpdateImagenEmprendimiento',
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      if (updateImagen != null) {
        updateImagen.nombre = newImagen.nombre;
        updateImagen.path = newImagen.path;
        updateImagen.base64 = newImagen.base64;
        updateImagen.bitacora.add(nuevaInstruccion);
        dataBase.imagenesBox.put(updateImagen);
        print('Imagen de Emprendimiento actualizada exitosamente');
      }
    } else {
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        final newImagenEmprendimiento = Imagenes(
            imagenes: newImagen.imagenes,
            idEmprendimiento: idEmprendimiento,
            path: newImagen.path,
            base64: newImagen.base64,
            nombre: newImagen.nombre);
        final nuevaInstruccion = Bitacora(
            instruccion: 'syncAddImagenEmprendimiento',
            usuario: prefs.getString("userId")!,
            idEmprendimiento: idEmprendimiento);
        newImagenEmprendimiento.emprendimiento.target = emprendimiento;
        newImagenEmprendimiento.bitacora.add(nuevaInstruccion);
        emprendimiento.imagen.target = newImagenEmprendimiento;
        dataBase.imagenesBox.put(newImagenEmprendimiento);
        dataBase.emprendimientosBox.put(emprendimiento);
        print('Sin Imagen de Emprendimiento actualizada exitosamente');
      }
    }
    notifyListeners();
  }

  void updateName(int id, String newNombre) {
    var updateEmprendimiento = dataBase.emprendimientosBox.get(id);
    final nuevaInstruccion = Bitacora(
        instruccion: 'syncUpdateNameEmprendimiento',
        usuario: prefs.getString("userId")!,
        idEmprendimiento:
            id); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendimiento != null) {
      updateEmprendimiento.nombre = newNombre;
      updateEmprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(updateEmprendimiento);
      print('Nombre de Emprendimiento actualizado exitosamente');
    }
    notifyListeners();
  }

  void updateEmprendedores(int idEmprendimiento, Emprendedores emprendedor) {
    emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    emprendedor.emprendimiento.target = emprendimiento;
    emprendimiento!.emprendedor.target = emprendedor;
    dataBase.emprendimientosBox.put(emprendimiento!);
    notifyListeners();
  }

  void remove(Emprendimientos emprendimiento) {
    dataBase.emprendimientosBox.remove(emprendimiento
        .id); //Se elimina de bitacora la instruccion creada anteriormente
    this.emprendimiento = null;

    notifyListeners();
  }

  void detenerEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox
        .query(FasesEmp_.fase.equals("Detenido"))
        .build()
        .findFirst();
    if (emprendimiento != null && faseEmp != null) {
      final nuevaInstruccionEmprendimiento = Bitacora(
          instruccion: 'syncUpdateFaseEmprendimiento',
          instruccionAdicional: "Detenido",
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseActual = faseEmp.fase;
      emprendimiento.faseEmp.toList().forEach((element) {
        print(element.fase);
      });
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  void reactivarOdesconsolidarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccionEmprendimiento = Bitacora(
          instruccion: 'syncUpdateFaseEmprendimiento',
          instruccionAdicional: emprendimiento.faseAnterior,
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp
          .removeWhere((element) => element.fase == emprendimiento.faseActual);
      emprendimiento.faseActual = emprendimiento.faseAnterior;
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  void consolidarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox
        .query(FasesEmp_.fase.equals("Consolidado"))
        .build()
        .findFirst();
    if (emprendimiento != null && faseEmp != null) {
      final nuevaInstruccionEmprendimiento = Bitacora(
          instruccion: 'syncUpdateFaseEmprendimiento',
          instruccionAdicional: "Consolidado",
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseActual = faseEmp.fase;
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  void archivarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(
          instruccion: 'syncArchivarEmprendimiento',
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado del Emprendimiento
      emprendimiento.archivado = true;
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento archivado exitosamente');
    }
  }

  void desarchivarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(
          instruccion: 'syncDesarchivarEmprendimiento',
          usuario: prefs.getString("userId")!,
          idEmprendimiento:
              idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado del Emprendimiento
      emprendimiento.archivado = false;
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento desarchivado exitosamente');
    }
  }
}
