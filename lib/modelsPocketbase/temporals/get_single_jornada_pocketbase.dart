import 'dart:convert';

GetSingleJornadaPocketbase getSingleJornadaPocketbaseFromMap(String str) => GetSingleJornadaPocketbase.fromMap(json.decode(str));

String getSingleJornadaPocketbaseToMap(GetSingleJornadaPocketbase data) => json.encode(data.toMap());

class GetSingleJornadaPocketbase {
    GetSingleJornadaPocketbase({
        required this.numJornada,
        required this.idTareaFk,
        required this.proximaVisita,
        required this.idEmprendimientoFk,
        required this.completada,
        required this.idEmiWeb,
    });

    final int numJornada;
    final String idTareaFk;
    final DateTime proximaVisita;
    final String idEmprendimientoFk;
    final bool completada;
    final String idEmiWeb;

    factory GetSingleJornadaPocketbase.fromMap(Map<String, dynamic> json) => GetSingleJornadaPocketbase(
        numJornada: json["num_jornada"],
        idTareaFk: json["id_tarea_fk"],
        proximaVisita: DateTime.parse(json["proxima_visita"]),
        idEmprendimientoFk: json["id_emprendimiento_fk"],
        completada: json["completada"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "num_jornada": numJornada,
        "id_tarea_fk": idTareaFk,
        "proxima_visita": proximaVisita.toIso8601String(),
        "id_emprendimiento_fk": idEmprendimientoFk,
        "completada": completada,
        "id_emi_web": idEmiWeb,
    };
}
