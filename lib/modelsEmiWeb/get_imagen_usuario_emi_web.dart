import 'dart:convert';

GetImagenUsuarioEmiWeb getImagenUsuarioEmiWebFromMap(String str) => GetImagenUsuarioEmiWeb.fromMap(json.decode(str));

String getImagenUsuarioEmiWebToMap(GetImagenUsuarioEmiWeb data) => json.encode(data.toMap());

class GetImagenUsuarioEmiWeb {
    GetImagenUsuarioEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetImagenUsuarioEmiWeb.fromMap(Map<String, dynamic> json) => GetImagenUsuarioEmiWeb(
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
        required this.idCatTipoDocumento,
        required this.nombreArchivo,
        required this.archivo,
        required this.idUsuario,
    });

    final int idCatTipoDocumento;
    final String nombreArchivo;
    final String archivo;
    final int idUsuario;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatTipoDocumento: json["idCatTipoDocumento"],
        nombreArchivo: json["nombreArchivo"],
        archivo: json["archivo"],
        idUsuario: json["idUsuario"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoDocumento": idCatTipoDocumento,
        "nombreArchivo": nombreArchivo,
        "archivo": archivo,
        "idUsuario": idUsuario,
    };
}
