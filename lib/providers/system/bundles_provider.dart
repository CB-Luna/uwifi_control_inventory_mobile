import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';

class BundlesProvider extends ChangeNotifier {

  List<Bundle> bundles = [];

  final searchController = TextEditingController();

  Future<void> updateState(int userID) async {
    searchController.clear();
    await getBundles(userID);
  }

  Future<void> getBundles(int userID) async {
    try {
      bundles.clear();
      // Se recuperan los bundles creados el día anteror y hoy
      var res = await supabase.rpc(
        'search_bundles_recently',
        params: {
          "busqueda": searchController.text,
          "created_by_user_id": userID
        },
      ).select();

      if (res == null) {
        log('Error en getBundles()');
        return;
      }

      bundles = (res as List<dynamic>).map((bundle) => Bundle.fromMap(bundle)).toList();

    } catch (e) {
      log('Error en getBundles() - $e');
    }
    notifyListeners();
  }

  Future<bool> deleteBundle(int routerDetailId, int userID) async {
    try {
      await supabase.from("router_sim_connection").delete().eq('router_detail_fk', routerDetailId);
    } catch (e) {
      log('Error en deleteBundle() - $e');
      return false;
    }
    await getBundles(userID);
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
