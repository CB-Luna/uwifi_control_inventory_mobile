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
    final int idTipoEmpaques;
    final String tipoEmpaques;
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
      required this.idTipoEmpaques,
      required this.tipoEmpaques,
      this.imagen,
      required this.fechaRegistro,
    });

}
