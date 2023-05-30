import 'dart:convert';

class ImageEvidence {
    final String path;
    final String base64;

    ImageEvidence({
      required this.path, 
      required this.base64,
    });

    factory ImageEvidence.fromJson(String str) => ImageEvidence.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ImageEvidence.fromMap(Map<String, dynamic> json) => ImageEvidence(
        path: json["path"],
        base64: json["base64"],
    );

    Map<String, dynamic> toMap() => {
        "path": path,
        "base64": base64,
    };
}

