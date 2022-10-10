import 'dart:convert';

GetAmbitoConsultoria getAmbitoConsultoriaFromMap(String str) => GetAmbitoConsultoria.fromMap(json.decode(str));

String getAmbitoConsultoriaToMap(GetAmbitoConsultoria data) => json.encode(data.toMap());

class GetAmbitoConsultoria {
    GetAmbitoConsultoria({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreAmbito,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreAmbito;
    final bool activo;
    final String idEmiWeb;

    factory GetAmbitoConsultoria.fromMap(Map<String, dynamic> json) => GetAmbitoConsultoria(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreAmbito: json["nombre_ambito"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_ambito": nombreAmbito,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
