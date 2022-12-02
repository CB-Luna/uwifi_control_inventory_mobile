import 'dart:convert';

GetBasicProductoVendidoPocketbase getBasicProductoVendidoPocketbaseFromMap(String str) => GetBasicProductoVendidoPocketbase.fromMap(json.decode(str));

String getBasicProductoVendidoPocketbaseToMap(GetBasicProductoVendidoPocketbase data) => json.encode(data.toMap());

class GetBasicProductoVendidoPocketbase {
    GetBasicProductoVendidoPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<ProdVendido> items;

    factory GetBasicProductoVendidoPocketbase.fromMap(Map<String, dynamic> json) => GetBasicProductoVendidoPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<ProdVendido>.from(json["items"].map((x) => ProdVendido.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class ProdVendido {
    ProdVendido({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.cantidadVendida,
        required this.costo,
        required this.created,
        required this.descripcion,
        required this.id,
        required this.idEmiWeb,
        required this.idProductosEmpFk,
        required this.idUndMedidaFk,
        required this.idVentaFk,
        required this.nombreProd,
        required this.precioVenta,
        required this.subTotal,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final ProdVendidoExpand expand;
    final int cantidadVendida;
    final double costo;
    final DateTime? created;
    final String descripcion;
    final String id;
    final String idEmiWeb;
    final String idProductosEmpFk;
    final String idUndMedidaFk;
    final String idVentaFk;
    final String nombreProd;
    final double precioVenta;
    final double subTotal;
    final DateTime? updated;

    factory ProdVendido.fromMap(Map<String, dynamic> json) => ProdVendido(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ProdVendidoExpand.fromMap(json["@expand"]),
        cantidadVendida: json["cantidad_vendida"],
        costo: json["costo"].toDouble(),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idProductosEmpFk: json["id_productos_emp_fk"],
        idUndMedidaFk: json["id_und_medida_fk"],
        idVentaFk: json["id_venta_fk"],
        nombreProd: json["nombre_prod"],
        precioVenta: json["precio_venta"].toDouble(),
        subTotal: json["subTotal"].toDouble(),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "cantidad_vendida": cantidadVendida,
        "costo": costo,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_productos_emp_fk": idProductosEmpFk,
        "id_und_medida_fk": idUndMedidaFk,
        "id_venta_fk": idVentaFk,
        "nombre_prod": nombreProd,
        "precio_venta": precioVenta,
        "subTotal": subTotal,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class ProdVendidoExpand {
    ProdVendidoExpand({
        required this.idUndMedidaFk,
    });

    final IdUndMedidaFk idUndMedidaFk;

    factory ProdVendidoExpand.fromMap(Map<String, dynamic> json) => ProdVendidoExpand(
        idUndMedidaFk: IdUndMedidaFk.fromMap(json["id_und_medida_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_und_medida_fk": idUndMedidaFk.toMap(),
    };
}

class IdUndMedidaFk {
    IdUndMedidaFk({
        required this.collectionId,
        required this.collectionName,
        required this.activo,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.unidadMedida,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final bool activo;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String unidadMedida;
    final DateTime? updated;

    factory IdUndMedidaFk.fromMap(Map<String, dynamic> json) => IdUndMedidaFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        unidadMedida: json["unidad_medida"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "unidad_medida": unidadMedida,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}
