import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';

class SIMSCardFormProvider extends ChangeNotifier {
  
  bool validateForm(GlobalKey<FormState> keyForm) {
    return keyForm.currentState!.validate() ? true : false;
  }

  //************************SIMS Cards Components *********/
  TextEditingController sapIdTextController = TextEditingController();
  TextEditingController imeiSCTextController = TextEditingController();
  String codeQR =  "";

  void autofillFieldsQR(String value) {
    codeQR = value;
    if (value.contains(sapIdRegExp) 
    && value.contains(imeiSCRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSapId = sapIdRegExp.firstMatch(value);
      Match? matchImeiSC = imeiSCRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSapId != null) {
          sapIdTextController.text =
              matchSapId.group(0)!.replaceAll(nameFieldSapId, "");
      }
      if (matchImeiSC != null) {
          imeiSCTextController.text =
              matchImeiSC.group(0)!.replaceAll(nameFieldImeiSC, "");
      }
    } 
    notifyListeners();
  }

  Future<bool> autofillFieldsOCR(String value) async {
    if (value.contains(sapIdRegExp) 
    && value.contains(imeiSCRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSapId = sapIdRegExp.firstMatch(value);
      Match? matchImeiSC = imeiSCRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSapId != null) {
        await Future.microtask(() => {
          sapIdTextController.text =
              matchSapId.group(0)!.replaceAll(nameFieldSapId, "")
        });
      }
      if (matchImeiSC != null) {
        await Future.microtask(() => {
          imeiSCTextController.text =
              matchImeiSC.group(0)!.replaceAll(nameFieldImeiSC, "")
        });
      }
      return true;
    } else {
      return false;
    }
  }

    Future<String> addNewSIMSCardBackend(Users currentUser) async {
    try {
      if (await existsRegisterInBackend("sim_detail", "imei", imeiSCTextController.text)) {
        return "Duplicate";
      }
      final recordInventoryProduct = await supabase.from('inventory_product').insert(
        {
          'inventory_location_fk': 1,
          'provider_invoice_fk': 1,
          'product_fk': 2,
          'barcode_type_fk': 1,
          'created_by': currentUser.sequentialId,
          'inventory_product_status_fk': 1
        },
      ).select<PostgrestList>('inventory_product_id');

      if (recordInventoryProduct.isNotEmpty) {
        final recordRouterSim = await supabase.from('sim_detail').insert(
          {
            'sap_id': sapIdTextController.text,
            'imei': imeiSCTextController.text,
            'phone_association': '(524) 1234233',
            'data_plan': 'Unlimited',
            'pin': "9999",
            'inventory_product_fk': recordInventoryProduct.first['inventory_product_id']
          },
        ).select<PostgrestList>('sim_detail_id');

        if (recordRouterSim.isNotEmpty) {
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
    sapIdTextController.clear();
    imeiSCTextController.clear();
    codeQR =  "";
  }
}