import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/general_information_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/equipment_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/inventory_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/search_gateways_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/control_inventory_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/options_add_products.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/result_section.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/components/bundle_gateway_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';

import '../../screens/inventory/components/inventory_form_qr.dart';
class GatewayMenuProvider extends ChangeNotifier {
  
  Vehicle? vehicleSelected;

  DateTime? completedDate;
  TextEditingController serviceCompleted = TextEditingController(text: "No");
  TextEditingController completedDateController = TextEditingController(text: "");

   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  //OPCIONES MENU:
  final menuTapedCheckOut = {
    0: ControlInventoryScreen(),// Measures 0
    1: const SearchGatewaysCreated(), // Lights 1
    2: const BundleGatewayaSIMSCard(), // Security 2
    3: const EquipmentSectionR(), // Equipment 3
    4: const GeneralInformationSectionR(), // General information 4
  };

  final menuTapedCheckIn = {
    0: ControlInventoryScreen(),// Measures 0
    1: Container(), // Lights 1
    2: Container(), // Security 2
    3: Container(), // Equipment 3
    4: Container(), // General information 4
  };

int valueOptionInventorySection = 1;

void changeOptionInventorySection(int value) {
    valueOptionInventorySection = value;
    notifyListeners();
  }

Widget optionInventorySection() { 
 switch (valueOptionInventorySection) {
      case 1:
        return OptionsAddProducts();
      case 2:
        return const InventoryFormOCR();
      case 3:
        return const InventoryFormQR();
      case 4:
        return ResultSection();
      default:
        return OptionsAddProducts();
    }
  }

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
