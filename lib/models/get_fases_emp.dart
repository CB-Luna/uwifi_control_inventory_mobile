import 'dart:convert';

GetFasesEmp getFasesEmpFromMap(String str) => GetFasesEmp.fromMap(json.decode(str));

String getFasesEmpToMap(GetFasesEmp data) => json.encode(data.toMap());

class GetFasesEmp {
    GetFasesEmp({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.fase,
        required this.idStatusSyncFk,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String fase;
    final String idStatusSyncFk;

    factory GetFasesEmp.fromMap(Map<String, dynamic> json) => GetFasesEmp(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        fase: json["fase"] == null ? null : json["fase"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "fase": fase == null ? null : fase,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
    };
}
