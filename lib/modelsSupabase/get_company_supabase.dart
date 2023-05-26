import 'dart:convert';

GetCompanySupabase getCompanySupabaseFromMap(String str) => GetCompanySupabase.fromMap(json.decode(str));

String getCompanySupabaseToMap(GetCompanySupabase data) => json.encode(data.toMap());

class GetCompanySupabase {
    GetCompanySupabase({
        required this.companyCollection,
    });

    final CompanyCollection companyCollection;

    factory GetCompanySupabase.fromMap(Map<String, dynamic> json) => GetCompanySupabase(
        companyCollection: CompanyCollection.fromMap(json["companyCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "companyCollection": companyCollection.toMap(),
    };
}

class CompanyCollection {
    CompanyCollection({
        required this.edges,
    });

    final List<Edge> edges;

    factory CompanyCollection.fromMap(Map<String, dynamic> json) => CompanyCollection(
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
        required this.company,
        required this.dateAdded,
    });

    final String id;
    final String company;
    final DateTime dateAdded;

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id_company"],
        company: json["company"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_company": id,
        "company": company,
        "date_added": dateAdded.toIso8601String(),
    };
}
