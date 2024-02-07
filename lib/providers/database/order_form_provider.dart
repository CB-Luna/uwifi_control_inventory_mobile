import 'dart:async';
import 'dart:convert';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card.dart';

class OrderFormProvider extends ChangeNotifier {

  Bundle? bundleCaptured;

  SIMSCard? simCard1;
  SIMSCard? simCard2;

  String provider = "";

  void updateProvider(String value) {
    provider = value;
    notifyListeners();
  }

  bool validateForm(GlobalKey<FormState> keyForm) {
    return keyForm.currentState!.validate() ? true : false;
  }

  //************************Bundles Components *********/
  TextEditingController serialNumberTextController = TextEditingController();
  String codeQRG =  "";

  Future<bool> autofillFieldsBundleQR(String value) async {
    codeQRG = value;
    if (value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSerialNumber != null) {
        serialNumberTextController.text =
            matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
        if (await validateBundleBackend(serialNumberTextController.text)) {
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

  Future<bool> autofillFieldsBundleOCR(String value) async {
    if (value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSerialNumber != null) {
        await Future.microtask(() => {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "")
        });
        if (await validateBundleBackend(serialNumberTextController.text)) {
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

  Future<bool> validateBundleBackend(String serialNumber) async {
    try {
      final res = await supabase
        .from('router_details_view')
        .select()
        .eq('serie_no', serialNumber);

      if (res[0] != null) {
        final bundle = res[0];
        bundleCaptured = Bundle.fromJson(jsonEncode(bundle));
        switch (bundleCaptured?.sim.length) {
          case 0:
            bundleCaptured = null;
            return false;
          case 1:
            bundleCaptured = null;
            return false;
          case 2:
            simCard1 = SIMSCard(
              simDetailId: bundleCaptured!.sim[0]!.simDetailId, 
              inventoryProductFk: bundleCaptured!.sim[0]!.inventoryProductId, 
              phoneAssociation: bundleCaptured!.sim[0]!.phoneAssociation, 
              pin: bundleCaptured!.sim[0]!.pin, 
              dataPlan: bundleCaptured!.sim[0]!.dataPlan, 
              imei: bundleCaptured!.sim[0]?.imei,
              createdAt: bundleCaptured!.sim[0]!.connectedAt
            );
            simCard2 = SIMSCard(
              simDetailId: bundleCaptured!.sim[1]!.simDetailId, 
              inventoryProductFk: bundleCaptured!.sim[1]!.inventoryProductId, 
              phoneAssociation: bundleCaptured!.sim[1]!.phoneAssociation, 
              pin: bundleCaptured!.sim[1]!.pin, 
              dataPlan: bundleCaptured!.sim[1]!.dataPlan, 
              imei: bundleCaptured!.sim[1]?.imei,
              createdAt: bundleCaptured!.sim[1]!.connectedAt
            );
            break;
          default:
            bundleCaptured = null;
            return false;
        }
        return true;
      } else {
        // Bundle doesn't exist
        return false;
      }
    } catch (e) {
      print("Error in 'validateBundleBackend': $e");
      return false;
    }
  }

  //************************SIMS Cards Components *********/
  TextEditingController imeiTextController = TextEditingController();
  String codeQRSC =  "";

  Future<bool> autofillFieldsSIMCardQR(String value, int number) async {
    codeQRSC = value;
    if (value.contains(imeiRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchImei = imeiRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchImei != null) {
          imeiTextController.text =
              matchImei.group(0)!.replaceAll(nameFieldImei, "");
          if (await validateSIMCardBackend(serialNumberTextController.text, number)) {
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

  Future<bool> autofillFieldsSIMCardOCR(String value, int number) async {
    if (value.contains(imeiRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchimei = imeiRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchimei != null) {
        await Future.microtask(() => {
          imeiTextController.text =
              matchimei.group(0)!.replaceAll(nameFieldImei, "")
        });
        if (await validateSIMCardBackend(imeiTextController.text, number)) {
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

  Future<bool> validateSIMCardBackend(String imei, int number) async {
    try {
      final res = await supabase
          .from('sim_detail')
          .select()
          .eq('imei', imei);

      if (res[0] != null) {
        final sim = res[0];
        if (number == 1) {
          simCard1 = SIMSCard.fromJson(jsonEncode(sim));
        }
        if (number == 2) {
          simCard2 = SIMSCard.fromJson(jsonEncode(sim));
        }

        return true;
      } else {
        // SIM Card doesn't exist
        return false;
      }
    } catch (e) {
      print("Error in 'validateSIMCardBackend': $e");
      return false;
    }
  }



  Future<bool> existsRegisterInBackend(String table, String column, String idUnique) async {
    final results = await supabase.from(table).select().eq(column, idUnique);
    return results.isNotEmpty;
  }

  void clearBundleControllers() {
    serialNumberTextController.clear();
    imeiTextController.clear();
    codeQRG =  "";
    codeQRSC =  "";
    bundleCaptured = null;
    simCard1 = null;
    simCard2 = null;
  }
}