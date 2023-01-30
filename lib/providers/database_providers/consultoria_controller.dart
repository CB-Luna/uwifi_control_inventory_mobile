import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class ConsultoriaController extends ChangeNotifier {

  List<Consultorias> consultorias = [];

  GlobalKey<FormState> consultoriaFormKey = GlobalKey<FormState>();

  //Consultorias
  DateTime? fechaRevision = DateTime.now();
  String tarea = "";
  String avanceObservado = "";
  String porcentaje = "";
  Imagenes? imagenLocal;
  bool activo = true;

  bool validateForm(GlobalKey<FormState> consultoriaKey) {
    return consultoriaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    tarea = "";
    avanceObservado = "";
    porcentaje = "";
    fechaRevision = DateTime.now();
    activo = true;
    imagenLocal = null;
    notifyListeners();
  }

  void add(int idEmprendimiento, int numConsultoria, int idAmbito, int idAreaCirculo) {
    final nuevaConsultoria = Consultorias(idEmprendimiento: idEmprendimiento);
    final nuevaTarea = Tareas(
    tarea: tarea,
    descripcion: "Creación de Consultoría",
    fechaRevision: fechaRevision!, idEmprendimiento: idEmprendimiento);
    //Se agrega la imagen a la Tarea y el porcentaje de avance
    final nuevaImagenTarea = Imagenes(imagenes: "", idEmprendimiento: idEmprendimiento); //Se crea el objeto imagenes para la Tarea
    nuevaTarea.imagenes.add(nuevaImagenTarea);
    //Se recupera el primer porcentaje de la Tarea
    final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.porcentajeAvance.equals("1")).build().findFirst();
    if (porcentajeAvance != null) {
      nuevaTarea.porcentaje.target = porcentajeAvance;
    }
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals("Consultorías")).build().findFirst();
    //Se recupera el ambito y el area del circulo
    final ambito = dataBase.ambitoConsultoriaBox.get(idAmbito);
    final areaCirculo = dataBase.areaCirculoBox.get(idAreaCirculo);
    if (emprendimiento != null && ambito != null && areaCirculo != null && faseEmp != null) {
      final nuevaInstruccionConsultoria = Bitacora(instruccion: 'syncAddConsultoria', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaInstruccionEmprendimiento = Bitacora(instruccion: 'syncUpdateFaseEmprendimiento', instruccionAdicional: "Consultorías", usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se asigna un ambito y un area del circulo a la nuevaConsultoria
      nuevaConsultoria.ambitoConsultoria.target = ambito;
      nuevaConsultoria.areaCirculo.target = areaCirculo;
      nuevaConsultoria.tareas.add(nuevaTarea);
      nuevaConsultoria.emprendimiento.target = emprendimiento;
      nuevaConsultoria.bitacora.add(nuevaInstruccionConsultoria);
      //Indispensable para que se muestre en la lista de consultorias
      emprendimiento.bitacora.add(nuevaInstruccionEmprendimiento);
      emprendimiento.consultorias.add(nuevaConsultoria);
      //Se actualiza la fase del Emprendimiento
      //TODO actualizar en el backend.
      emprendimiento.faseEmp.add(faseEmp);
      emprendimiento.faseAnterior = faseEmp.fase;
      emprendimiento.faseActual = faseEmp.fase;
      emprendimiento.faseEmp.toList().forEach((element) {print(element.fase);});
      dataBase.emprendimientosBox.put(emprendimiento);
      consultorias.add(nuevaConsultoria);
      //print('Consultoria agregada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

  void updateTareaConsultoria(int id, Tareas oldTarea, int idPorcentajeAvance, int idEmprendimiento) {
    final nuevaTarea = Tareas(
    tarea: tarea == "" ? oldTarea.tarea : tarea,
    descripcion: avanceObservado,
    fechaRevision: fechaRevision!, idEmprendimiento: idEmprendimiento);

    // Se agrega la imagen a la Tarea
    if (imagenLocal != null) {
      nuevaTarea.imagenes.add(imagenLocal!);
    }
    //Se actualiza el porcentaje de la Tarea
    final porcentajeAvance = dataBase.porcentajeAvanceBox.get(idPorcentajeAvance);
    if (porcentajeAvance != null) {
      //print("Se actualiza porcentaje");
      nuevaTarea.porcentaje.target = porcentajeAvance;
    }
    var updateConsultoria = dataBase.consultoriasBox.get(id);
    if (updateConsultoria !=  null) {
      //Se agrega la nueva tarea
      nuevaTarea.consultoria.target = updateConsultoria;
      updateConsultoria.tareas.add(nuevaTarea);
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateTareaConsultoria', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      dataBase.consultoriasBox.put(updateConsultoria);
      nuevaTarea.bitacora.add(nuevaInstruccion);
      dataBase.tareasBox.put(nuevaTarea);
      //print('Tarea de Consultoría actualizada exitosamente');
      clearInformation(); //Se limpia información para usar el mismo controller en otro registro
      notifyListeners();
    }
  }

    void archivarConsultoria(int idConsultoria, int idEmprendimiento) {
    final consultoria = dataBase.consultoriasBox.get(idConsultoria);
    if (consultoria != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncArchivarConsultoria', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado de la Consultoria
      consultoria.archivado = true;
      consultoria.bitacora.add(nuevaInstruccion);
      dataBase.consultoriasBox.put(consultoria);
      //print('Consultoria actualizada exitosamente');
    }
  }

  void desarchivarConsultoria(int idConsultoria, int idEmprendimiento) {
    final consultoria = dataBase.consultoriasBox.get(idConsultoria);
    if (consultoria != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncDesarchivarConsultoria', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      //Se actualiza el estado de la Consultoria
      consultoria.archivado = false;
      consultoria.bitacora.add(nuevaInstruccion);
      dataBase.consultoriasBox.put(consultoria);
      //print('Consultoria actualizada exitosamente');
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