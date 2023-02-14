import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_imagenes_local.dart';

class SaveInstruccionImagenTemporal {
    final String instruccion;
    final String? instruccionAdicional;
    final SaveImagenesLocal imagenLocal;

    SaveInstruccionImagenTemporal({
      required this.instruccion,
      this.instruccionAdicional,
      required this.imagenLocal,
    });

}