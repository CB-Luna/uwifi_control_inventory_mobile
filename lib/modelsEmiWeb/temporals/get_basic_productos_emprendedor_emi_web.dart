import 'dart:convert';

GetBasicProductosEmprendedorEmiWeb getBasicProductosEmprendedorEmiWebFromMap(String str) => GetBasicProductosEmprendedorEmiWeb.fromMap(json.decode(str));

String getBasicProductosEmprendedorEmiWebToMap(GetBasicProductosEmprendedorEmiWeb data) => json.encode(data.toMap());

class GetBasicProductosEmprendedorEmiWeb {
    GetBasicProductosEmprendedorEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload> payload;

    factory GetBasicProductosEmprendedorEmiWeb.fromMap(Map<String, dynamic> json) => GetBasicProductosEmprendedorEmiWeb(
        status: json["status"],
        payload: List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
    };
}

class Payload {
    Payload({
        required this.idProductoEmprendedor,
        this.idDocumento,
        this.documento,
        required this.idUnidadMedida,
        required this.unidadMedidaEmprendedor,
        required this.archivado,
        required this.costoUnidadMedida,
        this.descripcion,
        required this.idEmprendimiento,
        required this.producto,
    });

    final int idProductoEmprendedor;
    final int? idDocumento;
    final Documento? documento;
    final int idUnidadMedida;
    final UnidadMedidaEmprendedor unidadMedidaEmprendedor;
    final bool archivado;
    final double costoUnidadMedida;
    final String? descripcion;
    final int idEmprendimiento;
    final String producto;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idProductoEmprendedor: json["idProductoEmprendedor"],
        idDocumento: json["idDocumento"],
        documento: json["documento"] == null ? null : Documento.fromMap(json["documento"]),
        idUnidadMedida: json["idUnidadMedida"],
        unidadMedidaEmprendedor: UnidadMedidaEmprendedor.fromMap(json["unidadMedidaEmprendedor"]),
        archivado: json["archivado"],
        costoUnidadMedida: json["costoUnidadMedida"].toDouble(),
        descripcion: json["descripcion"],
        idEmprendimiento: json["idEmprendimiento"],
        producto: json["producto"],
    );

    Map<String, dynamic> toMap() => {
        "idProductoEmprendedor": idProductoEmprendedor,
        "idDocumento": idDocumento,
        "documento": documento == null ? null : documento!.toMap(),
        "idUnidadMedida": idUnidadMedida,
        "unidadMedidaEmprendedor": unidadMedidaEmprendedor == null ? null : unidadMedidaEmprendedor.toMap(),
        "archivado": archivado,
        "costoUnidadMedida": costoUnidadMedida,
        "descripcion": descripcion,
        "idEmprendimiento": idEmprendimiento,
        "producto": producto,
    };
}

class Documento {
    Documento({
        required this.idDocumento,
        required this.nombreArchivo,
        required this.fechaCarga,
        required this.archivo,
    });

    final int idDocumento;
    final String nombreArchivo;
    final DateTime fechaCarga;
    final String archivo;

    factory Documento.fromMap(Map<String, dynamic> json) => Documento(
        idDocumento: json["idDocumento"],
        nombreArchivo: json["nombreArchivo"],
        fechaCarga: DateTime.parse(json["fechaCarga"]),
        archivo: json["archivo"],
    );

    Map<String, dynamic> toMap() => {
        "idDocumento": idDocumento,
        "nombreArchivo": nombreArchivo,
        "fechaCarga": fechaCarga.toIso8601String(),
        "archivo": archivo,
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
