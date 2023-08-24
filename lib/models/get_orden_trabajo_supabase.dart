import 'dart:convert';

class GetOrdenTrabajoSupabase {
    final OrdenTrabajoCollection ordenTrabajoCollection;

    GetOrdenTrabajoSupabase({
        required this.ordenTrabajoCollection,
    });

    factory GetOrdenTrabajoSupabase.fromJson(String str) => GetOrdenTrabajoSupabase.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetOrdenTrabajoSupabase.fromMap(Map<String, dynamic> json) => GetOrdenTrabajoSupabase(
        ordenTrabajoCollection: OrdenTrabajoCollection.fromMap(json["orden_trabajoCollection"]),
    );

    Map<String, dynamic> toMap() => {
        "orden_trabajoCollection": ordenTrabajoCollection.toMap(),
    };
}

class OrdenTrabajoCollection {
    final List<Edge> edges;

    OrdenTrabajoCollection({
        required this.edges,
    });

    factory OrdenTrabajoCollection.fromJson(String str) => OrdenTrabajoCollection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrdenTrabajoCollection.fromMap(Map<String, dynamic> json) => OrdenTrabajoCollection(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toMap())),
    };
}

class Edge {
    final Node node;

    Edge({
        required this.node,
    });

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
    final String id;
    final Estatus estatus;
    final String gasolina;
    final VehiculoS vehiculo;
    final DateTime createdAt;
    final DateTime fechaOrden;
    final String kilometraje;
    final String descripcionFalla;
    final bool completado;

    Node({
        required this.id,
        required this.estatus,
        required this.gasolina,
        required this.vehiculo,
        required this.createdAt,
        required this.fechaOrden,
        required this.kilometraje,
        required this.descripcionFalla,
        required this.completado,
    });

    factory Node.fromJson(String str) => Node.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Node.fromMap(Map<String, dynamic> json) => Node(
        id: json["id"],
        estatus: Estatus.fromMap(json["estatus"]),
        gasolina: json["gasolina"],
        vehiculo: VehiculoS.fromMap(json["vehiculo"]),
        createdAt: DateTime.parse(json["created_at"]),
        fechaOrden: DateTime.parse(json["fecha_orden"]),
        kilometraje: json["kilometraje"],
        descripcionFalla: json["descripcion_falla"],
        completado: json["completado"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "estatus": estatus.toMap(),
        "gasolina": gasolina,
        "vehiculo": vehiculo.toMap(),
        "created_at": createdAt.toIso8601String(),
        "fecha_orden": fechaOrden.toIso8601String(),
        "kilometraje": kilometraje,
        "descripcion_falla": descripcionFalla,
        "compleatdo": completado,
    };
}

class Estatus {
    final String id;
    final String avance;
    final String estatus;

    Estatus({
        required this.id,
        required this.avance,
        required this.estatus,
    });

    factory Estatus.fromJson(String str) => Estatus.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Estatus.fromMap(Map<String, dynamic> json) => Estatus(
        id: json["id"],
        avance: json["avance"],
        estatus: json["estatus"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "avance": avance,
        "estatus": estatus,
    };
}

class VehiculoS {
    final String id;
    final String vin;
    final String anio;
    final String color;
    final String marca;
    final String motor;
    final String imagen;
    final String modelo;
    final String placas;
    final DateTime createdAt;

    VehiculoS({
        required this.id,
        required this.vin,
        required this.anio,
        required this.color,
        required this.marca,
        required this.motor,
        required this.imagen,
        required this.modelo,
        required this.placas,
        required this.createdAt,
    });

    factory VehiculoS.fromJson(String str) => VehiculoS.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VehiculoS.fromMap(Map<String, dynamic> json) => VehiculoS(
        id: json["id"],
        vin: json["vin"],
        anio: json["anio"],
        color: json["color"],
        marca: json["marca"],
        motor: json["motor"],
        imagen: json["imagen"],
        modelo: json["modelo"],
        placas: json["placas"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "vin": vin,
        "anio": anio,
        "color": color,
        "marca": marca,
        "motor": motor,
        "imagen": imagen,
        "modelo": modelo,
        "placas": placas,
        "created_at": createdAt.toIso8601String(),
    };
}
