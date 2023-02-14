
import 'package:taller_alex_app_asesor/screens/widgets/pdf/models/invoice_info.dart';

class JornadasInvoice {
  final InvoiceInfo info;
  final List<JornadasItem> items;

  const JornadasInvoice({
    required this.info,
    required this.items,
  });
}

class JornadasItem {
  final int id;
  final String emprendedor;
  final String comunidad;
  final String emprendimiento;
  final String jornada;
  final String tareaRegistrada;
  final DateTime fechaRevision;
  final String completada;
  final String usuario;
  final DateTime fechaRegistro;

  const JornadasItem({
    required this.id,
    required this.emprendedor,
    required this.comunidad,
    required this.emprendimiento,
    required this.jornada,
    required this.tareaRegistrada,
    required this.fechaRevision,
    required this.completada,
    required this.usuario,
    required this.fechaRegistro,
  });
}