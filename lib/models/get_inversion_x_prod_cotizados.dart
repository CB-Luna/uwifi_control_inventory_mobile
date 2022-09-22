import 'dart:convert';

GetInversionXProdCotizados getInversionXProdCotizadosFromMap(String str) => GetInversionXProdCotizados.fromMap(json.decode(str));

String getInversionXProdCotizadosToMap(GetInversionXProdCotizados data) => json.encode(data.toMap());

class GetInversionXProdCotizados {
    GetInversionXProdCotizados({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.idInversionFk,
        required this.aceptado,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String idInversionFk;
    final bool aceptado;

    factory GetInversionXProdCotizados.fromMap(Map<String, dynamic> json) => GetInversionXProdCotizados(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        idInversionFk: json["id_inversion_fk"],
        aceptado: json["aceptado"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "id_inversion_fk": idInversionFk,
        "aceptado": aceptado,
    };
}
