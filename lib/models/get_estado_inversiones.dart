import 'dart:convert';

GetEstadoInversiones getEstadoInversionesFromMap(String str) => GetEstadoInversiones.fromMap(json.decode(str));

String getEstadoInversionesToMap(GetEstadoInversiones data) => json.encode(data.toMap());

class GetEstadoInversiones {
    GetEstadoInversiones({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.estado,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String estado;

    factory GetEstadoInversiones.fromMap(Map<String, dynamic> json) => GetEstadoInversiones(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        estado: json["estado"] == null ? null : json["estado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "estado": estado == null ? null : estado,
    };
}
