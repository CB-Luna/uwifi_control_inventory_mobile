import 'dart:convert';

class GatewayBatchTemp {

  GatewayBatchTemp({
        required this.batchGatewayTempId,
        required this.createdAt,
        required this.wifiKey,
        required this.imei,
        required this.mac,
        required this.serialNumber,
        required this.batchDocumentFk,
        this.batchStatusFk,
    });

    int batchGatewayTempId;
    DateTime createdAt;
    String wifiKey;
    String imei;
    String mac;
    String serialNumber;
    int batchDocumentFk;
    int? batchStatusFk;

    factory GatewayBatchTemp.fromJson(String str) => GatewayBatchTemp.fromMap(json.decode(str));

    factory GatewayBatchTemp.fromMap(Map<String, dynamic> json) {
      GatewayBatchTemp gatewayBatchTemp = GatewayBatchTemp(
        batchGatewayTempId: json["batch_gateway_temp_id"],
        createdAt: DateTime.parse(json["created_at"]),
        wifiKey: json["wifi_key"],
        imei: json["imei"],
        mac: json["mac"],
        serialNumber: json["serial_number"],
        batchDocumentFk: json["batch_document_fk"],
        batchStatusFk: json["batch_status_fk"],
      );

      return gatewayBatchTemp;
    }
}
