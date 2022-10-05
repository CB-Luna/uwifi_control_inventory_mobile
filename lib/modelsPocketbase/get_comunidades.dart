// To parse this JSON data, do
//
//     final getComunidades = getComunidadesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetComunidades getComunidadesFromMap(String str) => GetComunidades.fromMap(json.decode(str));

String getComunidadesToMap(GetComunidades data) => json.encode(data.toMap());

class GetComunidades {
    GetComunidades({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.idMunicipioFk,
        required this.idStatusSyncFk,
        required this.nombreComunidad,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final bool activo;
    final String idMunicipioFk;
    final String idStatusSyncFk;
    final String nombreComunidad;

    factory GetComunidades.fromMap(Map<String, dynamic> json) => GetComunidades(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        activo: json["activo"] == null ? null : json["activo"],
        idMunicipioFk: json["id_municipio_fk"] == null ? null : json["id_municipio_fk"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
        nombreComunidad: json["nombre_comunidad"] == null ? null : json["nombre_comunidad"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "activo": activo == null ? null : activo,
        "id_municipio_fk": idMunicipioFk == null ? null : idMunicipioFk,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
        "nombre_comunidad": nombreComunidad == null ? null : nombreComunidad,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
