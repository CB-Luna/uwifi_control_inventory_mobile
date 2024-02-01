import 'dart:convert';

class RouterSIMConnection {
  RouterSIMConnection({
    required this.routerSIMConnectionId,
    required this.port,
    required this.routerDetailFk,
    required this.simDetailFk,
    required this.createdBy,
    required this.createdAt
  });

  int routerSIMConnectionId;
  String port;
  int routerDetailFk;
  int simDetailFk;
  int? createdBy;
  DateTime createdAt;

  factory RouterSIMConnection.fromJson(String str) => RouterSIMConnection.fromMap(json.decode(str));

  factory RouterSIMConnection.fromMap(Map<String, dynamic> json) {
    RouterSIMConnection routerSIMConnection = RouterSIMConnection(
      routerSIMConnectionId: json["router_sim_connection_id"],
      port: json['port'],
      routerDetailFk: json['router_detail_fk'],
      simDetailFk: json["sim_detail_fk"],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json["created_at"]),
    );

    return routerSIMConnection;
  }
}
