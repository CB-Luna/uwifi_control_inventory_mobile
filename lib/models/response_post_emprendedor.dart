import 'dart:convert';

class ResponsePostEmprendedor {
    ResponsePostEmprendedor({
        required this.collectionId,
        required this.collectionName,
        required this.apellidosEmp,
        required this.avatarEmprendedor,
        required this.comentarios,
        required this.created,
        required this.curp,
        required this.id,
        required this.idComunidadFk,
        required this.idEmprendimientoFk,
        required this.idStatusSyncFk,
        required this.integrantesFamilia,
        required this.nacimiento,
        required this.nombreEmprendedor,
        required this.telefono,
        required this.updated,
    });

    String collectionId;
    String collectionName;
    String apellidosEmp;
    String avatarEmprendedor;
    String comentarios;
    DateTime? created;
    String curp;
    String id;
    String idComunidadFk;
    String idEmprendimientoFk;
    String idStatusSyncFk;
    int integrantesFamilia;
    DateTime? nacimiento;
    String nombreEmprendedor;
    String telefono;
    DateTime? updated;

    factory ResponsePostEmprendedor.fromJson(String str) => ResponsePostEmprendedor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResponsePostEmprendedor.fromMap(Map<String, dynamic> json) => ResponsePostEmprendedor(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        apellidosEmp: json["apellidos_emp"] == null ? null : json["apellidos_emp"],
        avatarEmprendedor: json["avatar_emprendedor"] == null ? null : json["avatar_emprendedor"],
        comentarios: json["comentarios"] == null ? null : json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        curp: json["curp"] == null ? null : json["curp"],
        id: json["id"] == null ? null : json["id"],
        idComunidadFk: json["id_comunidad_fk"] == null ? null : json["id_comunidad_fk"],
        idEmprendimientoFk: json["id_emprendimiento_fk"] == null ? null : json["id_emprendimiento_fk"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
        integrantesFamilia: json["integrantes_familia"] == null ? null : json["integrantes_familia"],
        nacimiento: json["nacimiento"] == null ? null : DateTime.parse(json["nacimiento"]),
        nombreEmprendedor: json["nombre_emprendedor"] == null ? null : json["nombre_emprendedor"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "apellidos_emp": apellidosEmp == null ? null : apellidosEmp,
        "avatar_emprendedor": avatarEmprendedor == null ? null : avatarEmprendedor,
        "comentarios": comentarios == null ? null : comentarios,
        "created": created == null ? null : created!.toIso8601String(),
        "curp": curp == null ? null : curp,
        "id": id == null ? null : id,
        "id_comunidad_fk": idComunidadFk == null ? null : idComunidadFk,
        "id_emprendimiento_fk": idEmprendimientoFk == null ? null : idEmprendimientoFk,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
        "integrantes_familia": integrantesFamilia == null ? null : integrantesFamilia,
        "nacimiento": nacimiento == null ? null : nacimiento!.toIso8601String(),
        "nombre_emprendedor": nombreEmprendedor == null ? null : nombreEmprendedor,
        "telefono": telefono == null ? null : telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
