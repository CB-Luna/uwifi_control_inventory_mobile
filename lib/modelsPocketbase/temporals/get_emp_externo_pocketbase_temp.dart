// ignore_for_file: constant_identifier_names

import 'dart:convert';

GetEmpExternoPocketbaseTemp getEmpExternoPocketbaseTempFromMap(String str) => GetEmpExternoPocketbaseTemp.fromMap(json.decode(str));

String getEmpExternoPocketbaseTempToMap(GetEmpExternoPocketbaseTemp data) => json.encode(data.toMap());

class GetEmpExternoPocketbaseTemp {
    GetEmpExternoPocketbaseTemp({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<EmprendimientoTemp> items;

    factory GetEmpExternoPocketbaseTemp.fromMap(Map<String, dynamic> json) => GetEmpExternoPocketbaseTemp(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<EmprendimientoTemp>.from(json["items"].map((x) => EmprendimientoTemp.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class EmprendimientoTemp {
    EmprendimientoTemp({
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
        required this.selected,
    });

    final String collectionId;
    final String collectionName;
    final EmprendedorExpand expand;
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
    bool selected = false;

    factory EmprendimientoTemp.fromMap(Map<String, dynamic> json) => EmprendimientoTemp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: EmprendedorExpand.fromMap(json["@expand"]),
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
        selected: false,
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
        "selected": false,
    };
}

class EmprendedorExpand {
    EmprendedorExpand({
        required this.idEmprendedorFk,
    });

    final EmprendedorTemp idEmprendedorFk;

    factory EmprendedorExpand.fromMap(Map<String, dynamic> json) => EmprendedorExpand(
        idEmprendedorFk: EmprendedorTemp.fromMap(json["id_emprendedor_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_emprendedor_fk": idEmprendedorFk.toMap(),
    };
}

class EmprendedorTemp {
    EmprendedorTemp({
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
        required this.idUsuarioRegistraFk,
        required this.integrantesFamilia,
        required this.nombreEmprendedor,
        required this.telefono,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final UsuarioExpand expand;
    final String apellidosEmp;
    final String? comentarios;
    final DateTime? created;
    final String curp;
    final String id;
    final String idComunidadFk;
    final String idEmiWeb;
    final String? idStatusSyncFk;
    final String idUsuarioRegistraFk;
    final int? integrantesFamilia;
    final String nombreEmprendedor;
    final String? telefono;
    final DateTime? updated;

    factory EmprendedorTemp.fromMap(Map<String, dynamic> json) => EmprendedorTemp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: UsuarioExpand.fromMap(json["@expand"]),
        apellidosEmp: json["apellidos_emp"],
        comentarios: json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        curp: json["curp"],
        id: json["id"],
        idComunidadFk: json["id_comunidad_fk"],
        idEmiWeb: json["id_emi_web"],
        idStatusSyncFk: json["id_status_sync_fk"],
        idUsuarioRegistraFk: json["id_usuario_registra_fk"],
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
        "id_usuario_registra_fk": idUsuarioRegistraFk,
        "integrantes_familia": integrantesFamilia,
        "nombre_emprendedor": nombreEmprendedor,
        "telefono": telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class UsuarioExpand {
    UsuarioExpand({
        required this.idUsuarioRegistraFk,
    });

    final UsuarioTemp idUsuarioRegistraFk;

    factory UsuarioExpand.fromMap(Map<String, dynamic> json) => UsuarioExpand(
        idUsuarioRegistraFk: UsuarioTemp.fromMap(json["id_usuario_registra_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_usuario_registra_fk": idUsuarioRegistraFk.toMap(),
    };
}

class UsuarioTemp {
    UsuarioTemp({
        required this.collectionId,
        required this.collectionName,
        required this.apellidoM,
        required this.apellidoP,
        required this.archivado,
        required this.celular,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idImagenFk,
        required this.idRolesFk,
        required this.idStatusSyncFk,
        required this.nombreUsuario,
        required this.telefono,
        required this.updated,
        required this.user,
    });

    final String collectionId;
    final String collectionName;
    final String? apellidoM;
    final String apellidoP;
    final bool archivado;
    final String? celular;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String? idImagenFk;
    final List<String>? idRolesFk;
    final String idStatusSyncFk;
    final String nombreUsuario;
    final String? telefono;
    final DateTime? updated;
    final String user;

    factory UsuarioTemp.fromMap(Map<String, dynamic> json) => UsuarioTemp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        apellidoM: json["apellido_m"],
        apellidoP: json["apellido_p"],
        archivado: json["archivado"],
        celular: json["celular"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenFk: json["id_imagen_fk"],
        idRolesFk: json["id_roles_fk"] == null ? null : List<String>.from(json["id_roles_fk"].map((x) => x)),
        idStatusSyncFk: json["id_status_sync_fk"],
        nombreUsuario: json["nombre_usuario"],
        telefono: json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        user: json["user"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
        "archivado": archivado,
        "celular": celular,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_imagen_fk": idImagenFk,
        "id_roles_fk": idRolesFk == null ? null : List<dynamic>.from(idRolesFk!.map((x) => x)),
        "id_status_sync_fk": idStatusSyncFk,
        "nombre_usuario": nombreUsuario,
        "telefono": telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "user": user,
    };
}

