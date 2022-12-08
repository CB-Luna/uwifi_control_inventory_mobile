import 'dart:convert';

GetBasicPagosPocketbase getBasicPagosPocketbaseFromMap(String str) => GetBasicPagosPocketbase.fromMap(json.decode(str));

String getBasicPagosPocketbaseToMap(GetBasicPagosPocketbase data) => json.encode(data.toMap());

class GetBasicPagosPocketbase {
    GetBasicPagosPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Pago> items;

    factory GetBasicPagosPocketbase.fromMap(Map<String, dynamic> json) => GetBasicPagosPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<Pago>.from(json["items"].map((x) => Pago.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Pago {
    Pago({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.fechaMovimiento,
        required this.id,
        required this.idEmiWeb,
        required this.idInversionFk,
        required this.idUsuarioFk,
        required this.montoAbonado,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final DateTime fechaMovimiento;
    final String id;
    final String idEmiWeb;
    final String idInversionFk;
    final String idUsuarioFk;
    final double montoAbonado;
    final DateTime? updated;

    factory Pago.fromMap(Map<String, dynamic> json) => Pago(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        fechaMovimiento: DateTime.parse(json["fecha_movimiento"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idInversionFk: json["id_inversion_fk"],
        idUsuarioFk: json["id_usuario_fk"],
        montoAbonado: json["monto_abonado"].toDouble(),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "fecha_movimiento": fechaMovimiento.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_inversion_fk": idInversionFk,
        "id_usuario_fk": idUsuarioFk,
        "monto_abonado": montoAbonado,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
