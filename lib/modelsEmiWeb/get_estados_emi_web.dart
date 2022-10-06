import 'dart:convert';

GetEstadosEmiWeb getEstadosEmiWebFromMap(String str) => GetEstadosEmiWeb.fromMap(json.decode(str));

String getEstadosEmiWebToMap(GetEstadosEmiWeb data) => json.encode(data.toMap());

class GetEstadosEmiWeb {
    GetEstadosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetEstadosEmiWeb.fromMap(Map<String, dynamic> json) => GetEstadosEmiWeb(
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
        required this.idCatEstado,
        required this.estado,
        required this.activo,
    });

    final int idCatEstado;
    final String estado;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatEstado: json["idCatEstado"],
        estado: json["estado"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatEstado": idCatEstado,
        "estado": estado,
        "activo": activo,
    };
}
