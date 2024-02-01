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
  TextEditingController productIDTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController serialNumberTextController = TextEditingController();
  TextEditingController productCodeTextController = TextEditingController();
  String codeQR =  "";

  void autofillFieldsQR(String value) {
    codeQR = value;
    if (value.contains(productIDRegExpo) 
    && value.contains(nameRegExp) 
    && value.contains(descriptionRegExp)
    && value.contains(serialNumberRegExp)
    && value.contains(productCodeRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      Match? matchName = nameRegExp.firstMatch(value);
      Match? matchDescription = descriptionRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchProductID != null) {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "");
      }
      if (matchName != null) {
          nameTextController.text =
              matchName.group(0)!.replaceAll(nameFieldName, "");
      }
      if (matchDescription != null) {
          descriptionTextController.text =
              matchDescription.group(0)!.replaceAll(nameFieldDescription, "");
      }
      if (matchSerialNumber != null) {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
      }
      if (matchProductCode != null) {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "");
      }
    } 
    notifyListeners();
  }

  Future<bool> autofillFieldsOCR(String value) async {
    if (value.contains(productIDRegExpo) 
    && value.contains(nameRegExp) 
    && value.contains(descriptionRegExp)
    && value.contains(serialNumberRegExp)
    && value.contains(productCodeRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      Match? matchName = nameRegExp.firstMatch(value);
      Match? matchDescription = descriptionRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchProductID != null) {
        await Future.microtask(() => {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "")
        });
      }
      if (matchName != null) {
        await Future.microtask(() => {
          nameTextController.text =
              matchName.group(0)!.replaceAll(nameFieldName, "")
        });
      }
      if (matchDescription != null) {
        await Future.microtask(() => {
          descriptionTextController.text =
              matchDescription.group(0)!.replaceAll(nameFieldDescription, "")
        });
      }
      if (matchSerialNumber != null) {
        await Future.microtask(() => {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "")
        });
      }
      if (matchProductCode != null) {
        await Future.microtask(() => {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "")
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
          'product_fk': productIDTextController.text,
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
    productIDTextController.clear();
    nameTextController.clear();
    descriptionTextController.clear();
    serialNumberTextController.clear();
    productCodeTextController.clear();
    codeQR =  "";
  }
}