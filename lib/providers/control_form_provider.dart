import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class ControlFormProvider extends ChangeNotifier {
  
  
  final step1FormKey = GlobalKey<FormState>();
  final step2FormKey = GlobalKey<FormState>();
  final step3FormKey = GlobalKey<FormState>();

  bool validateForm(GlobalKey<FormState> stepFormKey) {
    return stepFormKey.currentState!.validate()
    ? true : false;
  }

  GlobalKey<FormState> controlFormFormKey = GlobalKey<FormState>();

  //Data about Control Form
  bool accept = false;

  TextEditingController mileageController = TextEditingController(text: ""); 
  TextEditingController commentsMileageController = TextEditingController(text: ""); 
  String? imageMileage;
  String? pathMileage;

  int gasPercent = 0;
  TextEditingController gasController = TextEditingController(text: ""); 
  TextEditingController commentsGasController = TextEditingController(text: ""); 
  String commentsGas = "";
  String? imageGas;
  String? pathGas;

  TextEditingController dentsController = TextEditingController(text: ""); 
  TextEditingController commentsDentsController = TextEditingController(text: ""); 
  String? imageDents;
  String? pathDents;


  DateTime? dateAdded; //Null to intialize the value in the text field


  void cleanData()
  {
    accept = false;
    
    mileageController.text = "";
    commentsMileageController.text = "";
    imageMileage = null;
    pathMileage = null;

    gasPercent = 0;
    gasController.text = "";
    commentsGasController.text = "";
    commentsGas = "";
    imageGas = null;
    pathGas = null;

    dentsController.text = "";
    commentsDentsController.text = "";
    imageDents = null;
    pathDents = null;

    dateAdded = null;

    notifyListeners();
  }

  void updateDataSelected(bool boolean) {
    accept = boolean;
    notifyListeners();
  }
  
  bool add() {
    notifyListeners();
    return true;
  }

  void updateGasPercent(int valor) {
    gasPercent = valor;
    notifyListeners();
  }


  bool validateStepOneForm ()
  {
    if (mileageController.text != "") {
      return true;
    } else {
      return false;
    }
  }

  bool validateStepTwoForm ()
  {
    if (gasPercent != 0) {
      return true;
    } else {
      return false;
    }
  }

  bool validateStepThreeForm ()
  {
    if (dentsController.text != "") {
      return true;
    } else {
      return false;
    }
  }
  
}