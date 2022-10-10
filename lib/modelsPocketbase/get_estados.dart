import 'dart:convert';

GetEstados getEstadosFromMap(String str) => GetEstados.fromMap(json.decode(str));

String getEstadosToMap(GetEstados data) => json.encode(data.toMap());

class GetEstados {
    GetEstados({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreEstado,
        required this.idStatusSyncFk,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreEstado;
    final String idStatusSyncFk;
    final bool activo;
    final String idEmiWeb;

    factory GetEstados.fromMap(Map<String, dynamic> json) => GetEstados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreEstado: json["nombre_estado"],
        idStatusSyncFk: json["id_status_sync_fk"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_estado": nombreEstado,
        "id_status_sync_fk": idStatusSyncFk,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
