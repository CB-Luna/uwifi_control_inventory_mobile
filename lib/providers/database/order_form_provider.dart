import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card.dart';
import 'package:uwifi_control_inventory_mobile/models/suggestions_sims_config.dart';

class OrderFormProvider extends ChangeNotifier {

  Bundle? bundleCaptured;
  InventoryOrder? order;

  SIMSCard? simCard1;
  SIMSCard? simCard2;

  String provider = "";

  List<List<String>> suggestionsSimsConfig = [];

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

  Future<bool> searchSuggestionsSimsConfig() async {
    suggestionsSimsConfig.clear();
    try {
      if (order != null) {
        var urlAPI = Uri.parse("$urlAirflow/inventory/api");
        final headers = ({
          "Content-Type": "application/json",
        });
        var responseAPI = await post(urlAPI,
          headers: headers,
          body: json.encode(
              {
                  "action": "scan_zc_area",
                  "data": {
                      "zipcode": order!.customerZipcode,
                  }
              },
            ),
          );
        if (responseAPI.statusCode == 200) {
          //Se marca como ejecutada la instrucción en Bitacora
          final listResponseSuggestions = SuggestionsSimsConfig.fromJson(responseAPI.body);
          suggestionsSimsConfig = listResponseSuggestions.msg;
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function searchSuggestionsSimsConfig(): $e');
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
    if (value.contains(imeiSCRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchImeiSC = imeiSCRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchImeiSC != null) {
          imeiTextController.text =
              matchImeiSC.group(0)!.replaceAll(nameFieldImeiSC, "");
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

  Future<bool> autofillFieldsSIMCardOCR(String value, int number) async {
    if (value.contains(imeiSCRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchImeiSC = imeiSCRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchImeiSC != null) {
        await Future.microtask(() => {
          imeiTextController.text =
              matchImeiSC.group(0)!.replaceAll(nameFieldImeiSC, "")
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

  Future<bool> shippingBundleBundleAssignedV1() async {
    try {
      if (order != null) {
        var urlAPI = Uri.parse("$urlAirflow/api/v1/dags/shipping_bundle_bundle_assigned_v1/dagRuns");
        final headers = ({
          "Content-Type": "application/json",
          "Authorization": bearerAirflow
        });
        var responseAPI = await post(urlAPI,
          headers: headers,
          body: json.encode(
              {
                  "conf": {
                      "order_id": order!.orderId,
                      "router_inventory_product_id": bundleCaptured?.inventoryProductFk,
                      "sim_inventory_product_ids": [
                          bundleCaptured?.sim[0]?.inventoryProductId,
                          bundleCaptured?.sim[1]?.inventoryProductId
                      ]
                  },
                  "note": "DAG runned by API"
              },
            ),
          );
        if (responseAPI.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function shippingBundleBundleAssignedV1(): $e');
      return false;
    }
  }

  Future<bool> shippingBundleBundleAssignedCarriersAssignedV1(List<String> sku) async {
    try {
      if (order != null) {
        var urlAPI = Uri.parse("$urlAirflow/api/v1/dags/shipping_bundle_bundle_assigned_v1/dagRuns");
        final headers = ({
          "Content-Type": "application/json",
          "Authorization": bearerAirflow
        });
        var responseAPI = await post(urlAPI,
          headers: headers,
          body: json.encode(
              {
                  "conf": {
                      "order_id": order!.orderId,
                      "router_inventory_product_id": bundleCaptured?.inventoryProductFk,
                      "sim_inventory_product_ids": [
                          bundleCaptured?.sim[0]?.inventoryProductId,
                          bundleCaptured?.sim[1]?.inventoryProductId
                      ]
                  },
                  "note": "DAG runned by API"
              },
            ),
          );
        if (responseAPI.statusCode == 200) {
          var urlAPI2 = Uri.parse("$urlAirflow/api/v1/dags/shipping_bundle_bundle_carriers_assigned_v1/dagRuns");
          final headers2 = ({
            "Content-Type": "application/json",
            "Authorization": bearerAirflow
          });
          var responseAPI2 = await post(urlAPI2,
            headers: headers2,
            body: json.encode(
                {
                    "conf": {
                        "order_id": order!.orderId,
                        "router_inventory_product_id": bundleCaptured?.inventoryProductFk,
                        "sim_inventory_product_ids": [
                            bundleCaptured?.sim[0]?.inventoryProductId,
                            bundleCaptured?.sim[1]?.inventoryProductId
                        ],
                        "carriers": [
                            sku[0],
                            sku[1]
                        ]
                    },
                    "note": "DAG runned by API"
                },
              ),
            );
          if (responseAPI2.statusCode == 200) {
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
    } catch (e) {
      print('ERROR - function shippingBundleBundleAssignedV1(): $e');
      return false;
    }
  }


  Future<bool> shippingBundleBundlePackagedV1() async {
    try {
      if (order != null) {
        if (order != null) {
        final res1 = await supabase
            .from('order_product')
            .select('inventory_product_fk')
            .eq('order_fk', order!.orderId);

        if (res1[0] != null) {
          final inventoryProductFk = res1[0]['inventory_product_fk'];
          final res2 = await supabase
            .from('router_details_view')
            .select()
            .eq('inventory_product_fk', inventoryProductFk);

          if (res2[0] != null) {
            final bundle = res2[0];
            bundleCaptured = Bundle.fromJson(jsonEncode(bundle));
            var urlAPI = Uri.parse("$urlAirflow/api/v1/dags/shipping_bundle_bundle_packaged_v1/dagRuns");
            final headers = ({
              "Content-Type": "application/json",
              "Authorization": bearerAirflow
            });
            var responseAPI = await post(urlAPI,
              headers: headers,
              body: json.encode(
                  {
                      "conf": {
                          "order_id": order!.orderId,
                          "router_inventory_product_id": bundleCaptured?.inventoryProductFk,
                          "sim_inventory_product_ids": [
                              bundleCaptured?.sim[0]?.inventoryProductId,
                              bundleCaptured?.sim[1]?.inventoryProductId
                          ]
                      },
                      "note": "DAG runned by API"
                  },
                ),
              );
            if (responseAPI.statusCode == 200) {
              //Se marca como ejecutada la instrucción en Bitacora
              return true;
            } else {
              return false;
            }
          } else {
            // Bundle doesn't exist
            return false;
          }
        } else {
          // SIM Card doesn't exist
          return false;
        }
      } else {
        return false;
      }
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function shippingBundleBundleAssignedV1(): $e');
      return false;
    }
  }


  Future<bool> existsRegisterInBackend(String table, String column, String idUnique) async {
    final results = await supabase.from(table).select().eq(column, idUnique);
    return results.isNotEmpty;
  }

  void clearBundleControllers() {
    suggestionsSimsConfig.clear();
    serialNumberTextController.clear();
    imeiTextController.clear();
    codeQRG =  "";
    codeQRSC =  "";
    bundleCaptured = null;
    simCard1 = null;
    simCard2 = null;
    order = null;
  }
}