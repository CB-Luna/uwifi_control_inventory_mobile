import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class JornadaController extends ChangeNotifier {

  List<Jornadas> jornadas = [];

  GlobalKey<FormState> jornadaFormKey = GlobalKey<FormState>();

  //Jornada
  String numJornada = '';
  DateTime? proximaVisita = DateTime.now();

  bool validateForm(GlobalKey<FormState> jornadaKey) {
    return jornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    numJornada = '';
    proximaVisita = null;
    notifyListeners();
  }

  void add(int idEmprendimiento) {
    final nuevaJornada = Jornadas(
      numJornada: numJornada,
      proximaVisita: proximaVisita!,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
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