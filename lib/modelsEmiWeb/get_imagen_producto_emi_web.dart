import 'dart:convert';

GetimagenProductoEmiWeb getimagenProductoEmiWebFromMap(String str) =>
    GetimagenProductoEmiWeb.fromMap(json.decode(str));

String getimagenProductoEmiWebToMap(GetimagenProductoEmiWeb data) =>
    json.encode(data.toMap());

class GetimagenProductoEmiWeb {
  GetimagenProductoEmiWeb({
    required this.status,
    required this.payload,
  });

  final String status;
  final Payload? payload;

  factory GetimagenProductoEmiWeb.fromMap(Map<String, dynamic> json) =>
      GetimagenProductoEmiWeb(
        status: json["status"],
        payload:
            json["payload"] == null ? null : Payload.fromMap(json["payload"]),
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
