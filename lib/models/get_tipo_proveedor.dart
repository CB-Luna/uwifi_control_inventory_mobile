import 'dart:convert';

GetTipoProveedor getTipoProveedorFromMap(String str) => GetTipoProveedor.fromMap(json.decode(str));

String getTipoProveedorToMap(GetTipoProveedor data) => json.encode(data.toMap());

class GetTipoProveedor {
    GetTipoProveedor({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.tipoProveedor,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String tipoProveedor;
    final bool activo;

    factory GetTipoProveedor.fromMap(Map<String, dynamic> json) => GetTipoProveedor(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        tipoProveedor: json["tipo_proveedor"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "tipo_proveedor": tipoProveedor,
        "activo": activo,
    };
}
