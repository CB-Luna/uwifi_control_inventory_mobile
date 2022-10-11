import 'dart:convert';

GetProveedoresEmiWeb getProveedoresEmiWebFromMap(String str) => GetProveedoresEmiWeb.fromMap(json.decode(str));

String getProveedoresEmiWebToMap(GetProveedoresEmiWeb data) => json.encode(data.toMap());

class GetProveedoresEmiWeb {
    GetProveedoresEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetProveedoresEmiWeb.fromMap(Map<String, dynamic> json) => GetProveedoresEmiWeb(
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
        required this.id,
        required this.nombreProveedor,
    });

    final int id;
    final String nombreProveedor;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
        nombreProveedor: json["nombreProveedor"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nombreProveedor": nombreProveedor,
    };
}
