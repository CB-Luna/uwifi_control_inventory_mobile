import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/add_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/options_recover_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/options_recover_bundles.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/search_orders_list.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/search_orders_delivery.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_assigned.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_detected.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_form_sku.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_founded.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/suggestions_sims_config.dart';

class OrderMenuProvider extends ChangeNotifier {


   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  int buttonMenuTaped = 0;

  //Menu Options:
  final menuTaped = {
    0: const SearchOrdersList(), // Lights 0
    1: const SearchOrdersDelivery(), // Equipment 1
  };


  int valueOptionSection = 0;

  void changeOptionInventorySection(int value) {
      valueOptionSection = value;
    notifyListeners();
  }

  Widget optionInventorySection() { 
  switch (valueOptionSection) {
      case 0:
        return OptionsRecoverBundles();
      case 1:
        return const BundleFormOCR();
      case 2:
        return const BundleFormSKU();
      case 3:
        return BundleFounded();
      case 4:
        return BundleDetected();
      case 5:
        return const SuggestionsSimsConfig();
      case 6:
        return BundleAssigned();
      default:
        return OptionsRecoverBundles();
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
