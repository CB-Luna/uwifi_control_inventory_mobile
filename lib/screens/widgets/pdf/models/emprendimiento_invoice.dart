
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class EmprendimientoInvoice {
  final InvoiceInfo info;
  final List<EmprendimientoItem> items;

  const EmprendimientoInvoice({
    required this.info,
    required this.items,
  });
}

class EmprendimientoItem {
  final String emprendedor;
  final String emprendimiento;
  final String comunidad;
  final String tipoProyecto;
  final String fase;

  const EmprendimientoItem({
    required this.emprendedor,
    required this.emprendimiento,
    required this.comunidad,
    required this.tipoProyecto,
    required this.fase,
  });
}