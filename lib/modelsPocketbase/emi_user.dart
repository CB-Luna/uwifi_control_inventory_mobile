import 'dart:convert';

EmiUser emiUserFromMap(String str) => EmiUser.fromMap(json.decode(str));

String emiUserToMap(EmiUser data) => json.encode(data.toMap());

class EmiUser {
    EmiUser({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Item>? items;

    factory EmiUser.fromMap(Map<String, dynamic> json) => EmiUser(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toMap())),
    };
}

class Item {
    Item({
        required this.collectionId,
        required this.collectionName,
        this.apellidoM,
        required this.apellidoP,
        required this.archivado,
        this.celular,
        required this.created,
        required this.id,
        required this.idEmiWeb,
        this.idImagenFk,
        required this.idRolesFk,
        required this.nombreUsuario,
        this.telefono,
        required this.updated,
        required this.user,
    });

    final String collectionId;
    final String collectionName;
    final String? apellidoM;
    final String apellidoP;
    final bool archivado;
    final String? celular;
    final DateTime? created;
    final String id;
    final String idEmiWeb;
    final String? idImagenFk;
    final List<String>? idRolesFk;
    final String nombreUsuario;
    final String? telefono;
    final DateTime? updated;
    final String user;

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        apellidoM: json["apellido_m"],
        apellidoP: json["apellido_p"],
        archivado: json["archivado"],
        celular: json["celular"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idEmiWeb: json["id_emi_web"],
        idImagenFk: json["id_imagen_fk"],
        idRolesFk: json["id_roles_fk"] == null ? null : List<String>.from(json["id_roles_fk"].map((x) => x)),
        nombreUsuario: json["nombre_usuario"],
        telefono: json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        user: json["user"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
        "archivado": archivado,
        "celular": celular,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_emi_web": idEmiWeb,
        "id_imagen_fk": idImagenFk,
        "id_roles_fk": idRolesFk == null ? null : List<dynamic>.from(idRolesFk!.map((x) => x)),
        "nombre_usuario": nombreUsuario,
        "telefono": telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "user": user,
    };
}
