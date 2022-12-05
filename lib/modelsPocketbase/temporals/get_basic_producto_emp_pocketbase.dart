import 'dart:convert';

GetBasicProductoEmpPocketbase getBasicProductoEmpPocketbaseFromMap(String str) => GetBasicProductoEmpPocketbase.fromMap(json.decode(str));

String getBasicProductoEmpPocketbaseToMap(GetBasicProductoEmpPocketbase data) => json.encode(data.toMap());

class GetBasicProductoEmpPocketbase {
    GetBasicProductoEmpPocketbase({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<ProductoEmp> items;

    factory GetBasicProductoEmpPocketbase.fromMap(Map<String, dynamic> json) => GetBasicProductoEmpPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<ProductoEmp>.from(json["items"].map((x) => ProductoEmp.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class ProductoEmp {
    ProductoEmp({
        required this.collectionId,
        required this.collectionName,
        required this.expand,
        required this.archivado,
        required this.costoProdEmp,
        required this.created,
        required this.descripcion,
        required this.id,
        required this.idEmiWeb,
        required this.idEmprendimientoFk,
        required this.idImagenFk,
        required this.idUndMedidaFk,
        required this.nombreProdEmp,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final ProductoEmpExpand expand;
    final bool archivado;
    final double costoProdEmp;
    final DateTime? created;
    final String descripcion;
    final String id;
    final String idEmiWeb;
    final String idEmprendimientoFk;
    final String? idImagenFk;
    final String idUndMedidaFk;
    final String nombreProdEmp;
    final DateTime? updated;

    factory ProductoEmp.fromMap(Map<String, dynamic> json) => ProductoEmp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ProductoEmpExpand.fromMap(json["@expand"]),
        archivado: json["archivado"],
        costoProdEmp: json["costo_prod_emp"].toDouble(),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        idImagenFk: json["id_imagen_fk"],
        idUndMedidaFk: json["id_und_medida_fk"],
        nombreProdEmp: json["nombre_prod_emp"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "archivado": archivado,
        "costo_prod_emp": costoProdEmp,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_emprendimiento_fk": idEmprendimientoFk,
        "id_imagen_fk": idImagenFk,
        "id_und_medida_fk": idUndMedidaFk,
        "nombre_prod_emp": nombreProdEmp,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class ProductoEmpExpand {
    ProductoEmpExpand({
        required this.idImagenFk,
        required this.idUndMedidaFk,
    });

    final IdImagenFk? idImagenFk;
    final IdUmFk idUndMedidaFk;

    factory ProductoEmpExpand.fromMap(Map<String, dynamic> json) => ProductoEmpExpand(
        idImagenFk: json["id_imagen_fk"] == null ? null : IdImagenFk.fromMap(json["id_imagen_fk"]),
        idUndMedidaFk: IdUmFk.fromMap(json["id_und_medida_fk"]),
    );

    Map<String, dynamic> toMap() => {
        "id_imagen_fk": idImagenFk == null ? null : idImagenFk!.toMap(),
        "id_und_medida_fk": idUndMedidaFk.toMap(),
    };
}

class IdImagenFk {
    IdImagenFk({
        required this.collectionId,
        required this.collectionName,
        required this.base64,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.nombre,
        required this.updated,
    });

    final String collectionId;
    final String collectionName;
    final String base64;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String nombre;
    final DateTime? updated;

    factory IdImagenFk.fromMap(Map<String, dynamic> json) => IdImagenFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        base64: json["base64"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        nombre: json["nombre"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "base64": base64,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "nombre": nombre,
        "updated": updated == null ? null : updated!.toIso8601String(),
    };
}

class IdUmFk {
    IdUmFk({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        required this.updated,
        required this.activo,
        required this.unidadMedida,
    });

    final String collectionId;
    final String collectionName;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final DateTime? updated;
    final bool activo;
    final String unidadMedida;

    factory IdUmFk.fromMap(Map<String, dynamic> json) => IdUmFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        activo: json["activo"],
        unidadMedida: json["unidad_medida"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "activo": activo,
        "unidad_medida": unidadMedida,
    };
}

