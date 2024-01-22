import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/general_information_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/equipment_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/lights_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/measures_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/security_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/general_information_section_d.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/equipment_section_d.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/lights_section_d.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/measures_section_d.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/security_section_d.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
class VehiculoController extends ChangeNotifier {
  
  Vehicle? vehicleSelected;

  DateTime? completedDate;
  TextEditingController serviceCompleted = TextEditingController(text: "No");
  TextEditingController completedDateController = TextEditingController(text: "");

   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  //OPCIONES MENU:
  final menuTapedCheckOut = {
    0: MeasuresSectionR(),// Measures 0
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

  Future<bool> vehicleAssigned(Users user) async {
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
            .match({'user_profile_id' : user.idDBR})
            .select<PostgrestList>('user_profile_id');
          if (updateStatusVehicle.isNotEmpty && updateEmployeeVehicle.isNotEmpty) {
            vehicleSelected!.status.target = actualStatus;
            dataBase.vehicleBox.put(vehicleSelected!);
            user.vehicle.target = vehicleSelected;
            dataBase.usersBox.put(user);
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
              .match({'user_profile_id' : user.idDBR});
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

  void cleanServiceVehicleComponentes() {
    completedDate = null;
    serviceCompleted.text = "No";
    completedDateController.text = "";
    notifyListeners();
  }

  void updateCompletedDate(DateTime date) {
    completedDate = date;
    completedDateController.text = dateTimeFormat("MMMM d, y", date);
    // notifyListeners();
  }

  void updateServiceCompleted(String answerCompleted) {
    serviceCompleted.text = answerCompleted;
    notifyListeners();
  }

  bool updateServiceVehicle(VehicleServices vehicleServices) {
    try {
      if (vehicleServices.service.target!.service == "Oil Change") {
        vehicleServices.vehicle.target!.ruleOilChange.target!.registered = "False";
        dataBase.ruleBox.put(vehicleServices.vehicle.target!.ruleOilChange.target!);
      }
      if (vehicleServices.service.target!.service == "Transmission Fluid Change") {
        vehicleServices.vehicle.target!.ruleTransmissionFluidChange.target!.registered = "False";
        dataBase.ruleBox.put(vehicleServices.vehicle.target!.ruleTransmissionFluidChange.target!);
      }
      if (vehicleServices.service.target!.service == "Radiator Fluid Change") {
        vehicleServices.vehicle.target!.ruleRadiatorFluidChange.target!.registered = "False";
        dataBase.ruleBox.put(vehicleServices.vehicle.target!.ruleRadiatorFluidChange.target!);
      }
      if (vehicleServices.service.target!.service == "Tire Change") {
        vehicleServices.vehicle.target!.ruleTireChange.target!.registered = "False";
        dataBase.ruleBox.put(vehicleServices.vehicle.target!.ruleTireChange.target!);
      }
      if (vehicleServices.service.target!.service == "Brake Change") {
        vehicleServices.vehicle.target!.ruleBrakeChange.target!.registered = "False";
        dataBase.ruleBox.put(vehicleServices.vehicle.target!.ruleBrakeChange.target!);
      }
      vehicleServices.serviceDate = completedDate!;
      dataBase.vehicleServicesBox.put(vehicleServices);
      vehicleServices.completed = true;
      //Se actualiza el vehicle Services
      dataBase.vehicleServicesBox.put(vehicleServices);

      final nuevaInstruccion = Bitacora(
        instruccion: 'syncUpdateVehicleServices',
        usuarioPropietario: prefs.getString("userId")!,
        idControlForm: 0,
      ); //Se crea la nueva instruccion a realizar en bitacora

      nuevaInstruccion.vehicleService.target = vehicleServices; //Se asigna el vehicleServices a la nueva instrucción
      vehicleServices.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      return true;
    } catch (e) {
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
