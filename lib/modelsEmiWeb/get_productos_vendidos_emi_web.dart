import 'dart:convert';

GetProductosVendidosEmiWeb getProductosVendidosEmiWebFromMap(String str) => GetProductosVendidosEmiWeb.fromMap(json.decode(str));

String getProductosVendidosEmiWebToMap(GetProductosVendidosEmiWeb data) => json.encode(data.toMap());

class GetProductosVendidosEmiWeb {
    GetProductosVendidosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetProductosVendidosEmiWeb.fromMap(Map<String, dynamic> json) => GetProductosVendidosEmiWeb(
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
        required this.venta,
        required this.ventasXProductoEmprenedorList,
    });

    final Venta? venta;
    final List<VentasXProductoEmprenedorList>? ventasXProductoEmprenedorList;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        venta: json["venta"] == null ? null : Venta.fromMap(json["venta"]),
        ventasXProductoEmprenedorList: json["ventasXProductoEmprenedorList"] == null ? null : List<VentasXProductoEmprenedorList>.from(json["ventasXProductoEmprenedorList"].map((x) => VentasXProductoEmprenedorList.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "venta": venta == null ? null : venta!.toMap(),
        "ventasXProductoEmprenedorList": ventasXProductoEmprenedorList == null ? null : List<dynamic>.from(ventasXProductoEmprenedorList!.map((x) => x.toMap())),
    };
}

class Venta {
    Venta({
        required this.idVentas,
        required this.fechaInicio,
        required this.fechaTermino,
        required this.total,
        required this.archivado,
        required this.idProyecto,
    });

    final int idVentas;
    final DateTime? fechaInicio;
    final DateTime? fechaTermino;
    final double total;
    final bool archivado;
    final int idProyecto;

    factory Venta.fromMap(Map<String, dynamic> json) => Venta(
        idVentas: json["idVentas"],
        fechaInicio: json["fechaInicio"] == null ? null : DateTime.parse(json["fechaInicio"]),
        fechaTermino: json["fechaTermino"] == null ? null : DateTime.parse(json["fechaTermino"]),
        total: json["total"].toDouble(),
        archivado: json["archivado"],
        idProyecto: json["idProyecto"],
    );

    Map<String, dynamic> toMap() => {
        "idVentas": idVentas,
        "fechaInicio": fechaInicio == null ? null : fechaInicio!.toIso8601String(),
        "fechaTermino": fechaTermino == null ? null : fechaTermino!.toIso8601String(),
        "total": total,
        "archivado": archivado,
        "idProyecto": idProyecto,
    };
}

class VentasXProductoEmprenedorList {
    VentasXProductoEmprenedorList({
        required this.id,
        required this.productoEmprendedorDto,
    });

    final int? id;
    final ProductoEmprendedorDto? productoEmprendedorDto;

    factory VentasXProductoEmprenedorList.fromMap(Map<String, dynamic> json) => VentasXProductoEmprenedorList(
        id: json["id"],
        productoEmprendedorDto: json["productoEmprendedorDto"] == null ? null : ProductoEmprendedorDto.fromMap(json["productoEmprendedorDto"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "productoEmprendedorDto": productoEmprendedorDto == null ? null : productoEmprendedorDto!.toMap(),
    };
}

class ProductoEmprendedorDto {
    ProductoEmprendedorDto({
        required this.idProductoEmprendedor,
        required this.producto,
        required this.costoUnidadMedida,
        required this.cantidadVendida,
        required this.precioVenta,
        required this.unidadMedida,
    });

    final int idProductoEmprendedor;
    final String producto;
    final double costoUnidadMedida;
    final int cantidadVendida;
    final double precioVenta;
    final String unidadMedida;

    factory ProductoEmprendedorDto.fromMap(Map<String, dynamic> json) => ProductoEmprendedorDto(
        idProductoEmprendedor: json["idProductoEmprendedor"],
        producto: json["producto"],
        costoUnidadMedida: json["costoUnidadMedida"].toDouble(),
        cantidadVendida: json["cantidadVendida"],
        precioVenta: json["precioVenta"].toDouble(),
        unidadMedida: json["unidadMedida"],
    );

    Map<String, dynamic> toMap() => {
        "idProductoEmprendedor": idProductoEmprendedor,
        "producto": producto,
        "costoUnidadMedida": costoUnidadMedida,
        "cantidadVendida": cantidadVendida,
        "precioVenta": precioVenta,
        "unidadMedida": unidadMedida,
    };
}
