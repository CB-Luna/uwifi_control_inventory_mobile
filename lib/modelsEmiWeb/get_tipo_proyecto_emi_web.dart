import 'dart:convert';

GetTipoProyectoEmiWeb getTipoProyectoEmiWebFromMap(String str) => GetTipoProyectoEmiWeb.fromMap(json.decode(str));

String getTipoProyectoEmiWebToMap(GetTipoProyectoEmiWeb data) => json.encode(data.toMap());

class GetTipoProyectoEmiWeb {
    GetTipoProyectoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetTipoProyectoEmiWeb.fromMap(Map<String, dynamic> json) => GetTipoProyectoEmiWeb(
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
        required this.idCatTipoProyecto,
        required this.tipoProyecto,
        required this.activo,
    });

    final int idCatTipoProyecto;
    final String tipoProyecto;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatTipoProyecto: json["idCatTipoProyecto"],
        tipoProyecto: json["tipoProyecto"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoProyecto": idCatTipoProyecto,
        "tipoProyecto": tipoProyecto,
        "activo": activo,
    };
}
