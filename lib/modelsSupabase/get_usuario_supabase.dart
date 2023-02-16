import 'dart:convert';

GetUsuarioSupabase getUsuarioSupabaseFromMap(String str) => GetUsuarioSupabase.fromMap(json.decode(str));

String getUsuarioSupabaseToMap(GetUsuarioSupabase usuarioCollection) => json.encode(usuarioCollection.toMap());

class GetUsuarioSupabase {
    GetUsuarioSupabase({
        required this.usuarioCollection,
    });

    final UsuarioCollection usuarioCollection;

    factory GetUsuarioSupabase.fromMap(Map<String, dynamic> json) => GetUsuarioSupabase(
        usuarioCollection: UsuarioCollection.fromMap(json["usuarioCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "usuarioCollection": usuarioCollection.toMap(),
    };
}


class UsuarioCollection {
    UsuarioCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory UsuarioCollection.fromMap(Map<String, dynamic> json) => UsuarioCollection(
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
        required this.curp,
        required this.correo,
        required this.nombre,
        required this.celular,
        this.telefono,
        required this.idRolFk,
        this.apellidoM,
        required this.apellidoP,
        required this.createdAt,
        this.idImagenFk,
        required this.fechaNacimiento,
    });

    final String id;
    final String curp;
    final String correo;
    final String nombre;
    final String celular;
    final String? telefono;
    final String idRolFk;
    final String? apellidoM;
    final String apellidoP;
    final DateTime createdAt;
    final String? idImagenFk;
    final DateTime fechaNacimiento;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        curp: json["curp"],
        correo: json["correo"],
        nombre: json["nombre"],
        celular: json["celular"],
        telefono: json["telefono"],
        idRolFk: json["id_rol_fk"],
        apellidoM: json["apellido_m"],
        apellidoP: json["apellido_p"],
        createdAt: DateTime.parse(json["created_at"]),
        idImagenFk: json["id_imagen_fk"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "curp": curp,
        "correo": correo,
        "nombre": nombre,
        "celular": celular,
        "telefono": telefono,
        "id_rol_fk": idRolFk,
        "apellido_m": apellidoM,
        "apellido_p": apellidoP,
        "created_at": createdAt.toIso8601String(),
        "id_imagen_fk": idImagenFk,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
    };
}
