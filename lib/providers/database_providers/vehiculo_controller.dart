import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
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

  Vehicle? vehicleSelected;

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

  void updateVehicleSelected(Vehicle vehicle) {
    vehicleSelected = vehicle;
    notifyListeners();
  }

  Future<bool> vehicleAssigned(Users employee) async {
    if (vehicleSelected != null) {
      //Antes verificar que el estatus no haya cambiado
      final validateStatus = await supabaseCtrlV
        .from('vehicle')
        .select().match({'id_vehicle' : int.parse(vehicleSelected!.idDBR!)}).select<PostgrestList>('id_status_fk');
      if (validateStatus.isNotEmpty) {
        final actualStatus = dataBase.statusBox.query(Status_.idDBR.equals(validateStatus.first['id_status_fk'].toString())).build().findUnique();
        print("Valor Estatus: ${validateStatus.first['id_status_fk'].toString()}");
        if (actualStatus?.status == 'Available') {
          final status = dataBase.statusBox.query(Status_.status.equals('Assigned')).build().findUnique();
          final updateStatusVehicle = await supabaseCtrlV
            .from('vehicle')
            .update({'id_status_fk' : int.parse(status!.idDBR!)})
            .match({'id_vehicle' : int.parse(vehicleSelected!.idDBR!)})
            .select<PostgrestList>('id_vehicle');
          final updateEmployeeVehicle = await supabase
            .from('user_profile')
            .update({'id_vehicle_fk' : int.parse(vehicleSelected!.idDBR!)})
            .match({'user_profile_id' : employee.idDBR})
            .select<PostgrestList>('user_profile_id');
          if (updateStatusVehicle.isNotEmpty && updateEmployeeVehicle.isNotEmpty) {
            vehicleSelected!.status.target = actualStatus;
            dataBase.vehicleBox.put(vehicleSelected!);
            employee.vehicle.target = vehicleSelected;
            dataBase.usersBox.put(employee);
            return true;
          } else {
            final status = dataBase.statusBox.query(Status_.status.equals('Available')).build().findUnique();
            await supabaseCtrlV
              .from('vehicle')
              .update({'id_status_fk' : int.parse(status!.idDBR!)})
              .match({'id_vehicle' : int.parse(vehicleSelected!.idDBR!)});
            await supabasePublic
              .from('user_profile')
              .update({'id_vehicle_fk' : null})
              .match({'user_profile_id' : employee.idDBR});
            return false;
          }
        } else {
          vehicleSelected!.status.target = actualStatus;
          dataBase.vehicleBox.put(vehicleSelected!);
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void cleanComponents() {
    isTapedCheckOut = 0;
    isTapedCheckIn = 0;
    vehicleSelected = null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
