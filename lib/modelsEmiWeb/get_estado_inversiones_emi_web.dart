import 'dart:convert';

GetEstadoInversionesEmiWeb getEstadoInversionesEmiWebFromMap(String str) => GetEstadoInversionesEmiWeb.fromMap(json.decode(str));

String getEstadoInversionesEmiWebToMap(GetEstadoInversionesEmiWeb data) => json.encode(data.toMap());

class GetEstadoInversionesEmiWeb {
    GetEstadoInversionesEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetEstadoInversionesEmiWeb.fromMap(Map<String, dynamic> json) => GetEstadoInversionesEmiWeb(
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
        required this.idCatEstadoInversion,
        required this.estadoInversion,
    });

    final int idCatEstadoInversion;
    final String estadoInversion;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatEstadoInversion: json["idCatEstadoInversion"],
        estadoInversion: json["estadoInversion"],
    );

    Map<String, dynamic> toMap() => {
        "idCatEstadoInversion": idCatEstadoInversion,
        "estadoInversion": estadoInversion,
    };
}
