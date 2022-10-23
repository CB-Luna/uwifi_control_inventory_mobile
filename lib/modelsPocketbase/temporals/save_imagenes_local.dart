
import 'dart:convert';

SaveImagenesLocal saveImagenesLocalFromMap(String str) => SaveImagenesLocal.fromMap(json.decode(str));

String saveImagenesLocalToMap(SaveImagenesLocal data) => json.encode(data.toMap());

class SaveImagenesLocal {
    SaveImagenesLocal({
        required this.nombre,
        required this.path,
        required this.base64,
    });

    final String nombre;
    final String path;
    final String base64;

    factory SaveImagenesLocal.fromMap(Map<String, dynamic> json) => SaveImagenesLocal(
        nombre: json["nombre"],
        path: json["path"],
        base64: json["base64"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "path": path,
        "base64": base64,
    };
}
