
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class EmprendedorInvoice {
  final InvoiceInfo info;
  final List<EmprendedorItem> items;

  const EmprendedorInvoice({
    required this.info,
    required this.items,
  });
}

class EmprendedorItem {
  final int id;
  final String nombre;
  final String apellidos;
  final String curp;
  final String integrantesFamilia;
  final String comunidad;
  final String telefono;
  final String emprendimiento;
  final String comentarios;
  final String usuario;
  final DateTime fechaRegistro;

  const EmprendedorItem({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.curp,
    required this.integrantesFamilia,
    required this.comunidad,
    required this.telefono,
    required this.emprendimiento,
    required this.comentarios,
    required this.usuario,
    required this.fechaRegistro,
  });
}