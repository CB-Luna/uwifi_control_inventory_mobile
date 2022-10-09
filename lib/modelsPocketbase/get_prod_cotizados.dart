import 'dart:convert';

GetProdCotizados getProdCotizadosFromMap(String str) => GetProdCotizados.fromMap(json.decode(str));

String getProdCotizadosToMap(GetProdCotizados data) => json.encode(data.toMap());

class GetProdCotizados {
    GetProdCotizados({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.cantidad,
        required this.costoTotal,
        required this.idProductoProvFk,
        required this.idInversionXProdCotizadosFk,
        required this.aceptado,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final int cantidad;
    final double costoTotal;
    final String idProductoProvFk;
    final String idInversionXProdCotizadosFk;
    final bool aceptado;

    factory GetProdCotizados.fromMap(Map<String, dynamic> json) => GetProdCotizados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        cantidad: json["cantidad"],
        costoTotal: json["costo_total"],
        idProductoProvFk: json["id_producto_prov_fk"],
        idInversionXProdCotizadosFk: json["id_inversion_x_prod_cotizados_fk"],
        aceptado: json["aceptado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "cantidad": cantidad,
        "costo_total": costoTotal,
        "id_producto_prov_fk": idProductoProvFk,
        "id_inversion_x_prod_cotizados_fk": idInversionXProdCotizadosFk,
        "aceptado": aceptado,
    };
}
