import 'dart:convert';

GetBasicConsultoriasEmiWeb getBasicConsultoriasEmiWebFromMap(String str) => GetBasicConsultoriasEmiWeb.fromMap(json.decode(str));

String getBasicConsultoriasEmiWebToMap(GetBasicConsultoriasEmiWeb data) => json.encode(data.toMap());

class GetBasicConsultoriasEmiWeb {
    GetBasicConsultoriasEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetBasicConsultoriasEmiWeb.fromMap(Map<String, dynamic> json) => GetBasicConsultoriasEmiWeb(
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
        required this.idConsultorias,
        required this.idCatAmbito,
        required this.idCatAreaCirculo,
        required this.fechaRegistro,
        required this.proximaVisita,
        required this.fechaAnterior,
        required this.asignarTarea,
        required this.tareaAnterior,
        required this.tareas,
    });

    final int idConsultorias;
    final int idCatAmbito;
    final int idCatAreaCirculo;
    final DateTime fechaRegistro;
    final DateTime proximaVisita;
    final DateTime fechaAnterior;
    final String asignarTarea;
    final String tareaAnterior;
    final List<Tarea> tareas;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idConsultorias: json["idConsultorias"],
        idCatAmbito: json["idCatAmbito"],
        idCatAreaCirculo: json["idCatAreaCirculo"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        proximaVisita: DateTime.parse(json["proximaVisita"]),
        fechaAnterior: DateTime.parse(json["fechaAnterior"]),
        asignarTarea: json["asignarTarea"],
        tareaAnterior: json["tareaAnterior"],
        tareas: List<Tarea>.from(json["tareas"].map((x) => Tarea.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idConsultorias": idConsultorias,
        "idCatAmbito": idCatAmbito,
        "idCatAreaCirculo": idCatAreaCirculo,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "proximaVisita": "${proximaVisita.year.toString().padLeft(4, '0')}-${proximaVisita.month.toString().padLeft(2, '0')}-${proximaVisita.day.toString().padLeft(2, '0')}",
        "fechaAnterior": "${fechaAnterior.year.toString().padLeft(4, '0')}-${fechaAnterior.month.toString().padLeft(2, '0')}-${fechaAnterior.day.toString().padLeft(2, '0')}",
        "asignarTarea": asignarTarea,
        "tareaAnterior": tareaAnterior,
        "tareas": List<dynamic>.from(tareas.map((x) => x.toMap())),
    };
}

class Tarea {
    Tarea({
        required this.idTarea,
        required this.avanceObservado,
        required this.idCatPorcentajeAvance,
        required this.siguientesPasos,
        required this.fechaRegistro,
        this.documento,
    });

    final int idTarea;
    final String avanceObservado;
    final int idCatPorcentajeAvance;
    final String siguientesPasos;
    final DateTime fechaRegistro;
    final Documento? documento;

    factory Tarea.fromMap(Map<String, dynamic> json) => Tarea(
        idTarea: json["idTarea"],
        avanceObservado: json["avanceObservado"],
        idCatPorcentajeAvance: json["idCatPorcentajeAvance"],
        siguientesPasos: json["siguientesPasos"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        documento: json["documento"] == null ? null : Documento.fromMap(json["documento"]),
    );

    Map<String, dynamic> toMap() => {
        "idTarea": idTarea,
        "avanceObservado": avanceObservado,
        "idCatPorcentajeAvance": idCatPorcentajeAvance,
        "siguientesPasos": siguientesPasos,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "documento": documento == null ? null : documento!.toMap(),
    };
}

class Documento {
    Documento({
        required this.idDocumento,
        required this.nombreArchivo,
        required this.archivo,
    });

    final int idDocumento;
    final String nombreArchivo;
    final String archivo;

    factory Documento.fromMap(Map<String, dynamic> json) => Documento(
        idDocumento: json["idDocumento"],
        nombreArchivo: json["nombreArchivo"],
        archivo: json["archivo"],
    );

    Map<String, dynamic> toMap() => {
        "idDocumento": idDocumento,
        "nombreArchivo": nombreArchivo,
        "archivo": archivo,
    };
}
