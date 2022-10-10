import 'dart:convert';

GetFamiliaProductos getFamiliaProductosFromMap(String str) => GetFamiliaProductos.fromMap(json.decode(str));

String getFamiliaProductosToMap(GetFamiliaProductos data) => json.encode(data.toMap());

class GetFamiliaProductos {
    GetFamiliaProductos({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreTipoProd,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreTipoProd;
    final bool activo;
    final String idEmiWeb;

    factory GetFamiliaProductos.fromMap(Map<String, dynamic> json) => GetFamiliaProductos(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreTipoProd: json["nombre_tipo_prod"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_tipo_prod": nombreTipoProd,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
