import 'dart:convert';

GetPorcentajeAvanceEmiWeb getPorcentajeAvanceEmiWebFromMap(String str) => GetPorcentajeAvanceEmiWeb.fromMap(json.decode(str));

String getPorcentajeAvanceEmiWebToMap(GetPorcentajeAvanceEmiWeb data) => json.encode(data.toMap());

class GetPorcentajeAvanceEmiWeb {
    GetPorcentajeAvanceEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetPorcentajeAvanceEmiWeb.fromMap(Map<String, dynamic> json) => GetPorcentajeAvanceEmiWeb(
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
        required this.idCatPorcentajeAvance,
        required this.porcentajeAvance,
    });

    final int idCatPorcentajeAvance;
    final String porcentajeAvance;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatPorcentajeAvance: json["idCatPorcentajeAvance"],
        porcentajeAvance: json["porcentajeAvance"],
    );

    Map<String, dynamic> toMap() => {
        "idCatPorcentajeAvance": idCatPorcentajeAvance,
        "porcentajeAvance": porcentajeAvance,
    };
}
