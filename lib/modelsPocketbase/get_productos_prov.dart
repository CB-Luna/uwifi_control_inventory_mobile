import 'dart:convert';

GetProductosProv getProductosProvFromMap(String str) => GetProductosProv.fromMap(json.decode(str));

String getProductosProvToMap(GetProductosProv data) => json.encode(data.toMap());

class GetProductosProv {
    GetProductosProv({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreProdProv,
        required this.descripcionProdProv,
        required this.marca,
        required this.isUndMedidaFk,
        required this.costoProdProv,
        required this.idProveedorFk,
        required this.idFamiliaProdFk,
        required this.tiempoEntrega,
        required this.archivado,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreProdProv;
    final String descripcionProdProv;
    final String marca;
    final String isUndMedidaFk;
    final double costoProdProv;
    final String idProveedorFk;
    final String idFamiliaProdFk;
    final int tiempoEntrega;
    final bool archivado;
    final String idEmiWeb;

    factory GetProductosProv.fromMap(Map<String, dynamic> json) => GetProductosProv(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreProdProv: json["nombre_prod_prov"],
        descripcionProdProv: json["descripcion_prod_prov"],
        marca: json["marca"],
        isUndMedidaFk: json["is_und_medida_fk"],
        costoProdProv: json["costo_prod_prov"] == null ? null : json["costo_prod_prov"]!.toDouble(),
        idProveedorFk: json["id_proveedor_fk"],
        idFamiliaProdFk: json["id_familia_prod_fk"],
        tiempoEntrega: json["tiempo_entrega"],
        archivado: json["archivado"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_prod_prov": nombreProdProv,
        "descripcion_prod_prov": descripcionProdProv,
        "marca": marca,
        "is_und_medida_fk": isUndMedidaFk,
        "costo_prod_prov": costoProdProv,
        "id_proveedor_fk": idProveedorFk,
        "id_familia_prod_fk": idFamiliaProdFk,
        "tiempo_entrega": tiempoEntrega,
        "archivado": archivado,
        "id_emi_web": idEmiWeb,
    };
}
