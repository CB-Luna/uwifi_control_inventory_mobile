import 'dart:convert';

PostSimpleRegistroExitosoEmiWeb postSimpleRegistroExitosoEmiWebFromMap(String str) => PostSimpleRegistroExitosoEmiWeb.fromMap(json.decode(str));

String postSimpleRegistroExitosoEmiWebToMap(PostSimpleRegistroExitosoEmiWeb data) => json.encode(data.toMap());

class PostSimpleRegistroExitosoEmiWeb {
    PostSimpleRegistroExitosoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final int payload;

    factory PostSimpleRegistroExitosoEmiWeb.fromMap(Map<String, dynamic> json) => PostSimpleRegistroExitosoEmiWeb(
        status: json["status"],
        payload: json["payload"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload,
    };
}
