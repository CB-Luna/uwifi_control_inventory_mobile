import 'package:bizpro_app/models/get_familia_productos.dart';
import 'package:bizpro_app/models/get_fases_emp.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/models/get_clasificacion_emp.dart';
import 'package:bizpro_app/models/get_comunidades.dart';
import 'package:bizpro_app/models/get_familia_inversion.dart';
import 'package:bizpro_app/models/get_ambito_consultoria.dart';
import 'package:bizpro_app/models/get_area_circulo.dart';
import 'package:bizpro_app/models/get_catalogos_proyectos.dart';
import 'package:bizpro_app/models/get_roles.dart';
import 'package:bizpro_app/models/get_unidades_medida.dart';
import 'package:bizpro_app/models/get_estados.dart';
import 'package:bizpro_app/models/get_municipios.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:http/http.dart' as http;

import '../objectbox.g.dart';

class CatalogProvider extends ChangeNotifier {

  
  bool procesoterminado = false;
  bool procesocargando = false;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    notifyListeners();
  }

  Future<void> getCatalogos() async {
    await getEstados();
    await getMunicipios();
    await getComunidades();
    await getClasificacionesEmp();
    await getCatalogosProyectos();
    await getFamiliaInversion();
    await getFamiliaProd();
    await getUnidadMedida();
    await getAmbitoConsultoria();
    await getFasesEmp();
    await getAreaCirculo();
    print("Proceso terminado");
    procesoterminado = true;
    procesocargando = false;
    notifyListeners();
    
  }

  Future<void> getEstados() async {
    if (dataBase.estadosBox.isEmpty()) {
      final records = await client.records.
      getFullList('estados', batch: 200, sort: '+nombre_estado');
      final List<GetEstados> listEstados = [];
      for (var element in records) {
        listEstados.add(getEstadosFromMap(element.toString()));
      }
      
      listEstados.sort((a, b) => removeDiacritics(a.nombreEstado).compareTo(removeDiacritics(b.nombreEstado)));

      print("*****Informacion estados*****");
      for (var i = 0; i < listEstados.length; i++) {
        if (listEstados[i].id.isNotEmpty) {
        final nuevoEstado = Estados(
        nombre: listEstados[i].nombreEstado,
        activo: listEstados[i].activo,
        idDBR: listEstados[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoEstado.statusSync.target = nuevoSync;
        dataBase.estadosBox.put(nuevoEstado);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Estado agregado exitosamente');
        final record = await client.records.update('estados', listEstados[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Estado actualizado en el backend exitosamente');
          }

        }
      }
      notifyListeners();
      }
  }

  Future<void> getMunicipios() async {
    if (dataBase.municipiosBox.isEmpty()) {
      final records = await client.records.
      getFullList('municipios', batch: 200, sort: '+nombre_municipio');
      final List<GetMunicipios> listMunicipios = [];
      for (var element in records) {
        listMunicipios.add(getMunicipiosFromMap(element.toString()));
      }

      listMunicipios.sort((a, b) => removeDiacritics(a.nombreMunicipio).compareTo(removeDiacritics(b.nombreMunicipio)));

      print("*****Informacion municipios****");
      for (var i = 0; i < listMunicipios.length; i++) {
        if (listMunicipios[i].id.isNotEmpty) {
        final nuevoMunicipio = Municipios(
        nombre: listMunicipios[i].nombreMunicipio,
        activo: listMunicipios[i].activo,
        idDBR: listMunicipios[i].id,
        );
        final estado = dataBase.estadosBox.query(Estados_.idDBR.equals(listMunicipios[i].idEstadoFk)).build().findUnique();
        if (estado != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevoMunicipio.statusSync.target = nuevoSync;
          nuevoMunicipio.estados.target = estado;
          dataBase.municipiosBox.put(nuevoMunicipio);
          print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
          print('Municipio agregado exitosamente');
          final record = await client.records.update('municipios', listMunicipios[i].id, body: {
            'id_status_sync_fk': 'HoI36PzYw1wtbO1',
          });
          if (record.id.isNotEmpty) {
            print('Municipio actualizado en el backend exitosamente');
          }
          }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getComunidades() async {
    if (dataBase.comunidadesBox.isEmpty()) {
      final records = await client.records.
      getFullList('comunidades', batch: 200, sort: '+nombre_comunidad');

      final List<GetComunidades> listComunidades = [];
      for (var element in records) {
        listComunidades.add(getComunidadesFromMap(element.toString()));
      }

      listComunidades.sort((a, b) => removeDiacritics(a.nombreComunidad).compareTo(removeDiacritics(b.nombreComunidad)));

      print("****Informacion comunidades****");
      for (var i = 0; i < records.length; i++) {
        if (listComunidades[i].id.isNotEmpty) {
        final nuevaComunidad = Comunidades(
        nombre: listComunidades[i].nombreComunidad,
        activo: listComunidades[i].activo,
        idDBR: listComunidades[i].id,
        );
        final municipio = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listComunidades[i].idMunicipioFk)).build().findUnique();
        if (municipio != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevaComunidad.statusSync.target = nuevoSync;
          nuevaComunidad.municipios.target = municipio;
          dataBase.comunidadesBox.put(nuevaComunidad);
          print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
          print('Comunidad agregada exitosamente');
          final record = await client.records.update('comunidades', listComunidades[i].id, body: {
            'id_status_sync_fk': 'HoI36PzYw1wtbO1',
          });
          if (record.id.isNotEmpty) {
            print('Comunidad actualizada en el backend exitosamente');
          }
          }
        }
      }
      notifyListeners();
      }
    }
  Future<void> getRoles() async {
    if (dataBase.rolesBox.isEmpty()) {
      final records = await client.records.
      getFullList('roles', batch: 200, sort: '+rol');
      final List<GetRoles> listRoles = [];
      for (var element in records) {
        listRoles.add(getRolesFromMap(element.toString()));
      }
      
      listRoles.sort((a, b) => removeDiacritics(a.rol).compareTo(removeDiacritics(b.rol)));

      print("*****Informacion roles*****");
      for (var i = 0; i < listRoles.length; i++) {
        if (listRoles[i].id.isNotEmpty) {
        final nuevoRol = Roles(
        rol: listRoles[i].rol,
        idDBR: listRoles[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoRol.statusSync.target = nuevoSync;
        dataBase.rolesBox.put(nuevoRol);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Rol agregado exitosamente');
        final record = await client.records.update('roles', listRoles[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Rol actualizado en el backend exitosamente');
          }

        }
      }
      notifyListeners();
      }
  }

  Future<void> getClasificacionesEmp() async {
    if (dataBase.clasificacionesEmpBox.isEmpty()) {
      final records = await client.records.
        getFullList('clasificaciones_emp', batch: 200, sort: '+clasificacion');
      final List<GetClasificacionEmp> listClasificacionEmp = [];
      for (var element in records) {
        listClasificacionEmp.add(getClasificacionEmpFromMap(element.toString()));
      }

      listClasificacionEmp.sort((a, b) => removeDiacritics(a.clasificacion).compareTo(removeDiacritics(b.clasificacion)));

      print("****Informacion clasificaciones_emp****");
      for (var i = 0; i < listClasificacionEmp.length; i++) {
        if (listClasificacionEmp[i].id.isNotEmpty) {
        final nuevaClasificacionEmp = ClasificacionEmp(
        clasificacion: listClasificacionEmp[i].clasificacion,
        activo: listClasificacionEmp[i].activo,
        idDBR: listClasificacionEmp[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaClasificacionEmp.statusSync.target = nuevoSync;
        dataBase.clasificacionesEmpBox.put(nuevaClasificacionEmp);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Clasificacion Emp agregado exitosamente');
        final record = await client.records.update('clasificaciones_emp', listClasificacionEmp[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Clasificacion Emp actualizado en el backend exitosamente');
          }
        }
      }
      notifyListeners();
    }    
  }

  Future<void> getFamiliaInversion() async {
    if (dataBase.familiaInversionBox.isEmpty()) {
      final records = await client.records.
      getFullList('familia_inversion', batch: 200, sort: '+nombre_familia_inver');
      final List<GetFamiliaInversion> listFamiliaInversion = [];
      for (var element in records) {
        listFamiliaInversion.add(getFamiliaInversionFromMap(element.toString()));
      }

      listFamiliaInversion.sort((a, b) => removeDiacritics(a.nombreFamiliaInver).compareTo(removeDiacritics(b.nombreFamiliaInver)));

      print("****Informacion familia_inversion****");
      for (var i = 0; i < listFamiliaInversion.length; i++) {
        if (listFamiliaInversion[i].id.isNotEmpty) {
        final nuevaFamiliaInversion = FamiliaInversion(
        nombre: listFamiliaInversion[i].nombreFamiliaInver,
        activo: listFamiliaInversion[i].activo,
        idDBR: listFamiliaInversion[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaFamiliaInversion.statusSync.target = nuevoSync;
        dataBase.familiaInversionBox.put(nuevaFamiliaInversion);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Familia Inversion agregada exitosamente');
        final record = await client.records.update('familia_inversion', listFamiliaInversion[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Familia Inversion actualizada en el backend exitosamente');
          }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getFamiliaProd() async {
    if (dataBase.familiaProductosBox.isEmpty()) {
      final records = await client.records.
      getFullList('familia_prod', batch: 200, sort: '+nombre_tipo_prod');
      final List<GetFamiliaProductos> listFamiliaProductos = [];
      for (var element in records) {
        listFamiliaProductos.add(getFamiliaProductosFromMap(element.toString()));
      }

      listFamiliaProductos.sort((a, b) => removeDiacritics(a.nombreTipoProd).compareTo(removeDiacritics(b.nombreTipoProd)));

      print("****Informacion familia_productos****");
      for (var i = 0; i < listFamiliaProductos.length; i++) {
        if (listFamiliaProductos[i].id.isNotEmpty) {
        final nuevaFamiliaProductos = FamiliaProd(
        nombre: listFamiliaProductos[i].nombreTipoProd,
        activo: listFamiliaProductos[i].activo,
        idDBR: listFamiliaProductos[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaFamiliaProductos.statusSync.target = nuevoSync;
        dataBase.familiaProductosBox.put(nuevaFamiliaProductos);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Familia Productos agregada exitosamente');
        // final record = await client.records.update('familia_prod', listFamiliaProductos[i].id, body: {
        //   'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        // });
        // if (record.id.isNotEmpty) {
        //     print('Familia productos actualizada en el backend exitosamente');
        //   }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getUnidadMedida() async {
    if (dataBase.unidadesMedidaBox.isEmpty()) {
      final records = await client.records.
      getFullList('und_medida', batch: 200, sort: '+unidad_medida');
      final List<GetUnidadesMedida> listUnidadMedida = [];
      for (var element in records) {
        listUnidadMedida.add(getUnidadesMedidaFromMap(element.toString()));
      }

      listUnidadMedida.sort((a, b) => removeDiacritics(a.unidadMedida).compareTo(removeDiacritics(b.unidadMedida)));

      print("****Informacion und_medida****");
      for (var i = 0; i < listUnidadMedida.length; i++) {
        if (listUnidadMedida[i].id.isNotEmpty) {
        final nuevaUnidadMedida = UnidadMedida(
        unidadMedida: listUnidadMedida[i].unidadMedida,
        activo: listUnidadMedida[i].activo,
        idDBR: listUnidadMedida[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaUnidadMedida.statusSync.target = nuevoSync;
        dataBase.unidadesMedidaBox.put(nuevaUnidadMedida);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Unidad Medida agregada exitosamente');
        final record = await client.records.update('und_medida', listUnidadMedida[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Unidad Medida actualizada en el backend exitosamente');
          }
        }
      }
      notifyListeners();
      }
  }


  Future<void> getCatalogosProyectos() async {
    if (dataBase.catalogoProyectoBox.isEmpty()) {
      final records = await client.records.
      getFullList('cat_proyecto', batch: 200, sort: '+nombre_proyecto');
      final List<GetCatalogoProyectos> listCatalogoProyecto = [];
      for (var element in records) {
        listCatalogoProyecto.add(getCatalogoProyectosFromMap(element.toString()));
      }

      listCatalogoProyecto.sort((a, b) => removeDiacritics(a.nombreProyecto).compareTo(removeDiacritics(b.nombreProyecto)));
      print("****Informacion catalogos proyectos****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listCatalogoProyecto[i].id.isNotEmpty) {
        final nuevoCatalogoProyecto = CatalogoProyecto(
        nombre: listCatalogoProyecto[i].nombreProyecto,
        idDBR: listCatalogoProyecto[i].id,
        );
        final clasificacionEmp = dataBase.clasificacionesEmpBox.query(ClasificacionEmp_.idDBR.equals(listCatalogoProyecto[i].idClasificacionEmprendimiento)).build().findUnique();
        if (clasificacionEmp != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevoCatalogoProyecto.statusSync.target = nuevoSync;
          nuevoCatalogoProyecto.clasificacionEmp.target = clasificacionEmp;
          dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
          print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
          print('Catalogo Proyecto agregado exitosamente');
          final record = await client.records.update('cat_proyecto', listCatalogoProyecto[i].id, body: {
            'id_status_sync_fk': 'HoI36PzYw1wtbO1',
          });
          if (record.id.isNotEmpty) {
            print('Catalogo Proyecto actualizado en el backend exitosamente');
          }
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getAmbitoConsultoria() async {
    if (dataBase.ambitoConsultoriaBox.isEmpty()) {
      final records = await client.records.
      getFullList('ambito_consultoria', batch: 200, sort: '+nombre_ambito');
      final List<GetAmbitoConsultoria> listAmbitoConsultoria = [];
      for (var element in records) {
        listAmbitoConsultoria.add(getAmbitoConsultoriaFromMap(element.toString()));
      }
      listAmbitoConsultoria.sort((a, b) => removeDiacritics(a.nombreAmbito).compareTo(removeDiacritics(b.nombreAmbito)));
      print("****Informacion ambito consultoria****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listAmbitoConsultoria[i].id.isNotEmpty) {
        final nuevoAmbitoConsultoria = AmbitoConsultoria(
        nombreAmbito: listAmbitoConsultoria[i].nombreAmbito,
        idDBR: listAmbitoConsultoria[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoAmbitoConsultoria.statusSync.target = nuevoSync;
        dataBase.ambitoConsultoriaBox.put(nuevoAmbitoConsultoria);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Ambito Consultoria agregado exitosamente');
        final record = await client.records.update('ambito_consultoria', listAmbitoConsultoria[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Ambito Consultoria actualizado en el backend exitosamente');
          }
        }
      }
      notifyListeners();
    }
    }

  Future<void> getAreaCirculo() async {
    if (dataBase.areaCirculoBox.isEmpty()) {
      final records = await client.records.
      getFullList('area_circulo', batch: 200, sort: '+nombre_area');
      final List<GetAreaCirculo> listAreaCirculo = [];
      for (var element in records) {
        listAreaCirculo.add(getAreaCirculoFromMap(element.toString()));
      }
      listAreaCirculo.sort((a, b) => removeDiacritics(a.nombreArea).compareTo(removeDiacritics(b.nombreArea)));
      print("****Informacion area circulo****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listAreaCirculo[i].id.isNotEmpty) {
        final nuevaAreaCirculo = AreaCirculo(
        nombreArea: listAreaCirculo[i].nombreArea,
        idDBR: listAreaCirculo[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaAreaCirculo.statusSync.target = nuevoSync;
        dataBase.areaCirculoBox.put(nuevaAreaCirculo);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Area circulo agregado exitosamente');
        final record = await client.records.update('area_circulo', listAreaCirculo[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Area circulo actualizado en el backend exitosamente');
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getFasesEmp() async {
    if (dataBase.fasesEmpBox.isEmpty()) {
      final records = await client.records.
      getFullList('fases_emp', batch: 200, sort: '+fase');
      final List<GetFasesEmp> listFasesEmp = [];
      for (var element in records) {
        listFasesEmp.add(getFasesEmpFromMap(element.toString()));
      }
      listFasesEmp.sort((a, b) => removeDiacritics(a.fase).compareTo(removeDiacritics(b.fase)));
      print("****Informacion fase emp****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listFasesEmp[i].id.isNotEmpty) {
        final nuevaFaseEmp = FasesEmp(
        fase: listFasesEmp[i].fase,
        idDBR: listFasesEmp[i].id,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaFaseEmp.statusSync.target = nuevoSync;
        dataBase.fasesEmpBox.put(nuevaFaseEmp);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Fase emp agregada exitosamente');
        }
      }
      notifyListeners();
    }
  }

  

}
