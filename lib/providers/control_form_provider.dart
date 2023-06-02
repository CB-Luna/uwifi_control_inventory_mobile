import 'package:flutter/material.dart';
class ControlFormProvider extends ChangeNotifier {
  
  dynamic hours;
  DateTime? registeredHour;

  bool boolCurrentHour = true;
  //Data about Control Form
  bool isSelectedHour = false;



  void cleanData()
  {
    isSelectedHour = false;
    boolCurrentHour = true;
    hours = null;
    registeredHour = null;
  }

  void rejectCurrentHour()
  {
    boolCurrentHour = false;
  }
  void acceptCurrentHour()
  {
    boolCurrentHour = true;
  }
  void changeIsSelectedHourValue(bool value)
  {
    isSelectedHour = value;
  }
  void changeRegisteredHour(DateTime hour)
  {
    registeredHour = hour;
  }
  void fillHoursData(dynamic value)
  {
    hours = value;
  }
}