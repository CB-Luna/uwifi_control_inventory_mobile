import 'dart:convert';

class GatewayBatch {
  GatewayBatch({
    required this.serialNo,
    required this.imei,
    required this.mac,
    required this.wifiKey,
  });

  String serialNo;
  String imei;
  String mac;
  String wifiKey;

  factory GatewayBatch.fromJson(String str) => GatewayBatch.fromMap(json.decode(str));

  factory GatewayBatch.fromMap(Map<String, dynamic> json) {
    GatewayBatch gatewayBatch = GatewayBatch(
      serialNo: json['s/n'],
      imei: json['imei'],
      mac: json["mac"],
      wifiKey: json['wifi_key'],
    );

    return gatewayBatch;
  }
}
