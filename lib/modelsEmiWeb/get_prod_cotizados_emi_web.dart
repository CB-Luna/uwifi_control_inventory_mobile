import 'dart:convert';

GetProdCotizadosEmiWeb getProdCotizadosEmiWebFromMap(String str) => GetProdCotizadosEmiWeb.fromMap(json.decode(str));

String getProdCotizadosEmiWebToMap(GetProdCotizadosEmiWeb data) => json.encode(data.toMap());

class GetProdCotizadosEmiWeb {
    GetProdCotizadosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<List<Payload>>? payload;

    factory GetProdCotizadosEmiWeb.fromMap(Map<String, dynamic> json) => GetProdCotizadosEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : List<List<Payload>>.from(json["payload"].map((x) => List<Payload>.from(x.map((x) => Payload.fromMap(x))))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : List<dynamic>.from(payload!.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
    };
}

class Payload {
    Payload({
        required this.idListaCotizacion,
        required this.idInversion,
        required this.productosCotizadosList,
    });

    final int idListaCotizacion;
    final int idInversion;
    final List<ProductosCotizadosList>? productosCotizadosList;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idListaCotizacion: json["idListaCotizacion"],
        idInversion: json["idInversion"],
        productosCotizadosList: json["productosCotizadosList"] == null ? null : List<ProductosCotizadosList>.from(json["productosCotizadosList"].map((x) => ProductosCotizadosList.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idListaCotizacion": idListaCotizacion,
        "idInversion": idInversion,
        "productosCotizadosList": productosCotizadosList == null ? null : List<dynamic>.from(productosCotizadosList!.map((x) => x.toMap())),
    };
}

class ProductosCotizadosList {
    ProductosCotizadosList({
        required this.proveedor,
        required this.idProducto,
        required this.producto,
        required this.descripcion,
        required this.marca,
        required this.cantidad,
        required this.costoTotal,
        this.idDocumento,
    });

    final String proveedor;
    final int idProducto;
    final String producto;
    final String descripcion;
    final String marca;
    final int cantidad;
    final double costoTotal;
    final int? idDocumento;

    factory ProductosCotizadosList.fromMap(Map<String, dynamic> json) => ProductosCotizadosList(
        proveedor: json["proveedor"],
        idProducto: json["idProducto"],
        producto: json["producto"],
        descripcion: json["descripcion"],
        marca: json["marca"],
        cantidad: json["cantidad"],
        costoTotal: json["costoTotal"].toDouble(),
        idDocumento: json["idDocumento"],
    );

    Map<String, dynamic> toMap() => {
        "proveedor": proveedor,
        "idProducto": idProducto,
        "producto": producto,
        "descripcion": descripcion,
        "marca": marca,
        "cantidad": cantidad,
        "costoTotal": costoTotal,
        "idDocumento": idDocumento,
    };
}
