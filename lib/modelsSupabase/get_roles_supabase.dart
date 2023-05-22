import 'dart:convert';

GetRolesSupabase getRolesSupabaseFromMap(String str) => GetRolesSupabase.fromMap(json.decode(str));

String getRolesSupabaseToMap(GetRolesSupabase data) => json.encode(data.toMap());

class GetRolesSupabase {
    GetRolesSupabase({
        required this.rolesCollection,
    });

    final RolesCollection rolesCollection;

    factory GetRolesSupabase.fromMap(Map<String, dynamic> json) => GetRolesSupabase(
        rolesCollection: RolesCollection.fromMap(json["rolCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "rolCollection": rolesCollection.toMap(),
    };
}

class RolesCollection {
    RolesCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory RolesCollection.fromMap(Map<String, dynamic> json) => RolesCollection(
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
        required this.nombre,
        required this.createdAt,
    });

    final String id;
    final String nombre;
    final DateTime createdAt;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["rol_id"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "rol_id": id,
        "nombre": nombre,
        "created_at": createdAt.toIso8601String(),
    };
}
