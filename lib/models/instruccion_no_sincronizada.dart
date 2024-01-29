import 'dart:convert';

InstruccionNoSincronizada instruccionNoSincronizadaFromMap(String str) => InstruccionNoSincronizada.fromMap(json.decode(str));

String instruccionNoSincronizadaToMap(InstruccionNoSincronizada data) => json.encode(data.toMap());

class InstruccionNoSincronizada {
    InstruccionNoSincronizada({
        this.emprendedor,
        required this.instruccion,
        required this.fecha,
    });

    final String? emprendedor;
    final String instruccion;
    final DateTime fecha;

    factory InstruccionNoSincronizada.fromMap(Map<String, dynamic> json) => InstruccionNoSincronizada(
        emprendedor: json["emprendedor"],
        instruccion: json["instruccion"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toMap() => {
        "emprendedor": emprendedor,
        "instruccion": instruccion,
        "fecha": fecha,
    };
}
