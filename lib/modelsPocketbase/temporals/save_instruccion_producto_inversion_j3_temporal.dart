import 'package:bizpro_app/database/entitys.dart';

class SaveInstruccionProductoInversionJ3Temporal {
    final String instruccion;
    final String? instruccionAdicional;
    final ProdSolicitado prodSolicitado;

    SaveInstruccionProductoInversionJ3Temporal({
      required this.instruccion,
      this.instruccionAdicional,
      required this.prodSolicitado,
    });

}