import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/models/router_sim_connection.dart';

class OrdersDeliveryProvider extends ChangeNotifier {

  List<InventoryOrder> ordersDelivery = [];
  List<RouterSIMConnection> routerSimConnection = [];

  final searchController = TextEditingController();

  Future<void> updateState() async {
    searchController.clear();
    await getOrdersDelivery();
  }

  Future<void> getOrdersDelivery() async {
      routerSimConnection.clear();
      ordersDelivery.clear();
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
            if (order.orderActions!.first.status == "Waiting for Delivery") {
              ordersDelivery.add(order);
            }
          }
        }
      } catch (e) {
        log('Error en getOrdersDelivery() - $e');
      }
      notifyListeners();
  }

  Future<bool> deleteOrderDelivery(int routerDetailId, int idSequential) async {
    try {
      await supabase.from("router_sim_connection").delete().eq('router_detail_fk', routerDetailId);
    } catch (e) {
      log('Error en deleteOrderDelivery() - $e');
      return false;
    }
    await getOrdersDelivery();
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
