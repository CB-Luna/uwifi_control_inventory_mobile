import 'dart:convert';

GetCondicionesPagoEmiWeb getCondicionesPagoEmiWebFromMap(String str) => GetCondicionesPagoEmiWeb.fromMap(json.decode(str));

String getCondicionesPagoEmiWebToMap(GetCondicionesPagoEmiWeb data) => json.encode(data.toMap());

class GetCondicionesPagoEmiWeb {
    GetCondicionesPagoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetCondicionesPagoEmiWeb.fromMap(Map<String, dynamic> json) => GetCondicionesPagoEmiWeb(
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
        required this.idCatCondicionesPago,
        required this.condicionesPago,
        required this.activo,
    });

    final int idCatCondicionesPago;
    final String condicionesPago;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatCondicionesPago: json["idCatCondicionesPago"],
        condicionesPago: json["condicionesPago"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatCondicionesPago": idCatCondicionesPago,
        "condicionesPago": condicionesPago,
        "activo": activo,
    };
}
