import 'dart:convert';

GetTipoEmpaquesEmiWeb getTipoEmpaquesEmiWebFromMap(String str) => GetTipoEmpaquesEmiWeb.fromMap(json.decode(str));

String getTipoEmpaquesEmiWebToMap(GetTipoEmpaquesEmiWeb data) => json.encode(data.toMap());

class GetTipoEmpaquesEmiWeb {
    GetTipoEmpaquesEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetTipoEmpaquesEmiWeb.fromMap(Map<String, dynamic> json) => GetTipoEmpaquesEmiWeb(
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
        required this.idCatTipoEmpaque,
        required this.tipoEmpaque,
        required this.activo,
    });

    final int idCatTipoEmpaque;
    final String tipoEmpaque;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatTipoEmpaque: json["idCatTipoEmpaque"],
        tipoEmpaque: json["tipoEmpaque"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoEmpaque": idCatTipoEmpaque,
        "tipoEmpaque": tipoEmpaque,
        "activo": activo,
    };
}
