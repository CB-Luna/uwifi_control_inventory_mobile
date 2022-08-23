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
        required this.idStatusSyncFk,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String rol;
    final String idStatusSyncFk;

    factory GetRoles.fromMap(Map<String, dynamic> json) => GetRoles(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        rol: json["rol"] == null ? null : json["rol"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "rol": rol == null ? null : rol,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
    };
}
