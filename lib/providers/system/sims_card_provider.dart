import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card.dart';
class SIMSCardProvider extends ChangeNotifier {

  List<SIMSCard> simsCard = [];

  final searchController = TextEditingController();

  Future<void> updateState(int userID) async {
    searchController.clear();
    await getSIMSCard(userID);
  }

  Future<void> getSIMSCard(int userID) async {
    try {
      simsCard.clear();
      // Se recuperan los simsCard creados el día anteror y hoy

      var res = await supabase.rpc(
          'search_simcards_recently',
          params: {
            "busqueda": searchController.text,
            "created_by_user_id": userID
          },
        ).select();

      if (res == null) {
        log('Error en getSIMSCard()');
        return;
      }

      simsCard = (res as List<dynamic>).map((simCard) => SIMSCard.fromMap(simCard)).toList();

    } catch (e) {
      log('Error en getSIMSCard() - $e');
    }
    notifyListeners();
  }

  Future<bool> deleteSIMSCard(int inventoryProductFk, int userID) async {
    try {
      await supabase.from("sim_detail").delete().eq('inventory_product_fk', inventoryProductFk);
      await supabase.from("inventory_product").delete().eq('inventory_product_id', inventoryProductFk);
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
      return false;
    }
    await getSIMSCard(userID);
    notifyListeners();
    return true;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
