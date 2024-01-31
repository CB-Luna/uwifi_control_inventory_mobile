import 'dart:async';
import 'dart:convert';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card.dart';

class BundleFormProvider extends ChangeNotifier {

  Gateway? gatewayCaptured;

  SIMSCard? simCard1;
  SIMSCard? simCard2;


  bool validateForm(GlobalKey<FormState> keyForm) {
    return keyForm.currentState!.validate() ? true : false;
  }

  //************************Gateways Components *********/
  TextEditingController serialNumberTextController = TextEditingController();
  String codeQR =  "";

  Future<bool> autofillFieldsGatewayQR(String value) async {
    codeQR = value;
    if (value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSerialNumber != null) {
        serialNumberTextController.text =
            matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
        if (await recoverGatewayBackend(serialNumberTextController.text)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> autofillFieldsGatewayOCR(String value) async {
    if (value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSerialNumber != null) {
        await Future.microtask(() => {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "")
        });
        if (await recoverGatewayBackend(serialNumberTextController.text)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> recoverGatewayBackend(String serialNumber) async {
    try {
      final res = await supabase
          .from('router_detail')
          .select()
          .eq('serie_no', serialNumber);

      if (res[0] != null) {
        final gateway = res[0];
        // final userProfileString = jsonEncode(userProfile).toString();
        //Existen datos del Usuario en Supabase
        gatewayCaptured = Gateway.fromJson(jsonEncode(gateway));
        if (gatewayCaptured?.idSIMSCardFkOne != null) {
          final res1 = await supabase
          .from('sim_detail')
          .select()
          .eq('sim_detail_id', gatewayCaptured!.idSIMSCardFkOne);
          if (res1[0] != null) {
            final sc1 = res1[0];
            simCard1 = SIMSCard.fromJson(jsonEncode(sc1));
          }
        }
        if (gatewayCaptured?.idSIMSCardFkTwo != null) {
          final res2 = await supabase
          .from('sim_detail')
          .select()
          .eq('sim_detail_id', gatewayCaptured!.idSIMSCardFkTwo);
          if (res2[0] != null) {
            final sc2 = res2[0];
            simCard2 = SIMSCard.fromJson(jsonEncode(sc2));
          }
        }
        return true;
      } else {
        // Gateway doesn't exist
        return false;
      }
    } catch (e) {
      print("Error in 'recoverGatewayBackend': $e");
      return false;
    }
  }

  // Future<String> addNewGatewayBackend(Users currentUser) async {
  //   try {
  //     if (await existsRegisterInBackend("router_detail", "serie_no", serialNumberTextController.text)) {
  //       return "Duplicate";
  //     }
  //     final recordInventoryProduct = await supabase.from('inventory_product').insert(
  //       {
  //         'inventory_location_fk': 1,
  //         'provider_invoice_fk': 1,
  //         'product_fk': productIDTextController.text,
  //         'barcode_type_fk': 1,
  //         'created_by': currentUser.id,
  //         'inventory_product_status_fk': 1
  //       },
  //     ).select<PostgrestList>('inventory_product_id');

  //     if (recordInventoryProduct.isNotEmpty) {
  //       final recordRouterDetail = await supabase.from('router_detail').insert(
  //         {
  //           'network_configuration': 'Static Routing',
  //           'inventory_product_fk': recordInventoryProduct.first['inventory_product_id'],
  //           'serie_no': serialNumberTextController.text,
  //           'location': 'Store'
  //         },
  //       ).select<PostgrestList>('router_detail_id');
  //       if (recordRouterDetail.isNotEmpty) {
  //         return "True";
  //       } else {
  //         return "False";
  //       }
  //     } else {
  //       return "False";
  //     }
  //   } catch (e) {
  //     return "$e";
  //   }
  // }

  Future<bool> existsRegisterInBackend(String table, String column, String idUnique) async {
    final results = await supabase.from(table).select().eq(column, idUnique);
    return results.isNotEmpty;
  }

  void clearGatewayControllers() {
    serialNumberTextController.clear();
    codeQR =  "";
    gatewayCaptured = null;
  }
}