import 'package:bizpro_app/modelsPocketbase/temporals/get_emp_externo_pocketbase_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';

class EmpExternosPocketbaseProvider extends ChangeNotifier {

//Función para recuperar los emprendimientos externos de Pocketbase
  Future<List<UsuarioProyectosTemporal>?> getUsuariosProyectosPocketbase() async {
    final GetEmpExternoPocketbaseTemp listEmpExternosPocketbaseTemp;
    List<UsuarioProyectosTemporal> listUsuariosProyectosTemp = [];
    try {
      //Se recupera toda la colección de usuarios en Pocketbase
      var url = Uri.parse("$baseUrl/api/collections/emprendimientos/records?perPage=200&expand=id_emprendedor_fk.id_usuario_registra_fk");
      final headers = ({
          "Content-Type": "application/json",
        });
      var response = await get(
        url,
        headers: headers
      );
      listEmpExternosPocketbaseTemp = getEmpExternoPocketbaseTempFromMap(response.body);

      if (response.statusCode == 200) {
        for (var elementEmprendimientoEmp in listEmpExternosPocketbaseTemp.items.toList()) {
          var indexItemUpdated = listUsuariosProyectosTemp.indexWhere((elementUsuario) => elementUsuario.usuarioTemp.id == elementEmprendimientoEmp.expand.idEmprendedorFk.expand.idUsuarioRegistraFk.id);
          if (indexItemUpdated != -1) {
            listUsuariosProyectosTemp[indexItemUpdated].emprendimientosTemp.add(elementEmprendimientoEmp);
          } else {
            final newUsuarioProyectoTemporal = 
            UsuarioProyectosTemporal(
              usuarioTemp: elementEmprendimientoEmp.expand.idEmprendedorFk.expand.idUsuarioRegistraFk, 
              emprendimientosTemp: [elementEmprendimientoEmp]
            );
            listUsuariosProyectosTemp.add(newUsuarioProyectoTemporal);
          }
        }
        return listUsuariosProyectosTemp;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
