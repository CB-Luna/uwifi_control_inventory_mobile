import 'dart:convert';

GetComunidadesEmiWeb getComunidadesEmiWebFromMap(String str) => GetComunidadesEmiWeb.fromMap(json.decode(str));

String getComunidadesEmiWebToMap(GetComunidadesEmiWeb data) => json.encode(data.toMap());

class GetComunidadesEmiWeb {
    GetComunidadesEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetComunidadesEmiWeb.fromMap(Map<String, dynamic> json) => GetComunidadesEmiWeb(
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
        required this.idCatComunidad,
        required this.comunidad,
        required this.idCatMunicipio,
        required this.activo,
        required this.idEstado,
    });

    final int idCatComunidad;
    final String comunidad;
    final int idCatMunicipio;
    final bool activo;
    final int idEstado;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatComunidad: json["idCatComunidad"],
        comunidad: json["comunidad"],
        idCatMunicipio: json["idCatMunicipio"],
        activo: json["activo"],
        idEstado: json["idEstado"],
    );

    Map<String, dynamic> toMap() => {
        "idCatComunidad": idCatComunidad,
        "comunidad": comunidad,
        "idCatMunicipio": idCatMunicipio,
        "activo": activo,
        "idEstado": idEstado,
    };
}
