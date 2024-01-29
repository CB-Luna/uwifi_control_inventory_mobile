import 'dart:convert';
import 'dart:typed_data';

class ImageEvidence {
    final String path;
    final Uint8List uint8List;
    final String name;

    ImageEvidence({
      required this.path, 
      required this.uint8List,
      required this.name,
    });

    factory ImageEvidence.fromJson(String str) => ImageEvidence.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ImageEvidence.fromMap(Map<String, dynamic> json) => ImageEvidence(
        path: json["path"],
        uint8List: json["uint8List"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "path": path,
        "uint8List": uint8List,
        "name": name,
    };
}

