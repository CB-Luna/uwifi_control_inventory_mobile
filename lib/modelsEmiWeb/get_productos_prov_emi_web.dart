import 'dart:convert';

GetProductosProvEmiWeb getProductosProvEmiWebFromMap(String str) => GetProductosProvEmiWeb.fromMap(json.decode(str));

String getProductosProvEmiWebToMap(GetProductosProvEmiWeb data) => json.encode(data.toMap());

class GetProductosProvEmiWeb {
    GetProductosProvEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetProductosProvEmiWeb.fromMap(Map<String, dynamic> json) => GetProductosProvEmiWeb(
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
        required this.ids,
        required this.tiposProductos,
        required this.productos,
        required this.descripciones,
        required this.marcas,
        required this.unidades,
        required this.costos,
        required this.tiempos,
    });

    final List<int>? ids;
    final List<String>? tiposProductos;
    final List<String>? productos;
    final List<String>? descripciones;
    final List<String>? marcas;
    final List<String>? unidades;
    final List<double>? costos;
    final List<int>? tiempos;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        ids: json["ids"] == null ? null : List<int>.from(json["ids"].map((x) => x)),
        tiposProductos: json["tiposProductos"] == null ? null : List<String>.from(json["tiposProductos"].map((x) => x)),
        productos: json["productos"] == null ? null : List<String>.from(json["productos"].map((x) => x)),
        descripciones: json["descripciones"] == null ? null : List<String>.from(json["descripciones"].map((x) => x)),
        marcas: json["marcas"] == null ? null : List<String>.from(json["marcas"].map((x) => x)),
        unidades: json["unidades"] == null ? null : List<String>.from(json["unidades"].map((x) => x)),
        costos: json["costos"] == null ? null : List<double>.from(json["costos"].map((x) => x.toDouble())),
        tiempos: json["tiempos"] == null ? null : List<int>.from(json["tiempos"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "ids": ids == null ? null : List<dynamic>.from(ids!.map((x) => x)),
        "tiposProductos": tiposProductos == null ? null : List<dynamic>.from(tiposProductos!.map((x) => x)),
        "productos": productos == null ? null : List<dynamic>.from(productos!.map((x) => x)),
        "descripciones": descripciones == null ? null : List<dynamic>.from(descripciones!.map((x) => x)),
        "marcas": marcas == null ? null : List<dynamic>.from(marcas!.map((x) => x)),
        "unidades": unidades == null ? null : List<dynamic>.from(unidades!.map((x) => x)),
        "costos": costos == null ? null : List<dynamic>.from(costos!.map((x) => x)),
        "tiempos": tiempos == null ? null : List<dynamic>.from(tiempos!.map((x) => x)),
    };
}
