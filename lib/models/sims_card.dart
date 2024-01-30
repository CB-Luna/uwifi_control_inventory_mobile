import 'dart:convert';

class SIMSCard {
  SIMSCard({
    required this.routerDetailId,
    required this.serialNo,
    required this.inventoryProductFk,
    required this.networkConfiguration,
    required this.location,
    this.idSIMSCardFkOne,
    this.idSIMSCardFkTwo,
    required this.createdAt
  });

  int routerDetailId;
  String serialNo;
  int inventoryProductFk;
  String networkConfiguration;
  String location;
  int? idSIMSCardFkOne;
  int? idSIMSCardFkTwo;
  DateTime createdAt;

  factory SIMSCard.fromJson(String str) => SIMSCard.fromMap(json.decode(str));

  factory SIMSCard.fromMap(Map<String, dynamic> json) {
    SIMSCard simsCard = SIMSCard(
      routerDetailId: json["router_detail_id"],
      serialNo: json['serie_no'],
      inventoryProductFk: json['inventory_product_fk'],
      networkConfiguration: json["network_configuration"],
      location: json['location'],
      idSIMSCardFkOne: json['id_sims_card_fk_one'],
      idSIMSCardFkTwo: json['id_sims_card_fk_two'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return simsCard;
  }
}
