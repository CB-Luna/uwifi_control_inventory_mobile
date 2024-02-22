import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/widgets/inventory_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/widgets/inventory_form_qr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/widgets/options_add_products.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/widgets/result_section.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/components/search_sims_card_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/components/selector_inventory_form_sims_card.dart';

class SIMSCardMenuProvider extends ChangeNotifier {

  int buttonMenuTaped = 0;


  //Menu Options:
  final menuTaped = {
    0: SelectorInventorySIMSCard(), // 0
    1: const SearchSIMSCardCreated(), // 1
  };


  int valueOptionSection = 1;

  void changeOptionInventorySection(int value) {
      valueOptionSection = value;
      notifyListeners();
    }

  Widget optionInventorySection() { 
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

  void clean() {
    buttonMenuTaped = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    buttonMenuTaped = 0;
    super.dispose();
  }

}
