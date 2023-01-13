import 'dart:convert';

GetValidateUsuarioEstatusEmiWeb getValidateUsuarioEstatusEmiWebFromMap(String str) => GetValidateUsuarioEstatusEmiWeb.fromMap(json.decode(str));

String getValidateUsuarioEstatusEmiWebToMap(GetValidateUsuarioEstatusEmiWeb data) => json.encode(data.toMap());

class GetValidateUsuarioEstatusEmiWeb {
    GetValidateUsuarioEstatusEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload payload;

    factory GetValidateUsuarioEstatusEmiWeb.fromMap(Map<String, dynamic> json) => GetValidateUsuarioEstatusEmiWeb(
        status: json["status"],
        payload: Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload.toMap(),
    };
}

class Payload {
    Payload({
        required this.idProyecto,
        required this.emprendimiento,
        required this.activo,
        required this.archivado,
        required this.idCatFase,
        required this.fecha,
        this.idCatTipoProyecto,
        this.idCatProyecto,
        required this.switchMovil,
        required this.idPromotor,
        required this.emprendedor,
    });

    final int idProyecto;
    final String emprendimiento;
    final bool activo;
    final bool archivado;
    final int idCatFase;
    final DateTime fecha;
    final int? idCatTipoProyecto;
    final int? idCatProyecto;
    final bool switchMovil;
    final int idPromotor;
    final Emprendedor emprendedor;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idProyecto: json["idProyecto"],
        emprendimiento: json["emprendimiento"],
        activo: json["activo"],
        archivado: json["archivado"],
        idCatFase: json["idCatFase"],
        fecha: DateTime.parse(json["fecha"]),
        idCatTipoProyecto: json["idCatTipoProyecto"],
        idCatProyecto: json["idCatProyecto"],
        switchMovil: json["switchMovil"],
        idPromotor: json["idPromotor"],
        emprendedor: Emprendedor.fromMap(json["emprendedor"]),
    );

    Map<String, dynamic> toMap() => {
        "idProyecto": idProyecto,
        "emprendimiento": emprendimiento,
        "activo": activo,
        "archivado": archivado,
        "idCatFase": idCatFase,
        "fecha": fecha.toIso8601String(),
        "idCatTipoProyecto": idCatTipoProyecto,
        "idCatProyecto": idCatProyecto,
        "switchMovil": switchMovil,
        "idPromotor": idPromotor,
        "emprendedor": emprendedor.toMap(),
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
        "fechaRegistro": fechaRegistro.toIso8601String(),
    };
}
