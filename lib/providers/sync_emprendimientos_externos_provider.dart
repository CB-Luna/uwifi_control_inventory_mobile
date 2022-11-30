import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_emprendimeinto_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_jornada_pocketbase.dart';
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
    for (var elementEmpId in idEmprendimientos) {
      print("Nombre emp: ${elementEmpId}");
      //Se recupera toda la colección de datos emprendimientos en Pocketbase
      var url = Uri.parse("$baseUrl/api/collections/emprendimientos/records?filter=(id='$elementEmpId')&expand=id_emprendedor_fk.id_comunidad_fk,id_fase_emp_fk,id_nombre_proyecto_fk");
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
            idDBR: basicEmprendimiento.items[0].id,
            idEmiWeb: basicEmprendimiento.items[0].idEmiWeb,
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
            idDBR: basicEmprendimiento.items[0].expand.idEmprendedorFk.id,
            idEmiWeb: basicEmprendimiento.items[0].expand.idEmprendedorFk.idEmiWeb,
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
          //Se recupera colección de datos jornadas en Pocketbase
          var urlJornadas = Uri.parse("$baseUrl/api/collections/jornadas/records?filter=(id_emprendimiento_fk='$elementEmpId')&expand=id_tarea_fk.id_imagenes_fk");
          final headers = ({
              "Content-Type": "application/json",
            });
          var responseJornada = await get(
            urlJornadas,
            headers: headers
          );
          var basicJornadas = getBasicJornadaPocketbaseFromMap(responseJornada.body);
          if (responseJornada.statusCode == 200) {
            print("éxito en recuperar jornadas");
            for (var elementJornada in basicJornadas.items) {
              if (elementJornada.numJornada == 1) {
                final nuevaJornada1 = Jornadas(
                  numJornada: elementJornada.numJornada.toString(),
                  fechaRevision: elementJornada.proximaVisita!,
                  fechaRegistro: elementJornada.created,
                  completada: elementJornada.completada,
                  idDBR: elementJornada.id,
                  idEmiWeb: elementJornada.idEmiWeb,
                );
                final nuevaTarea1 = Tareas(
                  tarea: elementJornada.expand.idTareaFk.tarea,
                  descripcion: "Creación Jornada 1",
                  fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
                  fechaRegistro: elementJornada.expand.idTareaFk.created,
                  idDBR: elementJornada.expand.idTareaFk.id,
                  idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
                );
                nuevaJornada1.tarea.target = nuevaTarea1;
                nuevaJornada1.emprendimiento.target = nuevoEmprendimiento;
                nuevaTarea1.jornada.target = nuevaJornada1;
                nuevoEmprendimiento.jornadas.add(nuevaJornada1);
                dataBase.jornadasBox.put(nuevaJornada1);
                dataBase.tareasBox.put(nuevaTarea1);
                dataBase.emprendimientosBox.put(nuevoEmprendimiento);
              }
            }
            banderasExitoSync.add(true);
          } else {
            print("No éxito en recuperar jornadas");
            banderasExitoSync.add(false);
            continue;
          }
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
