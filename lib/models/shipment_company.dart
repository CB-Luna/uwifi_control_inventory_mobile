import 'dart:convert';

class ShipmentCompany {
  ShipmentCompany({
    required this.shipmentCompayId,
    required this.createdBy,
    required this.name,
    required this.createdAt
  });

  int shipmentCompayId;
  int createdBy;
  String name;
  DateTime createdAt;

  factory ShipmentCompany.fromJson(String str) => ShipmentCompany.fromMap(json.decode(str));

  factory ShipmentCompany.fromMap(Map<String, dynamic> json) {
    ShipmentCompany shipmentCompany = ShipmentCompany(
      shipmentCompayId: json["shipment_company_id"],
      createdBy: json['created_by'],
      name: json['name'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return shipmentCompany;
  }
}
