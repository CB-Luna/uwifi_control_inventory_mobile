import 'dart:convert';

GetBasicVentasEmiWeb getBasicVentasEmiWebFromMap(String str) => GetBasicVentasEmiWeb.fromMap(json.decode(str));

String getBasicVentasEmiWebToMap(GetBasicVentasEmiWeb data) => json.encode(data.toMap());

class GetBasicVentasEmiWeb {
    GetBasicVentasEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetBasicVentasEmiWeb.fromMap(Map<String, dynamic> json) => GetBasicVentasEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : List<dynamic>.from(payload!.map((x) => x.toMap())),
    };
}

class Payload {
    Payload({
        required this.idVentas,
        required this.fechaInicio,
        required this.fechaTermino,
        required this.total,
        required this.archivado,
        required this.idProyecto,
        required this.ventasXProductoEmprendedor,
    });

    final int idVentas;
    final DateTime fechaInicio;
    final DateTime fechaTermino;
    final double total;
    final bool archivado;
    final int idProyecto;
    final List<VentasXProductoEmprendedor> ventasXProductoEmprendedor;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idVentas: json["idVentas"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaTermino: DateTime.parse(json["fechaTermino"]),
        total: json["total"].toDouble(),
        archivado: json["archivado"],
        idProyecto: json["idProyecto"],
        ventasXProductoEmprendedor: List<VentasXProductoEmprendedor>.from(json["ventasXProductoEmprendedor"].map((x) => VentasXProductoEmprendedor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idVentas": idVentas,
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaTermino": fechaTermino.toIso8601String(),
        "total": total,
        "archivado": archivado,
        "idProyecto": idProyecto,
        "ventasXProductoEmprendedor": List<dynamic>.from(ventasXProductoEmprendedor.map((x) => x.toMap())),
    };
}

class VentasXProductoEmprendedor {
    VentasXProductoEmprendedor({
        required this.id,
        required this.idVenta,
        required this.idProductoEmprendedor,
        required this.unidadMedidaEmprendedor,
        required this.cantidadVendida,
        required this.costoUnitario,
        required this.producto,
        required this.precioVenta,
        required this.subTotal,
    });

    final int id;
    final int idVenta;
    final int idProductoEmprendedor;
    final UnidadMedidaEmprendedor unidadMedidaEmprendedor;
    final int cantidadVendida;
    final double costoUnitario;
    final Producto producto;
    final double precioVenta;
    final double subTotal;

    factory VentasXProductoEmprendedor.fromMap(Map<String, dynamic> json) => VentasXProductoEmprendedor(
        id: json["id"],
        idVenta: json["idVenta"],
        idProductoEmprendedor: json["idProductoEmprendedor"],
        unidadMedidaEmprendedor: UnidadMedidaEmprendedor.fromMap(json["unidadMedidaEmprendedor"]),
        cantidadVendida: json["cantidadVendida"],
        costoUnitario: json["costoUnitario"].toDouble(),
        producto: Producto.fromMap(json["producto"]),
        precioVenta: json["precioVenta"].toDouble(),
        subTotal: json["subTotal"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "idVenta": idVenta,
        "idProductoEmprendedor": idProductoEmprendedor,
        "unidadMedidaEmprendedor": unidadMedidaEmprendedor.toMap(),
        "cantidadVendida": cantidadVendida,
        "costoUnitario": costoUnitario,
        "producto": producto.toMap(),
        "precioVenta": precioVenta,
        "subTotal": subTotal,
    };
}

class Producto {
    Producto({
        required this.producto,
        this.descripcion,
    });

    final String producto;
    final String? descripcion;

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        producto: json["producto"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toMap() => {
        "producto": producto,
        "descripcion": descripcion,
    };
}

class UnidadMedidaEmprendedor {
    UnidadMedidaEmprendedor({
        required this.idCatUnidadMedida,
        required this.unidadMedida,
        required this.activo,
    });

    final int idCatUnidadMedida;
    final String unidadMedida;
    final bool activo;

    factory UnidadMedidaEmprendedor.fromMap(Map<String, dynamic> json) => UnidadMedidaEmprendedor(
        idCatUnidadMedida: json["idCatUnidadMedida"],
        unidadMedida: json["unidadMedida"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatUnidadMedida": idCatUnidadMedida,
        "unidadMedida": unidadMedida,
        "activo": activo,
    };
}
