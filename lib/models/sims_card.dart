import 'dart:convert';

class SIMSCard {
  SIMSCard({
    required this.simDetailId,
    required this.inventoryProductFk,
    required this.phoneAssociation,
    required this.pin,
    required this.dataPlan,
    this.imei,
    required this.createdAt
  });

  int simDetailId;
  int inventoryProductFk;
  String phoneAssociation;
  String pin;
  String dataPlan;
  String? imei;
  DateTime createdAt;

  factory SIMSCard.fromJson(String str) => SIMSCard.fromMap(json.decode(str));

  factory SIMSCard.fromMap(Map<String, dynamic> json) {
    SIMSCard simsCard = SIMSCard(
      simDetailId: json["sim_detail_id"],
      inventoryProductFk: json['inventory_product_fk'],
      phoneAssociation: json['phone_association'],
      pin: json['pin'],
      dataPlan: json["data_plan"],
      imei: json['imei'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return simsCard;
  }
}
