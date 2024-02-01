import 'dart:convert';

class Bundle {
    final int routerDetailId;
    final DateTime createdAt;
    final String networkConfiguration;
    final int inventoryProductFk;
    final String serieNo;
    final String location;
    final List<Sim?> sim;

    Bundle({
        required this.routerDetailId,
        required this.createdAt,
        required this.networkConfiguration,
        required this.inventoryProductFk,
        required this.serieNo,
        required this.location,
        required this.sim,
    });

    factory Bundle.fromJson(String str) => Bundle.fromMap(json.decode(str));

    factory Bundle.fromMap(Map<String, dynamic> json) {
      Bundle bundle =  Bundle(
        routerDetailId: json["router_detail_id"],
        createdAt: DateTime.parse(json["created_at"]),
        networkConfiguration: json["network_configuration"],
        inventoryProductFk: json["inventory_product_fk"],
        serieNo: json["serie_no"],
        location: json["location"],
        sim: List<Sim>.from(json["sim"].map((x) => Sim.fromMap(x))),
      );

      return bundle;
    }

}

class Sim {
    final String pin;
    final String imei;
    final String port;
    final String? notes;
    final String? latitude;
    final String dataPlan;
    final String? longitude;
    final int statusId;
    final int operatorId;
    final String statusName;
    final String operatorName;
    final int simDetailId;
    final DateTime connectedAt;
    final DateTime? activationDate;
    final DateTime? expirationDate;
    final String phoneAssociation;
    final int inventoryProductId;

    Sim({
        required this.pin,
        required this.imei,
        required this.port,
        this.notes,
        this.latitude,
        required this.dataPlan,
        this.longitude,
        required this.statusId,
        required this.operatorId,
        required this.statusName,
        required this.operatorName,
        required this.simDetailId,
        required this.connectedAt,
        this.activationDate,
        this.expirationDate,
        required this.phoneAssociation,
        required this.inventoryProductId,
    });

    factory Sim.fromJson(String str) => Sim.fromMap(json.decode(str));

    factory Sim.fromMap(Map<String, dynamic> json) {
      Sim sim = Sim(
        pin: json["pin"],
        imei: json["IMEI"],
        port: json["port"],
        notes: json["notes"],
        latitude: json["latitude"],
        dataPlan: json["data_plan"],
        longitude: json["longitude"],
        statusId: json["status_id"],
        operatorId: json["operator_id"],
        statusName: json["status_name"],
        operatorName: json["operator_name"],
        simDetailId: json["sim_detail_id"],
        connectedAt: DateTime.parse(json["connected_at"]),
        activationDate: json["activation_date"] == null ? null : DateTime.parse(json["activation_date"]),
        expirationDate: json["expiration_date"] == null ? null : DateTime.parse(json["expiration_date"]),
        phoneAssociation: json["phone_association"],
        inventoryProductId: json["inventory_product_id"],
    );
  return sim;
  }
}

