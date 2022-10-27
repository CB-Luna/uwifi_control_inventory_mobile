import 'dart:convert';

GetVentaEmiWeb getVentaEmiWebFromMap(String str) => GetVentaEmiWeb.fromMap(json.decode(str));

String getVentaEmiWebToMap(GetVentaEmiWeb data) => json.encode(data.toMap());

class GetVentaEmiWeb {
    GetVentaEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetVentaEmiWeb.fromMap(Map<String, dynamic> json) => GetVentaEmiWeb(
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
        required this.emprendedores,
        required this.emprendimientos,
        required this.montosTotales,
    });

    final List<int>? ids;
    final List<String>? emprendedores;
    final List<String>? emprendimientos;
    final List<double>? montosTotales;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        ids: json["ids"] == null ? null : List<int>.from(json["ids"].map((x) => x)),
        emprendedores: json["emprendedores"] == null ? null : List<String>.from(json["emprendedores"].map((x) => x)),
        emprendimientos: json["emprendimientos"] == null ? null : List<String>.from(json["emprendimientos"].map((x) => x)),
        montosTotales: json["montosTotales"] == null ? null : List<double>.from(json["montosTotales"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "ids": ids == null ? null : List<dynamic>.from(ids!.map((x) => x)),
        "emprendedores": emprendedores == null ? null : List<dynamic>.from(emprendedores!.map((x) => x)),
        "emprendimientos": emprendimientos == null ? null : List<dynamic>.from(emprendimientos!.map((x) => x)),
        "montosTotales": montosTotales == null ? null : List<dynamic>.from(montosTotales!.map((x) => x)),
    };
}
