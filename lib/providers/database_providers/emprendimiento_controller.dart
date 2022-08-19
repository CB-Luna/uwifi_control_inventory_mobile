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

  void add(int idComunidad) {
    final nuevoEmprendimiento = Emprendimientos(
      imagen: imagen, 
      nombre: nombre,
      descripcion: descripcion,
      activo: true,
      archivado: false,
      );
      final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final comunidad = dataBase.comunidadesBox.get(idComunidad);
      if (comunidad != null) {
        nuevoEmprendimiento.comunidad.target = comunidad;
        nuevoEmprendimiento.statusSync.target = nuevoSync;
        nuevoEmprendimiento.bitacora.add(nuevaInstruccion);
        //Agregamos el emprendimiento en objectBox y recuperamos el Id
        idEmprendimiento = dataBase.emprendimientosBox.put(nuevoEmprendimiento);
        emprendimiento = nuevoEmprendimiento;
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Emprendimiento agregado exitosamente');
        notifyListeners();
      }
  }

  void update(int id, String newImagen, String newNombre, String newDescripcion, int idComunidad) {
    var updateEmprendimiento = dataBase.emprendimientosBox.get(id);
    final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendimiento', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendimiento != null) {
      updateEmprendimiento.imagen = newImagen;
      updateEmprendimiento.nombre = newNombre;
      updateEmprendimiento.descripcion = newDescripcion;
      updateEmprendimiento.comunidad.target = dataBase.comunidadesBox.get(idComunidad);
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

  void updateEmprendedores(int idEmprendimiento, Emprendedores emprendedor) {
    emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    emprendimiento!.emprendedor.target = emprendedor;
    dataBase.emprendimientosBox.put(emprendimiento!);
    notifyListeners();
  }

  void remove(Emprendimientos emprendimiento) {
    dataBase.emprendimientosBox.remove(emprendimiento.id); //Se elimina de bitacora la instruccion creada anteriormente
    this.emprendimiento = null;

    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}