import 'dart:convert';

GetTipoProyecto getTipoProyectoFromMap(String str) => GetTipoProyecto.fromMap(json.decode(str));

String getTipoProyectoToMap(GetTipoProyecto data) => json.encode(data.toMap());

class GetTipoProyecto {
    GetTipoProyecto({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.tipoProyecto,
        required this.activo,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String tipoProyecto;
    final bool activo;
    final String idEmiWeb;

    factory GetTipoProyecto.fromMap(Map<String, dynamic> json) => GetTipoProyecto(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        tipoProyecto: json["tipo_proyecto"],
        activo: json["activo"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "tipo_proyecto": tipoProyecto,
        "activo": activo,
        "id_emi_web": idEmiWeb,
    };
}
