import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/search_bundles_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/section_three_bundle.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/selector_inventory_form_bundle.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/add_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_captured.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_form_qr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/options_recover_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/bundle_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/sim_card_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/sim_card_form_qr.dart';
import '../../screens/inventory/bundle/widgets/options_recover_gateways.dart';

class BundleMenuProvider extends ChangeNotifier {


   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  int buttonMenuTaped = 0;

  //Menu Options:
  final menuTaped = {
    0: SelectorInventoryFormBundle(),// Measures 0
    1: const SearchBundlesCreated(), // Lights 1
    2: const SectionThreeBundle(), // Equipment 2
  };


  int valueOptionSection = 0;

  void changeOptionInventorySection(int value) {
      valueOptionSection = value;
    notifyListeners();
  }

  Widget optionInventorySection() { 
  switch (valueOptionSection) {
      case 0:
        return OptionsRecoverGateways();
      case 1:
        return const GatewayFormOCR();
      case 2:
        return const GatewayFormQR();
      case 3:
        return Container();
      case 4:
        return const GatewayCaptured();
      case 5:
        return const SIMCardFormOCR();
      case 6:
        return const SIMCardFormQR();
      case 7:
        return BundleCreated();
      default:
        return OptionsRecoverGateways();
    }
  }

  int valueOptionButtonsGC = 0;
  int simCardNumer = 1;

  void changeOptionButtonsGC(int value, int? number) {
      valueOptionButtonsGC = value;
      if (number != null) {
        simCardNumer = number;
      }
    notifyListeners();
  }

  Widget optionButtonsGC() { 
  switch (valueOptionButtonsGC) {
      case 0:
        return AddSIMSCard();
      case 1:
        return OptionsRecoverSIMSCard();
      default:
        return AddSIMSCard();
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

}
