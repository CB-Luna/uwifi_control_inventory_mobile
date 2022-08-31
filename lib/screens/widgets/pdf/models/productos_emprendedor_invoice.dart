
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class ProductosEmprendedorInvoice {
  final InvoiceInfo info;
  final List<ProductosEmprendedorItem> items;

  const ProductosEmprendedorInvoice({
    required this.info,
    required this.items,
  });
}

class ProductosEmprendedorItem {
  final int id;
  final String emprendedor;
  final String tipoProyecto;
  final String emprendimiento;
  final String producto;
  final String descripcion;
  final String unidadMedida;
  final String costo;
  final String usuario;
  final DateTime fechaRegistro;

  const ProductosEmprendedorItem({
    required this.id,
    required this.emprendedor,
    required this.tipoProyecto,
    required this.emprendimiento,
    required this.producto,
    required this.descripcion,
    required this.unidadMedida,
    required this.costo,
    required this.usuario,
    required this.fechaRegistro,
  });
}