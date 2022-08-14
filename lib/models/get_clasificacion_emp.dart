import 'dart:convert';

GetClasificacionEmp getClasificacionEmpFromMap(String str) => GetClasificacionEmp.fromMap(json.decode(str));

String getClasificacionEmpToMap(GetClasificacionEmp data) => json.encode(data.toMap());

class GetClasificacionEmp {
    GetClasificacionEmp({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.clasificacion,
        required this.idStatusSyncFk,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final bool activo;
    final String clasificacion;
    final String idStatusSyncFk;

    factory GetClasificacionEmp.fromMap(Map<String, dynamic> json) => GetClasificacionEmp(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        activo: json["activo"] == null ? null : json["activo"],
        clasificacion: json["clasificacion"] == null ? null : json["clasificacion"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "activo": activo == null ? null : activo,
        "clasificacion": clasificacion == null ? null : clasificacion,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
