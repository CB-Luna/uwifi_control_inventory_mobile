import 'dart:convert';

class GetUsuarioSupabase {
    final String id;
    final String email;
    final DateTime dateAdded;
    final String idPerfilUsuario;
    final int idSecuencial;
    final String name;
    final String? middleName;
    final String lastName;
    final DateTime birthday;
    final String address;
    final String telephoneNumber;
    final String? homephoneNumber;
    final String? image;
    final int idRolFk;
    final Rol rol;
    final Company company;
    final Configuration configuration;
    final int idTema;

    GetUsuarioSupabase({
        required this.id,
        required this.email,
        required this.dateAdded,
        required this.idPerfilUsuario,
        required this.idSecuencial,
        required this.name,
        this.middleName,
        required this.lastName,
        required this.birthday,
        required this.address,
        required this.telephoneNumber,
        this.homephoneNumber,
        this.image,
        required this.idRolFk,
        required this.rol,
        required this.company,
        required this.configuration,
        required this.idTema,
    });

    factory GetUsuarioSupabase.fromJson(String str) => GetUsuarioSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetUsuarioSupabase.fromMap(Map<String, dynamic> json) => GetUsuarioSupabase(
        id: json["id"],
        email: json["email"],
        dateAdded: DateTime.parse(json["date_added"]),
        idPerfilUsuario: json["perfil_usuario_id"],
        idSecuencial: json["id_secuencial"],
        name: json["name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        birthday: DateTime.parse(json["birthday"]),
        address: json["address"],
        telephoneNumber: json["telephone_number"],
        homephoneNumber: json["homephone_number"],
        image: json["image"],
        idRolFk: json["id_rol_fk"],
        rol: Rol.fromMap(json["rol"]),
        company: Company.fromMap(json["company"]),
        configuration: Configuration.fromMap(json["configuracion"]),
        idTema: json["id_tema"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "date_added": dateAdded.toIso8601String(),
        "perfil_usuario_id": idPerfilUsuario,
        "id_secuencial": idSecuencial,
        "name": name,
        "middle_name": middleName,
        "last_name": lastName,
        "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "address": address,
        "telephone_number": telephoneNumber,
        "homephone_number": homephoneNumber,
        "image": image,
        "id_rol_fk": idRolFk,
        "rol": rol.toMap(),
        "company": company.toMap(),
        "configuration": configuration.toMap(),
        "id_tema": idTema,
    };
}

class Company {
    final int companyId;
    final String company;

    Company({
        required this.companyId,
        required this.company,
    });

    factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Company.fromMap(Map<String, dynamic> json) => Company(
        companyId: json["company_id"],
        company: json["company"],
    );

    Map<String, dynamic> toMap() => {
        "company_id": companyId,
        "company": company,
    };
}

class Configuration {
    final Dark dark;
    final Dark light;
    final Logos logos;

    Configuration({
        required this.dark,
        required this.light,
        required this.logos,
    });

    factory Configuration.fromJson(String str) => Configuration.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Configuration.fromMap(Map<String, dynamic> json) => Configuration(
        dark: Dark.fromMap(json["dark"]),
        light: Dark.fromMap(json["light"]),
        logos: Logos.fromMap(json["logos"]),
    );

    Map<String, dynamic> toMap() => {
        "dark": dark.toMap(),
        "light": light.toMap(),
        "logos": logos.toMap(),
    };
}

class Dark {
    final String primaryText;
    final String primaryColor;
    final String tertiaryColor;
    final String secondaryColor;
    final String primaryBackground;

    Dark({
        required this.primaryText,
        required this.primaryColor,
        required this.tertiaryColor,
        required this.secondaryColor,
        required this.primaryBackground,
    });

    factory Dark.fromJson(String str) => Dark.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dark.fromMap(Map<String, dynamic> json) => Dark(
        primaryText: json["primaryText"],
        primaryColor: json["primaryColor"],
        tertiaryColor: json["tertiaryColor"],
        secondaryColor: json["secondaryColor"],
        primaryBackground: json["primaryBackground"],
    );

    Map<String, dynamic> toMap() => {
        "primaryText": primaryText,
        "primaryColor": primaryColor,
        "tertiaryColor": tertiaryColor,
        "secondaryColor": secondaryColor,
        "primaryBackground": primaryBackground,
    };
}

class Logos {
    final String logoColor;
    final String logoBlanco;
    final String backgroundImage;
    final String animationBackground;

    Logos({
        required this.logoColor,
        required this.logoBlanco,
        required this.backgroundImage,
        required this.animationBackground,
    });

    factory Logos.fromJson(String str) => Logos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Logos.fromMap(Map<String, dynamic> json) => Logos(
        logoColor: json["logoColor"],
        logoBlanco: json["LogoBlanco"],
        backgroundImage: json["backgroundImage"],
        animationBackground: json["animationBackground"],
    );

    Map<String, dynamic> toMap() => {
        "logoColor": logoColor,
        "LogoBlanco": logoBlanco,
        "backgroundImage": backgroundImage,
        "animationBackground": animationBackground,
    };
}

class Rol {
    final int rolId;
    final String nombre;
    final Permisos permisos;

    Rol({
        required this.rolId,
        required this.nombre,
        required this.permisos,
    });

    factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        rolId: json["rol_id"],
        nombre: json["nombre"],
        permisos: Permisos.fromMap(json["permisos"]),
    );

    Map<String, dynamic> toMap() => {
        "rol_id": rolId,
        "nombre": nombre,
        "permisos": permisos.toMap(),
    };
}

class Permisos {
    final String home;
    final String employees;
    final String userProfile;
    final String usersAdministration;

    Permisos({
        required this.home,
        required this.employees,
        required this.userProfile,
        required this.usersAdministration,
    });

    factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
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
