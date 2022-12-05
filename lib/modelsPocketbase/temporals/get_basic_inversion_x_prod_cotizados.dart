import 'dart:convert';

GetBasicInversionXProdCotizadosPocketbase getBasicInversionXProdCotizadosPocketbaseFromMap(String str) => GetBasicInversionXProdCotizadosPocketbase.fromMap(json.decode(str));

String getBasicInversionXProdCotizadosPocketbaseToMap(GetBasicInversionXProdCotizadosPocketbase data) => json.encode(data.toMap());

class GetBasicInversionXProdCotizadosPocketbase {
    GetBasicInversionXProdCotizadosPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<InversionXProductosCotizados> items;

    factory GetBasicInversionXProdCotizadosPocketbase.fromMap(Map<String, dynamic> json) => GetBasicInversionXProdCotizadosPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<InversionXProductosCotizados>.from(json["items"].map((x) => InversionXProductosCotizados.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class InversionXProductosCotizados {
    InversionXProductosCotizados({
        required this.collectionId,
        required this.collectionName,
        required this.aceptado,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idInversionFk,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool aceptado;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String idInversionFk;
    final DateTime? updated;

    factory InversionXProductosCotizados.fromMap(Map<String, dynamic> json) => InversionXProductosCotizados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        aceptado: json["aceptado"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idInversionFk: json["id_inversion_fk"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "aceptado": aceptado,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_inversion_fk": idInversionFk,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
