class ProductosVendidosTemporal {

    final String id;
    final int idProductoEmp;
    final String producto;
    final int idUnidadMedida;
    final String unidadMedida;
    final int cantidad;
    final double costoUnitario;
    final double precioVenta;
    final double subTotal;
    final DateTime fechaRegistro;

    ProductosVendidosTemporal({
      required this.id,
      required this.idProductoEmp,
      required this.producto,
      required this.idUnidadMedida,
      required this.unidadMedida,
      required this.cantidad,
      required this.costoUnitario,
      required this.precioVenta,
      required this.subTotal,
      required this.fechaRegistro,
    });

}