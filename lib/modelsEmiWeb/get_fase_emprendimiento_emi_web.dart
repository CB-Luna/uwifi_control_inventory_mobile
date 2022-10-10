import 'dart:convert';

GetFaseEmprendimientoEmiWeb getFaseEmprendimientoEmiWebFromMap(String str) => GetFaseEmprendimientoEmiWeb.fromMap(json.decode(str));

String getFaseEmprendimientoEmiWebToMap(GetFaseEmprendimientoEmiWeb data) => json.encode(data.toMap());

class GetFaseEmprendimientoEmiWeb {
    GetFaseEmprendimientoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetFaseEmprendimientoEmiWeb.fromMap(Map<String, dynamic> json) => GetFaseEmprendimientoEmiWeb(
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
        required this.idCatFase,
        required this.fase,
    });

    final int idCatFase;
    final String fase;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatFase: json["idCatFase"],
        fase: json["fase"],
    );

    Map<String, dynamic> toMap() => {
        "idCatFase": idCatFase,
        "fase": fase,
    };
}
