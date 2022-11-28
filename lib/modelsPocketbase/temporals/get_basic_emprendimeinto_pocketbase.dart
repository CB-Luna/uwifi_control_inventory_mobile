import 'dart:convert';

GetBasicEmprendimientoPocketbase getBasicEmprendimientoPocketbaseFromMap(String str) => GetBasicEmprendimientoPocketbase.fromMap(json.decode(str));

String getBasicEmprendimientoPocketbaseToMap(GetBasicEmprendimientoPocketbase data) => json.encode(data.toMap());

class GetBasicEmprendimientoPocketbase {
    GetBasicEmprendimientoPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<BasicEmprendimiento> items;

    factory GetBasicEmprendimientoPocketbase.fromMap(Map<String, dynamic> json) => GetBasicEmprendimientoPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<BasicEmprendimiento>.from(json["items"].map((x) => BasicEmprendimiento.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class BasicEmprendimiento{
    BasicEmprendimiento({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.activo,
        required this.archivado,
        required this.created,
        required this.descripcion,
        required this.id,
        required this.idEmiWeb,
        required this.idEmprendedorFk,
        required this.idFaseEmpFk,
        required this.idNombreProyectoFk,
        required this.idPrioridadFk,
        required this.idPromotorFk,
        required this.idStatusSyncFk,
        required this.nombreEmprendimiento,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final BasicEmprendedorExpand expand;
    final bool activo;
    final bool archivado;
    final DateTime? created;
    final String descripcion;
    final String id;
    final String idEmiWeb;
    final String idEmprendedorFk;
    final String idFaseEmpFk;
    final String? idNombreProyectoFk;
    final String idPrioridadFk;
    final String idPromotorFk;
    final String idStatusSyncFk;
    final String nombreEmprendimiento;
    final DateTime? updated;

    factory BasicEmprendimiento.fromMap(Map<String, dynamic> json) => BasicEmprendimiento(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: BasicEmprendedorExpand.fromMap(json["@expand"]),
        activo: json["activo"],
        archivado: json["archivado"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idEmprendedorFk: json["id_emprendedor_fk"],
        idFaseEmpFk: json["id_fase_emp_fk"],
        idNombreProyectoFk: json["id_nombre_proyecto_fk"],
        idPrioridadFk: json["id_prioridad_fk"],
        idPromotorFk: json["id_promotor_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        nombreEmprendimiento: json["nombre_emprendimiento"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "activo": activo,
        "archivado": archivado,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_emprendedor_fk": idEmprendedorFk,
        "id_fase_emp_fk": idFaseEmpFk,
        "id_nombre_proyecto_fk": idNombreProyectoFk,
        "id_prioridad_fk": idPrioridadFk,
        "id_promotor_fk": idPromotorFk,
        "id_status_sync_fk": idStatusSyncFk,
        "nombre_emprendimiento": nombreEmprendimiento,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class BasicEmprendedorExpand {
    BasicEmprendedorExpand({
        required this.idEmprendedorFk,
        required this.idFaseEmpFk,
        required this.idNombreProyectoFk,
    });

    final BasicEmprendedor idEmprendedorFk;
    final BasicFaseEmp idFaseEmpFk;
    final BasicNombreProyecto? idNombreProyectoFk;

    factory BasicEmprendedorExpand.fromMap(Map<String, dynamic> json) => BasicEmprendedorExpand(
        idEmprendedorFk: BasicEmprendedor.fromMap(json["id_emprendedor_fk"]),
        idFaseEmpFk: BasicFaseEmp.fromMap(json["id_fase_emp_fk"]),
        idNombreProyectoFk: json["id_nombre_proyecto_fk"] == null ? null : BasicNombreProyecto.fromMap(json["id_nombre_proyecto_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_emprendedor_fk": idEmprendedorFk.toMap(),
        "id_fase_emp_fk": idFaseEmpFk.toMap(),
        "id_nombre_proyecto_fk": idNombreProyectoFk == null ? null : idNombreProyectoFk!.toMap(),
    };
}

class BasicEmprendedor {
    BasicEmprendedor({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.apellidosEmp,
        required this.comentarios,
        required this.created,
        required this.curp,
        required this.id,
        required this.idComunidadFk,
        required this.idEmiWeb,
        required this.idStatusSyncFk,
        required this.integrantesFamilia,
        required this.nombreEmprendedor,
        required this.telefono,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final IdBasicEmprendedorFkExpand expand;
    final String apellidosEmp;
    final String? comentarios;
    final DateTime? created;
    final String curp;
    final String id;
    final String idComunidadFk;
    final String idEmiWeb;
    final String? idStatusSyncFk;
    final int? integrantesFamilia;
    final String nombreEmprendedor;
    final String? telefono;
    final DateTime? updated;

    factory BasicEmprendedor.fromMap(Map<String, dynamic> json) => BasicEmprendedor(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: IdBasicEmprendedorFkExpand.fromMap(json["@expand"]),
        apellidosEmp: json["apellidos_emp"],
        comentarios: json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        curp: json["curp"],
        id: json["id"],
        idComunidadFk: json["id_comunidad_fk"],
        idEmiWeb: json["id_emi_web"],
        idStatusSyncFk: json["id_status_sync_fk"],
        integrantesFamilia: json["integrantes_familia"],
        nombreEmprendedor: json["nombre_emprendedor"],
        telefono: json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "apellidos_emp": apellidosEmp,
        "comentarios": comentarios,
        "created": created == null ? null : created!.toIso8601String(),
        "curp": curp,
        "id": id,
        "id_comunidad_fk": idComunidadFk,
        "id_emi_web": idEmiWeb,
        "id_status_sync_fk": idStatusSyncFk,
        "integrantes_familia": integrantesFamilia,
        "nombre_emprendedor": nombreEmprendedor,
        "telefono": telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class IdBasicEmprendedorFkExpand {
    IdBasicEmprendedorFkExpand({
        required this.idComunidadFk,
    });

    final BasicComunidad idComunidadFk;

    factory IdBasicEmprendedorFkExpand.fromMap(Map<String, dynamic> json) => IdBasicEmprendedorFkExpand(
        idComunidadFk: BasicComunidad.fromMap(json["id_comunidad_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_comunidad_fk": idComunidadFk.toMap(),
    };
}

class BasicComunidad {
    BasicComunidad({
        required this.collectionId,
        required this.collectionName,
        required this.activo,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idMunicipioFk,
        required this.idStatusSyncFk,
        required this.nombreComunidad,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool activo;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String idMunicipioFk;
    final String? idStatusSyncFk;
    final String nombreComunidad;
    final DateTime? updated;

    factory BasicComunidad.fromMap(Map<String, dynamic> json) => BasicComunidad(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idMunicipioFk: json["id_municipio_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        nombreComunidad: json["nombre_comunidad"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_municipio_fk": idMunicipioFk,
        "id_status_sync_fk": idStatusSyncFk,
        "nombre_comunidad": nombreComunidad,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class BasicFaseEmp {
    BasicFaseEmp({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.fase,
        required this.id,
        required this.idEmiWeb,
        required this.idStatusSyncFk,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final String fase;
    final String id;
    final String idEmiWeb;
    final String? idStatusSyncFk;
    final DateTime? updated;

    factory BasicFaseEmp.fromMap(Map<String, dynamic> json) => BasicFaseEmp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        fase: json["fase"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idStatusSyncFk: json["id_status_sync_fk"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "fase": fase,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_status_sync_fk": idStatusSyncFk,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class BasicNombreProyecto {
    BasicNombreProyecto({
        required this.collectionId,
        required this.collectionName,
        required this.activo,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idTipoProyectoFk,
        required this.nombreProyecto,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool activo;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String idTipoProyectoFk;
    final String nombreProyecto;
    final DateTime? updated;

    factory BasicNombreProyecto.fromMap(Map<String, dynamic> json) => BasicNombreProyecto(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idTipoProyectoFk: json["id_tipo_proyecto_fk"],
        nombreProyecto: json["nombre_proyecto"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_tipo_proyecto_fk": idTipoProyectoFk,
        "nombre_proyecto": nombreProyecto,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
