import 'dart:convert';

GetBasicConsultoriaPocketbase getBasicConsultoriaPocketbaseFromMap(String str) => GetBasicConsultoriaPocketbase.fromMap(json.decode(str));

String getBasicConsultoriaPocketbaseToMap(GetBasicConsultoriaPocketbase data) => json.encode(data.toMap());

class GetBasicConsultoriaPocketbase {
    GetBasicConsultoriaPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Consultoria> items;

    factory GetBasicConsultoriaPocketbase.fromMap(Map<String, dynamic> json) => GetBasicConsultoriaPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<Consultoria>.from(json["items"].map((x) => Consultoria.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Consultoria {
    Consultoria({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.archivado,
        required this.created,
        required this.id,
        required this.idAmbitoFk,
        required this.idAreaCirculoFk,
        required this.idEmiWeb,
        required this.idEmprendimientoFk,
        required this.idStatusSyncFk,
        required this.idTareaFk,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final ConsultoriaExpand expand;
    final bool archivado;
    final DateTime? created;
    final String id;
    final String idAmbitoFk;
    final String idAreaCirculoFk;
    final String idEmiWeb;
    final String idEmprendimientoFk;
    final String idStatusSyncFk;
    final List<String> idTareaFk;
    final DateTime? updated;

    factory Consultoria.fromMap(Map<String, dynamic> json) => Consultoria(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ConsultoriaExpand.fromMap(json["@expand"]),
        archivado: json["archivado"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idAmbitoFk: json["id_ambito_fk"],
        idAreaCirculoFk: json["id_area_circulo_fk"],
        idEmiWeb: json["id_emi_web"],
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        idTareaFk: List<String>.from(json["id_tarea_fk"].map((x) => x)),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "archivado": archivado,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_ambito_fk": idAmbitoFk,
        "id_area_circulo_fk": idAreaCirculoFk,
        "id_emi_web": idEmiWeb,
        "id_emprendimiento_fk": idEmprendimientoFk,
        "id_status_sync_fk": idStatusSyncFk,
        "id_tarea_fk": List<dynamic>.from(idTareaFk.map((x) => x)),
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class ConsultoriaExpand {
    ConsultoriaExpand({
        required this.idAmbitoFk,
        required this.idAreaCirculoFk,
        required this.idTareaFk,
    });

    final IdAFk idAmbitoFk;
    final IdAcFk idAreaCirculoFk;
    final List<IdTareaFk> idTareaFk;

    factory ConsultoriaExpand.fromMap(Map<String, dynamic> json) => ConsultoriaExpand(
        idAmbitoFk: IdAFk.fromMap(json["id_ambito_fk"]),
        idAreaCirculoFk: IdAcFk.fromMap(json["id_area_circulo_fk"]),
        idTareaFk: List<IdTareaFk>.from(json["id_tarea_fk"].map((x) => IdTareaFk.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id_ambito_fk": idAmbitoFk.toMap(),
        "id_area_circulo_fk": idAreaCirculoFk.toMap(),
        "id_tarea_fk": List<dynamic>.from(idTareaFk.map((x) => x.toMap())),
    };
}

class IdFk {
    IdFk({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.updated,
        required this.porcentaje,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final DateTime? updated;
    final String porcentaje;

    factory IdFk.fromMap(Map<String, dynamic> json) => IdFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        porcentaje: json["porcentaje"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "porcentaje": porcentaje,
    };
}

class IdAFk {
    IdAFk({
        required this.collectionId,
        required this.collectionName,
        required this.activo,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.nombreAmbito,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool activo;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String nombreAmbito;
    final DateTime? updated;

    factory IdAFk.fromMap(Map<String, dynamic> json) => IdAFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        nombreAmbito: json["nombre_ambito"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "nombre_ambito": nombreAmbito,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class IdAcFk {
    IdAcFk({
        required this.collectionId,
        required this.collectionName,
        required this.activo,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.updated,
        required this.nombreArea,
    });

    final String collectionId;
    final String collectionName;
    final bool activo;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final DateTime? updated;
    final String nombreArea;

    factory IdAcFk.fromMap(Map<String, dynamic> json) => IdAcFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreArea: json["nombre_area"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_area": nombreArea,
    };
}

class IdTareaFk {
    IdTareaFk({
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
    final IdTareaFkExpand? expand;
    final String? comentarios;
    final DateTime? created;
    final String descripcion;
    final DateTime? fechaRevision;
    final String id;
    final String idEmiWeb;
    final List<String> idImagenesFk;
    final String idPorcentajeFk;
    final String idStatusSyncFk;
    final String tarea;
    final DateTime? updated;

    factory IdTareaFk.fromMap(Map<String, dynamic> json) => IdTareaFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: json["@expand"] == null ? null : IdTareaFkExpand.fromMap(json["@expand"]),
        comentarios: json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        fechaRevision: json["fecha_revision"] == null ? null : DateTime.parse(json["fecha_revision"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenesFk: List<String>.from(json["id_imagenes_fk"].map((x) => x)),
        idPorcentajeFk: json["id_porcentaje_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        tarea: json["tarea"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand == null ? null : expand!.toMap(),
        "comentarios": comentarios,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "fecha_revision": fechaRevision == null ? null : fechaRevision!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_imagenes_fk": List<dynamic>.from(idImagenesFk.map((x) => x)),
        "id_porcentaje_fk": idPorcentajeFk,
        "id_status_sync_fk": idStatusSyncFk,
        "tarea": tarea,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class IdTareaFkExpand {
    IdTareaFkExpand({
        required this.idPorcentajeFk,
    });

    final IdFk idPorcentajeFk;

    factory IdTareaFkExpand.fromMap(Map<String, dynamic> json) => IdTareaFkExpand(
        idPorcentajeFk: IdFk.fromMap(json["id_porcentaje_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_porcentaje_fk": idPorcentajeFk.toMap(),
    };
}
