import 'dart:convert';

GetBasicJornadasEmiWeb getBasicJornadasEmiWebFromMap(String str) => GetBasicJornadasEmiWeb.fromMap(json.decode(str));

String getBasicJornadasEmiWebToMap(GetBasicJornadasEmiWeb data) => json.encode(data.toMap());

class GetBasicJornadasEmiWeb {
    GetBasicJornadasEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetBasicJornadasEmiWeb.fromMap(Map<String, dynamic> json) => GetBasicJornadasEmiWeb(
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
        this.jornada1,
        this.jornada2,
        this.jornada3,
        this.jornada4,
    });

    final Jornada1? jornada1;
    final Jornada2? jornada2;
    final Jornada3? jornada3;
    final Jornada4? jornada4;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        jornada1: json["jornada1"] == null ? null : Jornada1.fromMap(json["jornada1"]),
        jornada2: json["jornada2"] == null ? null : Jornada2.fromMap(json["jornada2"]),
        jornada3: json["jornada3"] == null ? null : Jornada3.fromMap(json["jornada3"]),
        jornada4: json["jornada4"] == null ? null : Jornada4.fromMap(json["jornada4"]),
    );

    Map<String, dynamic> toMap() => {
        "jornada1": jornada1 == null ? null : jornada1!.toMap(),
        "jornada2": jornada2 == null ? null : jornada2!.toMap(),
        "jornada3": jornada3 == null ? null : jornada3!.toMap(),
        "jornada4": jornada4 == null ? null : jornada4!.toMap(),
    };
}

class Jornada1 {
    Jornada1({
        required this.idJornada1,
        required this.fechaRegistro,
        required this.registrarTarea,
        required this.fechaRevision,
        required this.tareaCompletada,
        required this.idProyecto,
    });

    final int idJornada1;
    final DateTime fechaRegistro;
    final String registrarTarea;
    final DateTime fechaRevision;
    final bool tareaCompletada;
    final int idProyecto;

    factory Jornada1.fromMap(Map<String, dynamic> json) => Jornada1(
        idJornada1: json["idJornada1"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        registrarTarea: json["registrarTarea"],
        fechaRevision: DateTime.parse(json["fechaRevision"]),
        tareaCompletada: json["tareaCompletada"],
        idProyecto: json["idProyecto"],
    );

    Map<String, dynamic> toMap() => {
        "idJornada1": idJornada1,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "registrarTarea": registrarTarea,
        "fechaRevision": fechaRevision.toIso8601String(),
        "tareaCompletada": tareaCompletada,
        "idProyecto": idProyecto,
    };
}

class Jornada2 {
    Jornada2({
        required this.idJornada2,
        required this.fechaRegistro,
        required this.registrarTarea,
        required this.fechaRevision,
        this.comentarios,
        required this.tareaCompletada,
        required this.idProyecto,
        required this.documentos,
        required this.descripcion,
    });

    final int idJornada2;
    final DateTime fechaRegistro;
    final String registrarTarea;
    final DateTime fechaRevision;
    final String? comentarios;
    final bool tareaCompletada;
    final int idProyecto;
    final List<Documento> documentos;
    final String descripcion;

    factory Jornada2.fromMap(Map<String, dynamic> json) => Jornada2(
        idJornada2: json["idJornada2"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        registrarTarea: json["registrarTarea"],
        fechaRevision: DateTime.parse(json["fechaRevision"]),
        comentarios: json["comentarios"],
        tareaCompletada: json["tareaCompletada"],
        idProyecto: json["idProyecto"],
        documentos: List<Documento>.from(json["documentos"].map((x) => Documento.fromMap(x))),
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toMap() => {
        "idJornada2": idJornada2,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "registrarTarea": registrarTarea,
        "fechaRevision": fechaRevision.toIso8601String(),
        "comentarios": comentarios,
        "tareaCompletada": tareaCompletada,
        "idProyecto": idProyecto,
        "documentos": documentos == null ? null : List<dynamic>.from(documentos.map((x) => x.toMap())),
        "descripcion": descripcion,
    };
}

class Jornada3 {
    Jornada3({
        required this.fechaRegistro,
        required this.registrarTarea,
        required this.fechaRevision,
        this.comentarios,
        required this.tareaCompletada,
        required this.idProyecto,
        required this.documentos,
        required this.idJornada3,
        required this.descripcion,
    });

    final DateTime fechaRegistro;
    final String registrarTarea;
    final DateTime fechaRevision;
    final String? comentarios;
    final bool tareaCompletada;
    final int idProyecto;
    final List<Documento> documentos;
    final int idJornada3;
    final String descripcion;

    factory Jornada3.fromMap(Map<String, dynamic> json) => Jornada3(
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        registrarTarea: json["registrarTarea"],
        fechaRevision: DateTime.parse(json["fechaRevision"]),
        comentarios: json["comentarios"],
        tareaCompletada: json["tareaCompletada"],
        idProyecto: json["idProyecto"],
        documentos: List<Documento>.from(json["documentos"].map((x) => Documento.fromMap(x))),
        idJornada3: json["idJornada3"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toMap() => {
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "registrarTarea": registrarTarea,
        "fechaRevision": fechaRevision.toIso8601String(),
        "comentarios": comentarios,
        "tareaCompletada": tareaCompletada,
        "idProyecto": idProyecto,
        "documentos": List<dynamic>.from(documentos.map((x) => x.toMap())),
        "idJornada3": idJornada3,
        "descripcion": descripcion,
    };
}


class Documento {
    Documento({
        required this.idDocumento,
        required this.nombreArchivo,
        required this.fechaCarga,
        required this.archivo,
    });

    final int idDocumento;
    final String nombreArchivo;
    final DateTime fechaCarga;
    final String archivo;

    factory Documento.fromMap(Map<String, dynamic> json) => Documento(
        idDocumento: json["idDocumento"],
        nombreArchivo: json["nombreArchivo"],
        fechaCarga: DateTime.parse(json["fechaCarga"]),
        archivo: json["archivo"],
    );

    Map<String, dynamic> toMap() => {
        "idDocumento": idDocumento,
        "nombreArchivo": nombreArchivo,
        "fechaCarga": fechaCarga.toIso8601String(),
        "archivo": archivo,
    };
}

class Jornada4 {
    Jornada4({
        required this.idJornada4,
        required this.fechaRegistro,
        required this.fechaRevision,
        this.comentarios,
        required this.idProyecto,
        required this.documentos,
    });

    final int idJornada4;
    final DateTime fechaRegistro;
    final DateTime fechaRevision;
    final String? comentarios;
    final int idProyecto;
    final List<Documento> documentos;

    factory Jornada4.fromMap(Map<String, dynamic> json) => Jornada4(
        idJornada4: json["idJornada4"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        fechaRevision: DateTime.parse(json["fechaRevision"]),
        comentarios: json["comentarios"],
        idProyecto: json["idProyecto"],
        documentos: List<Documento>.from(json["documentos"].map((x) => Documento.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "idJornada4": idJornada4,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "fechaRevision": fechaRevision.toIso8601String(),
        "comentarios": comentarios,
        "idProyecto": idProyecto,
        "documentos": List<dynamic>.from(documentos.map((x) => x.toMap())),
    };
}
