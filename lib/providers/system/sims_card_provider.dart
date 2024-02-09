import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card.dart';

class SIMSCardProvider extends ChangeNotifier {

  List<SIMSCard> simsCard = [];

  final searchController = TextEditingController();

  Future<void> updateState() async {
    searchController.clear();
    await getSIMSCard();
  }

  Future<void> getSIMSCard() async {
    try {
      simsCard.clear();
      // Se recuperan los simsCard creados el día anteror y hoy
      // Obtener la fecha del día de hoy y la fecha de ayer
      DateTime today = DateTime.now();
      DateTime yesterday = today.subtract(const Duration(days: 1));

      DateTime startOfYesterday = DateTime(yesterday.year, yesterday.month, yesterday.day);
      DateTime endOfToday = DateTime(today.year, today.month, today.day, 23, 59, 59);

      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

      String formattedStartOfYesteday = format.format(startOfYesterday);
      String formattedEndOfToday = format.format(endOfToday);


      final res = await supabase
      .from('sim_detail')
      .select()
      .gt('created_at', formattedStartOfYesteday).lt('created_at', formattedEndOfToday);

      // final res = await query.like('serial_no', '%${searchController.text}%').order(orden, ascending: true);

      if (res == null) {
        log('Error en getSIMSCard()');
        return;
      }

      simsCard = (res as List<dynamic>).map((simCard) => SIMSCard.fromMap(simCard)).toList();

      simsCard.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    } catch (e) {
      log('Error en getSIMSCard() - $e');
    }
    notifyListeners();
  }

  Future<bool> deleteSIMSCard(int inventoryProductFk) async {
    try {
      await supabase.from("sim_detail").delete().eq('inventory_product_fk', inventoryProductFk);
      await supabase.from("inventory_product").delete().eq('inventory_product_id', inventoryProductFk);
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
      return false;
    }
    await getSIMSCard();
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
