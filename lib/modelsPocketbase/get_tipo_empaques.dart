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
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String tipoEmpaque;
    final bool activo;
    final String idEmiWeb;

    factory GetTipoEmpaques.fromMap(Map<String, dynamic> json) => GetTipoEmpaques(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        tipoEmpaque: json["tipo_empaque"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "tipo_empaque": tipoEmpaque,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
