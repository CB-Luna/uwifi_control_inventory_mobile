import 'package:bizpro_app/modelsEmiWeb/temporals/get_emp_externo_emi_web_temp.dart';

class UsuarioProyectosTemporal {
    final Promotor usuarioTemp;
    List<Payload> emprendimientosTemp;
    String? pathImagenPerfil;

    UsuarioProyectosTemporal({
      required this.usuarioTemp,
      required this.emprendimientosTemp,
      this.pathImagenPerfil,
    });

}
