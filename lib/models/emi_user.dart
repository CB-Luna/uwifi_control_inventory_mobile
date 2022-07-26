// To parse this JSON data, do
//
//     final emiUser = emiUserFromMap(jsonString);

import 'dart:convert';

class EmiUser {
  EmiUser({
    required this.collectionId,
    required this.collectionName,
    this.apellidoM,
    required this.apellidoP,
    this.archivado,
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

  String collectionId;
  String collectionName;
  String? apellidoM;
  String apellidoP;
  bool? archivado;
  String? avatar;
  String celular;
  DateTime created;
  String id;
  String idRolFk;
  String idStatusSyncFk;
  DateTime nacimiento;
  String nombreUsuario;
  String? telefono;
  DateTime updated;
  String user;

  factory EmiUser.fromJson(String str) => EmiUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmiUser.fromMap(Map<String, dynamic> json) {
    final temp = json['items'][0];
    return EmiUser(
      collectionId: temp["@collectionId"],
      collectionName: temp["@collectionName"],
      apellidoM: temp["apellido_m"],
      apellidoP: temp["apellido_p"],
      archivado: temp["archivado"],
      avatar: temp["avatar"],
      celular: temp["celular"],
      created: DateTime.parse(temp["created"]),
      id: temp["id"],
      idRolFk: temp["id_rol_fk"],
      idStatusSyncFk: temp["id_status_sync_fk"],
      nacimiento: DateTime.parse(temp["nacimiento"]),
      nombreUsuario: temp["nombre_usuario"],
      telefono: temp["telefono"],
      updated: DateTime.parse(temp["updated"]),
      user: temp["user"],
    );
  }

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
        "archivado": archivado,
        "avatar": avatar,
        "celular": celular,
        "created": created.toIso8601String(),
        "id": id,
        "id_rol_fk": idRolFk,
        "id_status_sync_fk": idStatusSyncFk,
        "nacimiento": nacimiento.toIso8601String(),
        "nombre_usuario": nombreUsuario,
        "telefono": telefono,
        "updated": updated.toIso8601String(),
        "user": user,
      };
}
