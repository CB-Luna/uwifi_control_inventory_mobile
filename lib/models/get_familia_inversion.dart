import 'dart:convert';

GetFamiliaInversion getFamiliaInversionFromMap(String str) => GetFamiliaInversion.fromMap(json.decode(str));

String getFamiliaInversionToMap(GetFamiliaInversion data) => json.encode(data.toMap());

class GetFamiliaInversion {
    GetFamiliaInversion({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.nombreFamiliaInver,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final bool activo;
    final String nombreFamiliaInver;

    factory GetFamiliaInversion.fromMap(Map<String, dynamic> json) => GetFamiliaInversion(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        activo: json["activo"] == null ? null : json["activo"],
        nombreFamiliaInver: json["nombre_familia_inver"] == null ? null : json["nombre_familia_inver"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "activo": activo == null ? null : activo,
        "nombre_familia_inver": nombreFamiliaInver == null ? null : nombreFamiliaInver,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
