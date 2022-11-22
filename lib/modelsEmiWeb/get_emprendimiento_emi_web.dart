import 'dart:convert';

GetEmprendimientoEmiWeb getEmprendimientoEmiWebFromMap(String str) => GetEmprendimientoEmiWeb.fromMap(json.decode(str));

String getEmprendimientoEmiWebToMap(GetEmprendimientoEmiWeb data) => json.encode(data.toMap());

class GetEmprendimientoEmiWeb {
    GetEmprendimientoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetEmprendimientoEmiWeb.fromMap(Map<String, dynamic> json) => GetEmprendimientoEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : payload!.toMap(),
    };
}

class Payload {
    Payload({
        required this.id,
        required this.fase,
        required this.emprendimiento,
    });

    final int id;
    final String fase;
    final String emprendimiento;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
        fase: json["fase"],
        emprendimiento: json["emprendimiento"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "fase": fase,
        "emprendimiento": emprendimiento,
    };
}
