import 'dart:convert';

GetProveedorByIdEmiWeb getProveedorByIdEmiWebFromMap(String str) => GetProveedorByIdEmiWeb.fromMap(json.decode(str));

String getProveedorByIdEmiWebToMap(GetProveedorByIdEmiWeb data) => json.encode(data.toMap());

class GetProveedorByIdEmiWeb {
    GetProveedorByIdEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final Payload? payload;

    factory GetProveedorByIdEmiWeb.fromMap(Map<String, dynamic> json) => GetProveedorByIdEmiWeb(
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
        required this.idProveedor,
        required this.nombreFiscal,
        required this.rfc,
        required this.idTipoProveedor,
        required this.direccion,
        required this.idCatEstado,
        required this.idCatMunicipio,
        required this.nombreEncargado,
        required this.idCondicionesPago,
        required this.cuentaClabe,
        required this.telefono,
        required this.idBanco,
        required this.archivado,
        required this.idCatComunidad,
    });

    final int idProveedor;
    final String nombreFiscal;
    final String rfc;
    final int idTipoProveedor;
    final String direccion;
    final int idCatEstado;
    final int idCatMunicipio;
    final String nombreEncargado;
    final int idCondicionesPago;
    final String cuentaClabe;
    final String telefono;
    final int idBanco;
    final bool archivado;
    final int idCatComunidad;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idProveedor: json["idProveedor"],
        nombreFiscal: json["nombreFiscal"],
        rfc: json["rfc"],
        idTipoProveedor: json["idTipoProveedor"],
        direccion: json["direccion"],
        idCatEstado: json["idCatEstado"],
        idCatMunicipio: json["idCatMunicipio"],
        nombreEncargado: json["nombreEncargado"],
        idCondicionesPago: json["idCondicionesPago"],
        cuentaClabe: json["cuentaClabe"],
        telefono: json["telefono"],
        idBanco: json["idBanco"],
        archivado: json["archivado"],
        idCatComunidad: json["idCatComunidad"],
    );

    Map<String, dynamic> toMap() => {
        "idProveedor": idProveedor,
        "nombreFiscal": nombreFiscal,
        "rfc": rfc,
        "idTipoProveedor": idTipoProveedor,
        "direccion": direccion,
        "idCatEstado": idCatEstado,
        "idCatMunicipio": idCatMunicipio,
        "nombreEncargado": nombreEncargado,
        "idCondicionesPago": idCondicionesPago,
        "cuentaClabe": cuentaClabe,
        "telefono": telefono,
        "idBanco": idBanco,
        "archivado": archivado,
        "idCatComunidad": idCatComunidad,
    };
}
