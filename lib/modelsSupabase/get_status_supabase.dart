import 'dart:convert';

GetStatusSupabase getStatusSupabaseFromMap(String str) => GetStatusSupabase.fromMap(json.decode(str));

String getStatusSupabaseToMap(GetStatusSupabase data) => json.encode(data.toMap());

class GetStatusSupabase {
    GetStatusSupabase({
        required this.statusCollection,
    });

    final StatusCollection statusCollection;

    factory GetStatusSupabase.fromMap(Map<String, dynamic> json) => GetStatusSupabase(
        statusCollection: StatusCollection.fromMap(json["statusCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "statusCollection": statusCollection.toMap(),
    };
}

class StatusCollection {
    StatusCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory StatusCollection.fromMap(Map<String, dynamic> json) => StatusCollection(
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
        required this.status,
        required this.dateAdded,
    });

    final String id;
    final String status;
    final DateTime dateAdded;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id_status"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_status": id,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
    };
}
