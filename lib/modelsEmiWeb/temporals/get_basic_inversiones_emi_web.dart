import 'dart:convert';

GetBasicInversionesEmiWeb getBasicInversionesEmiWebFromMap(String str) => GetBasicInversionesEmiWeb.fromMap(json.decode(str));

String getBasicInversionesEmiWebToMap(GetBasicInversionesEmiWeb data) => json.encode(data.toMap());

class GetBasicInversionesEmiWeb {
    GetBasicInversionesEmiWeb({
        required this.status,
        required this.payload,
    });

    final String status;
    final List<Payload>? payload;

    factory GetBasicInversionesEmiWeb.fromMap(Map<String, dynamic> json) => GetBasicInversionesEmiWeb(
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
        required this.catEstadoInversion,
        this.productoEntregadoDocumento,
        this.firmaRecibidoDocumento,
        required this.fechaRegistro,
        this.fechaDeCompra,
        required this.idInversiones,
        required this.idProyecto,
        required this.idCatEstadoInversion,
        this.productoEntregado,
        this.pagoRecibido,
        required this.inversionRecibida,
        required this.montoPagar,
        required this.porcentajePago,
        required this.saldo,
        required this.totalInversion,
        required this.productosDeProyecto,
        required this.productosSolicitados,
        this.productosCotizados,
    });

    final CatEstadoInversion catEstadoInversion;
    final Documento? productoEntregadoDocumento;
    final Documento? firmaRecibidoDocumento;
    final DateTime fechaRegistro;
    final DateTime? fechaDeCompra;
    final int idInversiones;
    final int idProyecto;
    final int idCatEstadoInversion;
    final int? productoEntregado;
    final int? pagoRecibido;
    final bool inversionRecibida;
    final double montoPagar;
    final double porcentajePago;
    final double saldo;
    final double totalInversion;
    final List<ProductosDeProyecto> productosDeProyecto;
    final List<ProductosSolicitado> productosSolicitados;
    final List<ProductosCotizado>? productosCotizados;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        catEstadoInversion: CatEstadoInversion.fromMap(json["catEstadoInversion"]),
        productoEntregadoDocumento: json["productoEntregadoDocumento"] == null ? null : Documento.fromMap(json["productoEntregadoDocumento"]),
        firmaRecibidoDocumento: json["firmaRecibidoDocumento"] == null ? null : Documento.fromMap(json["firmaRecibidoDocumento"]),
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        fechaDeCompra: json["fechaDeCompra"] == null ? null : DateTime.parse(json["fechaDeCompra"]),
        idInversiones: json["idInversiones"],
        idProyecto: json["idProyecto"],
        idCatEstadoInversion: json["idCatEstadoInversion"],
        productoEntregado: json["productoEntregado"],
        pagoRecibido: json["pagoRecibido"],
        inversionRecibida: json["inversionRecibida"],
        montoPagar: json["montoPagar"].toDouble(),
        porcentajePago: json["porcentajePago"].toDouble(),
        saldo: json["saldo"].toDouble(),
        totalInversion: json["totalInversion"].toDouble(),
        productosDeProyecto: List<ProductosDeProyecto>.from(json["productosDeProyecto"].map((x) => ProductosDeProyecto.fromMap(x))),
        productosSolicitados: List<ProductosSolicitado>.from(json["productosSolicitados"].map((x) => ProductosSolicitado.fromMap(x))),
        productosCotizados: json["productosCotizados"] == null ? null : List<ProductosCotizado>.from(json["productosCotizados"].map((x) => ProductosCotizado.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "catEstadoInversion": catEstadoInversion.toMap(),
        "productoEntregadoDocumento": productoEntregadoDocumento == null ? null : productoEntregadoDocumento!.toMap(),
        "firmaRecibidoDocumento": firmaRecibidoDocumento == null ? null : firmaRecibidoDocumento!.toMap(),
        "fechaRegistro": fechaRegistro.toIso8601String(),
        "fechaDeCompra": fechaDeCompra == null ? null : "${fechaDeCompra!.year.toString().padLeft(4, '0')}-${fechaDeCompra!.month.toString().padLeft(2, '0')}-${fechaDeCompra!.day.toString().padLeft(2, '0')}",
        "idInversiones": idInversiones,
        "idProyecto": idProyecto,
        "idCatEstadoInversion": idCatEstadoInversion,
        "productoEntregado": productoEntregado,
        "pagoRecibido": pagoRecibido,
        "inversionRecibida": inversionRecibida,
        "montoPagar": montoPagar,
        "porcentajePago": porcentajePago,
        "saldo": saldo,
        "totalInversion": totalInversion,
        "productosDeProyecto": List<dynamic>.from(productosDeProyecto.map((x) => x.toMap())),
        "productosSolicitados": List<dynamic>.from(productosSolicitados.map((x) => x.toMap())),
        "productosCotizados": productosCotizados == null ? null : List<dynamic>.from(productosCotizados!.map((x) => x.toMap())),
    };
}

