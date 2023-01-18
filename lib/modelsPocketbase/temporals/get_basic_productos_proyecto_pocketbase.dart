import 'dart:convert';

GetBasicProductosProyectoPocketbase getBasicProductosProyectoPocketbaseFromMap(
        String str) =>
    GetBasicProductosProyectoPocketbase.fromMap(json.decode(str));

String getBasicProductosProyectoPocketbaseToMap(
        GetBasicProductosProyectoPocketbase data) =>
    json.encode(data.toMap());

class GetBasicProductosProyectoPocketbase {
  GetBasicProductosProyectoPocketbase({
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.items,
  });

  final int page;
  final int perPage;
  final int totalItems;
  final List<ProductoProyecto> items;

  factory GetBasicProductosProyectoPocketbase.fromMap(
          Map<String, dynamic> json) =>
      GetBasicProductosProyectoPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<ProductoProyecto>.from(
            json["items"].map((x) => ProductoProyecto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ProductoProyecto {
  ProductoProyecto({
    required this.collectionId,
    required this.collectionName,
    required this.expand,
    required this.cantidad,
    required this.costoEstimado,
    required this.created,
    required this.descripcion,
    required this.id,
    required this.idEmiWeb,
    required this.idImagenFk,
    required this.idInversionFk,
    required this.idTipoEmpaqueFk,
    required this.marcaSugerida,
    required this.producto,
    required this.proveedorSugerido,
    required this.updated,
  });

  final String collectionId;
  final String collectionName;
  final ProductoProyectoExpand expand;
  final int cantidad;
  final String costoEstimado;
  final DateTime? created;
  final String descripcion;
  final String id;
  final String idEmiWeb;
  final String idImagenFk;
  final String idInversionFk;
  final String idTipoEmpaqueFk;
  final String marcaSugerida;
  final String producto;
  final String proveedorSugerido;
  final DateTime? updated;

  factory ProductoProyecto.fromMap(Map<String, dynamic> json) =>
      ProductoProyecto(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ProductoProyectoExpand.fromMap(json["@expand"]),
        cantidad: json["cantidad"],
        costoEstimado: json["costo_estimado"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenFk: json["id_imagen_fk"],
        idInversionFk: json["id_inversion_fk"],
        idTipoEmpaqueFk: json["id_tipo_empaque_fk"],
        marcaSugerida: json["marca_sugerida"],
        producto: json["producto"],
        proveedorSugerido: json["proveedor_sugerido"],
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "@expand": expand.toMap(),
        "cantidad": cantidad,
        "costo_estimado": costoEstimado,
        "created": created == null ? null : created!.toIso8601String(),
        "descripcion": descripcion,
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_imagen_fk": idImagenFk,
        "id_inversion_fk": idInversionFk,
        "id_tipo_empaque_fk": idTipoEmpaqueFk,
        "marca_sugerida": marcaSugerida,
        "producto": producto,
        "proveedor_sugerido": proveedorSugerido,
        "updated": updated == null ? null : updated!.toIso8601String(),
      };
}

class ProductoProyectoExpand {
  ProductoProyectoExpand({
    required this.idTipoEmpaqueFk,
  });

  final IdTeFk idTipoEmpaqueFk;

  factory ProductoProyectoExpand.fromMap(Map<String, dynamic> json) =>
      ProductoProyectoExpand(
        idTipoEmpaqueFk: IdTeFk.fromMap(json["id_tipo_empaque_fk"]),
      );

  Map<String, dynamic> toMap() => {
        "id_tipo_empaque_fk": idTipoEmpaqueFk.toMap(),
      };
}

class IdFpFk {
  IdFpFk({
    required this.collectionId,
    required this.collectionName,
    required this.activo,
    required this.created,
    required this.id,
    required this.idEmiWeb,
    required this.nombreTipoProd,
    required this.updated,
  });

  final String collectionId;
  final String collectionName;
  final bool activo;
  final DateTime? created;
  final String id;
  final String idEmiWeb;
  final String nombreTipoProd;
  final DateTime? updated;

  factory IdFpFk.fromMap(Map<String, dynamic> json) => IdFpFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        nombreTipoProd: json["nombre_tipo_prod"],
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
      );

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "nombre_tipo_prod": nombreTipoProd,
        "updated": updated == null ? null : updated!.toIso8601String(),
      };
}

class IdTeFk {
  IdTeFk({
    required this.collectionId,
    required this.collectionName,
    required this.activo,
    required this.created,
    required this.id,
    required this.idEmiWeb,
    required this.updated,
    required this.tipoEmpaque,
  });

  final String collectionId;
  final String collectionName;
  final bool activo;
  final DateTime? created;
  final String id;
  final String idEmiWeb;
  final DateTime? updated;
  final String tipoEmpaque;

  factory IdTeFk.fromMap(Map<String, dynamic> json) => IdTeFk(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        activo: json["activo"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        tipoEmpaque: json["tipo_empaque"],
      );

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "activo": activo,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "tipo_empaque": tipoEmpaque,
      };
}
