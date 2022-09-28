import 'package:bizpro_app/models/get_catalogos_proyectos.dart';
import 'package:bizpro_app/models/get_clasificacion_emp.dart';
import 'package:bizpro_app/models/get_comunidades.dart';
import 'package:bizpro_app/models/get_familia_productos.dart';
import 'package:bizpro_app/models/get_municipios.dart';
import 'package:bizpro_app/models/get_roles.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/models/get_estados.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:http/http.dart' as http;
import '../objectbox.g.dart';

//Este provider sólo funciona para cuando se agregan o actualizan registros en los catálogos del backend

class CatalogProviderRecover extends ChangeNotifier {

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

  Future<void> getCatalogosAgain() async {
    await getEstadosAgain();
    await getMunicipiosAgain();
    await getComunidadesAgain();
    await getRolesAgain();
    await getClasificacionesEmpAgain();
    await getCatalogosProyectosAgain();
    await getFamiliaProdAgain();
    print("Proceso terminado");
    procesoterminado = true;
    procesocargando = false;
    notifyListeners();
    
  }

  Future<void> getEstadosAgain() async {
    if (!dataBase.estadosBox.isEmpty()) {
      final records = await client.records.
      getFullList('estados', batch: 200, sort: '+nombre_estado');
      final List<GetEstados> listEstados = [];
      for (var element in records) {
        listEstados.add(getEstadosFromMap(element.toString()));
      }
      print("*****Informacion estados*****");
      for (var i = 0; i < listEstados.length; i++) {
        final estadoExistente = dataBase.estadosBox.query(Estados_.idDBR.equals(listEstados[i].id)).build().findUnique();
        if (estadoExistente == null) {
          if (listEstados[i].id.isNotEmpty) {
            final nuevoEstado = Estados(
            nombre: listEstados[i].nombreEstado,
            activo: listEstados[i].activo,
            idDBR: listEstados[i].id,
            );
            dataBase.estadosBox.put(nuevoEstado);
            print('Estado agregado exitosamente');
          }
        } else {
          if (estadoExistente.fechaRegistro != listEstados[i].updated) {
            estadoExistente.nombre = listEstados[i].nombreEstado;
            estadoExistente.activo = listEstados[i].activo;
            estadoExistente.fechaRegistro = listEstados[i].updated!;
            dataBase.estadosBox.put(estadoExistente);
          }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getMunicipiosAgain() async {
    if (!dataBase.municipiosBox.isEmpty()) {
      final records = await client.records.
      getFullList('municipios', batch: 200, sort: '+nombre_municipio');
      final List<GetMunicipios> listMunicipios = [];
      for (var element in records) {
        listMunicipios.add(getMunicipiosFromMap(element.toString()));
      }

      print("*****Informacion municipios****");
      for (var i = 0; i < listMunicipios.length; i++) {
        final estado = dataBase.estadosBox.query(Estados_.idDBR.equals(listMunicipios[i].idEstadoFk)).build().findUnique();
        final municipioExistente = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listMunicipios[i].id)).build().findUnique();
        if (municipioExistente == null) {
        final nuevoMunicipio = Municipios(
        nombre: listMunicipios[i].nombreMunicipio,
        activo: listMunicipios[i].activo,
        idDBR: listMunicipios[i].id,
        );
        if (estado != null) {
          nuevoMunicipio.estados.target = estado;
          dataBase.municipiosBox.put(nuevoMunicipio);
          print('Municipio agregado exitosamente');
          }
        } else {
          if (municipioExistente.fechaRegistro != listMunicipios[i].updated && estado != null) {
            municipioExistente.nombre = listMunicipios[i].nombreMunicipio;
            municipioExistente.activo = listMunicipios[i].activo;
            municipioExistente.estados.target = estado;
            municipioExistente.fechaRegistro = listMunicipios[i].updated!;
            dataBase.municipiosBox.put(municipioExistente);
          }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getComunidadesAgain() async {
    if (!dataBase.comunidadesBox.isEmpty()) {
      final records = await client.records.
      getFullList('comunidades', batch: 200, sort: '+nombre_comunidad');

      final List<GetComunidades> listComunidades = [];
      for (var element in records) {
        listComunidades.add(getComunidadesFromMap(element.toString()));
      }

      print("****Informacion comunidades****");
      for (var i = 0; i < records.length; i++) {
        final municipio = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listComunidades[i].idMunicipioFk)).build().findUnique();
        final comunidadExistente = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listComunidades[i].id)).build().findUnique();
        if (comunidadExistente == null) {
        final nuevaComunidad = Comunidades(
        nombre: listComunidades[i].nombreComunidad,
        activo: listComunidades[i].activo,
        idDBR: listComunidades[i].id,
        );
        if (municipio != null) {
          nuevaComunidad.municipios.target = municipio;
          dataBase.comunidadesBox.put(nuevaComunidad);
          print('Comunidad agregada exitosamente');
          } 
        } else {
          if (comunidadExistente.fechaRegistro != listComunidades[i].updated && municipio != null) {
            comunidadExistente.nombre = listComunidades[i].nombreComunidad;
            comunidadExistente.activo = listComunidades[i].activo;
            comunidadExistente.municipios.target = municipio;
            comunidadExistente.fechaRegistro = listComunidades[i].updated!;
            dataBase.comunidadesBox.put(comunidadExistente);
          }
        }
      }
      notifyListeners();
      }
    }

  Future<void> getRolesAgain() async {
    if (!dataBase.rolesBox.isEmpty()) {
      final records = await client.records.
      getFullList('roles', batch: 200, sort: '+rol');
      final List<GetRoles> listRoles = [];
      for (var element in records) {
        listRoles.add(getRolesFromMap(element.toString()));
      }

      print("*****Informacion roles*****");
      for (var i = 0; i < listRoles.length; i++) {
        final rolExistente = dataBase.rolesBox.query(Roles_.idDBR.equals(listRoles[i].id)).build().findUnique();
        if (rolExistente == null) {
          final nuevoRol = Roles(
          rol: listRoles[i].rol,
          idDBR: listRoles[i].id,
          );
          dataBase.rolesBox.put(nuevoRol);
          print('Rol agregado exitosamente');
        } else {
          if (rolExistente.fechaRegistro != listRoles[i].updated) {
            rolExistente.rol = listRoles[i].rol;
            rolExistente.fechaRegistro = listRoles[i].updated!;
            dataBase. rolesBox.put(rolExistente);
          }
        }
      }
      notifyListeners();
      }
  }

  Future<void> getClasificacionesEmpAgain() async {
    if (!dataBase.clasificacionesEmpBox.isEmpty()) {
      final records = await client.records.
        getFullList('clasificaciones_emp', batch: 200, sort: '+clasificacion');
      final List<GetClasificacionEmp> listClasificacionEmp = [];
      for (var element in records) {
        listClasificacionEmp.add(getClasificacionEmpFromMap(element.toString()));
      }

      print("****Informacion clasificaciones_emp****");
      for (var i = 0; i < listClasificacionEmp.length; i++) {
        final clasificacionEmpExistente = dataBase.clasificacionesEmpBox.query(ClasificacionEmp_.idDBR.equals(listClasificacionEmp[i].id)).build().findUnique();
        if (clasificacionEmpExistente == null) {
        final nuevaClasificacionEmp = ClasificacionEmp(
        clasificacion: listClasificacionEmp[i].clasificacion,
        activo: listClasificacionEmp[i].activo,
        idDBR: listClasificacionEmp[i].id,
        );
        dataBase.clasificacionesEmpBox.put(nuevaClasificacionEmp);
        print('Clasificacion Emp agregado exitosamente');
        } else {
          if (clasificacionEmpExistente.fechaRegistro != listClasificacionEmp[i].updated) {
            clasificacionEmpExistente.clasificacion = listClasificacionEmp[i].clasificacion;
            clasificacionEmpExistente.activo = listClasificacionEmp[i].activo;
            clasificacionEmpExistente.fechaRegistro = listClasificacionEmp[i].updated!;
            dataBase.clasificacionesEmpBox.put(clasificacionEmpExistente);
          }
        }
      }
      notifyListeners();
    }    
  }

  Future<void> getCatalogosProyectosAgain() async {
    if (!dataBase.catalogoProyectoBox.isEmpty()) {
      final records = await client.records.
      getFullList('cat_proyecto', batch: 200, sort: '+nombre_proyecto');
      final List<GetCatalogoProyectos> listCatalogoProyecto = [];
      for (var element in records) {
        listCatalogoProyecto.add(getCatalogoProyectosFromMap(element.toString()));
      }

      print("****Informacion catalogos proyectos****");
      for (var i = 0; i < records.length; i++) {
        final clasificacionEmp = dataBase.clasificacionesEmpBox.query(ClasificacionEmp_.idDBR.equals(listCatalogoProyecto[i].idClasificacionEmprendimiento)).build().findUnique();
        final catalogoProyectoExistente = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listCatalogoProyecto[i].id)).build().findUnique();
        if (catalogoProyectoExistente == null) {
        final nuevoCatalogoProyecto = CatalogoProyecto(
        nombre: listCatalogoProyecto[i].nombreProyecto,
        idDBR: listCatalogoProyecto[i].id,
        );
        if (clasificacionEmp != null) {
          nuevoCatalogoProyecto.clasificacionEmp.target = clasificacionEmp;
          dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
          }
        } else {
          if (catalogoProyectoExistente.fechaRegistro != listCatalogoProyecto[i].updated && clasificacionEmp != null) {
            catalogoProyectoExistente.nombre = listCatalogoProyecto[i].nombreProyecto;
            catalogoProyectoExistente.clasificacionEmp.target = clasificacionEmp;
            catalogoProyectoExistente.fechaRegistro = listCatalogoProyecto[i].updated!;
            dataBase.catalogoProyectoBox.put(catalogoProyectoExistente);
          }
        }
      }
      notifyListeners();
    }
  }
  
