import 'dart:convert';

class EmiUserById {
    EmiUserById({
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.items,
    });

    final int page;
    final int perPage;
    final int totalItems;
    final List<Item>? items;

    factory EmiUserById.fromJson(String str) => EmiUserById.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmiUserById.fromMap(Map<String, dynamic> json) => EmiUserById(
        page: json["page"] == null ? null : json["page"],
        perPage: json["perPage"] == null ? null : json["perPage"],
        totalItems: json["totalItems"] == null ? null : json["totalItems"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page == null ? null : page,
        "perPage": perPage == null ? null : perPage,
        "totalItems": totalItems == null ? null : totalItems,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toMap())),
    };
}

class Item {
    Item({
        required this.collectionId,
        required this.collectionName,
        required this.apellidoM,
        required this.apellidoP,
        required this.archivado,
        required this.avatar,
        required this.celular,
        required this.created,
        required this.id,
        required this.idRolFk,
        required this.idStatusSyncFk,
        required this.nacimiento,
        required this.nombreUsuario,
        required this.telefono,
        required this.updated,
        required this.user,
    });

    final String collectionId;
    final String collectionName;
    final String apellidoM;
    final String apellidoP;
    final bool archivado;
    final String avatar;
    final String celular;
    final DateTime? created;
    final String id;
    final String idRolFk;
    final String idStatusSyncFk;
    final DateTime? nacimiento;
    final String nombreUsuario;
    final String telefono;
    final DateTime? updated;
    final String user;

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        collectionId: json["@collectionId"] == null ? null : json["@collectionId"],
        collectionName: json["@collectionName"] == null ? null : json["@collectionName"],
        apellidoM: json["apellido_m"] == null ? null : json["apellido_m"],
        apellidoP: json["apellido_p"] == null ? null : json["apellido_p"],
        archivado: json["archivado"] == null ? null : json["archivado"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        celular: json["celular"] == null ? null : json["celular"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        id: json["id"] == null ? null : json["id"],
        idRolFk: json["id_rol_fk"] == null ? null : json["id_rol_fk"],
        idStatusSyncFk: json["id_status_sync_fk"] == null ? null : json["id_status_sync_fk"],
        nacimiento: json["nacimiento"] == null ? null : DateTime.parse(json["nacimiento"]),
        nombreUsuario: json["nombre_usuario"] == null ? null : json["nombre_usuario"],
        telefono: json["telefono"] == null ? null : json["telefono"],
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        user: json["user"] == null ? null : json["user"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId == null ? null : collectionId,
        "@collectionName": collectionName == null ? null : collectionName,
        "apellido_m": apellidoM == null ? null : apellidoM,
        "apellido_p": apellidoP == null ? null : apellidoP,
        "archivado": archivado == null ? null : archivado,
        "avatar": avatar == null ? null : avatar,
        "celular": celular == null ? null : celular,
        "created": created == null ? null : created!.toIso8601String(),
        "id": id == null ? null : id,
        "id_rol_fk": idRolFk == null ? null : idRolFk,
        "id_status_sync_fk": idStatusSyncFk == null ? null : idStatusSyncFk,
        "nacimiento": nacimiento == null ? null : nacimiento!.toIso8601String(),
        "nombre_usuario": nombreUsuario == null ? null : nombreUsuario,
        "telefono": telefono == null ? null : telefono,
        "updated": updated == null ? null : updated!.toIso8601String(),
        "user": user == null ? null : user,
    };
}
