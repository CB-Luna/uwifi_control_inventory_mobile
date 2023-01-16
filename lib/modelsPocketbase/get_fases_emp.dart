import 'dart:convert';

GetFasesEmp getFasesEmpFromMap(String str) => GetFasesEmp.fromMap(json.decode(str));

String getFasesEmpToMap(GetFasesEmp data) => json.encode(data.toMap());

class GetFasesEmp {
    GetFasesEmp({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.fase,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String fase;
    final String idEmiWeb;

    factory GetFasesEmp.fromMap(Map<String, dynamic> json) => GetFasesEmp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        fase: json["fase"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "fase": fase,
        "id_emi_web": idEmiWeb,
    };
}
