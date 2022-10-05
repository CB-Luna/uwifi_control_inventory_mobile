import 'dart:convert';

GetBancos getBancosFromMap(String str) => GetBancos.fromMap(json.decode(str));

String getBancosToMap(GetBancos data) => json.encode(data.toMap());

class GetBancos {
    GetBancos({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreBanco,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreBanco;
    final bool activo;

    factory GetBancos.fromMap(Map<String, dynamic> json) => GetBancos(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreBanco: json["nombre_banco"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_banco": nombreBanco,
        "activo": activo,
    };
}
