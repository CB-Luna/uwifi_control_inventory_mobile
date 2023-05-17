import 'dart:convert';

class RolApi {
  RolApi({
    required this.rol,
    required this.rolId,
    required this.permits,
  });

  int rolId;
  String rol;
  Permits permits;

  factory RolApi.fromJson(String str) => RolApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RolApi.fromMap(Map<String, dynamic> json) => RolApi(
        rol: json["rol"],
        rolId: json["rol_id"],
        permits: Permits.fromMap(json["permits"]),
      );

  Map<String, dynamic> toMap() => {
        "rol": rol,
        "rol_id": rolId,
        "permits": permits.toMap(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RolApi &&
        other.rol == rol &&
        other.rolId == rolId;
  }

  @override
  int get hashCode => Object.hash(rol, rolId, permits);
}

class Permits {
  Permits({
    required this.home,
    required this.usersAdministration,
    required this.userProfile,
    required this.employees,
  });

  String? home;
  String? usersAdministration;
  String? userProfile;
  String? employees;

  factory Permits.fromJson(String str) => Permits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permits.fromMap(Map<String, dynamic> json) => Permits(
        home: json['Home'],
        usersAdministration: json["Users Administration"],
        userProfile: json["User Profile"],
        employees: json['Employees'],
      );

  Map<String, dynamic> toMap() => {
        "Home": home,
        "Users Administration": usersAdministration,
        "User Profile": userProfile,
        "Employees": employees,
      };
}
