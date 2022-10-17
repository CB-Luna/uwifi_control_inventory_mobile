import 'dart:convert';

GetUsuarioEmiWeb getUsuarioEmiWebFromMap(String str) => GetUsuarioEmiWeb.fromMap(json.decode(str));

String getUsuarioEmiWebToMap(GetUsuarioEmiWeb data) => json.encode(data.toMap());

class GetUsuarioEmiWeb {
    GetUsuarioEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetUsuarioEmiWeb.fromMap(Map<String, dynamic> json) => GetUsuarioEmiWeb(
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
        required this.idUsuario,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        required this.telefono,
        required this.iniciales,
    });

    final int idUsuario;
    final String nombre;
    final String apellidoPaterno;
    final String apellidoMaterno;
    final String telefono;
    final String iniciales;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        telefono: json["telefono"],
        iniciales: json["iniciales"],
    );

    Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "telefono": telefono,
        "iniciales": iniciales,
    };
}
