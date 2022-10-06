import 'dart:convert';

GetCatalogoProyectosEmiWeb getCatalogoProyectosEmiWebFromMap(String str) => GetCatalogoProyectosEmiWeb.fromMap(json.decode(str));

String getCatalogoProyectosEmiWebToMap(GetCatalogoProyectosEmiWeb data) => json.encode(data.toMap());

class GetCatalogoProyectosEmiWeb {
    GetCatalogoProyectosEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetCatalogoProyectosEmiWeb.fromMap(Map<String, dynamic> json) => GetCatalogoProyectosEmiWeb(
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
        required this.idCatProyecto,
        required this.proyecto,
        required this.catTipoProyecto,
        required this.activo,
    });

    final int idCatProyecto;
    final String proyecto;
    final CatTipoProyecto? catTipoProyecto;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatProyecto: json["idCatProyecto"],
        proyecto: json["proyecto"],
        catTipoProyecto: json["catTipoProyecto"] == null ? null : CatTipoProyecto.fromMap(json["catTipoProyecto"]),
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatProyecto": idCatProyecto,
        "proyecto": proyecto,
        "catTipoProyecto": catTipoProyecto == null ? null : catTipoProyecto!.toMap(),
        "activo": activo,
    };
}

class CatTipoProyecto {
    CatTipoProyecto({
        required this.idCatTipoProyecto,
        required this.tipoProyecto,
    });

    final int idCatTipoProyecto;
    final String tipoProyecto;

    factory CatTipoProyecto.fromMap(Map<String, dynamic> json) => CatTipoProyecto(
        idCatTipoProyecto: json["idCatTipoProyecto"],
        tipoProyecto: json["tipoProyecto"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoProyecto": idCatTipoProyecto,
        "tipoProyecto": tipoProyecto,
    };
}
