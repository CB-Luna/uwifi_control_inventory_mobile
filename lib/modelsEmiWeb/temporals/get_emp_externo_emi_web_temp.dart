import 'dart:convert';

GetEmpExternoEmiWebTemp getEmpExternoEmiWebTempFromMap(String str) => GetEmpExternoEmiWebTemp.fromMap(json.decode(str));

String getEmpExternoEmiWebTempToMap(GetEmpExternoEmiWebTemp data) => json.encode(data.toMap());

class GetEmpExternoEmiWebTemp {
    GetEmpExternoEmiWebTemp({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetEmpExternoEmiWebTemp.fromMap(Map<String, dynamic> json) => GetEmpExternoEmiWebTemp(
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
        required this.idEmprendedor,
        required this.nombre,
        required this.apellidos,
        required this.curp,
        required this.integrantesFamilia,
        required this.comunidad,
        required this.telefono,
        this.comentarios,
        required this.fechaRegistro,
        required this.proyectos,
        required this.promotor,
        required this.selected,
    });

    final int idEmprendedor;
    final String nombre;
    final String apellidos;
    final String curp;
    final int integrantesFamilia;
    final int comunidad;
    final String telefono;
    final String? comentarios;
    final DateTime fechaRegistro;
    final List<ProyectoTemp>? proyectos;
    final PromotorTemp promotor;
    bool selected = false;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idEmprendedor: json["idEmprendedor"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        curp: json["curp"],
        integrantesFamilia: json["integrantesFamilia"],
        comunidad: json["comunidad"],
        telefono: json["telefono"],
        comentarios: json["comentarios"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        proyectos: json["proyectos"] == null ? null : List<ProyectoTemp>.from(json["proyectos"].map((x) => ProyectoTemp.fromMap(x))),
        promotor: PromotorTemp.fromMap(json["promotor"]),
        selected: false,
    );

    Map<String, dynamic> toMap() => {
        "idEmprendedor": idEmprendedor,
        "nombre": nombre,
        "apellidos": apellidos,
        "curp": curp,
        "integrantesFamilia": integrantesFamilia,
        "comunidad": comunidad,
        "telefono": telefono,
        "comentarios": comentarios,
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "proyectos": proyectos == null ? null : List<dynamic>.from(proyectos!.map((x) => x.toMap())),
        "promotor": promotor.toMap(),
        "selected": false,
    };
}

class PromotorTemp {
    PromotorTemp({
        required this.idUsuario,
        required this.nombre,
        required this.apellidoPaterno,
        this.apellidoMaterno,
        required this.fechaNacimiento,
        required this.correo,
        this.telefono,
        this.celular,
        required this.fechaRegistro,
        this.documento,
    });

    final int idUsuario;
    final String nombre;
    final String apellidoPaterno;
    final String? apellidoMaterno;
    final DateTime? fechaNacimiento;
    final String correo;
    final String? telefono;
    final String? celular;
    final DateTime fechaRegistro;
    final Documento? documento;

    factory PromotorTemp.fromMap(Map<String, dynamic> json) => PromotorTemp(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        correo: json["correo"],
        telefono: json["telefono"],
        celular: json["celular"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        documento: json["documento"] == null ? null : Documento.fromMap(json["documento"]),
    );

    Map<String, dynamic> toMap() => {
        "idUsuario": idUsuario,
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "fechaNacimiento": fechaNacimiento == null ? null : "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "correo": correo,
        "telefono": telefono,
        "celular": celular,
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


class ProyectoTemp {
    ProyectoTemp({
        required this.idProyecto,
        required this.idEmprendedor,
        required this.idCatFase,
        this.idCatTipoProyecto,
        required this.activo,
        required this.archivado,
        required this.emprendimiento,
        required this.faseAnterior,
        this.idCatProyecto,
        required this.archivadoJornadas,
    });

    final int idProyecto;
    final int idEmprendedor;
    final int idCatFase;
    final int? idCatTipoProyecto;
    final bool activo;
    final bool archivado;
    final String emprendimiento;
    final int faseAnterior;
    final int? idCatProyecto;
    final bool archivadoJornadas;

    factory ProyectoTemp.fromMap(Map<String, dynamic> json) => ProyectoTemp(
        idProyecto: json["idProyecto"],
        idEmprendedor: json["idEmprendedor"],
        idCatFase: json["idCatFase"],
        idCatTipoProyecto: json["idCatTipoProyecto"],
        activo: json["activo"],
        archivado: json["archivado"],
        emprendimiento: json["emprendimiento"],
        faseAnterior: json["faseAnterior"],
        idCatProyecto: json["idCatProyecto"],
        archivadoJornadas: json["archivadoJornadas"],
    );

    Map<String, dynamic> toMap() => {
        "idProyecto": idProyecto,
        "idEmprendedor": idEmprendedor,
        "idCatFase": idCatFase,
        "idCatTipoProyecto": idCatTipoProyecto,
        "activo": activo,
        "archivado": archivado,
        "emprendimiento": emprendimiento,
        "faseAnterior": faseAnterior,
        "idCatProyecto": idCatProyecto,
        "archivadoJornadas": archivadoJornadas,
    };
}

