import 'dart:convert';

class GetUserSupabase {
    final String id;
    final String email;
    final DateTime dateAdded;
    final String idPerfilUsuario;
    final int idSecuencial;
    final String firstName;
    final String lastName;
    final String? image;
    final RoleSupabase role;
    final int? idRoleFk;

    GetUserSupabase({
        required this.id,
        required this.email,
        required this.dateAdded,
        required this.idPerfilUsuario,
        required this.idSecuencial,
        required this.firstName,
        required this.lastName,
        this.image,
        required this.role,
        this.idRoleFk,
    });

    factory GetUserSupabase.fromJson(String str) => GetUserSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetUserSupabase.fromMap(Map<String, dynamic> json) => GetUserSupabase(
        id: json["id"],
        email: json["email"],
        dateAdded: DateTime.parse(json["created_at"]),
        idPerfilUsuario: json["user_profile_id"],
        idSecuencial: json["sequential_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        role: RoleSupabase.fromMap(json["role"]),
        idRoleFk: json["role_fk"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "created_at": dateAdded.toIso8601String(),
        "user_profile_id": idPerfilUsuario,
        "sequential_id": idSecuencial,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "role": role.toMap(),
        "role_fk": idRoleFk,
    };
}

class RoleSupabase {
    final int id;
    final String name;
    final Permissions permissions;

    RoleSupabase({
        required this.id,
        required this.name,
        required this.permissions,
    });

    factory RoleSupabase.fromJson(String str) => RoleSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RoleSupabase.fromMap(Map<String, dynamic> json) => RoleSupabase(
        id: json["role_id"],
        name: json["name"],
        permissions: Permissions.fromMap(json["permissions"]),
    );

    Map<String, dynamic> toMap() => {
        "role_id": id,
        "name": name,
        "permissions": permissions.toMap(),
    };
}

class Permissions {
    String? home;
    String? employees;
    String? userProfile;
    String? usersAdministration;

    Permissions({
      this.home,
      this.employees,
      this.userProfile,
      this.usersAdministration,
    });

    factory Permissions.fromJson(String str) => Permissions.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Permissions.fromMap(Map<String, dynamic> json) => Permissions(
        home: json["Home"],
        employees: json["Employees"],
        userProfile: json["User Profile"],
        usersAdministration: json["Users Administration"],
    );

    Map<String, dynamic> toMap() => {
        "Home": home,
        "Employees": employees,
        "User Profile": userProfile,
        "Users Administration": usersAdministration,
    };
}
