import 'dart:convert';

GetBasicJornadaPocketbase getBasicJornadaPocketbaseFromMap(String str) => GetBasicJornadaPocketbase.fromMap(json.decode(str));

String getBasicJornadaPocketbaseToMap(GetBasicJornadaPocketbase data) => json.encode(data.toMap());

class GetBasicJornadaPocketbase {
    GetBasicJornadaPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Jornada> items;

    factory GetBasicJornadaPocketbase.fromMap(Map<String, dynamic> json) => GetBasicJornadaPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<Jornada>.from(json["items"].map((x) => Jornada.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Jornada {
    Jornada({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.completada,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idEmprendimientoFk,
        required this.idStatusSyncFk,
        required this.idTareaFk,
        required this.numJornada,
        required this.proximaVisita,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final TareaExpand expand;
    final bool completada;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String idEmprendimientoFk;
    final String idStatusSyncFk;
    final String idTareaFk;
    final int numJornada;
    final DateTime? proximaVisita;
    final DateTime? updated;

    factory Jornada.fromMap(Map<String, dynamic> json) => Jornada(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: TareaExpand.fromMap(json["@expand"]),
        completada: json["completada"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        idTareaFk: json["id_tarea_fk"],
        numJornada: json["num_jornada"],
        proximaVisita: json["proxima_visita"] == null ? null : DateTime.parse(json["proxima_visita"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "completada": completada,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_emprendimiento_fk": idEmprendimientoFk,
        "id_status_sync_fk": idStatusSyncFk,
        "id_tarea_fk": idTareaFk,
        "num_jornada": numJornada,
        "proxima_visita": proximaVisita == null ? null : proximaVisita!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class TareaExpand {
    TareaExpand({
        required this.idTareaFk,
    });

    final TareaBasic idTareaFk;

    factory TareaExpand.fromMap(Map<String, dynamic> json) => TareaExpand(
        idTareaFk: TareaBasic.fromMap(json["id_tarea_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_tarea_fk": idTareaFk.toMap(),
    };
}

class TareaBasic {
    TareaBasic({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.comentarios,
        required this.created,
        required this.descripcion,
        required this.fechaRevision,
        required this.id,
        required this.idEmiWeb,
        required this.idImagenesFk,
        required this.idPorcentajeFk,
        required this.idStatusSyncFk,
        required this.tarea,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final TareaBasicExpand expand;
    final String? comentarios;
    final DateTime? created;
    final String descripcion;
    final DateTime? fechaRevision;
    final String id;
    final String idEmiWeb;
    final List<String>? idImagenesFk;
    final String idPorcentajeFk;
    final String idStatusSyncFk;
    final String tarea;
    final DateTime? updated;

    factory TareaBasic.fromMap(Map<String, dynamic> json) => TareaBasic(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: TareaBasicExpand.fromMap(json["@expand"]),
        comentarios: json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        fechaRevision: json["fecha_revision"] == null ? null : DateTime.parse(json["fecha_revision"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenesFk: json["id_imagenes_fk"] == null ? null : List<String>.from(json["id_imagenes_fk"].map((x) => x)),
        idPorcentajeFk: json["id_porcentaje_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        tarea: json["tarea"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "comentarios": comentarios,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "fecha_revision": fechaRevision == null ? null : fechaRevision!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_imagenes_fk": idImagenesFk == null ? null : List<dynamic>.from(idImagenesFk!.map((x) => x)),
        "id_porcentaje_fk": idPorcentajeFk,
        "id_status_sync_fk": idStatusSyncFk,
        "tarea": tarea,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class TareaBasicExpand {
    TareaBasicExpand({
        required this.idImagenesFk,
    });

    final List<ImagenBasic> idImagenesFk;

    factory TareaBasicExpand.fromMap(Map<String, dynamic> json) => TareaBasicExpand(
        idImagenesFk: List<ImagenBasic>.from(json["id_imagenes_fk"].map((x) => ImagenBasic.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id_imagenes_fk": List<dynamic>.from(idImagenesFk.map((x) => x.toMap())),
    };
}

class ImagenBasic {
    ImagenBasic({
        required this.collectionId,
        required this.collectionName,
        required this.base64,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.nombre,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final String base64;
    final DateTime? created;
    final String id;
    final String? idEmiWeb;
    final String nombre;
    final DateTime? updated;

    factory ImagenBasic.fromMap(Map<String, dynamic> json) => ImagenBasic(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        base64: json["base64"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        nombre: json["nombre"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "base64": base64,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "nombre": nombre,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
