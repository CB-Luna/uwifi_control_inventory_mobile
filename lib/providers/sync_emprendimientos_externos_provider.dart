import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_emprendimeinto_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_emp_externo_pocketbase_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';

class EmpExternosPocketbaseProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  List<bool> banderasExitoSync = [];
  bool exitoso = true;
  bool usuarioExit = false;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    // notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    // notifyListeners();
  }

  void procesoExitoso(bool boleano) {
    procesoexitoso = boleano;
    // notifyListeners();
  }

  Future<bool> getProyectosExternos(List<String> idEmprendimientos, Usuarios usuario) async {
    for (var elementId in idEmprendimientos) {
      print("Nombre emp: ${elementId}");
      //Se recupera toda la colección de datos emprendimientos en Pocketbase
      var url = Uri.parse("$baseUrl/api/collections/emprendimientos/records?filter=(id='$elementId')&expand=id_emprendedor_fk.id_comunidad_fk,id_fase_emp_fk,id_nombre_proyecto_fk");
      final headers = ({
          "Content-Type": "application/json",
        });
      var response = await get(
        url,
        headers: headers
      );
      var basicEmprendimiento = getBasicEmprendimientoPocketbaseFromMap(response.body);

      if (response.statusCode == 200) {
        print("STATUS 200");
        final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(basicEmprendimiento.items[0].expand.idFaseEmpFk.fase)).build().findFirst();
        final comunidad = dataBase.comunidadesBox.query(Comunidades_.nombre.equals(basicEmprendimiento.items[0].expand.idEmprendedorFk.expand.idComunidadFk.nombreComunidad)).build().findFirst();
        final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.nombre.equals(basicEmprendimiento.items[0].expand.idNombreProyectoFk?.nombreProyecto ?? "")).build().findFirst();
        final nuevoSyncEmprendimiento = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevoSyncEmprendedor = StatusSync(); //Se crea el objeto estatus por dedault //M__
        if (faseEmp != null && comunidad != null) {
          final nuevoEmprendimiento = Emprendimientos(
            faseActual: faseEmp.fase, 
            faseAnterior: faseEmp.fase, 
            nombre: basicEmprendimiento.items[0].nombreEmprendimiento, 
            descripcion: basicEmprendimiento.items[0].descripcion,
            activo: basicEmprendimiento.items[0].activo,
            archivado: basicEmprendimiento.items[0].archivado,
          );
          nuevoEmprendimiento.faseEmp.add(faseEmp);
          nuevoEmprendimiento.statusSync.target = nuevoSyncEmprendimiento;
          if (catalogoProyecto != null) {
            nuevoEmprendimiento.catalogoProyecto.target = catalogoProyecto;
          }
          final nuevoEmprendedor = Emprendedores(
            nombre: basicEmprendimiento.items[0].expand.idEmprendedorFk.nombreEmprendedor, 
            apellidos: basicEmprendimiento.items[0].expand.idEmprendedorFk.apellidosEmp,
            nacimiento: DateTime.parse("2000-02-27 13:27:00"), 
            curp: basicEmprendimiento.items[0].expand.idEmprendedorFk.curp, 
            integrantesFamilia: basicEmprendimiento.items[0].expand.idEmprendedorFk.integrantesFamilia.toString(), 
            telefono: basicEmprendimiento.items[0].expand.idEmprendedorFk.telefono, 
            comentarios: basicEmprendimiento.items[0].expand.idEmprendedorFk.comentarios ?? '', 
          );
          final nuevaImagen = Imagenes(imagenes: "");
          nuevaImagen.emprendedor.target = nuevoEmprendedor;
          nuevoEmprendedor.comunidad.target = comunidad;
          nuevoEmprendedor.imagen.target = nuevaImagen;
          nuevoEmprendedor.statusSync.target = nuevoSyncEmprendedor;
          nuevoEmprendedor.emprendimiento.target = nuevoEmprendimiento;
          nuevoEmprendimiento.emprendedor.target = nuevoEmprendedor;
          nuevoEmprendimiento.usuario.target = usuario;
          dataBase.emprendimientosBox.put(nuevoEmprendimiento);
          usuario.emprendimientos.add(nuevoEmprendimiento);
          dataBase.usuariosBox.put(usuario);
          banderasExitoSync.add(true);
        } else {
          banderasExitoSync.add(false);
          continue;
        }
      } else {
        banderasExitoSync.add(false);
        continue;
      }
    }
    for (var element in banderasExitoSync) {
      //Aplicamos una operación and para validar que no haya habido un catálogo con False
      exitoso = exitoso && element;
    }
    //Verificamos que no haya habido errores al sincronizar con las banderas
    if (exitoso) {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      banderasExitoSync.clear();
      notifyListeners();
      return exitoso;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExitoSync.clear();
      notifyListeners();
      return exitoso;
    }
  }

//Función para recuperar los emprendimientos externos de Pocketbase
  Future<List<UsuarioProyectosTemporal>?> getUsuariosProyectosPocketbase() async {
    final GetEmpExternoPocketbaseTemp listEmpExternosPocketbaseTemp;
    List<UsuarioProyectosTemporal> listUsuariosProyectosTemp = [];
    try {
      //Se recupera toda la colección de usuarios en Pocketbase
      var url = Uri.parse("$baseUrl/api/collections/emprendimientos/records?perPage=200&expand=id_emprendedor_fk,id_promotor_fk");
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
          var indexItemUpdated = listUsuariosProyectosTemp.indexWhere((elementUsuario) => elementUsuario.usuarioTemp.id == elementEmprendimientoEmp.expand.idPromotorFk.id);
          if (indexItemUpdated != -1) {
            listUsuariosProyectosTemp[indexItemUpdated].emprendimientosTemp.add(elementEmprendimientoEmp);
          } else {
            final newUsuarioProyectoTemporal = 
            UsuarioProyectosTemporal(
              usuarioTemp: elementEmprendimientoEmp.expand.idPromotorFk, 
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
