import 'dart:convert';

GetAreaCirculoEmiWeb getAreaCirculoEmiWebFromMap(String str) => GetAreaCirculoEmiWeb.fromMap(json.decode(str));

String getAreaCirculoEmiWebToMap(GetAreaCirculoEmiWeb data) => json.encode(data.toMap());

class GetAreaCirculoEmiWeb {
    GetAreaCirculoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetAreaCirculoEmiWeb.fromMap(Map<String, dynamic> json) => GetAreaCirculoEmiWeb(
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
        required this.idCatAreaCirculo,
        required this.areaCirculo,
        required this.activo,
    });

    final int idCatAreaCirculo;
    final String areaCirculo;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatAreaCirculo: json["idCatAreaCirculo"],
        areaCirculo: json["areaCirculo"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatAreaCirculo": idCatAreaCirculo,
        "areaCirculo": areaCirculo,
        "activo": activo,
    };
}
