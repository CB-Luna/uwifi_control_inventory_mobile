import 'package:bizpro_app/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class ConsultoriaController extends ChangeNotifier {

  List<Consultorias> consultorias = [];

  GlobalKey<FormState> consultoriaFormKey = GlobalKey<FormState>();

  //Consultorias
  DateTime? fechaRevision = DateTime.now();
  String tarea = "";

  bool validateForm(GlobalKey<FormState> consultoriaKey) {
    return consultoriaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    tarea = "";
    fechaRevision =  null;
    notifyListeners();
  }

  void add(int idEmprendimiento, int numConsultoria, int idAmbito, int idAreaCirculo) {
    final nuevaConsultoria = Consultorias();
    final nuevaTarea = Tareas(
    tarea: tarea,
    descripcion: "Creación Consultoría",
    observacion: "Se crea consultoría",
    porcentaje: 1,
    fechaRevision: fechaRevision!);
    final nuevoSyncTarea = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Tarea
    nuevaTarea.statusSync.target = nuevoSyncTarea;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    //Se recupera el ambito y el area del circulo
    final ambito = dataBase.ambitoConsultoriaBox.get(idAmbito);
    final areaCirculo = dataBase.areaCirculoBox.get(idAreaCirculo);
    if (emprendimiento != null && ambito != null && areaCirculo != null) {
      final nuevoSyncConsultoria = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Consultoria
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddConsultoria', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaConsultoria.statusSync.target = nuevoSyncConsultoria;
      //Se asigna un ambito y un area del circulo a la nuevaConsultoria
      nuevaConsultoria.ambitoConsultoria.target = ambito;
      nuevaConsultoria.areaCirculo.target = areaCirculo;
      nuevaConsultoria.tareas.add(nuevaTarea);
      nuevaConsultoria.emprendimiento.target = emprendimiento;
      nuevaConsultoria.bitacora.add(nuevaInstruccion);
      //Indispensable para que se muestre en la lista de consultorias
      emprendimiento.consultorias.add(nuevaConsultoria);
      dataBase.emprendimientosBox.put(emprendimiento);
      consultorias.add(nuevaConsultoria);
      print('Consultoria agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void remove(Consultorias consultoria) {
    dataBase.consultoriasBox.remove(consultoria.id);
    notifyListeners(); 
  }

  getAll() {
    consultorias = dataBase.consultoriasBox.getAll();
    notifyListeners();
  }
  
}