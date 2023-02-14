import 'package:taller_alex_app_asesor/database/entitys.dart';

class SaveInstruccionProductoVendido {
    final String instruccion;
    final String? instruccionAdicional;
    final ProdVendidos prodVendido;

    SaveInstruccionProductoVendido({
      required this.instruccion,
      this.instruccionAdicional,
      required this.prodVendido,
    });

}