import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendedorController extends ChangeNotifier {

  List<Emprendedores> emprendedores = [];
  Emprendedores? emprendedor; 

  GlobalKey<FormState> emprendedorFormKey = GlobalKey<FormState>();

  //Emprendedor
  // TextEditingController integrantesFamilia = TextEditingController();
  String imagen = '';
  String nombre = '';
  String apellidos = '';
  DateTime? nacimiento = DateTime.parse("2000-02-27 13:27:00");
  String curp = '';
  String integrantesFamilia = '';
  String telefono = '';
  String comentarios = '';

  bool asociado =  false;

  bool validateForm(GlobalKey<FormState> emprendedorKey) {
    return emprendedorKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    apellidos = '';
    nacimiento = null;
    emprendedor = null;
    curp = '';
    integrantesFamilia = '';
    // integrantesFamilia.clear();
    telefono = '';
    comentarios = '';
    asociado = false;
    notifyListeners();
  }

  void addTemporaly() {
  emprendedor = Emprendedores(
    imagen: imagen,
    nombre: nombre, 
    apellidos: apellidos,
    nacimiento: nacimiento?? DateTime.parse("2000-02-27 13:27:00"), 
    curp: curp, 
    integrantesFamilia: integrantesFamilia, 
    telefono: telefono, 
    comentarios: comentarios,  
  );
  emprendedores.add(emprendedor!);
  asociado = true;
  print('Emprendedor temporal guardado éxitosamente');
  notifyListeners();
}

  void add(int idEmprendimiento, int idComunidad) {
    final nuevoEmprendedor = Emprendedores(
      imagen: imagen,
      nombre: nombre, 
      apellidos: apellidos,
      nacimiento: nacimiento?? DateTime.parse("2000-02-27 13:27:00"), 
      curp: curp, 
      integrantesFamilia: integrantesFamilia, 
      telefono: telefono, 
      comentarios: comentarios,  
      );

      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        final comunidad = dataBase.comunidadesBox.get(idComunidad);
        if (comunidad != null) {
          nuevoEmprendedor.comunidad.target = comunidad;
          nuevoEmprendedor.statusSync.target = nuevoSync;
          nuevoEmprendedor.bitacora.add(nuevaInstruccion);
          nuevoEmprendedor.emprendimiento.target = emprendimiento;
          emprendimiento.emprendedor.target = nuevoEmprendedor;
          dataBase.emprendimientosBox.put(emprendimiento);
          // dataBase.emprendedoresBox.put(nuevoEmprendedor);
          emprendedores.add(nuevoEmprendedor);
          print('Emprendedor agregado exitosamente');
          clearInformation();
          notifyListeners();
        }
      }

      // dataBase.emprendedoresBox.put(nuevoEmprendedor);
      // emprendedores.add(nuevoEmprendedor);
  }

  void update(int id, String newImagen, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad) {
    final updateEmprendedor = dataBase.emprendedoresBox.get(id);
    final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendedor != null) {
      updateEmprendedor.imagen = newImagen;
      updateEmprendedor.nombre = newNombre;
      updateEmprendedor.apellidos = newApellidos;
      updateEmprendedor.curp = newCurp;
      updateEmprendedor.integrantesFamilia = newIntegrantesFamilia;
      updateEmprendedor.telefono =  newTelefono;
      updateEmprendedor.comentarios =  newComentarios;
      updateEmprendedor.comunidad.target = dataBase.comunidadesBox.get(idComunidad);
      final statusSync = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateEmprendedor.statusSync.target!.id)).build().findUnique();
      if (statusSync != null) {
        statusSync.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del emprendedor
        dataBase.statusSyncBox.put(statusSync);
      }
      updateEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.emprendedoresBox.put(updateEmprendedor);
      print('Emprendedor actualizado exitosamente');

    }
    notifyListeners();
  }

  void remove(Emprendedores emprendedor) {
    dataBase.emprendedoresBox.remove(emprendedor.id);  //Se elimina de bitacora la instruccion creada anteriormente
    // emprendedores.remove(emprendedor);
    notifyListeners(); 
  }

  getAll() {
    emprendedores = dataBase.emprendedoresBox.getAll();
    notifyListeners();
  }

  List<Emprendedores> getEmprendedoresActualUser(List<Emprendimientos> emprendimientos) {
    emprendedores = [];
    for (var element in emprendimientos) {
      if (element.emprendedor.target != null) {
        emprendedores.add(element.emprendedor.target!);
      }
    }
    return emprendedores;
  }

  void getEmprendedoresByEmprendimiento(Emprendimientos emprendimiento) {
    emprendedores = [];
     if (emprendimiento.emprendedor.target != null) {
        emprendedores.add(emprendimiento.emprendedor.target!);
      }
  }
  
}