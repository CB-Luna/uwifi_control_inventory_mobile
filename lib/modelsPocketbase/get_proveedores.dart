import 'dart:convert';

GetProveedores getProveedoresFromMap(String str) => GetProveedores.fromMap(json.decode(str));

String getProveedoresToMap(GetProveedores data) => json.encode(data.toMap());

class GetProveedores {
    GetProveedores({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreFiscal,
        required this.rfc,
        required this.idTipoProveedorFk,
        required this.direccion,
        required this.idComunidadFk,
        required this.nombreEncargado,
        required this.idCondicionPagoFk,
        required this.clabe,
        required this.telefono,
        required this.idBancoFk,
        required this.archivado,
        required this.registradoPor,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreFiscal;
    final String rfc;
    final String idTipoProveedorFk;
    final String direccion;
    final String idComunidadFk;
    final String nombreEncargado;
    final String idCondicionPagoFk;
    final String clabe;
    final String telefono;
    final String idBancoFk;
    final bool archivado;
    final int registradoPor;

    factory GetProveedores.fromMap(Map<String, dynamic> json) => GetProveedores(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreFiscal: json["nombre_fiscal"],
        rfc: json["rfc"],
        idTipoProveedorFk: json["id_tipo_proveedor_fk"],
        direccion: json["direccion"],
        idComunidadFk: json["id_comunidad_fk"],
        nombreEncargado: json["nombre_encargado"],
        idCondicionPagoFk: json["id_condicion_pago_fk"],
        clabe: json["clabe"],
        telefono: json["telefono"],
        idBancoFk: json["id_banco_fk"],
        archivado: json["archivado"],
        registradoPor: json["registrado_por"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_fiscal": nombreFiscal,
        "rfc": rfc,
        "id_tipo_proveedor_fk": idTipoProveedorFk,
        "direccion": direccion,
        "id_comunidad_fk": idComunidadFk,
        "nombre_encargado": nombreEncargado,
        "id_condicion_pago_fk": idCondicionPagoFk,
        "clabe": clabe,
        "telefono": telefono,
        "id_banco_fk": idBancoFk,
        "archivado": archivado,
        "registrado_por": registradoPor,
    };
}
