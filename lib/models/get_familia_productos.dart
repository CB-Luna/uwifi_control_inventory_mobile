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
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreTipoProd;
    final bool activo;

    factory GetFamiliaProductos.fromMap(Map<String, dynamic> json) => GetFamiliaProductos(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreTipoProd: json["nombre_tipo_prod"] == null ? null : json["nombre_tipo_prod"],
        activo: json["activo"] == null ? null : json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_tipo_prod": nombreTipoProd == null ? null : nombreTipoProd,
        "activo": activo == null ? null : activo,
    };
}
