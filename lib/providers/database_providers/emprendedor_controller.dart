import 'package:bizpro_app/models/temporals/emprendedor_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';
class EmprendedorController extends ChangeNotifier {
  EmprendedorTemporal? emprendedor; 

  Emprendedores? recoverEmprendedor; 

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
    recoverEmprendedor = null;
    curp = '';
    integrantesFamilia = '';
    // integrantesFamilia.clear();
    telefono = '';
    comentarios = '';
    asociado = false;
    notifyListeners();
  }

  void addTemporaly(int idComunidad) {
  emprendedor = EmprendedorTemporal(
    imagen: imagen,
    nombre: nombre, 
    apellidos: apellidos,
    nacimiento: nacimiento?? DateTime.parse("2000-02-27 13:27:00"), 
    curp: curp, 
    integrantesFamilia: int.parse(integrantesFamilia), 
    telefono: telefono, 
    comentarios: comentarios,  
    idComunidad: idComunidad,
    fechaRegistro: DateTime.now(),
  );
  asociado = true;
  print('Emprendedor temporal guardado éxitosamente');
  notifyListeners();
}

 void recoverTemporaly(int idEmprendedor) {
  recoverEmprendedor = dataBase.emprendedoresBox.get(idEmprendedor);
  asociado = true;
  print('Emprendedor temporal recuperado éxitosamente');
  notifyListeners();
}

  void add(int idEmprendimiento) {
    if (emprendedor != null) {
      final nuevoEmprendedor = Emprendedores(
      imagen: emprendedor?.imagen ?? "",
      nombre: emprendedor!.nombre, 
      apellidos: emprendedor!.apellidos,
      nacimiento: emprendedor?.nacimiento ?? DateTime.parse("2000-02-27 13:27:00"), 
      curp: emprendedor!.curp, 
      integrantesFamilia: emprendedor!.integrantesFamilia.toString(), 
      telefono: emprendedor!.telefono, 
      comentarios: emprendedor!.comentarios,  
      );

      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        final comunidad = dataBase.comunidadesBox.get(emprendedor!.idComunidad);
        if (comunidad != null) {
          nuevoEmprendedor.comunidad.target = comunidad;
          nuevoEmprendedor.statusSync.target = nuevoSync;
          nuevoEmprendedor.bitacora.add(nuevaInstruccion);
          nuevoEmprendedor.emprendimiento.target = emprendimiento;
          emprendimiento.emprendedor.target = nuevoEmprendedor;
          dataBase.emprendimientosBox.put(emprendimiento);
          // dataBase.emprendedoresBox.put(nuevoEmprendedor);
          print('Emprendedor agregado exitosamente');
          clearInformation();
          notifyListeners();
        }
      }
      
    } 
  }
//TODO: ARREGALAR ESTE PENDIENTE DE DESARCHIBVAR LUEGO DE ARREGLAR LA LÓGICA DEL SISTEMA
  void recover(int idEmprendimiento) {
    if (recoverEmprendedor != null) {
      final newEmprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final oldEmprendimiento = dataBase.emprendimientosBox.get(recoverEmprendedor!.emprendimiento.target!.id);
      if (newEmprendimiento != null && oldEmprendimiento != null) {
        //final nuevaInstruccion = Bitacora(instrucciones: 'syncAddEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        // nuevoEmprendedor.bitacora.add(nuevaInstruccion);
        //Se vuelve inactivo el antiguo emprendimiento
        oldEmprendimiento.activo = false;
        oldEmprendimiento.emprendedor.target = null;
        dataBase.emprendimientosBox.put(oldEmprendimiento);
        //Se actualiza el emprendimiento del emprendedor
        recoverEmprendedor!.emprendimiento.target = newEmprendimiento;
        //Se actualiza el nuevo emprendimiento
        newEmprendimiento.emprendedor.target = dataBase.emprendedoresBox.get(dataBase.emprendedoresBox.put(recoverEmprendedor!));
        dataBase.emprendimientosBox.put(newEmprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        print('Emprendedor ascociado exitosamente');
        clearInformation();
        notifyListeners();
      }
    }
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


  List<Emprendedores> getEmprendedoresActualUser(List<Emprendimientos> emprendimientos) {
    List<Emprendedores> emprendedoresActualUser = [];
    for (var element in emprendimientos) {
      if (element.emprendedor.target != null) {
        emprendedoresActualUser.add(element.emprendedor.target!);
      }
    }
    return emprendedoresActualUser;
  }
  
}