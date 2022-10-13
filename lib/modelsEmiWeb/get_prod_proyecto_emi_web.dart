import 'dart:convert';

GetProdProyectoEmiWeb getProdProyectoEmiWebFromMap(String str) => GetProdProyectoEmiWeb.fromMap(json.decode(str));

String getProdProyectoEmiWebToMap(GetProdProyectoEmiWeb data) => json.encode(data.toMap());

class GetProdProyectoEmiWeb {
    GetProdProyectoEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetProdProyectoEmiWeb.fromMap(Map<String, dynamic> json) => GetProdProyectoEmiWeb(
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
        required this.idCatInversionProyecto,
        required this.idCatTipoProyecto,
        required this.idCatProyecto,
        required this.familiaInversion,
        required this.proveedorSugerido,
        required this.producto,
        required this.cantidad,
        required this.costoEstimado,
        required this.activo,
    });

    final int idCatInversionProyecto;
    final int idCatTipoProyecto;
    final int idCatProyecto;
    final FamiliaInversion? familiaInversion;
    final ProveedorSugerido? proveedorSugerido;
    final Producto? producto;
    final int cantidad;
    final int costoEstimado;
    final bool activo;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        idCatInversionProyecto: json["idCatInversionProyecto"],
        idCatTipoProyecto: json["idCatTipoProyecto"],
        idCatProyecto: json["idCatProyecto"],
        familiaInversion: json["familiaInversion"] == null ? null : FamiliaInversion.fromMap(json["familiaInversion"]),
        proveedorSugerido: json["proveedorSugerido"] == null ? null : ProveedorSugerido.fromMap(json["proveedorSugerido"]),
        producto: json["producto"] == null ? null : Producto.fromMap(json["producto"]),
        cantidad: json["cantidad"],
        costoEstimado: json["costoEstimado"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatInversionProyecto": idCatInversionProyecto,
        "idCatTipoProyecto": idCatTipoProyecto,
        "idCatProyecto": idCatProyecto,
        "familiaInversion": familiaInversion == null ? null : familiaInversion!.toMap(),
        "proveedorSugerido": proveedorSugerido == null ? null : proveedorSugerido!.toMap(),
        "producto": producto == null ? null : producto!.toMap(),
        "cantidad": cantidad,
        "costoEstimado": costoEstimado,
        "activo": activo,
    };
}

class FamiliaInversion {
    FamiliaInversion({
        required this.idCatFamiliaInversion,
        required this.familiaInversionNecesaria,
        required this.activo,
    });

    final int idCatFamiliaInversion;
    final String familiaInversionNecesaria;
    final bool activo;

    factory FamiliaInversion.fromMap(Map<String, dynamic> json) => FamiliaInversion(
        idCatFamiliaInversion: json["idCatFamiliaInversion"],
        familiaInversionNecesaria: json["familiaInversionNecesaria"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatFamiliaInversion": idCatFamiliaInversion,
        "familiaInversionNecesaria": familiaInversionNecesaria,
        "activo": activo,
    };
}

class Producto {
    Producto({
        required this.idProductosProveedor,
        required this.producto,
    });

    final int idProductosProveedor;
    final String producto;

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        idProductosProveedor: json["idProductosProveedor"],
        producto: json["producto"],
    );

    Map<String, dynamic> toMap() => {
        "idProductosProveedor": idProductosProveedor,
        "producto": producto,
    };
}

class ProveedorSugerido {
    ProveedorSugerido({
        required this.idProveedor,
        required this.nombreFiscal,
    });

    final int idProveedor;
    final String nombreFiscal;

    factory ProveedorSugerido.fromMap(Map<String, dynamic> json) => ProveedorSugerido(
        idProveedor: json["idProveedor"],
        nombreFiscal: json["nombreFiscal"],
    );

    Map<String, dynamic> toMap() => {
        "idProveedor": idProveedor,
        "nombreFiscal": nombreFiscal,
    };
}
