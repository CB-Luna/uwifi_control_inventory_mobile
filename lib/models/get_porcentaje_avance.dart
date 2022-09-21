import 'dart:convert';

GetPorcentajeAvance getPorcentajeAvanceFromMap(String str) => GetPorcentajeAvance.fromMap(json.decode(str));

String getPorcentajeAvanceToMap(GetPorcentajeAvance data) => json.encode(data.toMap());

class GetPorcentajeAvance {
    GetPorcentajeAvance({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.porcentaje,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final int porcentaje;
    final bool activo;

    factory GetPorcentajeAvance.fromMap(Map<String, dynamic> json) => GetPorcentajeAvance(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        porcentaje: json["porcentaje"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "porcentaje": porcentaje,
        "activo": activo,
    };
}

