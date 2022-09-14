
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class ConsultoriasInvoice {
  final InvoiceInfo info;
  final List<ConsultoriasItem> items;

  const ConsultoriasInvoice({
    required this.info,
    required this.items,
  });
}

class ConsultoriasItem {
  final int id;
  final String emprendedor;
  final String ambito;
  final String areaCirculo;
  final String avanceObservado;
  final String porcentajeAvance;
  final String siguientesPasos;
  final DateTime fechaRevision;
  final String usuario;
  final DateTime fechaRegistro;

  const ConsultoriasItem({
    required this.id,
    required this.emprendedor,
    required this.ambito,
    required this.areaCirculo,
    required this.avanceObservado,
    required this.porcentajeAvance,
    required this.siguientesPasos,
    required this.fechaRevision,
    required this.usuario,
    required this.fechaRegistro,
  });
}