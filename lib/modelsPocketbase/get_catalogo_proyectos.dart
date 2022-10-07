import 'dart:convert';

GetCatalogoProyectos getCatalogoProyectosFromMap(String str) => GetCatalogoProyectos.fromMap(json.decode(str));

String getCatalogoProyectosToMap(GetCatalogoProyectos data) => json.encode(data.toMap());

class GetCatalogoProyectos {
    GetCatalogoProyectos({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreProyecto,
        required this.idTipoProyectoFk,
        required this.idEmiWeb,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreProyecto;
    final String idTipoProyectoFk;
    final String idEmiWeb;
    final bool activo;

    factory GetCatalogoProyectos.fromMap(Map<String, dynamic> json) => GetCatalogoProyectos(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreProyecto: json["nombre_proyecto"],
        idTipoProyectoFk: json["id_tipo_proyecto_fk"],
        idEmiWeb: json["id_emi_web"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_proyecto": nombreProyecto,
        "id_tipo_proyecto_fk": idTipoProyectoFk,
        "id_emi_web": idEmiWeb,
        "activo": activo,
    };
}
