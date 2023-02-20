
import 'package:taller_alex_app_asesor/database/entitys.dart';

class VehiculoTemporal {
    final String marca;
    final String modelo;
    final String anio;
    final String vin;
    final String placas;
    final String kilometraje;
    final String gasolina;
    final Imagenes imagen;

    VehiculoTemporal({
      required this.marca,
      required this.modelo,
      required this.anio,
      required this.vin,
      required this.placas,
      required this.kilometraje,
      required this.gasolina,
      required this.imagen,
    });

}
