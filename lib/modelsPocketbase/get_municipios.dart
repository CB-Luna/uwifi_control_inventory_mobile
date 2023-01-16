import 'dart:convert';

GetMunicipios getMunicipiosFromMap(String str) => GetMunicipios.fromMap(json.decode(str));

String getMunicipiosToMap(GetMunicipios data) => json.encode(data.toMap());

class GetMunicipios {
    GetMunicipios({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreMunicipio,
        required this.idEstadoFk,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreMunicipio;
    final String idEstadoFk;
    final bool activo;
    final String idEmiWeb;

    factory GetMunicipios.fromMap(Map<String, dynamic> json) => GetMunicipios(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreMunicipio: json["nombre_municipio"],
        idEstadoFk: json["id_estado_fk"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_municipio": nombreMunicipio,
        "id_estado_fk": idEstadoFk,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
