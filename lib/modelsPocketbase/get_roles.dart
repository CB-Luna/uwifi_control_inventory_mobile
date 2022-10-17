import 'dart:convert';

GetRoles getRolesFromMap(String str) => GetRoles.fromMap(json.decode(str));

String getRolesToMap(GetRoles data) => json.encode(data.toMap());

class GetRoles {
    GetRoles({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.rol,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String rol;
    final String idEmiWeb;

    factory GetRoles.fromMap(Map<String, dynamic> json) => GetRoles(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        rol: json["rol"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "rol": rol,
        "id_emi_web": idEmiWeb,
    };
}
