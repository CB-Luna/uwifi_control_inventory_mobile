import 'dart:convert';

GetEstadosProdCotizados getEstadosProdCotizadosFromMap(String str) => GetEstadosProdCotizados.fromMap(json.decode(str));

String getEstadosProdCotizadosToMap(GetEstadosProdCotizados data) => json.encode(data.toMap());

class GetEstadosProdCotizados {
    GetEstadosProdCotizados({
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

    factory GetEstadosProdCotizados.fromMap(Map<String, dynamic> json) => GetEstadosProdCotizados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        estado: json["estado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "estado": estado,
    };
}
