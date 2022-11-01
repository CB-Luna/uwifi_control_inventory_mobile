import 'dart:convert';

GetImagenUsuario getImagenUsuarioFromMap(String str) => GetImagenUsuario.fromMap(json.decode(str));

String getImagenUsuarioToMap(GetImagenUsuario data) => json.encode(data.toMap());

class GetImagenUsuario {
    GetImagenUsuario({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombre,
        required this.idEmiWeb,
        required this.base64,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombre;
    final String idEmiWeb;
    final String base64;

    factory GetImagenUsuario.fromMap(Map<String, dynamic> json) => GetImagenUsuario(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombre: json["nombre"],
        idEmiWeb: json["id_emi_web"],
        base64: json["base64"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre": nombre,
        "id_emi_web": idEmiWeb,
        "base64": base64,
    };
}
