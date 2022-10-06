import 'dart:convert';

GetInversion getInversionFromMap(String str) => GetInversion.fromMap(json.decode(str));

String getInversionToMap(GetInversion data) => json.encode(data.toMap());

class GetInversion {
    GetInversion({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.idEmprendimientoFk,
        required this.idEstadoInversionFk,
        this.factura,
        this.porcentajePago,
        required this.inversionRecibida,
        required this.pagoRecibido,
        required this.productoEntregado,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String idEmprendimientoFk;
    final String idEstadoInversionFk;
    final String? factura;
    final int? porcentajePago;
    final bool inversionRecibida;
    final bool pagoRecibido;
    final bool productoEntregado;

    factory GetInversion.fromMap(Map<String, dynamic> json) => GetInversion(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        idEstadoInversionFk: json["id_estado_inversion_fk"],
        factura: json["factura"] == null ? null : json["factura"]!,
        porcentajePago: json["porcentaje_pago"] == null ? null : json["porcentaje_pago"]!,
        inversionRecibida: json["inversion_recibida"],
        pagoRecibido: json["pago_recibido"],
        productoEntregado: json["producto_entregado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "id_emprendimiento_fk": idEmprendimientoFk,
        "id_estado_inversion_fk": idEstadoInversionFk,
        "factura": factura == null ? null : factura!,
        "porcentaje_pago": porcentajePago == null ? null : porcentajePago!,
        "inversion_recibida": inversionRecibida,
        "pago_recibido": pagoRecibido,
        "producto_entregado": productoEntregado,
    };
}
