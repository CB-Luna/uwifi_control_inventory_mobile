
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class InversionesInvoice {
  final InvoiceInfo info;
  final List<InversionesItem> items;

  const InversionesInvoice({
    required this.info,
    required this.items,
  });
}

class InversionesItem {
  final int id;
  final String emprendedor;
  final String producto;
  final String descripcion;
  final String marcaSugerida;
  final String proveedorSugerido;
  final String tipoEmpaque;
  final String cantidad;
  final String costoEstimado;
  final String porcentajePago;
  final String usuario;
  final DateTime fechaRegistro;

  const InversionesItem({
    required this.id,
    required this.emprendedor,
    required this.producto,
    required this.descripcion,
    required this.marcaSugerida,
    required this.proveedorSugerido,
    required this.tipoEmpaque,
    required this.cantidad,
    required this.costoEstimado,
    required this.porcentajePago,
    required this.usuario,
    required this.fechaRegistro,
  });
}