import 'dart:convert';

InstruccionNoSincronizada instruccionNoSincronizadaFromMap(String str) => InstruccionNoSincronizada.fromMap(json.decode(str));

String instruccionNoSincronizadaToMap(InstruccionNoSincronizada data) => json.encode(data.toMap());

class InstruccionNoSincronizada {
    InstruccionNoSincronizada({
        this.emprendimiento,
        this.emprendedor,
        required this.instruccion,
        required this.fecha,
    });

    final String? emprendimiento;
    final String? emprendedor;
    final String instruccion;
    final DateTime fecha;

    factory InstruccionNoSincronizada.fromMap(Map<String, dynamic> json) => InstruccionNoSincronizada(
        emprendimiento: json["emprendimiento"],
        emprendedor: json["emprendedor"],
        instruccion: json["instruccion"],
        fecha: json["fecha"],
    );

    Map<String, dynamic> toMap() => {
        "emprendimiento": emprendimiento,
        "emprendedor": emprendedor,
        "instruccion": instruccion,
        "fecha": fecha,
    };
}
