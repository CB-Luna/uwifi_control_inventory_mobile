import 'dart:convert';

GetMunicipios getMunicipiosFromMap(String str) => GetMunicipios.fromMap(json.decode(str));

String getMunicipiosToMap(GetMunicipios data) => json.encode(data.toMap());

class GetMunicipios {
    GetMunicipios({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.idEstadoFk,
        required this.idStatusSyncFk,
        required this.nombreMunicipio,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final bool activo;
    final String idEstadoFk;
    final String idStatusSyncFk;
    final String nombreMunicipio;

    factory GetMunicipios.fromMap(Map<String, dynamic> json) => GetMunicipios(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        activo: json["activo"] == null ? null : json["activo"],
        idEstadoFk: json["id_estado_fk"] == null ? null : json["id_estado_fk"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
        nombreMunicipio: json["nombre_municipio"] == null ? null : json["nombre_municipio"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "activo": activo == null ? null : activo,
        "id_estado_fk": idEstadoFk == null ? null : idEstadoFk,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
        "nombre_municipio": nombreMunicipio == null ? null : nombreMunicipio,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
