import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_productos_prov.dart';
import 'package:bizpro_app/modelsPocketbase/get_proveedores.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proveedor.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsPocketbase/get_tipo_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_comunidades.dart';
import 'package:bizpro_app/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:bizpro_app/modelsPocketbase/get_area_circulo.dart';
import 'package:bizpro_app/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:http/http.dart' as http;
import '../objectbox.g.dart';

class CatalogPocketbaseProvider extends ChangeNotifier {

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
    await getTipoProyecto();
    await getCatalogosProyectos();
    await getFamiliaProd();
    await getUnidadMedida();
    await getAmbitoConsultoria();
    await getFasesEmp();
    await getTipoEmpaque();
    await getEstadoInversion();
    await getAreaCirculo();
    await getTipoProveedor();
    await getCondicionesPago();
    await getBancos();
    await getPorcentajeAvance();
    await getProveedores();
    await getProductosProv();
    await getProdProyecto();
    await getEstadosProdCotizados();
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

      print("*****Informacion estados*****");
      for (var i = 0; i < listEstados.length; i++) {
        if (listEstados[i].id.isNotEmpty) {
        final nuevoEstado = Estados(
        nombre: listEstados[i].nombreEstado,
        activo: listEstados[i].activo,
        idDBR: listEstados[i].id,
        fechaRegistro: listEstados[i].updated, 
        idEmiWeb: 0,
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

      print("*****Informacion municipios****");
      for (var i = 0; i < listMunicipios.length; i++) {
        if (listMunicipios[i].id.isNotEmpty) {
        final nuevoMunicipio = Municipios(
        nombre: listMunicipios[i].nombreMunicipio,
        activo: listMunicipios[i].activo,
        idDBR: listMunicipios[i].id,
        fechaRegistro: listMunicipios[i].updated, 
        idEmiWeb: 0,
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

      print("****Informacion comunidades****");
      for (var i = 0; i < records.length; i++) {
        if (listComunidades[i].id.isNotEmpty) {
        final nuevaComunidad = Comunidades(
        nombre: listComunidades[i].nombreComunidad,
        activo: listComunidades[i].activo,
        idDBR: listComunidades[i].id,
        fechaRegistro: listComunidades[i].updated, 
        idEmiWeb: 0,
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

      print("*****Informacion roles*****");
      for (var i = 0; i < listRoles.length; i++) {
        if (listRoles[i].id.isNotEmpty) {
        final nuevoRol = Roles(
        rol: listRoles[i].rol,
        idDBR: listRoles[i].id,
        fechaRegistro: listRoles[i].updated
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

  Future<void> getTipoProyecto() async {
    if (dataBase.tipoProyectoBox.isEmpty()) {
      final records = await client.records.
        getFullList('tipo_proyecto', batch: 200, sort: '+tipo_proyecto');
      final List<GetTipoProyecto> listTipoProyecto = [];
      for (var element in records) {
        listTipoProyecto.add(getTipoProyectoFromMap(element.toString()));
      }

      print("****Informacion tipo_proyecto****");
      for (var i = 0; i < listTipoProyecto.length; i++) {
        if (listTipoProyecto[i].id.isNotEmpty) {
        final nuevoTipoProyecto = TipoProyecto(
        tipoProyecto: listTipoProyecto[i].tipoProyecto,
        activo: listTipoProyecto[i].activo,
        idDBR: listTipoProyecto[i].id,
        fechaRegistro: listTipoProyecto[i].updated,
        idEmiWeb: 0,
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoTipoProyecto.statusSync.target = nuevoSync;
        dataBase.tipoProyectoBox.put(nuevoTipoProyecto);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Tipo Proyecto agregado exitosamente');
        final record = await client.records.update('tipo_proyecto', listTipoProyecto[i].id, body: {
          'id_status_sync_fk': 'HoI36PzYw1wtbO1',
        });
        if (record.id.isNotEmpty) {
            print('Tipo Proyecto actualizado en el backend exitosamente');
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

      print("****Informacion familia_productos****");
      for (var i = 0; i < listFamiliaProductos.length; i++) {
        if (listFamiliaProductos[i].id.isNotEmpty) {
        final nuevaFamiliaProductos = FamiliaProd(
        nombre: listFamiliaProductos[i].nombreTipoProd,
        activo: listFamiliaProductos[i].activo,
        idDBR: listFamiliaProductos[i].id,
        fechaRegistro: listFamiliaProductos[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaFamiliaProductos.statusSync.target = nuevoSync;
        dataBase.familiaProductosBox.put(nuevaFamiliaProductos);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Familia Productos agregada exitosamente');
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

      print("****Informacion und_medida****");
      for (var i = 0; i < listUnidadMedida.length; i++) {
        if (listUnidadMedida[i].id.isNotEmpty) {
        final nuevaUnidadMedida = UnidadMedida(
        unidadMedida: listUnidadMedida[i].unidadMedida,
        activo: listUnidadMedida[i].activo,
        idDBR: listUnidadMedida[i].id,
        fechaRegistro: listUnidadMedida[i].updated
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

      print("****Informacion catalogos proyectos****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listCatalogoProyecto[i].id.isNotEmpty) {
        final nuevoCatalogoProyecto = CatalogoProyecto(
        nombre: listCatalogoProyecto[i].nombreProyecto,
        idDBR: listCatalogoProyecto[i].id,
        fechaRegistro: listCatalogoProyecto[i].updated, 
        idEmiWeb: 0,
        );
        final clasificacionEmp = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listCatalogoProyecto[i].idTipoProyecto)).build().findUnique();
        if (clasificacionEmp != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevoCatalogoProyecto.statusSync.target = nuevoSync;
          nuevoCatalogoProyecto.tipoProyecto.target = clasificacionEmp;
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

      print("****Informacion ambito consultoria****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listAmbitoConsultoria[i].id.isNotEmpty) {
        final nuevoAmbitoConsultoria = AmbitoConsultoria(
        nombreAmbito: listAmbitoConsultoria[i].nombreAmbito,
        idDBR: listAmbitoConsultoria[i].id,
        activo: listAmbitoConsultoria[i].activo,
        fechaRegistro: listAmbitoConsultoria[i].updated, 
        idEmiWeb: 0,
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
      print("****Informacion area circulo****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listAreaCirculo[i].id.isNotEmpty) {
        final nuevaAreaCirculo = AreaCirculo(
        nombreArea: listAreaCirculo[i].nombreArea,
        idDBR: listAreaCirculo[i].id,
        activo: listAreaCirculo[i].activo,
        fechaRegistro: listAreaCirculo[i].updated
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
      getFullList('fases_emp', batch: 200);
      final List<GetFasesEmp> listFasesEmp = [];
      for (var element in records) {
        listFasesEmp.add(getFasesEmpFromMap(element.toString()));
      }
      print("****Informacion fase emp****");
      for (var i = 0; i < records.length; i++) {
        print(records[i]);
        if (listFasesEmp[i].id.isNotEmpty) {
        final nuevaFaseEmp = FasesEmp(
        fase: listFasesEmp[i].fase,
        idDBR: listFasesEmp[i].id,
        fechaRegistro: listFasesEmp[i].updated
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

  Future<void> getTipoEmpaque() async {
    if (dataBase.tipoEmpaquesBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_empaques', batch: 200, sort: '+tipo_empaque');
      final List<GetTipoEmpaques> listTipoEmpaques = [];
      for (var element in records) {
        listTipoEmpaques.add(getTipoEmpaquesFromMap(element.toString()));
      }
      print("****Informacion tipo empaque****");
      for (var i = 0; i < records.length; i++) {
        if (listTipoEmpaques[i].id.isNotEmpty) {
        final nuevoTipoEmpaque = TipoEmpaques(
        tipo: listTipoEmpaques[i].tipoEmpaque,
        idDBR: listTipoEmpaques[i].id,
        activo: listTipoEmpaques[i].activo,
        fechaRegistro: listTipoEmpaques[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoTipoEmpaque.statusSync.target = nuevoSync;
        dataBase.tipoEmpaquesBox.put(nuevoTipoEmpaque);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Tipo empaque agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }
  
  Future<void> getEstadoInversion() async {
    if (dataBase.estadoInversionBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_inversiones', batch: 200, sort: '+estado');
      final List<GetEstadoInversiones> listEstadoInversiones = [];
      for (var element in records) {
        listEstadoInversiones.add(getEstadoInversionesFromMap(element.toString()));
      }
      print("****Informacion estado inversiones****");
      for (var i = 0; i < records.length; i++) {
        if (listEstadoInversiones[i].id.isNotEmpty) {
        final nuevaEstadoInversiones = EstadoInversion(
        estado: listEstadoInversiones[i].estado,
        idDBR: listEstadoInversiones[i].id,
        fechaRegistro: listEstadoInversiones[i].updated
        );
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaEstadoInversiones.statusSync.target = nuevoSync;
        dataBase.estadoInversionBox.put(nuevaEstadoInversiones);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Estado inversion agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

  Future<void> getTipoProveedor() async {
    if (dataBase.tipoProveedorBox.isEmpty()) {
      final records = await client.records.
      getFullList('tipo_proveedor', batch: 200, sort: '+tipo_proveedor');
      final List<GetTipoProveedor> listTipoProveedor = [];
      for (var element in records) {
        listTipoProveedor.add(getTipoProveedorFromMap(element.toString()));
      }
      print("****Informacion tipo proveedor****");
      for (var i = 0; i < records.length; i++) {
        if (listTipoProveedor[i].id.isNotEmpty) {
        final nuevoTipoProveedor = TipoProveedor(
        tipo: listTipoProveedor[i].tipoProveedor,
        idDBR: listTipoProveedor[i].id,
        activo: listTipoProveedor[i].activo,
        fechaRegistro: listTipoProveedor[i].updated
        );
        dataBase.tipoProveedorBox.put(nuevoTipoProveedor);
        print('Tipo proveedor agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

  Future<void> getCondicionesPago() async {
    if (dataBase.condicionesPagoBox.isEmpty()) {
      final records = await client.records.
      getFullList('condiciones_pago', batch: 200, sort: '+condicion_pago');
      final List<GetCondicionesPago> listCondicionesPago = [];
      for (var element in records) {
        listCondicionesPago.add(getCondicionesPagoFromMap(element.toString()));
      }
    
      print("****Informacion condición pago****");
      for (var i = 0; i < records.length; i++) {
        if (listCondicionesPago[i].id.isNotEmpty) {
        final nuevaCondicionPago = CondicionesPago(
        condicion: listCondicionesPago[i].condicionPago,
        idDBR: listCondicionesPago[i].id,
        activo: listCondicionesPago[i].activo,
        fechaRegistro: listCondicionesPago[i].updated
        );
        dataBase.condicionesPagoBox.put(nuevaCondicionPago);
        print('Condición pago agregada exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getBancos() async {
    if (dataBase.bancosBox.isEmpty()) {
      final records = await client.records.
      getFullList('bancos', batch: 200, sort: '+nombre_banco');
      final List<GetBancos> listBancos = [];
      for (var element in records) {
        listBancos.add(getBancosFromMap(element.toString()));
      }
      print("****Informacion banco****");
      for (var i = 0; i < records.length; i++) {
        if (listBancos[i].id.isNotEmpty) {
        final nuevoBanco = Bancos(
        banco: listBancos[i].nombreBanco,
        idDBR: listBancos[i].id,
        activo: listBancos[i].activo,
        fechaRegistro: listBancos[i].updated
        );
        dataBase.bancosBox.put(nuevoBanco);
        print('Banco agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getPorcentajeAvance() async {
    if (dataBase.porcentajeAvanceBox.isEmpty()) {
      final records = await client.records.
      getFullList('porcentaje_avance', batch: 200, sort: '+porcentaje');
      final List<GetPorcentajeAvance> listPorcentaje = [];
      for (var element in records) {
        listPorcentaje.add(getPorcentajeAvanceFromMap(element.toString()));
      }
      print("****Informacion porcentaje****");
      for (var i = 0; i < records.length; i++) {
        if (listPorcentaje[i].id.isNotEmpty) {
        final nuevoPorcentaje = PorcentajeAvance(
        porcentajeAvance: listPorcentaje[i].porcentaje,
        idDBR: listPorcentaje[i].id,
        activo: listPorcentaje[i].activo,
        fechaRegistro: listPorcentaje[i].updated
        );
        dataBase.porcentajeAvanceBox.put(nuevoPorcentaje);
        print('Porcentaje agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getEstadosProdCotizados() async {
    if (dataBase.estadosProductoCotizadosBox.isEmpty()) {
      final records = await client.records.
      getFullList('estado_prod_cotizados', batch: 200, sort: '+estado');
      final List<GetEstadosProdCotizados> listEstadosProdCotizados = [];
      for (var element in records) {
        listEstadosProdCotizados.add(getEstadosProdCotizadosFromMap(element.toString()));
      }

      print("****Informacion estado prod cotizado****");
      for (var i = 0; i < records.length; i++) {
        if (listEstadosProdCotizados[i].id.isNotEmpty) {
        final nuevoEstadoProdCotizado = EstadoProdCotizado(
        estado: listEstadosProdCotizados[i].estado,
        idDBR: listEstadosProdCotizados[i].id,
        fechaRegistro: listEstadosProdCotizados[i].updated
        );
        dataBase.estadosProductoCotizadosBox.put(nuevoEstadoProdCotizado);
        print('Estado prod Cotizado agregado exitosamente');
        }
      }
      notifyListeners();
    }
  }

Future<void> getProveedores() async {
    if (dataBase.proveedoresBox.isEmpty()) {
      final records = await client.records.
      getFullList('proveedores', batch: 200, sort: '+nombre_fiscal');
      final List<GetProveedores> listProveedores = [];
      for (var element in records) {
        listProveedores.add(getProveedoresFromMap(element.toString()));
      }
      print("****Informacion proveedor****");
      for (var i = 0; i < records.length; i++) {
        if (listProveedores[i].id.isNotEmpty) {
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
          final tipoProveedor = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listProveedores[i].idTipoProveedorFk)).build().findUnique();
          final condicionPago = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listProveedores[i].idCondicionPagoFk)).build().findUnique();
          final banco = dataBase.bancosBox.query(Bancos_.idDBR.equals(listProveedores[i].idBancoFk)).build().findUnique();
          final comunidad = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listProveedores[i].idComunidadFk)).build().findUnique();
          if (tipoProveedor != null && condicionPago != null && banco != null && comunidad != null) {
            nuevoProveedor.tipoProveedor.target = tipoProveedor;
            nuevoProveedor.condicionPago.target = condicionPago;
            nuevoProveedor.banco.target = banco;
            nuevoProveedor.comunidades.target = comunidad;
            dataBase.proveedoresBox.put(nuevoProveedor);
            print('Proveedor agregado exitosamente');
          }
        }
      }
      notifyListeners();
    }
  }

Future<void> getProductosProv() async {
    if (dataBase.productosProvBox.isEmpty()) {
      final records = await client.records.
      getFullList('productos_prov', batch: 200, sort: '+nombre_prod_prov');
      final List<GetProductosProv> listProductosProv = [];
      for (var element in records) {
        listProductosProv.add(getProductosProvFromMap(element.toString()));
      }
      print("****Informacion producto prov****");
      for (var i = 0; i < records.length; i++) {
        if (listProductosProv[i].id.isNotEmpty) {
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
          final proveedor = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProductosProv[i].idProveedorFk)).build().findUnique();
          final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listProductosProv[i].isUndMedidaFk)).build().findUnique();
          final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProductosProv[i].idFamiliaProdFk)).build().findUnique();
          if (proveedor != null && unidadMedida != null && familiaProd != null) {
            nuevoProductoProv.unidadMedida.target = unidadMedida;
            nuevoProductoProv.familiaProducto.target = familiaProd;
            nuevoProductoProv.proveedor.target = proveedor;
            dataBase.productosProvBox.put(nuevoProductoProv);
            print('Prducto Prov agregado exitosamente');
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> getProdProyecto() async {
    if (dataBase.productosProyectoBox.isEmpty()) {
      final records = await client.records.
      getFullList('prod_proyecto', batch: 200, sort: '+producto');

      final List<GetProdProyecto> listProdProyecto = [];
      for (var element in records) {
        listProdProyecto.add(getProdProyectoFromMap(element.toString()));
      }

      print("****Informacion prod Proyecto****");
      for (var i = 0; i < records.length; i++) {
        if (listProdProyecto[i].id.isNotEmpty) {
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
        final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProdProyecto[i].idFamiliaProdFk)).build().findUnique();
        final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listProdProyecto[i].idTipoEmpaquesFk)).build().findUnique();
        final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listProdProyecto[i].idCatalogoProyectoFk)).build().findUnique();
        if (familiaProd != null && tipoEmpaque != null && catalogoProyecto != null) {
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
          nuevoProdProyecto.statusSync.target = nuevoSync;
          nuevoProdProyecto.familiaProducto.target = familiaProd;
          nuevoProdProyecto.tipoEmpaques.target = tipoEmpaque;
          nuevoProdProyecto.catalogoProyecto.target = catalogoProyecto;
          // dataBase.productosProyectoBox.put(nuevoProdProyecto);
          catalogoProyecto.prodProyecto.add(nuevoProdProyecto);
          dataBase.catalogoProyectoBox.put(catalogoProyecto);
          print("TAMANÑO PROD PROYECTO: ${dataBase.productosProyectoBox.getAll().length}");
          print('Prod Proyecto agregado exitosamente');
          }
        }
      }
      notifyListeners();
      }
    }
}
