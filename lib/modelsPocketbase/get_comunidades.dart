import 'dart:convert';

GetComunidades getComunidadesFromMap(String str) => GetComunidades.fromMap(json.decode(str));

String getComunidadesToMap(GetComunidades data) => json.encode(data.toMap());

class GetComunidades {
    GetComunidades({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreComunidad,
        required this.idMunicipioFk,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreComunidad;
    final String idMunicipioFk;
    final bool activo;
    final String idEmiWeb;

    factory GetComunidades.fromMap(Map<String, dynamic> json) => GetComunidades(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreComunidad: json["nombre_comunidad"],
        idMunicipioFk: json["id_municipio_fk"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_comunidad": nombreComunidad,
        "id_municipio_fk": idMunicipioFk,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
