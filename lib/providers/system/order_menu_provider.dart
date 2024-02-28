import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/add_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/options_recover_sims_card.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/options_recover_bundles.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/options_recover_tickets.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/search_orders_list.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/search_orders_delivery.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/components/search_orders_package.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_assigned.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_detected.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_form_sku.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_founded.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/bundle_form_ocr.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/suggestions_sims_config.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/tracking_assigned.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/tracking_form_ocr.dart';

class OrderMenuProvider extends ChangeNotifier {


   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  int buttonMenuTaped = 0;

  //Menu Options:
  final menuTaped = {
    0: const SearchOrdersList(), // Lights 0
    1: const SearchOrdersPackageList(), // Equipment 1
    2: const SearchOrdersDelivery(), // Equipment 1
  };


  int valueSectionOrders = 0;

  void changeOptionOrders(int value) {
      valueSectionOrders = value;
    notifyListeners();
  }

  Widget optionOrders() { 
  switch (valueSectionOrders) {
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

  int valueSectionOrdersDelivery = 0;

  void changeOptionOrdersDelivery(int value) {
      valueSectionOrdersDelivery = value;
    notifyListeners();
  }

  Widget optionOrdersDelivery() { 
  switch (valueSectionOrdersDelivery) {
      case 0:
        return OptionsRecoverTracking();
      case 1:
        return const TrackingFormOCR();
      case 2:
        return const BundleFormSKU();
      case 3:
        return TrackingAssigned();
      default:
        return OptionsRecoverTracking();
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

  int valueSKUProvider = 0;

  void changeOptionSKUProvider(int value) {
      valueSKUProvider = value;
    notifyListeners();
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
