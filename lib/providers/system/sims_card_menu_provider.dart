import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/section_five_gateway.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/section_four_gateway.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/search_gateways_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/selector_inventory_form.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/inventory_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/inventory_form_qr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/options_add_products.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/result_section.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/bundle_gateway_sims_card.dart';

class SIMSCardMenuProvider extends ChangeNotifier {

  int buttonMenuTaped = 0;


  //Menu Options:
  final menuTaped = {
    0: SelectorInventoryFormGateway(), // Measures 0
    1: const SearchGatewaysCreated(), // Lights 1
    2: const BundleGatewayaSIMSCard(), // Security 2
    3: const SectionFourGateway(), // Equipment 3
    4: const SectionFiveGateway(), // General information 4
  };


  int valueOptionSection = 1;

  void changeOptionSection(int value) {
      valueOptionSection = value;
      notifyListeners();
    }

  Widget optionSection() { 
  switch (valueOptionSection) {
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
