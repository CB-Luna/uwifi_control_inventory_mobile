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
        required this.idInversionFk,
        required this.cantidad,
        required this.costoTotal,
        required this.idEstadoProdCotizadoFk,
        required this.idProductoProvFk,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String idInversionFk;
    final int cantidad;
    final double costoTotal;
    final String idEstadoProdCotizadoFk;
    final String idProductoProvFk;

    factory GetProdCotizados.fromMap(Map<String, dynamic> json) => GetProdCotizados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        idInversionFk: json["id_inversion_fk"],
        cantidad: json["cantidad"],
        costoTotal: json["costo_total"],
        idEstadoProdCotizadoFk: json["id_estado_prod_cotizado_fk"],
        idProductoProvFk: json["id_producto_prov_fk"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "id_inversion_fk": idInversionFk,
        "cantidad": cantidad,
        "costo_total": costoTotal,
        "id_estado_prod_cotizado_fk": idEstadoProdCotizadoFk,
        "id_producto_prov_fk": idProductoProvFk,
    };
}
