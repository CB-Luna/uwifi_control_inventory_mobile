import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway.dart';

class GatewaysProvider extends ChangeNotifier {

  List<Gateway> gateways = [];

  final searchController = TextEditingController();

  Future<void> updateState(int userID) async {
    searchController.clear();
    await getGateways(userID);
  }

  Future<void> getGateways(int userID) async {
    try {
      gateways.clear();
      // Se recuperan los gateways creados el día anteror y hoy

      var res = await supabase.rpc(
          'search_gateways_recently',
          params: {
            "busqueda": searchController.text,
            "created_by_user_id": userID
          },
        ).select();

      if (res == null) {
        log('Error en getGateways()');
        return;
      }

      gateways = (res as List<dynamic>).map((gateway) => Gateway.fromMap(gateway)).toList();

    } catch (e) {
      log('Error en getGateways() - $e');
    }
    notifyListeners();
  }

  Future<bool> deleteGateway(int inventoryProductFk, int userId) async {
    try {
      await supabase.from("router_detail").delete().eq('inventory_product_fk', inventoryProductFk);
      await supabase.from("inventory_product").delete().eq('inventory_product_id', inventoryProductFk);
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
      return false;
    }
    await getGateways(userId);
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
