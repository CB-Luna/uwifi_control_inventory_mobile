import 'dart:convert';

GetUnidadMedidaEmiWeb getUnidadMedidaEmiWebFromMap(String str) => GetUnidadMedidaEmiWeb.fromMap(json.decode(str));

String getUnidadMedidaEmiWebToMap(GetUnidadMedidaEmiWeb data) => json.encode(data.toMap());

class GetUnidadMedidaEmiWeb {
    GetUnidadMedidaEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetUnidadMedidaEmiWeb.fromMap(Map<String, dynamic> json) => GetUnidadMedidaEmiWeb(
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
        required this.idCatUnidadMedida,
        required this.unidadMedida,
        required this.activo,
    });

    final int idCatUnidadMedida;
    final String unidadMedida;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
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
