import 'package:bizpro_app/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class JornadaController extends ChangeNotifier {

  List<Jornadas> jornadas = [];

  GlobalKey<FormState> jornadaFormKey = GlobalKey<FormState>();

  //Jornada
  String numJornada = '';
  DateTime? fechaRevision = DateTime.now();

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    numJornada = '';
    fechaRevision = null;
    notifyListeners();
  }

  void add(int idEmprendimiento) {
    final nuevaJornada = Jornadas(
      numJornada: numJornada,
      fechaRevision: fechaRevision!,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddJornada', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevaJornada.statusSync.target = nuevoSync;
        nuevaJornada.bitacora.add(nuevaInstruccion);
        emprendimiento.jornadas.add(nuevaJornada);
        emprendimiento.jornadas.applyToDb();
        jornadas.add(nuevaJornada);
        print('Jornada agregada exitosamente');
        notifyListeners();
      }
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