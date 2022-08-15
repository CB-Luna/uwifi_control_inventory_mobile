import 'dart:convert';

GetCatalogoProyectos getCatalogoProyectosFromMap(String str) => GetCatalogoProyectos.fromMap(json.decode(str));

String getCatalogoProyectosToMap(GetCatalogoProyectos data) => json.encode(data.toMap());

class GetCatalogoProyectos {
    GetCatalogoProyectos({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.idClasificacionEmprendimiento,
        required this.nombreProyecto,
    });

    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String collectionId;
    final String collectionName;
    final Expand? expand;
    final String idClasificacionEmprendimiento;
    final String nombreProyecto;

    factory GetCatalogoProyectos.fromMap(Map<String, dynamic> json) => GetCatalogoProyectos(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        expand: json["@expand"] == null ? null : Expand.fromMap(json["@expand"]),
        idClasificacionEmprendimiento: json["id_clasificacion_emprendimiento"] == null ? null : json["id_clasificacion_emprendimiento"],
        nombreProyecto: json["nombre_proyecto"] == null ? null : json["nombre_proyecto"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "id_clasificacion_emprendimiento": idClasificacionEmprendimiento == null ? null : idClasificacionEmprendimiento,
        "nombre_proyecto": nombreProyecto == null ? null : nombreProyecto,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
