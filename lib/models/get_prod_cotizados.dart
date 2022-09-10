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
        required this.producto,
        required this.cantidad,
        required this.costoTotal,
        required this.estado,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String idInversionFk;
    final String producto;
    final int cantidad;
    final double costoTotal;
    final String estado;

    factory GetProdCotizados.fromMap(Map<String, dynamic> json) => GetProdCotizados(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        idInversionFk: json["id_inversion_fk"] == null ? null : json["id_inversion_fk"],
        producto: json["producto"] == null ? null : json["producto"],
        cantidad: json["cantidad"] == null ? null : json["cantidad"],
        costoTotal: json["costo_total"] == null ? null : json["costo_total"],
        estado: json["estado"] == null ? null : json["estado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "id": id == null ? null : id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "id_inversion_fk": idInversionFk == null ? null : idInversionFk,
        "producto": producto == null ? null : producto,
        "cantidad": cantidad == null ? null : cantidad,
        "costo_total": costoTotal == null ? null : costoTotal,
        "estado": estado == null ? null : estado,
    };
}
