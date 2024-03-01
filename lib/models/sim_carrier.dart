import 'dart:convert';

class SimCarrier {
  SimCarrier({
    required this.simCarrierId,
    required this.name,
    required this.createdAt
  });

  int simCarrierId;
  String name;
  DateTime createdAt;

  factory SimCarrier.fromJson(String str) => SimCarrier.fromMap(json.decode(str));

  factory SimCarrier.fromMap(Map<String, dynamic> json) {
    SimCarrier simCarrier = SimCarrier(
      simCarrierId: json["sim_carrier_id"],
      name: json['name'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return simCarrier;
  }
}
