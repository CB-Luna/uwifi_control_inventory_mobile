import 'dart:convert';

EmiUser emiUserFromMap(String str) => EmiUser.fromMap(json.decode(str));

String emiUserToMap(EmiUser data) => json.encode(data.toMap());

class EmiUser {
    EmiUser({
        required this.page,
        required this.perPage,
        this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int? totalItems;
    final List<Item>? items;

    factory EmiUser.fromMap(Map<String, dynamic> json) => EmiUser(
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"] == null ? null : json["totalItems"]!,
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
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreUsuario,
        required this.apellidoP,
        this.apellidoM,
        required this.telefono,
        this.celular,
        this.avatar,
        required this.idRolesFk,
        required this.idStatusSyncFk,
        required this.archivado,
        required this.user,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreUsuario;
    final String apellidoP;
    final String? apellidoM;
    final String telefono;
    final String? celular;
    final String? avatar;
    final List<String>? idRolesFk;
    final String idStatusSyncFk;
    final bool archivado;
    final String user;
    final String idEmiWeb;


    factory Item.fromMap(Map<String, dynamic> json) => Item(
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
        avatar: json["avatar"],
        idRolesFk: json["id_roles_fk"] == null ? null : List<String>.from(json["id_roles_fk"].map((x) => x)),
        idStatusSyncFk: json["id_status_sync_fk"],
        archivado: json["archivado"],
        user: json["user"],
        idEmiWeb: json["id_emi_web"],
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
        "avatar": avatar,
        "id_roles_fk": idRolesFk == null ? null : List<dynamic>.from(idRolesFk!.map((x) => x)),
        "id_status_sync_fk": idStatusSyncFk,
        "archivado": archivado,
        "user": user,
        "id_emi_web": idEmiWeb, 
    };
}
