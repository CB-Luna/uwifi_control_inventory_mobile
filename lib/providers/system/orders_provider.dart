import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/models/router_sim_connection.dart';

class OrdersProvider extends ChangeNotifier {

  List<InventoryOrder> orders = [];
  List<RouterSIMConnection> routerSimConnection = [];

  final searchController = TextEditingController();

  Future<void> updateState() async {
    searchController.clear();
    await getOrders();
  }

  Future<void> getOrders() async {
      routerSimConnection.clear();
      orders.clear();
      try {
        var resOrders = await supabase.rpc(
          'inventory_orders',
          params: {
            "search": searchController.text,
          },
        ).select();

        if (resOrders != null) {
          final totalOrders = (resOrders as List<dynamic>).map((product) => InventoryOrder.fromMap(product)).toList();
          for (InventoryOrder order in totalOrders) {
            order.orderActions!.sort((a, b) => b.startedAt!.compareTo(a.startedAt!));
            if (order.orderActions!.first.status == "Waiting for Equipment Assignment" ||
                order.orderActions!.first.status == "Waiting for Packaging") {
              orders.add(order);
            }
          }
          orders.sort((a, b) => b.orderCreation!.compareTo(a.orderCreation!));
        }
      } catch (e) {
        log('Error en getOrders() - $e');
      }
      notifyListeners();
  }

  Future<bool> deleteOrder(int routerDetailId, int idSequential) async {
    try {
      await supabase.from("router_sim_connection").delete().eq('router_detail_fk', routerDetailId);
    } catch (e) {
      log('Error en deleteOrder() - $e');
      return false;
    }
    await getOrders();
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
