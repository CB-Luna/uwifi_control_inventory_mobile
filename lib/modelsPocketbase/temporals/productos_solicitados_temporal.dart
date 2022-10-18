class ProductosSolicitadosTemporal {

    final String id;
    final String producto;
    final String? marcaSugerida;
    final String descripcion;
    final String? proveedorSugerido;
    final double? costoEstimado;
    final int cantidad;
    final int idFamiliaProd;
    final String familiaProd;
    final int? idTipoEmpaques;
    final String? tipoEmpaques;
    final int? idUnidadMedida;
    final String? unidadMedida;
    final String? imagen;
    final DateTime fechaRegistro;

    ProductosSolicitadosTemporal({
      required this.id,
      required this.producto,
      this.marcaSugerida,
      required this.descripcion,
      this.proveedorSugerido,
      this.costoEstimado,
      required this.cantidad,
      required this.idFamiliaProd,
      required this.familiaProd,
      this.idTipoEmpaques,
      this.tipoEmpaques,
      this.idUnidadMedida,
      this.unidadMedida,
      this.imagen,
      required this.fechaRegistro,
    });

}
