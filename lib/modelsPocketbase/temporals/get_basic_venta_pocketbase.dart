import 'dart:convert';

GetBasicVentaPocketbase getBasicVentaPocketbaseFromMap(String str) => GetBasicVentaPocketbase.fromMap(json.decode(str));

String getBasicVentaPocketbaseToMap(GetBasicVentaPocketbase data) => json.encode(data.toMap());

class GetBasicVentaPocketbase {
    GetBasicVentaPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Venta> items;

    factory GetBasicVentaPocketbase.fromMap(Map<String, dynamic> json) => GetBasicVentaPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<Venta>.from(json["items"].map((x) => Venta.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Venta {
    Venta({
        required this.collectionId,
        required this.collectionName,
        required this.archivado,
        required this.created,
        required this.fechaInicio,
        required this.fechaTermino,
        required this.id,
        required this.idEmiWeb,
        required this.idEmprendimientoFk,
        required this.total,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool archivado;
    final DateTime? created;
    final DateTime fechaInicio;
    final DateTime fechaTermino;
    final String id;
    final String idEmiWeb;
    final String idEmprendimientoFk;
    final double total;
    final DateTime? updated;

    factory Venta.fromMap(Map<String, dynamic> json) => Venta(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        archivado: json["archivado"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaTermino: DateTime.parse(json["fecha_termino"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        total: json["total"].toDouble(),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "archivado": archivado,
        "created": created == null ? null : created!.toIso8601String(),
        "fecha_inicio": fechaInicio.toIso8601String(),
        "fecha_termino": fechaTermino.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_emprendimiento_fk": idEmprendimientoFk,
        "total": total,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
