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
  String imagen = '';
  String nombre = '';
  String descripcion = '';

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> emprendimientoKey) {
    return emprendimientoKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    descripcion = '';
    idEmprendimiento =  null;
    emprendimiento = null;
    notifyListeners();
  }

  void add() {
    final nuevoEmprendimiento = Emprendimientos(
      imagen: imagen, 
      nombre: nombre,
      descripcion: descripcion,
      activo: true,
      archivado: false,
      );
      final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Inscrito")).build().findFirst(); //Agregamos fase actual al emprendimiento
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      if (faseEmp != null) {
        nuevoEmprendimiento.statusSync.target = nuevoSync;
        nuevoEmprendimiento.faseEmp.add(faseEmp); //Agregamos fase actual al emprendimiento
        nuevoEmprendimiento.bitacora.add(nuevaInstruccion);
        //Agregamos el emprendimiento en objectBox y recuperamos el Id
        idEmprendimiento = dataBase.emprendimientosBox.put(nuevoEmprendimiento);
        emprendimiento = nuevoEmprendimiento;
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Emprendimiento agregado exitosamente');
        notifyListeners();
      }
  }

  void update(int id, String newImagen, String newNombre, String newDescripcion) {
    var updateEmprendimiento = dataBase.emprendimientosBox.get(id);
    final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendimiento != null) {
      updateEmprendimiento.imagen = newImagen;
      updateEmprendimiento.nombre = newNombre;
      updateEmprendimiento.descripcion = newDescripcion;
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      updateEmprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(updateEmprendimiento);
      print('Emprendimiento actualizado exitosamente');

    }
    notifyListeners();
  }

  void updateName(int id, String newNombre) {
    var updateEmprendimiento = dataBase.emprendimientosBox.get(id);
    final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateNameEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendimiento != null) {
      updateEmprendimiento.nombre = newNombre;
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
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
    dataBase.emprendimientosBox.remove(emprendimiento.id); //Se elimina de bitacora la instruccion creada anteriormente
    this.emprendimiento = null;

    notifyListeners(); 
  }

  void detenerEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Detenido")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseEmp.toList().forEach((element) {print(element.fase);});
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  void reactivarOdesconsolidarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp.removeLast();
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

   void consolidarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Consolidado")).build().findFirst();
    if (emprendimiento != null && faseEmp != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza la fase del Emprendimiento
      emprendimiento.faseEmp.add(faseEmp);
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

    void archivarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado del Emprendimiento
      emprendimiento.archivado = true;
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  void desarchivarEmprendimiento(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado del Emprendimiento
      emprendimiento.archivado = false;
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(emprendimiento.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendimiento
        dataBase.statusSyncBox.put(statusSync);
      }
      emprendimiento.bitacora.add(nuevaInstruccion);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Emprendimiento actualizado exitosamente');
    }
  }

  
}