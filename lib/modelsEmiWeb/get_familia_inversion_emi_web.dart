import 'dart:convert';

GetFamiliaInversionEmiWeb getFamiliaInversionEmiWebFromMap(String str) => GetFamiliaInversionEmiWeb.fromMap(json.decode(str));

String getFamiliaInversionEmiWebToMap(GetFamiliaInversionEmiWeb data) => json.encode(data.toMap());

class GetFamiliaInversionEmiWeb {
    GetFamiliaInversionEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetFamiliaInversionEmiWeb.fromMap(Map<String, dynamic> json) => GetFamiliaInversionEmiWeb(
        status: json["status"],
        payload: List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": List<dynamic>.from(payload!.map((x) => x.toMap())),
    };
}

class Payload {
    Payload({
        required this.idCatFamiliaInversion,
        required this.familiaInversionNecesaria,
        required this.activo,
    });

    final int idCatFamiliaInversion;
    final String familiaInversionNecesaria;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatFamiliaInversion: json["idCatFamiliaInversion"],
        familiaInversionNecesaria: json["familiaInversionNecesaria"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatFamiliaInversion": idCatFamiliaInversion,
        "familiaInversionNecesaria": familiaInversionNecesaria,
        "activo": activo,
    };
}
