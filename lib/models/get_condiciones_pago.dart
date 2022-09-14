import 'dart:convert';

GetCondicionesPago getCondicionesPagoFromMap(String str) => GetCondicionesPago.fromMap(json.decode(str));

String getCondicionesPagoToMap(GetCondicionesPago data) => json.encode(data.toMap());

class GetCondicionesPago {
    GetCondicionesPago({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.condicionPago,
        required this.activo,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String condicionPago;
    final bool activo;

    factory GetCondicionesPago.fromMap(Map<String, dynamic> json) => GetCondicionesPago(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        condicionPago: json["condicion_pago"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "condicion_pago": condicionPago,
        "activo": activo,
    };
}
