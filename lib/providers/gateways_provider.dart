import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway.dart';

class GatewaysProvider extends ChangeNotifier {

  List<Gateway> gateways = [];

  final searchController = TextEditingController();

  String orden = "serial_no";

  Future<void> updateState() async {
    searchController.clear();
    await getGateways();
  }

  Future<void> getGateways() async {
    try {
      final res = await supabase.from('gateway_test_mobile').select();

      // final res = await query.like('serial_no', '%${searchController.text}%').order(orden, ascending: true);

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

  Future<void> deleteGateway(String serialNo) async {
    try {
      await supabase.from("gateway_test_mobile").delete().eq('serial_no', serialNo);
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
    }
    await getGateways();
    notifyListeners();
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
