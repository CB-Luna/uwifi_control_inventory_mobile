import 'dart:async';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';
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
  String codeQRG =  "";

  Future<bool> autofillFieldsGatewayQR(String value) async {
    codeQRG = value;
    if (value.contains(serialNumberRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchSerialNumber != null) {
        serialNumberTextController.text =
            matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
        if (await validateGatewayBackend(serialNumberTextController.text)) {
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
        if (await validateGatewayBackend(serialNumberTextController.text)) {
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

  Future<bool> validateGatewayBackend(String serialNumber) async {
    try {
      final res = await supabase
          .from('router_detail')
          .select()
          .eq('serie_no', serialNumber);

      if (res[0] != null) {
        final gateway = res[0];
        gatewayCaptured = Gateway.fromJson(jsonEncode(gateway));

        final res1 = await supabase
        .from('router_details_view')
        .select()
        .eq('router_detail_id', gatewayCaptured!.routerDetailId);

        if (res1[0] != null) {
          final bundle = res1[0];
          final bundleCaptured = Bundle.fromJson(jsonEncode(bundle));
          switch (bundleCaptured.sim.length) {
            case 0:
              break;
            case 1:
              simCard1 = SIMSCard(
                simDetailId: bundleCaptured.sim[0]!.simDetailId, 
                inventoryProductFk: bundleCaptured.sim[0]!.inventoryProductId, 
                phoneAssociation: bundleCaptured.sim[0]!.phoneAssociation, 
                pin: bundleCaptured.sim[0]!.pin, 
                dataPlan: bundleCaptured.sim[0]!.dataPlan, 
                createdAt: DateTime.now()
              );
              break;
            case 2:
              simCard1 = SIMSCard(
                simDetailId: bundleCaptured.sim[0]!.simDetailId, 
                inventoryProductFk: bundleCaptured.sim[0]!.inventoryProductId, 
                phoneAssociation: bundleCaptured.sim[0]!.phoneAssociation, 
                pin: bundleCaptured.sim[0]!.pin, 
                dataPlan: bundleCaptured.sim[0]!.dataPlan, 
                createdAt: DateTime.now()
              );
              simCard2 = SIMSCard(
                simDetailId: bundleCaptured.sim[1]!.simDetailId, 
                inventoryProductFk: bundleCaptured.sim[1]!.inventoryProductId, 
                phoneAssociation: bundleCaptured.sim[1]!.phoneAssociation, 
                pin: bundleCaptured.sim[1]!.pin, 
                dataPlan: bundleCaptured.sim[1]!.dataPlan, 
                createdAt: DateTime.now()
              );
              break;
            default:
              break;
          }
        }
        return true;
      } else {
        // Gateway doesn't exist
        return false;
      }
    } catch (e) {
      print("Error in 'validateGatewayBackend': $e");
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


  Future<String> addNewBundleBackend(Users currentUser) async {
    try {
      if (await existsRegisterInBackend("router_sim_connection", "sim_detail_fk", simCard1!.simDetailId.toString()) 
      || await existsRegisterInBackend("router_sim_connection", "sim_detail_fk", simCard2!.simDetailId.toString()) ) {
        return "Duplicate";
      }
      final recordSim1 = await supabase.from('router_sim_connection').insert(
        {
          'port': 1,
          'router_detail_fk': gatewayCaptured!.routerDetailId,
          'sim_detail_fk': simCard1!.simDetailId,
          'created_by': currentUser.id
        },
      ).select<PostgrestList>('router_sim_connection_id');
      
      final recordSim2 = await supabase.from('router_sim_connection').insert(
        {
          'port': 2,
          'router_detail_fk': gatewayCaptured!.routerDetailId,
          'sim_detail_fk': simCard2!.simDetailId,
          'created_by': currentUser.id
        },
      ).select<PostgrestList>('router_sim_connection_id');

      if (recordSim1.isNotEmpty && recordSim2.isNotEmpty) {
        return "True";
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

  void clearGatewayControllers() {
    serialNumberTextController.clear();
    codeQRG =  "";
    codeQRSC =  "";
    gatewayCaptured = null;
  }
}