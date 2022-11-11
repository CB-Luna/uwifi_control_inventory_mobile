import 'dart:convert';

PostRegistroExitosoEmiWebSingle postRegistroExitosoEmiWebSingleFromMap(String str) => PostRegistroExitosoEmiWebSingle.fromMap(json.decode(str));

String postRegistroExitosoEmiWebSingleToMap(PostRegistroExitosoEmiWebSingle data) => json.encode(data.toMap());

class PostRegistroExitosoEmiWebSingle {
    PostRegistroExitosoEmiWebSingle({
        required this.status,
        required this.payload,
    });

    final String status;
    final int payload;

    factory PostRegistroExitosoEmiWebSingle.fromMap(Map<String, dynamic> json) => PostRegistroExitosoEmiWebSingle(
        status: json["status"],
        payload: json["payload"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload,
    };
}
