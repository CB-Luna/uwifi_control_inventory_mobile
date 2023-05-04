import 'package:taller_alex_app_asesor/database/entitys.dart';

class SaveInstruccionProductoVendido {
    final String instruccion;
    final String? instruccionAdicional;

    SaveInstruccionProductoVendido({
      required this.instruccion,
      this.instruccionAdicional,
    });

}