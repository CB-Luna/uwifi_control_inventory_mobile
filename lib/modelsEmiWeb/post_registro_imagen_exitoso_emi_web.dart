import 'dart:convert';

PostRegistroImagenExitosoEmiWeb postRegistroImagenExitosoEmiWebFromMap(String str) => PostRegistroImagenExitosoEmiWeb.fromMap(json.decode(str));

String postRegistroImagenExitosoEmiWebToMap(PostRegistroImagenExitosoEmiWeb data) => json.encode(data.toMap());

class PostRegistroImagenExitosoEmiWeb {
    PostRegistroImagenExitosoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload payload;

    factory PostRegistroImagenExitosoEmiWeb.fromMap(Map<String, dynamic> json) => PostRegistroImagenExitosoEmiWeb(
        status: json["status"],
        payload: Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload.toMap(),
    };
}

class Payload {
    Payload({
        required this.idDocumento,
    });

    final int idDocumento;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idDocumento: json["idDocumento"],
    );

    Map<String, dynamic> toMap() => {
        "idDocumento": idDocumento,
    };
}
