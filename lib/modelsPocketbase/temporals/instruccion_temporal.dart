import 'dart:convert';

InstruccionTemporal instruccionTemporalFromMap(String str) => InstruccionTemporal.fromMap(json.decode(str));

String instruccionTemporalToMap(InstruccionTemporal data) => json.encode(data.toMap());

class InstruccionTemporal {
    InstruccionTemporal({
        required this.id,
        required this.instrucciones,
    });

    final int id;
    final String instrucciones;

    factory InstruccionTemporal.fromMap(Map<String, dynamic> json) => InstruccionTemporal(
        id: json["id"],
        instrucciones: json["instrucciones"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "instrucciones": instrucciones,
    };
}
