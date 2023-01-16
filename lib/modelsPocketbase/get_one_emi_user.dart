import 'dart:convert';

GetOneEmiUser getOneEmiUserFromMap(String str) => GetOneEmiUser.fromMap(json.decode(str));

String getOneEmiUserToMap(GetOneEmiUser data) => json.encode(data.toMap());

class GetOneEmiUser {
    GetOneEmiUser({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreUsuario,
        required this.apellidoP,
        this.apellidoM,
        this.telefono,
        this.celular,
        this.idRolesFk,
        required this.archivado,
        required this.user,
        required this.idEmiWeb,
        this.idImagenFk,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreUsuario;
    final String apellidoP;
    final String? apellidoM;
    final String? telefono;
    final String? celular;
    final List<String>? idRolesFk;
    final bool archivado;
    final String user;
    final String idEmiWeb;
    final String? idImagenFk;

    factory GetOneEmiUser.fromMap(Map<String, dynamic> json) => GetOneEmiUser(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreUsuario: json["nombre_usuario"],
        apellidoP: json["apellido_p"],
        apellidoM: json["apellido_m"],
        telefono: json["telefono"],
        celular: json["celular"],
        idRolesFk: json["id_roles_fk"] == null ? null : List<String>.from(json["id_roles_fk"].map((x) => x)),
        archivado: json["archivado"],
        user: json["user"],
        idEmiWeb: json["id_emi_web"],
        idImagenFk: json["id_imagen_fk"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_usuario": nombreUsuario,
        "apellido_p": apellidoP,
        "apellido_m": apellidoM,
        "telefono": telefono,
        "celular": celular,
        "id_roles_fk": idRolesFk == null ? null : List<dynamic>.from(idRolesFk!.map((x) => x)),
        "archivado": archivado,
        "user": user,
        "id_emi_web": idEmiWeb,
        "id_imagen_fk": idImagenFk,
    };
}
