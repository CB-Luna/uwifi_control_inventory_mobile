import 'dart:convert';

GetBasicProductoSolicitadoPocketbase
    getBasicProductoSolicitadoPocketbaseFromMap(String str) =>
        GetBasicProductoSolicitadoPocketbase.fromMap(json.decode(str));

String getBasicProductoSolicitadoPocketbaseToMap(
        GetBasicProductoSolicitadoPocketbase data) =>
    json.encode(data.toMap());

class GetBasicProductoSolicitadoPocketbase {
  GetBasicProductoSolicitadoPocketbase({
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.items,
  });

  final int page;
  final int perPage;
  final int totalItems;
  final List<ProductoSolicitado> items;

  factory GetBasicProductoSolicitadoPocketbase.fromMap(
          Map<String, dynamic> json) =>
      GetBasicProductoSolicitadoPocketbase(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: List<ProductoSolicitado>.from(
            json["items"].map((x) => ProductoSolicitado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ProductoSolicitado {
  ProductoSolicitado({
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
    required this.idTipoEmpaquesFk,
    required this.marcaSugerida,
    required this.producto,
    required this.proveedoSugerido,
    required this.updated,
  });

  final String collectionId;
  final String collectionName;
  final ProductoSolicitadoExpand expand;
  final int cantidad;
  final double costoEstimado;
  final DateTime? created;
  final String descripcion;
  final String id;
  final String idEmiWeb;
  final String idImagenFk;
  final String idInversionFk;
  final String idTipoEmpaquesFk;
  final String marcaSugerida;
  final String producto;
  final String proveedoSugerido;
  final DateTime? updated;

  factory ProductoSolicitado.fromMap(Map<String, dynamic> json) =>
      ProductoSolicitado(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        expand: ProductoSolicitadoExpand.fromMap(json["@expand"]),
        cantidad: json["cantidad"],
        costoEstimado: json["costo_estimado"].toDouble(),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        descripcion: json["descripcion"],
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenFk: json["id_imagen_fk"],
        idInversionFk: json["id_inversion_fk"],
        idTipoEmpaquesFk: json["id_tipo_empaques_fk"],
        marcaSugerida: json["marca_sugerida"],
        producto: json["producto"],
        proveedoSugerido: json["proveedo_sugerido"],
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
        "id_tipo_empaques_fk": idTipoEmpaquesFk,
        "marca_sugerida": marcaSugerida,
        "producto": producto,
        "proveedo_sugerido": proveedoSugerido,
        "updated": updated == null ? null : updated!.toIso8601String(),
      };
}

class ProductoSolicitadoExpand {
  ProductoSolicitadoExpand({
    required this.idTipoEmpaquesFk,
    required this.idImagenFk,
  });

  final IdTek idTipoEmpaquesFk;
  final IdImagenFk? idImagenFk;

  factory ProductoSolicitadoExpand.fromMap(Map<String, dynamic> json) =>
      ProductoSolicitadoExpand(
        idTipoEmpaquesFk: IdTek.fromMap(json["id_tipo_empaques_fk"]),
        idImagenFk: json["id_imagen_fk"] == null
            ? null
            : IdImagenFk.fromMap(json["id_imagen_fk"]),
      );

  Map<String, dynamic> toMap() => {
        "id_tipo_empaques_fk": idTipoEmpaquesFk.toMap(),
        "id_imagen_fk": idImagenFk == null ? null : idImagenFk!.toMap(),
      };
}

class IdFpk {
  IdFpk({
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

  factory IdFpk.fromMap(Map<String, dynamic> json) => IdFpk(
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

class IdTek {
  IdTek({
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

  factory IdTek.fromMap(Map<String, dynamic> json) => IdTek(
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
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        nombre: json["nombre"],
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
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
