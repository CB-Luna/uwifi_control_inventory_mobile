import 'dart:convert';

GetImagenProductoEmiWeb getImagenProductoEmiWebFromMap(String str) =>
    GetImagenProductoEmiWeb.fromMap(json.decode(str));

String getImagenProductoEmiWebToMap(GetImagenProductoEmiWeb data) =>
    json.encode(data.toMap());

class GetImagenProductoEmiWeb {
  GetImagenProductoEmiWeb({
    required this.status,
    required this.payload,
  });

  final String status;
  final Payload? payload;

  factory GetImagenProductoEmiWeb.fromMap(Map<String, dynamic> json) =>
      GetImagenProductoEmiWeb(
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
  late final String archivo;
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
