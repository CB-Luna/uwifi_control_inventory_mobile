import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';

class GatewayFormProvider extends ChangeNotifier {
  
  bool validateForm(GlobalKey<FormState> keyForm) {
    return keyForm.currentState!.validate() ? true : false;
  }

  //************************Gateways Components *********/
  TextEditingController wifiKeyTextController = TextEditingController();
  TextEditingController imeiGTextController = TextEditingController();
  TextEditingController macTextController = TextEditingController();
  TextEditingController serialNumberTextController = TextEditingController();
  String codeQR =  "";

  void autofillFieldsQR(String value) {
    codeQR = value;
    if (value.contains(wifiKeyRegExp) 
    && value.contains(imeiGRegExp) 
    && value.contains(macRegExp)
    && value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchWifiKey = wifiKeyRegExp.firstMatch(value);
      Match? matchImeiG = imeiGRegExp.firstMatch(value);
      Match? matchMac = macRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchWifiKey != null) {
          wifiKeyTextController.text =
              matchWifiKey.group(0)!.replaceAll(nameFieldWifiKey, "");
      }
      if (matchImeiG != null) {
          imeiGTextController.text =
              matchImeiG.group(0)!.replaceAll(nameFieldImeiG, "");
      }
      if (matchMac != null) {
          macTextController.text =
              matchMac.group(0)!.replaceAll(nameFieldMac, "");
      }
      if (matchSerialNumber != null) {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
      }
    } 
    notifyListeners();
  }

  Future<bool> autofillFieldsOCR(String value) async {
    print("*****<<<<<>>>>$value<<<<<>>>>>********");
    print("Wi-Fi: KEY: ${value.contains(wifiKeyRegExp)}");
    print("IMEI: ${value.contains(imeiGRegExp)}");
    print("MAC: ${value.contains(macRegExp)}");
    print("S/N: ${value.contains(serialNumberRegExp)}");
    if (value.contains(wifiKeyRegExp) 
    && value.contains(imeiGRegExp) 
    && value.contains(macRegExp)
    && value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchWifiKey = wifiKeyRegExp.firstMatch(value);
      Match? matchImeiG = imeiGRegExp.firstMatch(value);
      Match? matchMac = macRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchWifiKey != null) {
        await Future.microtask(() => {
          wifiKeyTextController.text =
              matchWifiKey.group(0)!.replaceAll(nameFieldWifiKey, "")
        });
      }
      if (matchImeiG != null) {
        await Future.microtask(() => {
          imeiGTextController.text =
              matchImeiG.group(0)!.replaceAll(nameFieldImeiG, "")
        });
      }
      if (matchMac != null) {
        await Future.microtask(() => {
          macTextController.text =
              matchMac.group(0)!.replaceAll(nameFieldMac, "")
        });
      }
      if (matchSerialNumber != null) {
        await Future.microtask(() => {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "")
        });
      }
      return true;
    } else {
      return false;
    }
  }

  Future<String> addNewGatewayBackend(Users currentUser) async {
    try {
      if (await existsRegisterInBackend("router_detail", "serie_no", serialNumberTextController.text)) {
        return "Duplicate";
      }
      final recordInventoryProduct = await supabase.from('inventory_product').insert(
        {
          'inventory_location_fk': 1,
          'provider_invoice_fk': 1,
          'product_fk': 1,
          'barcode_type_fk': 1,
          'created_by': currentUser.sequentialId,
          'inventory_product_status_fk': 1
        },
      ).select<PostgrestList>('inventory_product_id');

      if (recordInventoryProduct.isNotEmpty) {
        final recordRouterDetail = await supabase.from('router_detail').insert(
          {
            'network_configuration': 'Static Routing',
            'inventory_product_fk': recordInventoryProduct.first['inventory_product_id'],
            'serie_no': serialNumberTextController.text,
            'mac': macTextController.text,
            'imei': imeiGTextController.text,
            'location': 'Store'
          },
        ).select<PostgrestList>('router_detail_id');
        if (recordRouterDetail.isNotEmpty) {
          return "True";
        } else {
          return "False";
        }
      } else {
        return "False";
      }
    } catch (e) {
      return "$e";
    }
  }

  Future<bool> existsRegisterInBackend(String table, String column, String idUnique) async {
    final results = await supabase.from(table).select().eq(column, idUnique);
    return results.isNotEmpty;
  }

  void clearControllers() {
    wifiKeyTextController.clear();
    imeiGTextController.clear();
    macTextController.clear();
    serialNumberTextController.clear();
    codeQR =  "";
  }
}