import 'dart:convert';

GetFamiliaProductoEmiWeb getFamiliaProductoEmiWebFromMap(String str) => GetFamiliaProductoEmiWeb.fromMap(json.decode(str));

String getFamiliaProductoEmiWebToMap(GetFamiliaProductoEmiWeb data) => json.encode(data.toMap());

class GetFamiliaProductoEmiWeb {
    GetFamiliaProductoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetFamiliaProductoEmiWeb.fromMap(Map<String, dynamic> json) => GetFamiliaProductoEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : List<dynamic>.from(payload!.map((x) => x.toMap())),
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
