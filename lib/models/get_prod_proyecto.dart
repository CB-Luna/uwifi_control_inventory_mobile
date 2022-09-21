import 'dart:convert';

GetProdProyecto getProdProyectoFromMap(String str) => GetProdProyecto.fromMap(json.decode(str));

String getProdProyectoToMap(GetProdProyecto data) => json.encode(data.toMap());

class GetProdProyecto {
    GetProdProyecto({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.producto,
        this.marcaSugerida,
        required this.descripcion,
        this.proveedorSugerido,
        required this.cantidad,
        this.costoEstimado,
        required this.idFamiliaProdFk,
        required this.idTipoEmpaquesFk,
        required this.idCatalogoProyectoFk,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String producto;
    final String? marcaSugerida;
    final String descripcion;
    final String? proveedorSugerido;
    final int cantidad;
    final double? costoEstimado;
    final String idFamiliaProdFk;
    final String idTipoEmpaquesFk;
    final String idCatalogoProyectoFk;

    factory GetProdProyecto.fromMap(Map<String, dynamic> json) => GetProdProyecto(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        producto: json["producto"],
        marcaSugerida: json["marca_sugerida"] == null ? null : json["marca_sugerida"]!,
        descripcion: json["descripcion"],
        proveedorSugerido: json["proveedor_sugerido"] == null ? null : json["proveedor_sugerido"]!,
        cantidad: json["cantidad"],
        costoEstimado: json["costo_estimado"] == null ? null : json["costo_estimado"]!.toDouble(),
        idFamiliaProdFk: json["id_familia_prod_fk"],
        idTipoEmpaquesFk: json["id_tipo_empaques_fk"],
        idCatalogoProyectoFk: json["id_catalogo_proyecto_fk"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "producto": producto,
        "marca_sugerida": marcaSugerida == null ? null : marcaSugerida!,
        "descripcion": descripcion,
        "proveedor_sugerido": proveedorSugerido == null ? null : proveedorSugerido!,
        "cantidad": cantidad,
        "costo_estimado": costoEstimado == null ? null : costoEstimado!,
        "id_familia_prod_fk": idFamiliaProdFk,
        "id_tipo_empaques_fk": idTipoEmpaquesFk,
        "id_catalogo_proyecto_fk": idCatalogoProyectoFk,
    };
}
