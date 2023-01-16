import 'dart:convert';

List<GetSingleConsultoriasPocketbase> getSingleConsultoriasPocketbaseFromMap(String str) => List<GetSingleConsultoriasPocketbase>.from(json.decode(str).map((x) => GetSingleConsultoriasPocketbase.fromMap(x)));

String getSingleConsultoriasPocketbaseToMap(List<GetSingleConsultoriasPocketbase> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GetSingleConsultoriasPocketbase {
    GetSingleConsultoriasPocketbase({
        required this.id,
        required this.created,
        required this.updated,
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        this.comentarios,
        required this.descripcion,
        required this.fechaRevision,
        required this.idEmiWeb,
        this.idImagenesFk,
        this.idPorcentajeFk,
        required this.jornada,
        required this.tarea,
    });

    final String id;
    final DateTime created;
    final DateTime updated;
    final String collectionId;
    final String collectionName;
    final Expand expand;
    final String? comentarios;
    final String descripcion;
    final DateTime fechaRevision;
    final String idEmiWeb;
    final List<String>? idImagenesFk;
    final String? idPorcentajeFk;
    final bool jornada;
    final String tarea;

    factory GetSingleConsultoriasPocketbase.fromMap(Map<String, dynamic> json) => GetSingleConsultoriasPocketbase(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: Expand.fromMap(json["@expand"]),
        comentarios: json["comentarios"],
        descripcion: json["descripcion"],
        fechaRevision: DateTime.parse(json["fecha_revision"]),
        idEmiWeb: json["id_emi_web"],
        idImagenesFk: json["id_imagenes_fk"] == null ? null : List<String>.from(json["id_imagenes_fk"].map((x) => x)),
        idPorcentajeFk: json["id_porcentaje_fk"],
        jornada: json["jornada"],
        tarea: json["tarea"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "comentarios": comentarios,
        "descripcion": descripcion,
        "fecha_revision": fechaRevision == null ? null : fechaRevision.toIso8601String(),
        "id_emi_web": idEmiWeb,
        "id_imagenes_fk": idImagenesFk == null ? null : List<dynamic>.from(idImagenesFk!.map((x) => x)),
        "id_porcentaje_fk": idPorcentajeFk,
        "jornada": jornada,
        "tarea": tarea,
    };
}

class Expand {
    Expand();

    factory Expand.fromMap(Map<String, dynamic> json) => Expand(
    );

    Map<String, dynamic> toMap() => {
    };
}
