import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/preview_gateways_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/preview_gateways_uploaded.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/gateways_created_list.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/components/selector_inventory_form_gateway.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/gateways_added.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/gateways_not_created.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/inevntory_form_ocr_batch.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/inventory_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/inventory_form_batch.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/options_add_products.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/result_section.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/result_section_batch.dart';
class GatewayMenuProvider extends ChangeNotifier {


   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  int buttonMenuTaped = 0;

  //Menu Options:
  final menuTaped = {
    0: SelectorInventoryFormGateway(),//  0
    1: const GatewaysCreatedList(), // 1
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
        return const InventoryFormBatch();
      case 4:
        return ResultSection();
      case 5:
        return const PreviewGatewaysUploaded();
      case 6:
        return GatewaysAdded();
      case 7:
        return GatewaysNotCreated();
      case 8:
        return const PreviewGatewaysCreated();
      case 9:
        return const InventoryFormOCRBatch();
      case 10:
        return ResultSectionBatch();
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
