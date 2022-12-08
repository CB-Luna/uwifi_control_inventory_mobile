import 'dart:convert';

GetInversionEmiWeb getInversionEmiWebFromMap(String str) => GetInversionEmiWeb.fromMap(json.decode(str));

String getInversionEmiWebToMap(GetInversionEmiWeb data) => json.encode(data.toMap());

class GetInversionEmiWeb {
    GetInversionEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetInversionEmiWeb.fromMap(Map<String, dynamic> json) => GetInversionEmiWeb(
        status: json["status"],
        payload: json["payload"] == null ? null : Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload == null ? null : payload!.toMap(),
    };
}

class Payload {
    Payload({
        required this.idInversiones,
        required this.idProyecto,
        required this.archivadoPromotor,
        required this.archivadoStaff,
        required this.idCatEstadoInversion,
        required this.fechaDeCompra,
        required this.porcentajePago,
        required this.montoPagar,
        required this.saldo,
        required this.totalInversion,
        required this.inversionRecibida,
        required this.fechaRegistro,
    });

    final int idInversiones;
    final int idProyecto;
    final bool archivadoPromotor;
    final bool archivadoStaff;
    final int idCatEstadoInversion;
    final DateTime? fechaDeCompra;
    final double porcentajePago;
    final double montoPagar;
    final double saldo;
    final double totalInversion;
    final bool inversionRecibida;
    final DateTime? fechaRegistro;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idInversiones: json["idInversiones"],
        idProyecto: json["idProyecto"],
        archivadoPromotor: json["archivadoPromotor"],
        archivadoStaff: json["archivadoStaff"],
        idCatEstadoInversion: json["idCatEstadoInversion"],
        fechaDeCompra: json["fechaDeCompra"] == null ? null : DateTime.parse(json["fechaDeCompra"]),
        porcentajePago: json["porcentajePago"].toDouble(),
        montoPagar: json["montoPagar"].toDouble(),
        saldo: json["saldo"].toDouble(),
        totalInversion: json["totalInversion"].toDouble(),
        inversionRecibida: json["inversionRecibida"],
        fechaRegistro: json["fechaRegistro"] == null ? null : DateTime.parse(json["fechaRegistro"]),
    );

    Map<String, dynamic> toMap() => {
        "idInversiones": idInversiones,
        "idProyecto": idProyecto,
        "archivadoPromotor": archivadoPromotor,
        "archivadoStaff": archivadoStaff,
        "idCatEstadoInversion": idCatEstadoInversion,
        "fechaDeCompra": fechaDeCompra == null ? null : "${fechaDeCompra!.year.toString().padLeft(4, '0')}-${fechaDeCompra!.month.toString().padLeft(2, '0')}-${fechaDeCompra!.day.toString().padLeft(2, '0')}",
        "porcentajePago": porcentajePago,
        "montoPagar": montoPagar,
        "saldo": saldo,
        "totalInversion": totalInversion,
        "inversionRecibida": inversionRecibida,
        "fechaRegistro": fechaRegistro == null ? null : fechaRegistro!.toIso8601String(),
    };
}
