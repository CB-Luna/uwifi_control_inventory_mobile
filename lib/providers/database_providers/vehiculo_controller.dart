import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/equipment_section.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/fluids_section.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/lights_section.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/measures_section.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/security_section.dart';
class VehiculoController extends ChangeNotifier {
  //OPCIONES MENU:
  final menuTaped = {
    0: const MeasuresSection(),// Measures 0
    1: const LightsSection(), // Lights 1
    2: const FluidsSection(), // Fluids 2
    3: const SecuritySection(), // Security 3
    4: const EquipmentSection(), // Equipment 4
  };

  int isTaped = 0;
  
  void setTapedOption(int index) {
    isTaped = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
