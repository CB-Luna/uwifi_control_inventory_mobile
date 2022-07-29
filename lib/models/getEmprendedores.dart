// To parse this JSON data, do
//
//     final GetEmprendedores = GetEmprendedoresFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class GetEmprendedores {
    GetEmprendedores({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    int page;
    int perPage;
    int totalItems;
    List<Item>? items;

    factory GetEmprendedores.fromJson(String str) => GetEmprendedores.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetEmprendedores.fromMap(Map<String, dynamic> json) => GetEmprendedores(
        page: json["page"] == null ? null : json["page"],
        perPage: json["perPage"] == null ? null : json["perPage"],
        totalItems: json["totalItems"] == null ? null : json["totalItems"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page == null ? null : page,
        "perPage": perPage == null ? null : perPage,
        "totalItems": totalItems == null ? null : totalItems,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toMap())),
    };
}

class Item {
    Item({
        required this.collectionId,
        required this.collectionName,
        required this.apellidoMEmp,
        required this.apellidoPEmp,
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
    String apellidoMEmp;
    String apellidoPEmp;
    String avatarEmprendedor;
    String comentarios;
    DateTime? created;
    String curp;
    String id;
    String idComunidadFk;
    String idEmprendimientoFk;
    String idStatusSyncFk;
    Map<String, String>? integrantesFamilia;
    DateTime? nacimiento;
    String nombreEmprendedor;
    String telefono;
    DateTime? updated;

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        apellidoMEmp: json["apellido_m_emp"] == null ? null : json["apellido_m_emp"],
        apellidoPEmp: json["apellido_p_emp"] == null ? null : json["apellido_p_emp"],
        avatarEmprendedor: json["avatar_emprendedor"] == null ? null : json["avatar_emprendedor"],
        comentarios: json["comentarios"] == null ? null : json["comentarios"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        curp: json["curp"] == null ? null : json["curp"],
        id: json["id"] == null ? null : json["id"],
        idComunidadFk: json["id_comunidad_fk"] == null ? null : json["id_comunidad_fk"],
        idEmprendimientoFk: json["id_emprendimiento_fk"] == null ? null : json["id_emprendimiento_fk"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
        integrantesFamilia: json["integrantes_familia"] == null ? null : Map.from(json["integrantes_familia"]).map((k, v) => MapEntry<String, String>(k, v)),
        nacimiento: json["nacimiento"] == null ? null : DateTime.parse(json["nacimiento"]),
        nombreEmprendedor: json["nombre_emprendedor"] == null ? null : json["nombre_emprendedor"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "apellido_m_emp": apellidoMEmp == null ? null : apellidoMEmp,
        "apellido_p_emp": apellidoPEmp == null ? null : apellidoPEmp,
        "avatar_emprendedor": avatarEmprendedor == null ? null : avatarEmprendedor,
        "comentarios": comentarios == null ? null : comentarios,
        "created": created == null ? null : created!.toIso8601String(),
        "curp": curp == null ? null : curp,
        "id": id == null ? null : id,
        "id_comunidad_fk": idComunidadFk == null ? null : idComunidadFk,
        "id_emprendimiento_fk": idEmprendimientoFk == null ? null : idEmprendimientoFk,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
        "integrantes_familia": integrantesFamilia == null ? null : Map.from(integrantesFamilia!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "nacimiento": nacimiento == null ? null : nacimiento!.toIso8601String(),
        "nombre_emprendedor": nombreEmprendedor == null ? null : nombreEmprendedor,
        "telefono": telefono == null ? null : telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
