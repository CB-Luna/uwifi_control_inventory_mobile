import 'dart:convert';

class SuggestionsSimsConfig {
    int code;
    List<List<String>> msg;

    SuggestionsSimsConfig({
        required this.code,
        required this.msg,
    });

    factory SuggestionsSimsConfig.fromJson(String str) => SuggestionsSimsConfig.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SuggestionsSimsConfig.fromMap(Map<String, dynamic> json) => SuggestionsSimsConfig(
        code: json["code"],
        msg: List<List<String>>.from(json["msg"].map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "msg": List<dynamic>.from(msg.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
