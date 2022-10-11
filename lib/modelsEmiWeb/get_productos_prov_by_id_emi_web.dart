import 'dart:convert';

GetProductosProvByIdEmiWeb getProductosProvByIdEmiWebFromMap(String str) => GetProductosProvByIdEmiWeb.fromMap(json.decode(str));

String getProductosProvByIdEmiWebToMap(GetProductosProvByIdEmiWeb data) => json.encode(data.toMap());

class GetProductosProvByIdEmiWeb {
    GetProductosProvByIdEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetProductosProvByIdEmiWeb.fromMap(Map<String, dynamic> json) => GetProductosProvByIdEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : payload!.toMap(),
    };
}

class Payload {
    Payload({
        required this.idProductosProveedor,
        required this.idProveedor,
        required this.producto,
        required this.idCatTipoProducto,
        required this.marca,
        required this.descripcion,
        required this.costoUnidadMedida,
        required this.tiempoEntrega,
        required this.idUnidadMedida,
        required this.archivado,
    });

    final int idProductosProveedor;
    final int idProveedor;
    final String producto;
    final int idCatTipoProducto;
    final String marca;
    final String descripcion;
    final double costoUnidadMedida;
    final int tiempoEntrega;
    final int idUnidadMedida;
    final bool archivado;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idProductosProveedor: json["idProductosProveedor"],
        idProveedor: json["idProveedor"],
        producto: json["producto"],
        idCatTipoProducto: json["idCatTipoProducto"],
        marca: json["marca"],
        descripcion: json["descripcion"],
        costoUnidadMedida: json["costoUnidadMedida"],
        tiempoEntrega: json["tiempoEntrega"],
        idUnidadMedida: json["idUnidadMedida"],
        archivado: json["archivado"],
    );

    Map<String, dynamic> toMap() => {
        "idProductosProveedor": idProductosProveedor,
        "idProveedor": idProveedor,
        "producto": producto,
        "idCatTipoProducto": idCatTipoProducto,
        "marca": marca,
        "descripcion": descripcion,
        "costoUnidadMedida": costoUnidadMedida,
        "tiempoEntrega": tiempoEntrega,
        "idUnidadMedida": idUnidadMedida,
        "archivado": archivado,
    };
}