class CatEstadoInversion {
    CatEstadoInversion({
        required this.idCatEstadoInversion,
        required this.estadoInversion,
    });

    final int idCatEstadoInversion;
    final String estadoInversion;

    factory CatEstadoInversion.fromMap(Map<String, dynamic> json) => CatEstadoInversion(
        idCatEstadoInversion: json["idCatEstadoInversion"],
        estadoInversion: json["estadoInversion"],
    );

    Map<String, dynamic> toMap() => {
        "idCatEstadoInversion": idCatEstadoInversion,
        "estadoInversion": estadoInversion,
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

class ProductosCotizado {
    ProductosCotizado({
        required this.inversionesXProductosCotizadosId,
        required this.aceptado,
        required this.productoCotizado,
    });

    final InversionesXProductosCotizadosId inversionesXProductosCotizadosId;
    final bool aceptado;
    final ProductoCotizado productoCotizado;

    factory ProductosCotizado.fromMap(Map<String, dynamic> json) => ProductosCotizado(
        inversionesXProductosCotizadosId: InversionesXProductosCotizadosId.fromMap(json["inversionesXProductosCotizadosId"]),
        aceptado: json["aceptado"],
        productoCotizado: ProductoCotizado.fromMap(json["productoCotizado"]),
    );

    Map<String, dynamic> toMap() => {
        "inversionesXProductosCotizadosId": inversionesXProductosCotizadosId.toMap(),
        "aceptado": aceptado,
        "productoCotizado": productoCotizado.toMap(),
    };
}

class InversionesXProductosCotizadosId {
    InversionesXProductosCotizadosId({
        required this.idListaCotizacion,
        required this.idInversion,
        required this.idProductoCotizado,
    });

    final int idListaCotizacion;
    final int idInversion;
    final int idProductoCotizado;

    factory InversionesXProductosCotizadosId.fromMap(Map<String, dynamic> json) => InversionesXProductosCotizadosId(
        idListaCotizacion: json["idListaCotizacion"],
        idInversion: json["idInversion"],
        idProductoCotizado: json["idProductoCotizado"],
    );

    Map<String, dynamic> toMap() => {
        "idListaCotizacion": idListaCotizacion,
        "idInversion": idInversion,
        "idProductoCotizado": idProductoCotizado,
    };
}

class ProductoCotizado {
    ProductoCotizado({
        required this.idProductoCotizado,
        required this.cantidad,
        required this.aceptado,
        required this.costoTotal,
        required this.nombreProveedor,
        required this.nombreProducto,
        required this.descripcionProducto,
        required this.marcaProducto,
        required this.costoProducto,
        required this.idDocumento,
        required this.documento,
    });

    final int idProductoCotizado;
    final int cantidad;
    final bool aceptado;
    final double costoTotal;
    final String nombreProveedor;
    final String nombreProducto;
    final String descripcionProducto;
    final String marcaProducto;
    final String costoProducto;
    final int idDocumento;
    final Documento documento;

    factory ProductoCotizado.fromMap(Map<String, dynamic> json) => ProductoCotizado(
        idProductoCotizado: json["idProductoCotizado"],
        cantidad: json["cantidad"],
        aceptado: json["aceptado"],
        costoTotal: json["costoTotal"].toDouble(),
        nombreProveedor: json["nombreProveedor"],
        nombreProducto: json["nombreProducto"],
        descripcionProducto: json["descripcionProducto"],
        marcaProducto: json["marcaProducto"],
        costoProducto: json["costoProducto"],
        idDocumento: json["idDocumento"],
        documento: Documento.fromMap(json["documento"]),
    );

    Map<String, dynamic> toMap() => {
        "idProductoCotizado": idProductoCotizado,
        "cantidad": cantidad,
        "aceptado": aceptado,
        "costoTotal": costoTotal,
        "nombreProveedor": nombreProveedor,
        "nombreProducto": nombreProducto,
        "descripcionProducto": descripcionProducto,
        "marcaProducto": marcaProducto,
        "costoProducto": costoProducto,
        "idDocumento": idDocumento,
        "documento": documento.toMap(),
    };
}

class ProductosDeProyecto {
    ProductosDeProyecto({
        required this.catFamiliaInversion,
        required this.catUnidadMedidaProveedor,
        required this.cantidad,
        required this.costoEstimado,
        required this.descripcion,
        required this.idProductoDeProyecto,
        required this.idFamilia,
        required this.unidadMedida,
        required this.marcaRecomendada,
        required this.producto,
        required this.proveedorSugerido,
    });

    final CatFamiliaInversion catFamiliaInversion;
    final CatUnidadMedidaProveedor catUnidadMedidaProveedor;
    final int cantidad;
    final double costoEstimado;
    final String descripcion;
    final int idProductoDeProyecto;
    final int idFamilia;
    final int unidadMedida;
    final String marcaRecomendada;
    final String producto;
    final String proveedorSugerido;

    factory ProductosDeProyecto.fromMap(Map<String, dynamic> json) => ProductosDeProyecto(
        catFamiliaInversion: CatFamiliaInversion.fromMap(json["catFamiliaInversion"]),
        catUnidadMedidaProveedor: CatUnidadMedidaProveedor.fromMap(json["catUnidadMedidaProveedor"]),
        cantidad: json["cantidad"],
        costoEstimado: json["costoEstimado"].toDouble(),
        descripcion: json["descripcion"],
        idProductoDeProyecto: json["idProductoDeProyecto"],
        idFamilia: json["idFamilia"],
        unidadMedida: json["unidadMedida"],
        marcaRecomendada: json["marcaRecomendada"],
        producto: json["producto"],
        proveedorSugerido: json["proveedorSugerido"],
    );

    Map<String, dynamic> toMap() => {
        "catFamiliaInversion": catFamiliaInversion.toMap(),
        "catUnidadMedidaProveedor": catUnidadMedidaProveedor.toMap(),
        "cantidad": cantidad,
        "costoEstimado": costoEstimado,
        "descripcion": descripcion,
        "idProductoDeProyecto": idProductoDeProyecto,
        "idFamilia": idFamilia,
        "unidadMedida": unidadMedida,
        "marcaRecomendada": marcaRecomendada,
        "producto": producto,
        "proveedorSugerido": proveedorSugerido,
    };
}

class CatFamiliaInversion {
    CatFamiliaInversion({
        required this.idCatFamiliaInversion,
        required this.familiaInversionNecesaria,
        required this.activo,
    });

    final int idCatFamiliaInversion;
    final String familiaInversionNecesaria;
    final bool activo;

    factory CatFamiliaInversion.fromMap(Map<String, dynamic> json) => CatFamiliaInversion(
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

class CatUnidadMedidaProveedor {
    CatUnidadMedidaProveedor({
        required this.catUnidadMedidaProveedor,
        required this.unidadMedida,
        required this.activo,
    });

    final int catUnidadMedidaProveedor;
    final String unidadMedida;
    final bool activo;

    factory CatUnidadMedidaProveedor.fromMap(Map<String, dynamic> json) => CatUnidadMedidaProveedor(
        catUnidadMedidaProveedor: json["catUnidadMedidaProveedor"],
        unidadMedida: json["unidadMedida"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "catUnidadMedidaProveedor": catUnidadMedidaProveedor,
        "unidadMedida": unidadMedida,
        "activo": activo,
    };
}

class ProductosSolicitado {
    ProductosSolicitado({
        required this.id,
        required this.idInversiones,
        required this.productoSolicitado,
    });

    final int id;
    final int idInversiones;
    final ProductoSolicitado productoSolicitado;

    factory ProductosSolicitado.fromMap(Map<String, dynamic> json) => ProductosSolicitado(
        id: json["id"],
        idInversiones: json["idInversiones"],
        productoSolicitado: ProductoSolicitado.fromMap(json["productoSolicitado"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "idInversiones": idInversiones,
        "productoSolicitado": productoSolicitado.toMap(),
    };
}

class ProductoSolicitado {
    ProductoSolicitado({
        required this.idProductoSolicitado,
        required this.producto,
        this.marcaSugerida,
        required this.descripcion,
        this.proveedorSugerido,
        required this.idCatTipoEmpaque,
        required this.catTipoEmpaque,
        required this.cantidad,
        required this.costoEstimado,
        this.idDocumento,
    });

    final int idProductoSolicitado;
    final String producto;
    final String? marcaSugerida;
    final String descripcion;
    final String? proveedorSugerido;
    final int idCatTipoEmpaque;
    final CatTipoEmpaque catTipoEmpaque;
    final int cantidad;
    final double costoEstimado;
    final int? idDocumento;

    factory ProductoSolicitado.fromMap(Map<String, dynamic> json) => ProductoSolicitado(
        idProductoSolicitado: json["idProductoSolicitado"],
        producto: json["producto"],
        marcaSugerida: json["marcaSugerida"],
        descripcion: json["descripcion"],
        proveedorSugerido: json["proveedorSugerido"],
        idCatTipoEmpaque: json["idCatTipoEmpaque"],
        catTipoEmpaque: CatTipoEmpaque.fromMap(json["catTipoEmpaque"]),
        cantidad: json["cantidad"],
        costoEstimado: json["costoEstimado"].toDouble(),
        idDocumento: json["idDocumento"],
    );

    Map<String, dynamic> toMap() => {
        "idProductoSolicitado": idProductoSolicitado,
        "producto": producto,
        "marcaSugerida": marcaSugerida,
        "descripcion": descripcion,
        "proveedorSugerido": proveedorSugerido,
        "idCatTipoEmpaque": idCatTipoEmpaque,
        "catTipoEmpaque": catTipoEmpaque.toMap(),
        "cantidad": cantidad,
        "costoEstimado": costoEstimado,
        "idDocumento": idDocumento,
    };
}

class CatTipoEmpaque {
    CatTipoEmpaque({
        required this.idCatTipoEmpaque,
        required this.tipoEmpaque,
        required this.activo,
    });

    final int idCatTipoEmpaque;
    final String tipoEmpaque;
    final bool activo;

    factory CatTipoEmpaque.fromMap(Map<String, dynamic> json) => CatTipoEmpaque(
        idCatTipoEmpaque: json["idCatTipoEmpaque"],
        tipoEmpaque: json["tipoEmpaque"],
        activo: json["activo"],
    );

    Map<String, dynamic> toMap() => {
        "idCatTipoEmpaque": idCatTipoEmpaque,
        "tipoEmpaque": tipoEmpaque,
        "activo": activo,
    };
}
