import 'package:bizpro_app/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:bizpro_app/modelsPocketbase/get_area_circulo.dart';
import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_comunidades.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_productos_prov.dart';
import 'package:bizpro_app/modelsPocketbase/get_proveedores.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proveedor.dart';
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsPocketbase/get_estados.dart';

import 'package:http/http.dart' as http;
import '../objectbox.g.dart';

//Este provider sólo funciona para cuando se agregan o actualizan registros en los catálogos del backend

class CatalogPocketbaseRecoverProvider extends ChangeNotifier {

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
    await getTipoProyectoAgain();
    await getCatalogosProyectosAgain();
    await getFamiliaProdAgain();
    await getUnidadMedidaAgain();
    await getAmbitoConsultoriaAgain();
    await getFasesEmpAgain();
    await getTipoEmpaqueAgain();
    await getEstadoInversionAgain();
    await getAreaCirculoAgain();
    await getTipoProveedorAgain();
    await getCondicionesPagoAgain();
    await getBancosAgain();
    await getPorcentajeAvanceAgain();
    await getProveedoresAgain();
    await getProductosProvAgain();
    await getProdProyectoAgain();
    await getEstadosProdCotizadosAgain();
    print("Proceso terminado");
    procesoterminado = true;
    procesocargando = false;
    notifyListeners();
    
  }

  Future<bool> getEstadosAgain() async {
    //Se recupera toda la colección de estados en Pocketbase
    final records = await client.records.
    getFullList('estados', batch: 200, sort: '+nombre_estado');
    if (records.isNotEmpty) {
      //Existen datos de estados en Pocketbase
      final List<GetEstados> listEstados = [];
      for (var element in records) {
        listEstados.add(getEstadosFromMap(element.toString()));
      }
      for (var i = 0; i < listEstados.length; i++) {
        //Se valida que el nuevo estado aún no existe en Objectbox
        final estadoExistente = dataBase.estadosBox.query(Estados_.idDBR.equals(listEstados[i].id)).build().findUnique();
        if (estadoExistente == null) {
          if (listEstados[i].id.isNotEmpty) {
            final nuevoEstado = Estados(
            nombre: listEstados[i].nombreEstado,
            activo: listEstados[i].activo,
            idDBR: listEstados[i].id, 
            idEmiWeb: "0",
            );
            dataBase.estadosBox.put(nuevoEstado);
            print('Estado Nuevo agregado exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (estadoExistente.fechaRegistro != listEstados[i].updated) {
            //Se actualiza el registro en Objectbox
            estadoExistente.nombre = listEstados[i].nombreEstado;
            estadoExistente.activo = listEstados[i].activo;
            estadoExistente.fechaRegistro = listEstados[i].updated!;
            dataBase.estadosBox.put(estadoExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
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
        idEmiWeb: "0",
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
        idEmiWeb: "0",
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

  Future<void> getTipoProyectoAgain() async {
    if (!dataBase.tipoProyectoBox.isEmpty()) {
      final records = await client.records.
        getFullList('tipo_proyecto', batch: 200, sort: '+tipo_proyecto');
      final List<GetTipoProyecto> listTipoProyecto = [];
      for (var element in records) {
        listTipoProyecto.add(getTipoProyectoFromMap(element.toString()));
      }

      print("****Informacion tipo_proyecto****");
      for (var i = 0; i < listTipoProyecto.length; i++) {
        final tipoProyectoExistente = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listTipoProyecto[i].id)).build().findUnique();
        if (tipoProyectoExistente == null) {
        final nuevaClasificacionEmp = TipoProyecto(
        tipoProyecto: listTipoProyecto[i].tipoProyecto,
        activo: listTipoProyecto[i].activo,
        idDBR: listTipoProyecto[i].id,
        idEmiWeb: "0",
        );
        dataBase.tipoProyectoBox.put(nuevaClasificacionEmp);
        print('Tipo Proyecto agregado exitosamente');
        } else {
          if (tipoProyectoExistente.fechaRegistro != listTipoProyecto[i].updated) {
            tipoProyectoExistente.tipoProyecto = listTipoProyecto[i].tipoProyecto;
            tipoProyectoExistente.activo = listTipoProyecto[i].activo;
            tipoProyectoExistente.fechaRegistro = listTipoProyecto[i].updated!;
            dataBase.tipoProyectoBox.put(tipoProyectoExistente);
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
        final tipoProyecto = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listCatalogoProyecto[i].idTipoProyectoFk)).build().findUnique();
        final catalogoProyectoExistente = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listCatalogoProyecto[i].id)).build().findUnique();
        if (catalogoProyectoExistente == null) {
        final nuevoCatalogoProyecto = CatalogoProyecto(
        nombre: listCatalogoProyecto[i].nombreProyecto,
        idDBR: listCatalogoProyecto[i].id, 
        idEmiWeb: "0",
        );
        if (tipoProyecto != null) {
          nuevoCatalogoProyecto.tipoProyecto.target = tipoProyecto;
          dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
          }
        } else {
          if (catalogoProyectoExistente.fechaRegistro != listCatalogoProyecto[i].updated && tipoProyecto != null) {
            catalogoProyectoExistente.nombre = listCatalogoProyecto[i].nombreProyecto;
            catalogoProyectoExistente.tipoProyecto.target = tipoProyecto;
            catalogoProyectoExistente.fechaRegistro = listCatalogoProyecto[i].updated!;
            dataBase.catalogoProyectoBox.put(catalogoProyectoExistente);
          }
        }
      }
      notifyListeners();
    }
  }
  
  Future<void> getFamiliaProdAgain() async {
    if (!dataBase.familiaProductosBox.isEmpty()) {
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
        fechaRegistro: listFamiliaProductos[i].updated, 
        idEmiWeb: "0",
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

Future<void> getUnidadMedidaAgain() async {
    if (!dataBase.unidadesMedidaBox.isEmpty()) {
      final records = await client.records.
      getFullList('und_medida', batch: 200, sort: '+unidad_medida');
      final List<GetUnidadesMedida> listUnidadMedida = [];
      for (var element in records) {
        listUnidadMedida.add(getUnidadesMedidaFromMap(element.toString()));
      }

      print("****Informacion und_medida****");
      for (var i = 0; i < listUnidadMedida.length; i++) {
        final unidadMedidaExistente = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listUnidadMedida[i].id)).build().findUnique();
        if (unidadMedidaExistente == null) {
        final nuevaUnidadMedida = UnidadMedida(
        unidadMedida: listUnidadMedida[i].unidadMedida,
        activo: listUnidadMedida[i].activo,
        idDBR: listUnidadMedida[i].id,
        fechaRegistro: listUnidadMedida[i].updated, 
        idEmiWeb: "0",
        );
        dataBase.unidadesMedidaBox.put(nuevaUnidadMedida);
        print('Unidad Medida agregada exitosamente');

        } else {
          if (unidadMedidaExistente.fechaRegistro != listUnidadMedida[i].updated) {
            unidadMedidaExistente.unidadMedida = listUnidadMedida[i].unidadMedida;
            unidadMedidaExistente.activo = listUnidadMedida[i].activo;
            unidadMedidaExistente.fechaRegistro = listUnidadMedida[i].updated!;
            dataBase.unidadesMedidaBox.put(unidadMedidaExistente);
          }
        }
      }
      notifyListeners();
      }
  }

Future<void> getAmbitoConsultoriaAgain() async {
    if (!dataBase.ambitoConsultoriaBox.isEmpty()) {
      final records = await client.records.
      getFullList('ambito_consultoria', batch: 200, sort: '+nombre_ambito');
      final List<GetAmbitoConsultoria> listAmbitoConsultoria = [];
      for (var element in records) {
        listAmbitoConsultoria.add(getAmbitoConsultoriaFromMap(element.toString()));
      }
      print("****Informacion ambito consultoria****");
      for (var i = 0; i < records.length; i++) {
        final ambitoConsultoriaExistente = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idDBR.equals(listAmbitoConsultoria[i].id)).build().findUnique();
        if (ambitoConsultoriaExistente == null) {
        final nuevoAmbitoConsultoria = AmbitoConsultoria(
        nombreAmbito: listAmbitoConsultoria[i].nombreAmbito,
        activo: listAmbitoConsultoria[i].activo,
        idDBR: listAmbitoConsultoria[i].id,
        fechaRegistro: listAmbitoConsultoria[i].updated, 
        idEmiWeb: "0",
        );
        dataBase.ambitoConsultoriaBox.put(nuevoAmbitoConsultoria);
        print('Ambito Consultoria agregado exitosamente');

        } else {
          if (ambitoConsultoriaExistente.fechaRegistro != listAmbitoConsultoria[i].updated) {
            ambitoConsultoriaExistente.nombreAmbito = listAmbitoConsultoria[i].nombreAmbito;
            ambitoConsultoriaExistente.activo = listAmbitoConsultoria[i].activo;
            ambitoConsultoriaExistente.fechaRegistro = listAmbitoConsultoria[i].updated!;
            dataBase.ambitoConsultoriaBox.put(ambitoConsultoriaExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getFasesEmpAgain() async {
    if (!dataBase.fasesEmpBox.isEmpty()) {
      final records = await client.records.
      getFullList('fases_emp', batch: 200);
      final List<GetFasesEmp> listFasesEmp = [];
      for (var element in records) {
        listFasesEmp.add(getFasesEmpFromMap(element.toString()));
      }
      print("****Informacion fase emp****");
      for (var i = 0; i < records.length; i++) {
        final faseEmpExistente = dataBase.fasesEmpBox.query(FasesEmp_.idDBR.equals(listFasesEmp[i].id)).build().findUnique();
        if (faseEmpExistente == null) {
        final nuevaFaseEmp = FasesEmp(
        fase: listFasesEmp[i].fase,
        idDBR: listFasesEmp[i].id,
        fechaRegistro: listFasesEmp[i].updated, 
        idEmiWeb: "0",
        );
        dataBase.fasesEmpBox.put(nuevaFaseEmp);
        print('Fase emp agregada exitosamente');
        } else {
          if (faseEmpExistente.fechaRegistro != listFasesEmp[i].updated) {
            faseEmpExistente.fase = listFasesEmp[i].fase;
            faseEmpExistente.fechaRegistro = listFasesEmp[i].updated!;
            dataBase.fasesEmpBox.put(faseEmpExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getTipoEmpaqueAgain() async {
    if (!dataBase.tipoEmpaquesBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_empaques', batch: 200, sort: '+tipo_empaque');
      final List<GetTipoEmpaques> listTipoEmpaques = [];
      for (var element in records) {
        listTipoEmpaques.add(getTipoEmpaquesFromMap(element.toString()));
      }
      print("****Informacion tipo empaque****");
      for (var i = 0; i < records.length; i++) {
        final tipoEmpaqueExistente = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listTipoEmpaques[i].id)).build().findUnique();
        if (tipoEmpaqueExistente == null) {
        final nuevoTipoEmpaque = TipoEmpaques(
        tipo: listTipoEmpaques[i].tipoEmpaque,
        idDBR: listTipoEmpaques[i].id,
        activo: listTipoEmpaques[i].activo,
        fechaRegistro: listTipoEmpaques[i].updated, idEmiWeb: ''
        );
        dataBase.tipoEmpaquesBox.put(nuevoTipoEmpaque);
        print('Tipo empaque agregado exitosamente');
        } else {
          if (tipoEmpaqueExistente.fechaRegistro != listTipoEmpaques[i].updated) {
            tipoEmpaqueExistente.tipo = listTipoEmpaques[i].tipoEmpaque;
            tipoEmpaqueExistente.activo = listTipoEmpaques[i].activo;
            tipoEmpaqueExistente.fechaRegistro = listTipoEmpaques[i].updated!;
            dataBase.tipoEmpaquesBox.put(tipoEmpaqueExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getEstadoInversionAgain() async {
    if (!dataBase.estadoInversionBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_inversiones', batch: 200, sort: '+estado');
      final List<GetEstadoInversiones> listEstadoInversiones = [];
      for (var element in records) {
        listEstadoInversiones.add(getEstadoInversionesFromMap(element.toString()));
      }
      print("****Informacion estado inversiones****");
      for (var i = 0; i < records.length; i++) {
        final estadoInversionExistente = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(listEstadoInversiones[i].id)).build().findUnique();
        if (estadoInversionExistente == null) {
        final nuevaEstadoInversiones = EstadoInversion(
        estado: listEstadoInversiones[i].estado,
        idDBR: listEstadoInversiones[i].id,
        fechaRegistro: listEstadoInversiones[i].updated, idEmiWeb: ''
        );
        dataBase.estadoInversionBox.put(nuevaEstadoInversiones);
        print('Estado inversion agregado exitosamente');
        } else {
          if (estadoInversionExistente.fechaRegistro != listEstadoInversiones[i].updated) {
            estadoInversionExistente.estado = listEstadoInversiones[i].estado;
            estadoInversionExistente.fechaRegistro = listEstadoInversiones[i].updated!;
            dataBase.estadoInversionBox.put(estadoInversionExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getAreaCirculoAgain() async {
    if (!dataBase.areaCirculoBox.isEmpty()) {
      final records = await client.records.
      getFullList('area_circulo', batch: 200, sort: '+nombre_area');
      final List<GetAreaCirculo> listAreaCirculo = [];
      for (var element in records) {
        listAreaCirculo.add(getAreaCirculoFromMap(element.toString()));
      }
      print("****Informacion area circulo****");
      for (var i = 0; i < records.length; i++) {
        final areaCirculoExistente = dataBase.areaCirculoBox.query(AreaCirculo_.idDBR.equals(listAreaCirculo[i].id)).build().findUnique();
        if (areaCirculoExistente == null) {
        final nuevaAreaCirculo = AreaCirculo(
        nombreArea: listAreaCirculo[i].nombreArea,
        idDBR: listAreaCirculo[i].id,
        fechaRegistro: listAreaCirculo[i].updated, 
        idEmiWeb: "0",
        );
        dataBase.areaCirculoBox.put(nuevaAreaCirculo);
        print('Area circulo agregado exitosamente');
        } else {
          if (areaCirculoExistente.fechaRegistro != listAreaCirculo[i].updated) {
            areaCirculoExistente.nombreArea = listAreaCirculo[i].nombreArea;
            areaCirculoExistente.fechaRegistro = listAreaCirculo[i].updated!;
            dataBase.areaCirculoBox.put(areaCirculoExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getTipoProveedorAgain() async {
    if (!dataBase.tipoProveedorBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_proveedor', batch: 200, sort: '+tipo_proveedor');
      final List<GetTipoProveedor> listTipoProveedor = [];
      for (var element in records) {
        listTipoProveedor.add(getTipoProveedorFromMap(element.toString()));
      }
      print("****Informacion tipo proveedor****");
      for (var i = 0; i < records.length; i++) {
        final tipoProveedorExistente = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listTipoProveedor[i].id)).build().findUnique();
        if (tipoProveedorExistente == null) {
        final nuevoTipoProveedor = TipoProveedor(
        tipo: listTipoProveedor[i].tipoProveedor,
        idDBR: listTipoProveedor[i].id,
        activo: listTipoProveedor[i].activo,
        fechaRegistro: listTipoProveedor[i].updated
        );
        dataBase.tipoProveedorBox.put(nuevoTipoProveedor);
        print('Tipo proveedor agregado exitosamente');
        } else {
          if (tipoProveedorExistente.fechaRegistro != listTipoProveedor[i].updated) {
            tipoProveedorExistente.tipo = listTipoProveedor[i].tipoProveedor;
            tipoProveedorExistente.fechaRegistro = listTipoProveedor[i].updated!;
            tipoProveedorExistente.activo = listTipoProveedor[i].activo;
            dataBase.tipoProveedorBox.put(tipoProveedorExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getCondicionesPagoAgain() async {
    if (!dataBase.condicionesPagoBox.isEmpty()) {
      final records = await client.records.
      getFullList('condiciones_pago', batch: 200, sort: '+condicion_pago');
      final List<GetCondicionesPago> listCondicionesPago = [];
      for (var element in records) {
        listCondicionesPago.add(getCondicionesPagoFromMap(element.toString()));
      }
      print("****Informacion condición pago****");
      for (var i = 0; i < records.length; i++) {
        final condicionPagoExistente = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listCondicionesPago[i].id)).build().findUnique();
        if (condicionPagoExistente == null) {
        final nuevaCondicionPago = CondicionesPago(
        condicion: listCondicionesPago[i].condicionPago,
        idDBR: listCondicionesPago[i].id,
        activo: listCondicionesPago[i].activo,
        fechaRegistro: listCondicionesPago[i].updated
        );
        dataBase.condicionesPagoBox.put(nuevaCondicionPago);
        print('Condición pago agregada exitosamente');
        } else {
          if (condicionPagoExistente.fechaRegistro != listCondicionesPago[i].updated) {
            condicionPagoExistente.condicion = listCondicionesPago[i].condicionPago;
            condicionPagoExistente.fechaRegistro = listCondicionesPago[i].updated!;
            condicionPagoExistente.activo = listCondicionesPago[i].activo;
            dataBase.condicionesPagoBox.put(condicionPagoExistente);
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getBancosAgain() async {
    if (!dataBase.bancosBox.isEmpty()) {
      final records = await client.records.
      getFullList('bancos', batch: 200, sort: '+nombre_banco');
      final List<GetBancos> listBancos = [];
      for (var element in records) {
        listBancos.add(getBancosFromMap(element.toString()));
      }
      print("****Informacion banco****");
      for (var i = 0; i < records.length; i++) {
        final bancoExistente = dataBase.bancosBox.query(Bancos_.idDBR.equals(listBancos[i].id)).build().findUnique();
        if (bancoExistente == null) {
        final nuevoBanco = Bancos(
        banco: listBancos[i].nombreBanco,
        idDBR: listBancos[i].id,
        activo: listBancos[i].activo,
        fechaRegistro: listBancos[i].updated
        );
        dataBase.bancosBox.put(nuevoBanco);
        print('Banco agregado exitosamente');
        } else {
          if (bancoExistente.fechaRegistro != listBancos[i].updated) {
            bancoExistente.banco = listBancos[i].nombreBanco;
            bancoExistente.fechaRegistro = listBancos[i].updated!;
            bancoExistente.activo = listBancos[i].activo;
            dataBase.bancosBox.put(bancoExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getPorcentajeAvanceAgain() async {
    if (!dataBase.porcentajeAvanceBox.isEmpty()) {
      final records = await client.records.
      getFullList('porcentaje_avance', batch: 200, sort: '+porcentaje');
      final List<GetPorcentajeAvance> listPorcentaje = [];
      for (var element in records) {
        listPorcentaje.add(getPorcentajeAvanceFromMap(element.toString()));
      }
      print("****Informacion porcentaje****");
      for (var i = 0; i < records.length; i++) {
        final porcentajeExistente = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idDBR.equals(listPorcentaje[i].id)).build().findUnique();
        if (porcentajeExistente == null) {
        final nuevoPorcentaje = PorcentajeAvance(
        porcentajeAvance: listPorcentaje[i].porcentaje,
        idDBR: listPorcentaje[i].id,
        activo: listPorcentaje[i].activo,
        fechaRegistro: listPorcentaje[i].updated
        );
        dataBase.porcentajeAvanceBox.put(nuevoPorcentaje);
        print('Porcentaje agregado exitosamente');
        } else {
          if (porcentajeExistente.fechaRegistro != listPorcentaje[i].updated) {
            porcentajeExistente.porcentajeAvance = listPorcentaje[i].porcentaje;
            porcentajeExistente.fechaRegistro = listPorcentaje[i].updated!;
            porcentajeExistente.activo = listPorcentaje[i].activo;
            dataBase.porcentajeAvanceBox.put(porcentajeExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getProveedoresAgain() async {
    if (!dataBase.proveedoresBox.isEmpty()) {
      final records = await client.records.
      getFullList('proveedores', batch: 200, sort: '+nombre_fiscal');
      final List<GetProveedores> listProveedores = [];
      for (var element in records) {
        listProveedores.add(getProveedoresFromMap(element.toString()));
      }
      print("****Informacion proveedor****");
      for (var i = 0; i < records.length; i++) {
        final tipoProveedor = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listProveedores[i].idTipoProveedorFk)).build().findUnique();
        final condicionPago = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listProveedores[i].idCondicionPagoFk)).build().findUnique();
        final banco = dataBase.bancosBox.query(Bancos_.idDBR.equals(listProveedores[i].idBancoFk)).build().findUnique();
        final comunidad = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listProveedores[i].idComunidadFk)).build().findUnique();
        final proveedorExistente = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProveedores[i].id)).build().findUnique();
        if (proveedorExistente == null) {
          final nuevoProveedor = Proveedores(
          nombreFiscal: listProveedores[i].nombreFiscal,
          rfc: listProveedores[i].rfc,
          direccion: listProveedores[i].direccion,
          nombreEncargado: listProveedores[i].nombreEncargado,
          clabe: listProveedores[i].clabe,
          telefono: listProveedores[i].telefono,
          registradoPor: listProveedores[i].registradoPor,
          archivado: listProveedores[i].archivado,
          idDBR: listProveedores[i].id,
          fechaRegistro: listProveedores[i].updated
          );
          if (tipoProveedor != null && condicionPago != null && banco != null && comunidad != null) {
            nuevoProveedor.tipoProveedor.target = tipoProveedor;
            nuevoProveedor.condicionPago.target = condicionPago;
            nuevoProveedor.banco.target = banco;
            nuevoProveedor.comunidades.target = comunidad;
            dataBase.proveedoresBox.put(nuevoProveedor);
            print('Proveedor agregado exitosamente');
          }
        } else {
          if (proveedorExistente.fechaRegistro != listProveedores[i].updated && tipoProveedor != null && condicionPago != null && banco != null && comunidad != null) {
            proveedorExistente.tipoProveedor.target = tipoProveedor;
            proveedorExistente.condicionPago.target = condicionPago;
            proveedorExistente.banco.target = banco;
            proveedorExistente.comunidades.target = comunidad;
            proveedorExistente.nombreFiscal = listProveedores[i].nombreFiscal;
            proveedorExistente.rfc = listProveedores[i].rfc;
            proveedorExistente.direccion = listProveedores[i].direccion;
            proveedorExistente.nombreEncargado = listProveedores[i].nombreEncargado;
            proveedorExistente.clabe = listProveedores[i].clabe;
            proveedorExistente.telefono = listProveedores[i].telefono;
            proveedorExistente.registradoPor = listProveedores[i].registradoPor;
            proveedorExistente.archivado = listProveedores[i].archivado;
            proveedorExistente.fechaRegistro = listProveedores[i].updated!;
            dataBase.proveedoresBox.put(proveedorExistente);
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getProductosProvAgain() async {
    if (!dataBase.productosProvBox.isEmpty()) {
      final records = await client.records.
      getFullList('productos_prov', batch: 200, sort: '+nombre_prod_prov');
      final List<GetProductosProv> listProductosProv = [];
      for (var element in records) {
        listProductosProv.add(getProductosProvFromMap(element.toString()));
      }
      print("****Informacion producto prov****");
      for (var i = 0; i < records.length; i++) {
        final proveedor = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProductosProv[i].idProveedorFk)).build().findUnique();
        final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listProductosProv[i].isUndMedidaFk)).build().findUnique();
        final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProductosProv[i].idFamiliaProdFk)).build().findUnique();
        final productoProvExistente = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(listProductosProv[i].id)).build().findUnique();
        if (productoProvExistente == null) {
          final nuevoProductoProv = ProductosProv(
          nombre: listProductosProv[i].nombreProdProv,
          descripcion: listProductosProv[i].descripcionProdProv,
          marca: listProductosProv[i].marca,
          costo: listProductosProv[i].costoProdProv,
          tiempoEntrega: listProductosProv[i].tiempoEntrega,
          archivado: listProductosProv[i].archivado,
          idDBR: listProductosProv[i].id,
          fechaRegistro: listProductosProv[i].updated
          );
          if (proveedor != null && unidadMedida != null && familiaProd != null) {
            nuevoProductoProv.unidadMedida.target = unidadMedida;
            nuevoProductoProv.familiaProducto.target = familiaProd;
            nuevoProductoProv.proveedor.target = proveedor;
            dataBase.productosProvBox.put(nuevoProductoProv);
            print('Prducto Prov agregado exitosamente');
          }
        } else {
          if (productoProvExistente.fechaRegistro != listProductosProv[i].updated && proveedor != null && unidadMedida != null && familiaProd != null) {
            productoProvExistente.proveedor.target = proveedor;
            productoProvExistente.unidadMedida.target = unidadMedida;
            productoProvExistente.familiaProducto.target = familiaProd;
            productoProvExistente.nombre = listProductosProv[i].nombreProdProv;
            productoProvExistente.descripcion = listProductosProv[i].descripcionProdProv;
            productoProvExistente.marca = listProductosProv[i].marca;
            productoProvExistente.costo = listProductosProv[i].costoProdProv;
            productoProvExistente.tiempoEntrega = listProductosProv[i].tiempoEntrega;
            productoProvExistente.archivado = listProductosProv[i].archivado;
            productoProvExistente.fechaRegistro = listProductosProv[i].updated!;
            dataBase.productosProvBox.put(productoProvExistente);
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getProdProyectoAgain() async {
    if (!dataBase.productosProyectoBox.isEmpty()) {
      final records = await client.records.
      getFullList('prod_proyecto', batch: 200, sort: '+producto');

      final List<GetProdProyecto> listProdProyecto = [];
      for (var element in records) {
        listProdProyecto.add(getProdProyectoFromMap(element.toString()));
      }

      print("****Informacion prod Proyecto****");
      for (var i = 0; i < records.length; i++) {
        final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProdProyecto[i].idFamiliaProdFk)).build().findUnique();
        final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listProdProyecto[i].idTipoEmpaquesFk)).build().findUnique();
        final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listProdProyecto[i].idCatalogoProyectoFk)).build().findUnique();
        final prodProyectoExistente = dataBase.productosProyectoBox.query(ProdProyecto_.idDBR.equals(listProdProyecto[i].id)).build().findUnique();
        if (prodProyectoExistente == null) {
        final nuevoProdProyecto = ProdProyecto(
        producto: listProdProyecto[i].producto,
        marcaSugerida: listProdProyecto[i].marcaSugerida,
        descripcion: listProdProyecto[i].descripcion,
        proveedorSugerido: listProdProyecto[i].proveedorSugerido,
        cantidad: listProdProyecto[i].cantidad,
        costoEstimado: listProdProyecto[i].costoEstimado,
        idDBR: listProdProyecto[i].id,
        fechaRegistro: listProdProyecto[i].updated
        );
        if (familiaProd != null && tipoEmpaque != null && catalogoProyecto != null) {
          nuevoProdProyecto.familiaProducto.target = familiaProd;
          nuevoProdProyecto.tipoEmpaques.target = tipoEmpaque;
          nuevoProdProyecto.catalogoProyecto.target = catalogoProyecto;
          catalogoProyecto.prodProyecto.add(nuevoProdProyecto);
          dataBase.catalogoProyectoBox.put(catalogoProyecto);
          print('Prod Proyecto agregado exitosamente');
          }
        } else {
          if (prodProyectoExistente.fechaRegistro != listProdProyecto[i].updated && familiaProd != null && tipoEmpaque != null && catalogoProyecto != null) {
            prodProyectoExistente.familiaProducto.target = familiaProd;
            prodProyectoExistente.tipoEmpaques.target = tipoEmpaque;
            prodProyectoExistente.catalogoProyecto.target = catalogoProyecto;
            prodProyectoExistente.producto = listProdProyecto[i].producto;
            prodProyectoExistente.marcaSugerida = listProdProyecto[i].marcaSugerida;
            prodProyectoExistente.descripcion = listProdProyecto[i].descripcion;
            prodProyectoExistente.proveedorSugerido = listProdProyecto[i].proveedorSugerido;
            prodProyectoExistente.cantidad = listProdProyecto[i].cantidad;
            prodProyectoExistente.costoEstimado = listProdProyecto[i].costoEstimado;
            prodProyectoExistente.fechaRegistro = listProdProyecto[i].updated!;
            dataBase.productosProyectoBox.put(prodProyectoExistente);
          }
        }
      }
      notifyListeners();
      }
    }

Future<void> getEstadosProdCotizadosAgain() async {
    if (!dataBase.estadosProductoCotizadosBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_prod_cotizados', batch: 200, sort: '+estado');
      final List<GetEstadosProdCotizados> listEstadosProdCotizados = [];
      for (var element in records) {
        listEstadosProdCotizados.add(getEstadosProdCotizadosFromMap(element.toString()));
      }
      print("****Informacion estado prod cotizado****");
      for (var i = 0; i < records.length; i++) {
        final estadoProdCotizadoExistente = dataBase.estadosProductoCotizadosBox.query(EstadoProdCotizado_.idDBR.equals(listEstadosProdCotizados[i].id)).build().findUnique();
        if (estadoProdCotizadoExistente == null) {
        final nuevoEstadoProdCotizado = EstadoProdCotizado(
        estado: listEstadosProdCotizados[i].estado,
        idDBR: listEstadosProdCotizados[i].id,
        fechaRegistro: listEstadosProdCotizados[i].updated
        );
        dataBase.estadosProductoCotizadosBox.put(nuevoEstadoProdCotizado);
        print('Estado prod Cotizado agregado exitosamente');
        } else {
          if (estadoProdCotizadoExistente.fechaRegistro != listEstadosProdCotizados[i].updated) {
            estadoProdCotizadoExistente.estado = listEstadosProdCotizados[i].estado;
            estadoProdCotizadoExistente.fechaRegistro = listEstadosProdCotizados[i].updated!;
            dataBase.estadosProductoCotizadosBox.put(estadoProdCotizadoExistente);
          }
        }
      }
      notifyListeners();
    }
  }

}
