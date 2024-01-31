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
  TextEditingController pinTextController = TextEditingController();
  TextEditingController descriptionSTextController = TextEditingController();
  TextEditingController imeiTextController = TextEditingController();
  TextEditingController productCodeTextController = TextEditingController();
  TextEditingController productIDTextController = TextEditingController();
  String codeQR =  "";

  void autofillFieldsQR(String value) {
    codeQR = value;
    if (value.contains(pinRegExpo) 
    && value.contains(descriptionSRegExp)
    && value.contains(imeiRegExp)
    && value.contains(productCodeRegExp)
    && value.contains(productIDRegExpo)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchpin = pinRegExpo.firstMatch(value);
      Match? matchDescriptionS = descriptionSRegExp.firstMatch(value);
      Match? matchImei = imeiRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchpin != null) {
          pinTextController.text =
              matchpin.group(0)!.replaceAll(nameFieldPin, "");
      }
      if (matchDescriptionS != null) {
          descriptionSTextController.text =
              matchDescriptionS.group(0)!.replaceAll(nameFieldDescriptionS, "");
      }
      if (matchImei != null) {
          imeiTextController.text =
              matchImei.group(0)!.replaceAll(nameFieldImei, "");
      }
      if (matchProductCode != null) {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "");
      }
      if (matchProductID != null) {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "");
      }
    } 
    notifyListeners();
  }

  Future<bool> autofillFieldsOCR(String value) async {
    if (value.contains(pinRegExpo) 
    && value.contains(descriptionSRegExp)
    && value.contains(imeiRegExp)
    && value.contains(productCodeRegExp)
    && value.contains(productIDRegExpo)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchpin = pinRegExpo.firstMatch(value);
      Match? matchDescriptionS = descriptionSRegExp.firstMatch(value);
      Match? matchimei = imeiRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchpin != null) {
        await Future.microtask(() => {
          pinTextController.text =
              matchpin.group(0)!.replaceAll(nameFieldPin, "")
        });
      }
      if (matchDescriptionS != null) {
        await Future.microtask(() => {
          descriptionSTextController.text =
              matchDescriptionS.group(0)!.replaceAll(nameFieldDescriptionS, "")
        });
      }
      if (matchimei != null) {
        await Future.microtask(() => {
          imeiTextController.text =
              matchimei.group(0)!.replaceAll(nameFieldImei, "")
        });
      }
      if (matchProductCode != null) {
        await Future.microtask(() => {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "")
        });
      }
      if (matchProductID != null) {
        await Future.microtask(() => {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "")
        });
      }
      return true;
    } else {
      return false;
    }
  }

    Future<String> addNewSIMSCardBackend(Users currentUser) async {
    try {
      if (await existsRegisterInBackend("sim_detail", "imei", imeiTextController.text)) {
        return "Duplicate";
      }
      final recordInventoryProduct = await supabase.from('inventory_product').insert(
        {
          'inventory_location_fk': 1,
          'provider_invoice_fk': 1,
          'product_fk': productIDTextController.text,
          'barcode_type_fk': 1,
          'created_by': currentUser.id,
          'inventory_product_status_fk': 1
        },
      ).select<PostgrestList>('inventory_product_id');

      if (recordInventoryProduct.isNotEmpty) {
        final recordRouterSim = await supabase.from('sim_detail').insert(
          {
            'imei': imeiTextController.text,
            'phone_association': '(524) 1234233',
            'data_plan': 'Unlimited',
            'pin': pinTextController.text,
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
    pinTextController.clear();
    descriptionSTextController.clear();
    imeiTextController.clear();
    productIDTextController.clear();
    productCodeTextController.clear();
    codeQR =  "";
  }
}