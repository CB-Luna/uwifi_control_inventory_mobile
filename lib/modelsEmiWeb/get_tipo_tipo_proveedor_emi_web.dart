import 'dart:convert';

GetTipoProveedorEmiWeb getTipoProveedorEmiWebFromMap(String str) => GetTipoProveedorEmiWeb.fromMap(json.decode(str));

String getTipoProveedorEmiWebToMap(GetTipoProveedorEmiWeb data) => json.encode(data.toMap());

class GetTipoProveedorEmiWeb {
    GetTipoProveedorEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetTipoProveedorEmiWeb.fromMap(Map<String, dynamic> json) => GetTipoProveedorEmiWeb(
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
        required this.idCatTipoProveedor,
        required this.tipoProveedor,
        required this.activo,
    });

    final int idCatTipoProveedor;
    final String tipoProveedor;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatTipoProveedor: json["idCatTipoProveedor"],
        tipoProveedor: json["tipoProveedor"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoProveedor": idCatTipoProveedor,
        "tipoProveedor": tipoProveedor,
        "activo": activo,
    };
}
