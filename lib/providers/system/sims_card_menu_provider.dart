import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/general_information_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/equipment_section_r.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/inventory_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/search_gateways_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/control_inventory_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/options_add_products.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/result_section.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/bundle_gateway_sims_card.dart';

import '../../screens/revision/components/inventory_form_qr.dart';
class SIMSCardMenuProvider extends ChangeNotifier {

  int buttonMenuTaped = 0;


  //OPCIONES MENU:
  final menuTapedCheckOut = {
    0: ControlInventoryScreen(), // Measures 0
    1: const SearchGatewaysCreated(), // Lights 1
    2: const BundleGatewayaSIMSCard(), // Security 2
    3: const EquipmentSectionR(), // Equipment 3
    4: const GeneralInformationSectionR(), // General information 4
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
  
  void setButtonMenuTaped(int index) {
    buttonMenuTaped = index;
    notifyListeners();
  }

  @override
  void dispose() {
    buttonMenuTaped = 0;
    super.dispose();
  }
}
