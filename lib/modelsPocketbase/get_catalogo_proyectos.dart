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
        required this.idTipoProyecto,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreProyecto;
    final String idTipoProyecto;

    factory GetCatalogoProyectos.fromMap(Map<String, dynamic> json) => GetCatalogoProyectos(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreProyecto: json["nombre_proyecto"],
        idTipoProyecto: json["id_tipo_proyecto"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_proyecto": nombreProyecto,
        "id_tipo_proyecto": idTipoProyecto,
    };
}
