import 'dart:convert';

GetBasicProductosCotizadosPocketbase getBasicProductosCotizadosPocketbaseFromMap(String str) => GetBasicProductosCotizadosPocketbase.fromMap(json.decode(str));

String getBasicProductosCotizadosPocketbaseToMap(GetBasicProductosCotizadosPocketbase data) => json.encode(data.toMap());

class GetBasicProductosCotizadosPocketbase {
    GetBasicProductosCotizadosPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<ProductoCotizado> items;

    factory GetBasicProductosCotizadosPocketbase.fromMap(Map<String, dynamic> json) => GetBasicProductosCotizadosPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<ProductoCotizado>.from(json["items"].map((x) => ProductoCotizado.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class ProductoCotizado {
    ProductoCotizado({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.aceptado,
        required this.cantidad,
        required this.costoTotal,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.idInversionXProdCotizadosFk,
        required this.idProductoProvFk,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final ProductoCotizadoExpand expand;
    final bool aceptado;
    final int cantidad;
    final double costoTotal;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String idInversionXProdCotizadosFk;
    final String idProductoProvFk;
    final DateTime? updated;

    factory ProductoCotizado.fromMap(Map<String, dynamic> json) => ProductoCotizado(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ProductoCotizadoExpand.fromMap(json["@expand"]),
        aceptado: json["aceptado"],
        cantidad: json["cantidad"],
        costoTotal: json["costo_total"].toDouble(),
        created: DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idInversionXProdCotizadosFk: json["id_inversion_x_prod_cotizados_fk"],
        idProductoProvFk: json["id_producto_prov_fk"],
        updated: DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "aceptado": aceptado,
        "cantidad": cantidad,
        "costo_total": costoTotal,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_inversion_x_prod_cotizados_fk": idInversionXProdCotizadosFk,
        "id_producto_prov_fk": idProductoProvFk,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class ProductoCotizadoExpand {
    ProductoCotizadoExpand({
        required this.idProductoProvFk,
    });

    final IdProductoProvFk idProductoProvFk;

    factory ProductoCotizadoExpand.fromMap(Map<String, dynamic> json) => ProductoCotizadoExpand(
        idProductoProvFk: IdProductoProvFk.fromMap(json["id_producto_prov_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_producto_prov_fk": idProductoProvFk.toMap(),
    };
}

class IdProductoProvFk {
    IdProductoProvFk({
        required this.collectionId,
        required this.collectionName,
        required this.archivado,
        required this.costoProdProv,
        required this.created,
        required this.descripcionProdProv,
        required this.id,
        required this.idEmiWeb,
        required this.idFamiliaProdFk,
        required this.idProveedorFk,
        required this.idUndMedidaFk,
        required this.marca,
        required this.nombreProdProv,
        required this.tiempoEntrega,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool archivado;
    final double costoProdProv;
    final DateTime? created;
    final String descripcionProdProv;
    final String id;
    final String idEmiWeb;
    final String idFamiliaProdFk;
    final String idProveedorFk;
    final String idUndMedidaFk;
    final String marca;
    final String nombreProdProv;
    final int tiempoEntrega;
    final DateTime? updated;

    factory IdProductoProvFk.fromMap(Map<String, dynamic> json) => IdProductoProvFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        archivado: json["archivado"],
        costoProdProv: json["costo_prod_prov"].toDouble(),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcionProdProv: json["descripcion_prod_prov"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idFamiliaProdFk: json["id_familia_prod_fk"],
        idProveedorFk: json["id_proveedor_fk"],
        idUndMedidaFk: json["id_und_medida_fk"],
        marca: json["marca"],
        nombreProdProv: json["nombre_prod_prov"],
        tiempoEntrega: json["tiempo_entrega"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "archivado": archivado,
        "costo_prod_prov": costoProdProv,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion_prod_prov": descripcionProdProv,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_familia_prod_fk": idFamiliaProdFk,
        "id_proveedor_fk": idProveedorFk,
        "id_und_medida_fk": idUndMedidaFk,
        "marca": marca,
        "nombre_prod_prov": nombreProdProv,
        "tiempo_entrega": tiempoEntrega,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
