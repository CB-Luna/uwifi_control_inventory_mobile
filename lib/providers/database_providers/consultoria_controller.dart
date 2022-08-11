import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class ConsultoriaController extends ChangeNotifier {

  List<Consultorias> consultorias = [];

  GlobalKey<FormState> consultoriaFormKey = GlobalKey<FormState>();

  //Consultorias
  List<String> documentos = []; //TODO preguntar que es un arraystring

  bool validateForm(GlobalKey<FormState> consultoriaKey) {
    return consultoriaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    documentos.clear();
    notifyListeners();
  }

  void add(int idEmprendimiento) {
    final nuevaConsultoria = Consultorias(
      documentos: documentos,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        emprendimiento.consultorias.add(nuevaConsultoria);
        emprendimiento.consultorias.applyToDb();
        consultorias.add(nuevaConsultoria);
        print('Jornada agregada exitosamente');
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

  void getConsultoriasActualUser(List<Emprendimientos> emprendimientos) {
    consultorias = [];
    emprendimientos.forEach((element) {
      element.consultorias.forEach(
        (element) {consultorias.add(element);
        });
    });
  }
  void getConsultoriasByEmprendimiento(Emprendimientos emprendimiento) {
    consultorias = [];
    consultorias = emprendimiento.consultorias.toList();
  }
  
}