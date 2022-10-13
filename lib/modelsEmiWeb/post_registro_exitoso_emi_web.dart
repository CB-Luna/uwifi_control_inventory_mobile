import 'dart:convert';

PostRegistroExitosoEmiWeb postRegistroExitosoEmiWebFromMap(String str) => PostRegistroExitosoEmiWeb.fromMap(json.decode(str));

String postRegistroExitosoEmiWebToMap(PostRegistroExitosoEmiWeb data) => json.encode(data.toMap());

class PostRegistroExitosoEmiWeb {
    PostRegistroExitosoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory PostRegistroExitosoEmiWeb.fromMap(Map<String, dynamic> json) => PostRegistroExitosoEmiWeb(
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
        required this.id,
    });

    final int id;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
    };
}
