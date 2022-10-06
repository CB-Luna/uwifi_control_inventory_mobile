import 'dart:convert';

GetMunicipiosEmiWeb getMunicipiosEmiWebFromMap(String str) => GetMunicipiosEmiWeb.fromMap(json.decode(str));

String getMunicipiosEmiWebToMap(GetMunicipiosEmiWeb data) => json.encode(data.toMap());

class GetMunicipiosEmiWeb {
    GetMunicipiosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetMunicipiosEmiWeb.fromMap(Map<String, dynamic> json) => GetMunicipiosEmiWeb(
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
        required this.idCatMunicipio,
        required this.municipio,
        required this.idCatEstado,
        required this.activo,
    });

    final int idCatMunicipio;
    final String municipio;
    final int idCatEstado;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatMunicipio: json["idCatMunicipio"],
        municipio: json["municipio"],
        idCatEstado: json["idCatEstado"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatMunicipio": idCatMunicipio,
        "municipio": municipio,
        "idCatEstado": idCatEstado,
        "activo": activo,
    };
}
