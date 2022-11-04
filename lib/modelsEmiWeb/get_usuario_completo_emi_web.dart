import 'dart:convert';

GetUsuarioCompletoEmiWeb getUsuarioCompletoEmiWebFromMap(String str) => GetUsuarioCompletoEmiWeb.fromMap(json.decode(str));

String getUsuarioCompletoEmiWebToMap(GetUsuarioCompletoEmiWeb data) => json.encode(data.toMap());

class GetUsuarioCompletoEmiWeb {
    GetUsuarioCompletoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetUsuarioCompletoEmiWeb.fromMap(Map<String, dynamic> json) => GetUsuarioCompletoEmiWeb(
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
        required this.tiposUsuario,
        required this.fechaNacimiento,
        required this.correo,
        this.telefono,
        this.celular,
        required this.fechaRegistro,
        required this.idDocumento,
    });

    final int idUsuario;
    final String nombre;
    final String apellidoPaterno;
    final String apellidoMaterno;
    final List<TiposUsuario>? tiposUsuario;
    final DateTime? fechaNacimiento;
    final String correo;
    final String? telefono;
    final String? celular;
    final DateTime? fechaRegistro;
    final int idDocumento;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        tiposUsuario: json["tiposUsuario"] == null ? null : List<TiposUsuario>.from(json["tiposUsuario"].map((x) => TiposUsuario.fromMap(x))),
        fechaNacimiento: json["fechaNacimiento"] == null ? null : DateTime.parse(json["fechaNacimiento"]),
        correo: json["correo"],
        telefono: json["telefono"],
        celular: json["celular"],
        fechaRegistro: json["fechaRegistro"] == null ? null : DateTime.parse(json["fechaRegistro"]),
        idDocumento: json["idDocumento"],
    );

    Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "tiposUsuario": tiposUsuario == null ? null : List<dynamic>.from(tiposUsuario!.map((x) => x.toMap())),
        "fechaNacimiento": fechaNacimiento == null ? null : "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "correo": correo,
        "telefono": telefono,
        "celular": celular,
        "fechaRegistro": fechaRegistro == null ? null : fechaRegistro!.toIso8601String(),
        "idDocumento": idDocumento,
    };
}

class TiposUsuario {
    TiposUsuario({
        required this.idCatRoles,
        required this.rol,
    });

    final int idCatRoles;
    final String rol;

    factory TiposUsuario.fromMap(Map<String, dynamic> json) => TiposUsuario(
        idCatRoles: json["idCatRoles"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "idCatRoles": idCatRoles,
        "rol": rol,
    };
}
