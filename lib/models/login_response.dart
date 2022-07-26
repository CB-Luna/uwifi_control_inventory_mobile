// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.id,
    required this.created,
    required this.updated,
    required this.email,
    required this.lastResetSentAt,
    required this.verified,
    required this.lastVerificationSentAt,
    required this.profile,
  });

  String id;
  DateTime created;
  DateTime updated;
  String email;
  String lastResetSentAt;
  bool verified;
  String lastVerificationSentAt;
  Profile profile;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        email: json["email"],
        lastResetSentAt: json["lastResetSentAt"],
        verified: json["verified"],
        lastVerificationSentAt: json["lastVerificationSentAt"],
        profile: Profile.fromMap(json["profile"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "email": email,
        "lastResetSentAt": lastResetSentAt,
        "verified": verified,
        "lastVerificationSentAt": lastVerificationSentAt,
        "profile": profile.toMap(),
      };
}

class Profile {
  Profile({
    required this.collectionId,
    required this.collectionName,
    required this.apellidoM,
    required this.apellidoP,
    required this.archivado,
    required this.celular,
    required this.created,
    required this.id,
    required this.idRolFk,
    required this.idStatusSyncFk,
    this.imagen,
    required this.nacimiento,
    required this.nombre,
    this.telefono, 
    this.token,
    required this.updated,
    required this.userId,
  });

  String collectionId;
  String collectionName;
  String apellidoM;
  String apellidoP;
  bool archivado;
  String celular;
  DateTime created;
  String id;
  String idRolFk;
  String idStatusSyncFk;
  String? imagen;
  DateTime nacimiento;
  String nombre;
  String? telefono;
  String? token;
  DateTime updated;
  String userId;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        apellidoM: json["apellido_m"],
        apellidoP: json["apellido_p"],
        archivado: json["archivado"],
        celular: json["celular"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
        idRolFk: json["id_rol_fk"],
        idStatusSyncFk: json["id_status_fk"],
        imagen: json["imagen"],
        nacimiento: DateTime.parse(json["nacimiento"]),
        nombre: json["nombre"],
        telefono: json["telefono"],
        token: json["token"],
        updated: DateTime.parse(json["updated"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
        "archivado": archivado,
        "celular": celular,
        "created": created.toIso8601String(),
        "id": id,
        "id_rol_fk": idRolFk,
        "id_status_fk": idStatusSyncFk,
        "imagen": imagen,
        "nacimiento": nacimiento.toIso8601String(),
        "nombre": nombre,
        "telefono": telefono,
        "token": token,
        "updated": updated.toIso8601String(),
        "userId": userId,
      };
}
