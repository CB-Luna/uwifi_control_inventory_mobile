import 'dart:convert';

UpdateEmiUserPocketbase updateEmiUserPocketbaseFromMap(String str) => UpdateEmiUserPocketbase.fromMap(json.decode(str));

String updateEmiUserPocketbaseToMap(UpdateEmiUserPocketbase data) => json.encode(data.toMap());

class UpdateEmiUserPocketbase {
    UpdateEmiUserPocketbase({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreUsuario,
        required this.apellidoP,
        required this.apellidoM,
        required this.telefono,
        required this.celular,
        required this.idRolesFk,
        required this.idStatusSyncFk,
        required this.archivado,
        required this.user,
        required this.idEmiWeb,
        required this.idImagenFk,
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
    final List<String> idRolesFk;
    final String idStatusSyncFk;
    final bool archivado;
    final String user;
    final String idEmiWeb;
    final String? idImagenFk;

    factory UpdateEmiUserPocketbase.fromMap(Map<String, dynamic> json) => UpdateEmiUserPocketbase(
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
        idRolesFk: List<String>.from(json["id_roles_fk"].map((x) => x)),
        idStatusSyncFk: json["id_status_sync_fk"],
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
        "id_roles_fk": List<dynamic>.from(idRolesFk.map((x) => x)),
        "id_status_sync_fk": idStatusSyncFk,
        "archivado": archivado,
        "user": user,
        "id_emi_web": idEmiWeb,
        "id_imagen_fk": idImagenFk,
    };
}
