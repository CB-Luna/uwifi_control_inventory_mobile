import 'dart:convert';

class SimCardBatchTemp {
    int batchSimCardTempId;
    DateTime createdAt;
    int batchDocumentFk;
    int? batchStatusFk;
    String sapId;
    String imei;

    SimCardBatchTemp({
        required this.batchSimCardTempId,
        required this.createdAt,
        required this.batchDocumentFk,
        this.batchStatusFk,
        required this.sapId,
        required this.imei,
    });

    factory SimCardBatchTemp.fromJson(String str) => SimCardBatchTemp.fromMap(json.decode(str));

    factory SimCardBatchTemp.fromMap(Map<String, dynamic> json) {
    SimCardBatchTemp simCardBatchTemp =  SimCardBatchTemp(
        batchSimCardTempId: json["batch_sim_card_temp_id"],
        createdAt: DateTime.parse(json["created_at"]),
        batchDocumentFk: json["batch_document_fk"],
        batchStatusFk: json["batch_status_fk"],
        sapId: json["sap_id"],
        imei: json["imei"],
    );
    return simCardBatchTemp;
    }

}
