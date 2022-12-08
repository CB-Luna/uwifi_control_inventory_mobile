import 'dart:convert';

GetBasicInversionPocketbase getBasicInversionPocketbaseFromMap(String str) => GetBasicInversionPocketbase.fromMap(json.decode(str));

String getBasicInversionPocketbaseToMap(GetBasicInversionPocketbase data) => json.encode(data.toMap());

class GetBasicInversionPocketbase {
    GetBasicInversionPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Inversion> items;

    factory GetBasicInversionPocketbase.fromMap(Map<String, dynamic> json) => GetBasicInversionPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<Inversion>.from(json["items"].map((x) => Inversion.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Inversion {
    Inversion({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.created,
        required this.fechaCompra,
        required this.id,
        required this.idEmiWeb,
        required this.idEmprendimientoFk,
        required this.idEstadoInversionFk,
        required this.idImagenFirmaRecibidoFk,
        required this.idImagenProductoEntregadoFk,
        required this.inversionRecibida,
        required this.jornada3,
        required this.montoPagar,
        required this.pagoRecibido,
        required this.porcentajePago,
        required this.productoEntregado,
        required this.saldo,
        required this.totalInversion,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final InversionExpand expand;
    final DateTime? created;
    final String? fechaCompra;
    final String id;
    final String idEmiWeb;
    final String idEmprendimientoFk;
    final String idEstadoInversionFk;
    final String? idImagenFirmaRecibidoFk;
    final String? idImagenProductoEntregadoFk;
    final bool inversionRecibida;
    final bool jornada3;
    final double montoPagar;
    final bool pagoRecibido;
    final int porcentajePago;
    final bool productoEntregado;
    final double saldo;
    final double totalInversion;
    final DateTime? updated;

    factory Inversion.fromMap(Map<String, dynamic> json) => Inversion(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: InversionExpand.fromMap(json["@expand"]),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        fechaCompra: json["fecha_compra"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        idEstadoInversionFk: json["id_estado_inversion_fk"],
        idImagenFirmaRecibidoFk: json["id_imagen_firma_recibido_fk"],
        idImagenProductoEntregadoFk: json["id_imagen_producto_entregado_fk"],
        inversionRecibida: json["inversion_recibida"],
        jornada3: json["jornada_3"],
        montoPagar: json["monto_pagar"].toDouble(),
        pagoRecibido: json["pago_recibido"],
        porcentajePago: json["porcentaje_pago"],
        productoEntregado: json["producto_entregado"],
        saldo: json["saldo"].toDouble(),
        totalInversion: json["total_inversion"].toDouble(),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "created": created == null ? null : created!.toIso8601String(),
        "fecha_compra": fechaCompra,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_emprendimiento_fk": idEmprendimientoFk,
        "id_estado_inversion_fk": idEstadoInversionFk,
        "id_imagen_firma_recibido_fk": idImagenFirmaRecibidoFk,
        "id_imagen_producto_entregado_fk": idImagenProductoEntregadoFk,
        "inversion_recibida": inversionRecibida,
        "jornada_3": jornada3,
        "monto_pagar": montoPagar,
        "pago_recibido": pagoRecibido,
        "porcentaje_pago": porcentajePago,
        "producto_entregado": productoEntregado,
        "saldo": saldo,
        "total_inversion": totalInversion,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class InversionExpand {
    InversionExpand({
        required this.idEstadoInversionFk,
        required this.idImagenFirmaRecibidoFk,
        required this.idImagenProductoEntregadoFk,
    });

    final IdEstadoInversionFk idEstadoInversionFk;
    final IdImagenFk? idImagenFirmaRecibidoFk;
    final IdImagenFk? idImagenProductoEntregadoFk;

    factory InversionExpand.fromMap(Map<String, dynamic> json) => InversionExpand(
        idEstadoInversionFk: IdEstadoInversionFk.fromMap(json["id_estado_inversion_fk"]),
        idImagenFirmaRecibidoFk: json["id_imagen_firma_recibido_fk"] == null ? null : IdImagenFk.fromMap(json["id_imagen_firma_recibido_fk"]),
        idImagenProductoEntregadoFk: json["id_imagen_producto_entregado_fk"] == null ? null : IdImagenFk.fromMap(json["id_imagen_producto_entregado_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_estado_inversion_fk": idEstadoInversionFk.toMap(),
        "id_imagen_firma_recibido_fk": idImagenFirmaRecibidoFk == null ? null : idImagenFirmaRecibidoFk!.toMap(),
        "id_imagen_producto_entregado_fk": idImagenProductoEntregadoFk == null ? null : idImagenProductoEntregadoFk!.toMap(),
    };
}

class IdEstadoInversionFk {
    IdEstadoInversionFk({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.estado,
        required this.id,
        required this.idEmiWeb,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final String estado;
    final String id;
    final String idEmiWeb;
    final DateTime? updated;

    factory IdEstadoInversionFk.fromMap(Map<String, dynamic> json) => IdEstadoInversionFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        estado: json["estado"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "estado": estado,
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class IdImagenFk {
    IdImagenFk({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.updated,
        required this.base64,
        required this.nombre,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final DateTime? updated;
    final String base64;
    final String nombre;

    factory IdImagenFk.fromMap(Map<String, dynamic> json) => IdImagenFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        base64: json["base64"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "base64": base64,
        "nombre": nombre,
    };
}
