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
        required this.proyecto,
        this.imagenPerfil,
    });

    final Proyecto proyecto;
    final ImagenPerfil? imagenPerfil;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        proyecto: Proyecto.fromMap(json["proyecto"]),
        imagenPerfil: json["imagenPerfil"] == null ? null : ImagenPerfil.fromMap(json["imagenPerfil"]),
    );

    Map<String, dynamic> toMap() => {
        "proyecto": proyecto.toMap(),
        "imagenPerfil": imagenPerfil == null ? null : imagenPerfil!.toMap(),
    };
}

class ImagenPerfil {
    ImagenPerfil({
        required this.idDocumento,
        required this.nombreArchivo,
        required this.fechaCarga,
        required this.archivo,
    });

    final int idDocumento;
    final String nombreArchivo;
    final DateTime fechaCarga;
    final String archivo;

    factory ImagenPerfil.fromMap(Map<String, dynamic> json) => ImagenPerfil(
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

class Proyecto {
    Proyecto({
        required this.idProyecto,
        required this.idCatFase,
        required this.activo,
        required this.emprendimiento,
        required this.faseAnterior,
        required this.emprendedor,
        this.idCatTipoProyecto,
        this.idCatProyecto,
        required this.switchMovil,
        this.promotor,
        required this.selected,
    });

    final int idProyecto;
    final int idCatFase;
    final bool? activo;
    final String emprendimiento;
    final int faseAnterior;
    final Emprendedor emprendedor;
    final int? idCatTipoProyecto;
    final int? idCatProyecto;
    final bool? switchMovil;
    final Promotor? promotor;
    bool selected = false;

    factory Proyecto.fromMap(Map<String, dynamic> json) => Proyecto(
        idProyecto: json["idProyecto"],
        idCatFase: json["idCatFase"],
        activo: json["activo"],
        emprendimiento: json["emprendimiento"],
        faseAnterior: json["faseAnterior"],
        emprendedor: Emprendedor.fromMap(json["emprendedor"]),
        idCatTipoProyecto: json["idCatTipoProyecto"],
        idCatProyecto: json["idCatProyecto"],
        switchMovil: json["switchMovil"],
        promotor: json["promotor"] == null ? null : Promotor.fromMap(json["promotor"]),
        selected: false,
    );

    Map<String, dynamic> toMap() => {
        "idProyecto": idProyecto,
        "idCatFase": idCatFase,
        "activo": activo,
        "emprendimiento": emprendimiento,
        "faseAnterior": faseAnterior,
        "emprendedor": emprendedor.toMap(),
        "idCatTipoProyecto": idCatTipoProyecto,
        "idCatProyecto": idCatProyecto,
        "switchMovil": switchMovil,
        "promotor": promotor == null ? null : promotor!.toMap(),
        "selected": false,
    };
}

class Emprendedor {
    Emprendedor({
        required this.idEmprendedor,
        required this.nombre,
        required this.apellidos,
        required this.curp,
        required this.integrantesFamilia,
        required this.comunidad,
        this.telefono,
        this.comentarios,
        required this.archivado,
        required this.estado,
        required this.municipio,
        required this.fechaRegistro,
    });

    final int idEmprendedor;
    final String nombre;
    final String apellidos;
    final String curp;
    final int integrantesFamilia;
    final int comunidad;
    final String? telefono;
    final String? comentarios;
    final bool? archivado;
    final int estado;
    final int municipio;
    final DateTime fechaRegistro;

    factory Emprendedor.fromMap(Map<String, dynamic> json) => Emprendedor(
        idEmprendedor: json["idEmprendedor"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        curp: json["curp"],
        integrantesFamilia: json["integrantesFamilia"],
        comunidad: json["comunidad"],
        telefono: json["telefono"],
        comentarios: json["comentarios"],
        archivado: json["archivado"],
        estado: json["estado"],
        municipio: json["municipio"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
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
        "archivado": archivado,
        "estado": estado,
        "municipio": municipio,
        "fechaRegistro": fechaRegistro.toIso8601String(),
    };
}

class Promotor {
    Promotor({
        required this.idUsuario,
        required this.nombre,
        required this.apellidoPaterno,
        this.apellidoMaterno,
        this.fechaNacimiento,
        required this.correo,
        required this.telefono,
        this.celular,
        // required this.fechaRegistro,
    });

    final int idUsuario;
    final String nombre;
    final String apellidoPaterno;
    final String? apellidoMaterno;
    final DateTime? fechaNacimiento;
    final String correo;
    final String telefono;
    final String? celular;
    // final DateTime fechaRegistro;

    factory Promotor.fromMap(Map<String, dynamic> json) => Promotor(
        idUsuario: json["idUsuario"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        fechaNacimiento: json["fechaNacimiento"] == null ? null : DateTime.parse(json["fechaNacimiento"]),
        correo: json["correo"],
        telefono: json["telefono"],
        celular: json["celular"],
        // fechaRegistro: json["fechaRegistro"],
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
        // "fechaRegistro": fechaRegistro.toIso8601String(),
    };
}

