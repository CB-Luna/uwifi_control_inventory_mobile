import 'dart:convert';

GetRolesEmiWeb getRolesEmiWebFromMap(String str) => GetRolesEmiWeb.fromMap(json.decode(str));

String getRolesEmiWebToMap(GetRolesEmiWeb data) => json.encode(data.toMap());

class GetRolesEmiWeb {
    GetRolesEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetRolesEmiWeb.fromMap(Map<String, dynamic> json) => GetRolesEmiWeb(
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
        required this.idCatRoles,
        required this.rol,
    });

    final int idCatRoles;
    final String rol;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatRoles: json["idCatRoles"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "idCatRoles": idCatRoles,
        "rol": rol,
    };
}
