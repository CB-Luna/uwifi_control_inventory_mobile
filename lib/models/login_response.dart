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
    required this.created,
    required this.id,
    required this.updated,
    required this.userId,
  });

  String collectionId;
  String collectionName;
  DateTime created;
  String id;
  DateTime updated;
  String userId;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
        updated: DateTime.parse(json["updated"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "created": created.toIso8601String(),
        "id": id,
        "updated": updated.toIso8601String(),
        "userId": userId,
      };
}
