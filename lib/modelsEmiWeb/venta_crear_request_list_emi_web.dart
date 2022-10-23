import 'dart:convert';

VentaCrearRequestListEmiWeb ventaCrearRequestListEmiWebFromMap(String str) => VentaCrearRequestListEmiWeb.fromMap(json.decode(str));

String ventaCrearRequestListEmiWebToMap(VentaCrearRequestListEmiWeb data) => json.encode(data.toMap());

class VentaCrearRequestListEmiWeb {
    VentaCrearRequestListEmiWeb({
        required this.idProductoEmprendedor,
        required this.cantidadVendida,
        required this.precioVenta,
    });

    final int idProductoEmprendedor;
    final int cantidadVendida;
    final double precioVenta;

    factory VentaCrearRequestListEmiWeb.fromMap(Map<String, dynamic> json) => VentaCrearRequestListEmiWeb(
        idProductoEmprendedor: json["idProductoEmprendedor"],
        cantidadVendida: json["cantidadVendida"],
        precioVenta: json["precioVenta"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "idProductoEmprendedor": idProductoEmprendedor,
        "cantidadVendida": cantidadVendida,
        "precioVenta": precioVenta,
    };
}
