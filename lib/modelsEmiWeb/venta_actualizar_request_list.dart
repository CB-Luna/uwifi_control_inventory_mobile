import 'dart:convert';

VentaActualizarRequestList ventaActualizarRequestListFromMap(String str) => VentaActualizarRequestList.fromMap(json.decode(str));

String ventaActualizarRequestListToMap(VentaActualizarRequestList data) => json.encode(data.toMap());

class VentaActualizarRequestList {
    VentaActualizarRequestList({
        required this.id,
        required this.idProductoEmprendedor,
        required this.cantidadVendida,
        required this.nombreProducto,
        required this.costoUnitario,
        required this.unidadMedida,
        required this.precioVenta,
    });

    final int id;
    final String idProductoEmprendedor;
    final int cantidadVendida;
    final String nombreProducto;
    final double costoUnitario;
    final String unidadMedida;
    final double precioVenta;

    factory VentaActualizarRequestList.fromMap(Map<String, dynamic> json) => VentaActualizarRequestList(
        id: json["id"],
        idProductoEmprendedor: json["idProductoEmprendedor"],
        cantidadVendida: json["cantidadVendida"],
        nombreProducto: json["nombreProducto"],
        costoUnitario: json["costoUnitario"].toDouble(),
        unidadMedida: json["unidadMedida"],
        precioVenta: json["precioVenta"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "idProductoEmprendedor": idProductoEmprendedor,
        "cantidadVendida": cantidadVendida,
        "nombreProducto": nombreProducto,
        "costoUnitario": costoUnitario,
        "unidadMedida": unidadMedida,
        "precioVenta": precioVenta,
    };
}
