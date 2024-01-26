import 'dart:convert';

class Gateway {
  Gateway({
    required this.id,
    required this.serialNo,
    required this.productId,
    required this.brand,
    required this.model,
    this.idSIMSCardFkOne,
    this.idSIMSCardFkTwo,
    required this.createdAt
  });

  int id;
  String serialNo;
  int productId;
  String brand;
  String model;
  int? idSIMSCardFkOne;
  int? idSIMSCardFkTwo;
  DateTime createdAt;

  factory Gateway.fromJson(String str) => Gateway.fromMap(json.decode(str));

  factory Gateway.fromMap(Map<String, dynamic> json) {
    Gateway gateway = Gateway(
      id: json["id"],
      serialNo: json['serial_no'],
      productId: json['product_id'],
      brand: json["brand"],
      model: json['model'],
      idSIMSCardFkOne: json['id_sims_card_fk_one'],
      idSIMSCardFkTwo: json['id_sims_card_fk_two'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return gateway;
  }
}