  Future<void> getFamiliaProdAgain() async {
    if (dataBase.familiaProductosBox.isEmpty()) {
      final records = await client.records.
      getFullList('familia_prod', batch: 200, sort: '+nombre_tipo_prod');
      final List<GetFamiliaProductos> listFamiliaProductos = [];
      for (var element in records) {
        listFamiliaProductos.add(getFamiliaProductosFromMap(element.toString()));
      }

      print("****Informacion familia_productos****");
      for (var i = 0; i < listFamiliaProductos.length; i++) {
        final familiaProductoEmpExistente = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listFamiliaProductos[i].id)).build().findUnique();
        if (familiaProductoEmpExistente == null) {
        final nuevaFamiliaProductos = FamiliaProd(
        nombre: listFamiliaProductos[i].nombreTipoProd,
        activo: listFamiliaProductos[i].activo,
        idDBR: listFamiliaProductos[i].id,
        fechaRegistro: listFamiliaProductos[i].updated
        );
        dataBase.familiaProductosBox.put(nuevaFamiliaProductos);
        print('Familia Productos agregada exitosamente');
        } else {
          if (familiaProductoEmpExistente.fechaRegistro != listFamiliaProductos[i].updated) {
            familiaProductoEmpExistente.nombre = listFamiliaProductos[i].nombreTipoProd;
            familiaProductoEmpExistente.activo = listFamiliaProductos[i].activo;
            familiaProductoEmpExistente.fechaRegistro = listFamiliaProductos[i].updated!;
            dataBase.familiaProductosBox.put(familiaProductoEmpExistente);
          }
        }
      }
      notifyListeners();
      }
  }
}
