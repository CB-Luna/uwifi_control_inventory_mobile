import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';
import 'package:uwifi_control_inventory_mobile/models/router_sim_connection.dart';

class BundlesProvider extends ChangeNotifier {

  List<Bundle> bundles = [];
  List<RouterSIMConnection> routerSimConnection = [];

  final searchController = TextEditingController();

  Future<void> updateState(int idSequential) async {
    searchController.clear();
    await getBundles(idSequential);
  }

  Future<void> getBundles(int idSequential) async {
    try {
      routerSimConnection.clear();
      bundles.clear();
      // Se recuperan los bundles creados el día anteror y hoy
      // Obtener la fecha del día de hoy y la fecha de ayer
      DateTime today = DateTime.now();
      DateTime yesterday = today.subtract(const Duration(days: 1));

      DateTime startOfYesterday = DateTime(yesterday.year, yesterday.month, yesterday.day);
      DateTime endOfToday = DateTime(today.year, today.month, today.day, 23, 59, 59);

      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

      String formattedStartOfYesteday = format.format(startOfYesterday);
      String formattedEndOfToday = format.format(endOfToday);


      final res1 = await supabase
      .from('router_sim_connection')
      .select()
      .eq('created_by', idSequential)
      .gt('created_at', formattedStartOfYesteday).lt('created_at', formattedEndOfToday);

      // final res = await query.like('serial_no', '%${searchController.text}%').order(orden, ascending: true);

      if (res1 == null) {
        log('Error en getBundles()');
        return;
      } else {
        routerSimConnection = (res1 as List<dynamic>).map((routerSimConnection) => RouterSIMConnection.fromMap(routerSimConnection)).toList();
        // Extraer los valores de router_detail_fk y eliminar duplicados
        final routersId = routerSimConnection.map((connection) => connection.routerDetailFk).toSet().toList();
        for (var routerId in routersId) {
          final res2 = await supabase
            .from('router_details_view')
            .select()
            .eq('router_detail_id', routerId);

          if (res2[0] != null) {
            final bundle = res2[0];
            bundles.add(Bundle.fromJson(jsonEncode(bundle)));
          }
        }
      }

    } catch (e) {
      log('Error en getBundles() - $e');
    }
    notifyListeners();
  }

  Future<bool> deleteBundle(int routerDetailId, int idSequential) async {
    try {
      await supabase.from("router_sim_connection").delete().eq('router_detail_fk', routerDetailId);
    } catch (e) {
      log('Error en deleteBundle() - $e');
      return false;
    }
    await getBundles(idSequential);
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
