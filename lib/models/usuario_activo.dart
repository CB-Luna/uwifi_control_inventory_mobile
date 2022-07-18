// To parse this JSON data, do
//
//     final usuarioActivo = usuarioActivoFromMap(jsonString);

import 'dart:convert';

class UsuarioActivo {
  UsuarioActivo({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.apellidoP,
    required this.apellidoM,
    required this.nacimiento,
    required this.celular,
    required this.telefono,
    required this.imagen,
  });

  //TODO: decidir variables necesarias
  String id;
  String username;
  String email;
  String role;
  String apellidoP;
  String apellidoM;
  DateTime nacimiento;
  String celular;
  String telefono;
  Imagen imagen;

  factory UsuarioActivo.fromJson(String str) =>
      UsuarioActivo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioActivo.fromMap(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final role = attributes['role']['data']['attributes']['name'];
    return UsuarioActivo(
      id: json["id"],
      username: attributes["username"],
      email: attributes["email"],
      role: role,
      apellidoP: attributes["apellidoP"],
      apellidoM: attributes["apellidoM"],
      nacimiento: DateTime.parse(attributes["nacimiento"]),
      celular: attributes["celular"],
      telefono: attributes["telefono"],
      imagen: Imagen.fromMap(attributes["imagen"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": {
          "username": username,
          "email": email,
          "role": role,
          "apellidoP": apellidoP,
          "apellidoM": apellidoM,
          "nacimiento": nacimiento.toString(),
          "celular": celular,
          "telefono": telefono,
          "imagen": imagen.toMap(),
        },
      };
}

//TODO: modificar para rol, usar un usuario con imagen
class Imagen {
  Imagen({
    this.data,
  });

  Data? data;

  factory Imagen.fromJson(String str) => Imagen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Imagen.fromMap(Map<String, dynamic> json) => Imagen(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    required this.attributes,
  });

  DataAttributes attributes;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        attributes: DataAttributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "attributes": attributes.toMap(),
      };
}

class DataAttributes {
  DataAttributes({
    required this.name,
  });

  String name;

  factory DataAttributes.fromJson(String str) =>
      DataAttributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAttributes.fromMap(Map<String, dynamic> json) => DataAttributes(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
