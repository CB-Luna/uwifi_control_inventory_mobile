import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/general_information_section_r.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/equipment_section_r.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/lights_section_r.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/measures_section_r.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/security_section_r.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/general_information_section_d.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/equipment_section_d.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/lights_section_d.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/measures_section_d.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/security_section_d.dart';
class VehiculoController extends ChangeNotifier {
  //OPCIONES MENU:
  final menuTapedCheckOut = {
    0: const MeasuresSectionR(),// Measures 0
    1: const LightsSectionR(), // Lights 1
    2: const SecuritySectionR(), // Security 2
    3: const EquipmentSectionR(), // Equipment 3
    4: const GeneralInformationSectionR(), // General information 4
  };

  final menuTapedCheckIn = {
    0: const MeasuresSectionD(),// Measures 0
    1: const LightsSectionD(), // Lights 1
    2: const SecuritySectionD(), // Security 2
    3: const EquipmentSectionD(), // Equipment 3
    4: const GeneralInformationSectionD(), // General information 4
  };

  int isTapedCheckOut = 0;

  int isTapedCheckIn = 0;
  
  void setTapedOptionCheckOut(int index) {
    isTapedCheckOut = index;
    notifyListeners();
  }
  void setTapedOptionCheckIn(int index) {
    isTapedCheckIn = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
