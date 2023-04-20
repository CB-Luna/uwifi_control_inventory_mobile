import 'dart:convert';
class GetUsuarioSupabase {
    GetUsuarioSupabase({
        required this.perfilUsuarioCollection,
    });

    final PerfilUsuarioCollection perfilUsuarioCollection;

    factory GetUsuarioSupabase.fromJson(String str) => GetUsuarioSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetUsuarioSupabase.fromMap(Map<String, dynamic> json) => GetUsuarioSupabase(
        perfilUsuarioCollection: PerfilUsuarioCollection.fromMap(json["perfil_usuarioCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "perfil_usuarioCollection": perfilUsuarioCollection.toMap(),
    };
}

class PerfilUsuarioCollection {
    PerfilUsuarioCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory PerfilUsuarioCollection.fromJson(String str) => PerfilUsuarioCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PerfilUsuarioCollection.fromMap(Map<String, dynamic> json) => PerfilUsuarioCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
    };
}

class Edge {
    Edge({
        required this.node,
    });

    final Node node;

    factory Edge.fromJson(String str) => Edge.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Edge.fromMap(Map<String, dynamic> json) => Edge(
        node: Node.fromMap(json["node"]),
    );

    Map<String, dynamic> toMap() => {
        "node": node.toMap(),
    };
}

class Node {
    Node({
        required this.id,
        required this.createdAt,
        required this.rfc,
        required this.roles,
        this.imagen,
        required this.nombre,
        required this.celular,
        this.telefono,
        this.domicilio,
        required this.apellidoM,
        required this.apellidoP,
    });

    final String id;
    final DateTime createdAt;
    final String rfc;
    final Roles roles;
    final String? imagen;
    final String nombre;
    final String celular;
    final String? telefono;
    final String? domicilio;
    final String apellidoM;
    final String apellidoP;

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["perfil_usuario_id"],
        createdAt: DateTime.parse(json["created_at"]),
        rfc: json["rfc"],
        roles: Roles.fromMap(json["roles"]),
        imagen: json["imagen"],
        nombre: json["nombre"],
        celular: json["celular"],
        telefono: json["telefono"],
        domicilio: json["domicilio"],
        apellidoM: json["apellido_m"],
        apellidoP: json["apellido_p"],
    );

    Map<String, dynamic> toMap() => {
        "perfil_usuario_id": id,
        "created_at": createdAt.toIso8601String(),
        "rfc": rfc,
        "roles": roles.toMap(),
        "imagen": imagen,
        "nombre": nombre,
        "celular": celular,
        "telefono": telefono,
        "domicilio": domicilio,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
    };
}

class Roles {
    Roles({
        required this.id,
        required this.rol,
    });

    final String id;
    final String rol;

    factory Roles.fromJson(String str) => Roles.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Roles.fromMap(Map<String, dynamic> json) => Roles(
        id: json["id"],
        rol: json["rol"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "rol": rol,
    };
}
