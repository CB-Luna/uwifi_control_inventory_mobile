import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/search_bundles_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/section_three_bundle.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/components/selector_inventory_form_bundle.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_captured.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/gateway_form_qr.dart';
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
      default:
        return OptionsRecoverGateways();
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
