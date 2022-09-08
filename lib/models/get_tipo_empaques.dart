import 'dart:convert';

GetTipoEmpaques getTipoEmpaquesFromMap(String str) => GetTipoEmpaques.fromMap(json.decode(str));

String getTipoEmpaquesToMap(GetTipoEmpaques data) => json.encode(data.toMap());

class GetTipoEmpaques {
    GetTipoEmpaques({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.tipoEmpaque,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String tipoEmpaque;
    final bool activo;

    factory GetTipoEmpaques.fromMap(Map<String, dynamic> json) => GetTipoEmpaques(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        tipoEmpaque: json["tipo_empaque"] == null ? null : json["tipo_empaque"],
        activo: json["activo"] == null ? null : json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "tipo_empaque": tipoEmpaque == null ? null : tipoEmpaque,
        "activo": activo == null ? null : activo,
    };
}
