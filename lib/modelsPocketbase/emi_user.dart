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
        this.apellidoM,
        required this.apellidoP,
        required this.archivado,
        this.avatar,
        required this.celular,
        required this.created,
        required this.id,
        required this.idRolFk,
        required this.idStatusSyncFk,
        required this.nacimiento,
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
    final String? avatar;
    final String celular;
    final DateTime? created;
    final String id;
    final List<String> idRolFk;
    final String idStatusSyncFk;
    final DateTime nacimiento;
    final String nombreUsuario;
    final String? telefono;
    final DateTime? updated;
    final String user;

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        apellidoM: json["apellido_m"] == null ? null : json["apellido_m"]!,
        apellidoP: json["apellido_p"],
        archivado: json["archivado"],
        avatar: json["avatar"] == null ? null : json["avatar"]!,
        celular: json["celular"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"],
        idRolFk: List<String>.from(json["id_rol_fk"].map((x) => x)),
        idStatusSyncFk: json["id_status_sync_fk"],
        nacimiento: DateTime.parse(json["nacimiento"]),
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
        "avatar": avatar,
        "celular": celular,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id,
        "id_rol_fk": List<dynamic>.from(idRolFk.map((x) => x)),
        "id_status_sync_fk": idStatusSyncFk,
        "nacimiento": nacimiento.toIso8601String(),
        "nombre_usuario": nombreUsuario,
        "telefono": telefono == null ? null : telefono!,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "user": user,
    };
}
