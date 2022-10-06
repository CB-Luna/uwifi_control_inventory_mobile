import 'dart:convert';

GetAmbitoConsultoriaEmiWeb getAmbitoConsultoriaEmiWebFromMap(String str) => GetAmbitoConsultoriaEmiWeb.fromMap(json.decode(str));

String getAmbitoConsultoriaEmiWebToMap(GetAmbitoConsultoriaEmiWeb data) => json.encode(data.toMap());

class GetAmbitoConsultoriaEmiWeb {
    GetAmbitoConsultoriaEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetAmbitoConsultoriaEmiWeb.fromMap(Map<String, dynamic> json) => GetAmbitoConsultoriaEmiWeb(
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
        required this.idCatAmbito,
        required this.ambito,
        required this.activo,
    });

    final int idCatAmbito;
    final String ambito;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatAmbito: json["idCatAmbito"],
        ambito: json["ambito"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatAmbito": idCatAmbito,
        "ambito": ambito,
        "activo": activo,
    };
}
