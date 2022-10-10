import 'dart:convert';

GetAreaCirculo getAreaCirculoFromMap(String str) => GetAreaCirculo.fromMap(json.decode(str));

String getAreaCirculoToMap(GetAreaCirculo data) => json.encode(data.toMap());

class GetAreaCirculo {
    GetAreaCirculo({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreArea,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreArea;
    final bool activo;
    final String idEmiWeb;

    factory GetAreaCirculo.fromMap(Map<String, dynamic> json) => GetAreaCirculo(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreArea: json["nombre_area"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_area": nombreArea,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
