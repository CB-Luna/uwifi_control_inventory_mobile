import 'dart:convert';

GetFamiliaInversion getFamiliaInversionFromMap(String str) => GetFamiliaInversion.fromMap(json.decode(str));

String getFamiliaInversionToMap(GetFamiliaInversion data) => json.encode(data.toMap());

class GetFamiliaInversion {
    GetFamiliaInversion({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.familiaInversion,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime created;
    final DateTime updated;
    final String familiaInversion;
    final bool activo;
    final String idEmiWeb;

    factory GetFamiliaInversion.fromMap(Map<String, dynamic> json) => GetFamiliaInversion(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        familiaInversion: json["familia_inversion"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "familia_inversion": familiaInversion,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
