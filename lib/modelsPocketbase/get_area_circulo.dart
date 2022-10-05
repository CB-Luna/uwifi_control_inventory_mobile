import 'dart:convert';

GetAreaCirculo getAreaCirculoFromMap(String str) => GetAreaCirculo.fromMap(json.decode(str));

String getAreaCirculoToMap(GetAreaCirculo data) => json.encode(data.toMap());

class GetAreaCirculo {
    GetAreaCirculo({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.nombreArea,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final bool activo;
    final String nombreArea;

    factory GetAreaCirculo.fromMap(Map<String, dynamic> json) => GetAreaCirculo(
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        activo: json["activo"],
        nombreArea: json["nombre_area"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "activo": activo,
        "nombre_area": nombreArea,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
