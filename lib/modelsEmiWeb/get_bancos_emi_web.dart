import 'dart:convert';

GetBancosEmiWeb getBancosEmiWebFromMap(String str) => GetBancosEmiWeb.fromMap(json.decode(str));

String getBancosEmiWebToMap(GetBancosEmiWeb data) => json.encode(data.toMap());

class GetBancosEmiWeb {
    GetBancosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetBancosEmiWeb.fromMap(Map<String, dynamic> json) => GetBancosEmiWeb(
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
        required this.idCatBancos,
        required this.banco,
        required this.activo,
    });

    final int idCatBancos;
    final String banco;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatBancos: json["idCatBancos"],
        banco: json["banco"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatBancos": idCatBancos,
        "banco": banco,
        "activo": activo,
    };
}
