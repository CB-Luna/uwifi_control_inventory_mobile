
import 'package:taller_alex_app_asesor/screens/widgets/pdf/models/invoice_info.dart';

class VentasInvoice {
  final InvoiceInfo info;
  final List<VentasItem> items;

  const VentasInvoice({
    required this.info,
    required this.items,
  });
}

class VentasItem {
  final int id;
  final String emprendedor;
  final DateTime fechaInicio;
  final DateTime fechaTermino;
  final String producto;
  final String unidadMedida;
  final String cantidadVendida;
  final String costoUnitario;
  final String precioVenta;
  final String total;
  final String usuario;
  final DateTime fechaRegistro;

  const VentasItem({
    required this.id,
    required this.emprendedor,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.producto,
    required this.unidadMedida,
    required this.cantidadVendida,
    required this.costoUnitario,
    required this.precioVenta,
    required this.total,
    required this.usuario,
    required this.fechaRegistro,
  });
}