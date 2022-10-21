import 'dart:convert';

GetProdEmprendedorByEmprendedorEmiWeb getProdEmprendedorByEmprendedorEmiWebFromMap(String str) => GetProdEmprendedorByEmprendedorEmiWeb.fromMap(json.decode(str));

String getProdEmprendedorByEmprendedorEmiWebToMap(GetProdEmprendedorByEmprendedorEmiWeb data) => json.encode(data.toMap());

class GetProdEmprendedorByEmprendedorEmiWeb {
    GetProdEmprendedorByEmprendedorEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetProdEmprendedorByEmprendedorEmiWeb.fromMap(Map<String, dynamic> json) => GetProdEmprendedorByEmprendedorEmiWeb(
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
        required this.idProductoEmprendedor,
        required this.producto,
        required this.costoUnidadMedida,
        required this.archivado,
        required this.unidadMedida,
    });

    final int idProductoEmprendedor;
    final String producto;
    final double costoUnidadMedida;
    final bool archivado;
    final String unidadMedida;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idProductoEmprendedor: json["idProductoEmprendedor"],
        producto: json["producto"],
        costoUnidadMedida: json["costoUnidadMedida"].toDouble(),
        archivado: json["archivado"],
        unidadMedida: json["unidadMedida"],
    );

    Map<String, dynamic> toMap() => {
        "idProductoEmprendedor": idProductoEmprendedor,
        "producto": producto,
        "costoUnidadMedida": costoUnidadMedida,
        "archivado": archivado,
        "unidadMedida": unidadMedida,
    };
}
