import 'package:bizpro_app/modelsEmiWeb/get_ambito_consultoria_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_catalogo_proyectos_emi_web.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsEmiWeb/get_comunidades_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_estados_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_municipios_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_proyecto_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_productos_prov.dart';
import 'package:bizpro_app/modelsPocketbase/get_proveedores.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proveedor.dart';


import 'package:bizpro_app/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:bizpro_app/modelsPocketbase/get_area_circulo.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';

import 'package:http/http.dart' as http;

class CatalogEmiWebProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
  bool exitoso = true;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    notifyListeners();
  }

  void procesoExitoso(bool boleano) {
    procesoexitoso = boleano;
    notifyListeners();
  }

  Future<void> getCatalogosEmiWeb() async {
    if (await getTokenOAuth()) {
      banderasExistoSync.add(await getEstados());
      banderasExistoSync.add(await getMunicipios());
      banderasExistoSync.add(await getComunidades());
      banderasExistoSync.add(await getTipoProyecto());
      banderasExistoSync.add(await getCatalogosProyectos());
      // await getFamiliaProd();
      // await getUnidadMedida();
      banderasExistoSync.add(await getAmbitoConsultoria());
      // await getFasesEmp();
      // await getTipoEmpaque();
      // await getEstadoInversion();
      // await getAreaCirculo();
      // await getTipoProveedor();
      // await getCondicionesPago();
      // await getBancos();
      // await getPorcentajeAvance();
      // await getProveedores();
      // await getProductosProv();
      // await getProdProyecto();
      // await getEstadosProdCotizados();
      for (var element in banderasExistoSync) {
        //Aplicamos una operación and para validar que no haya habido un catálogo con False
        exitoso = exitoso && element;
      }
      //Verificamos que no haya habido errores al sincronizar con las banderas
      if (exitoso) {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = true;
        notifyListeners();
      } else {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        clearDataBase();
        notifyListeners();
      }
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      clearDataBase();
      notifyListeners();
    }
  }

//Función inicial para recuperar el Token para el llamado de catálogos
  Future<bool> getTokenOAuth() async {

    var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
    final headers = ({
        "Authorization": "Basic Yml6cHJvOmFkbWlu",
      });
    final bodyMsg = ({
        "grant_type": "password",
        "scope": "webclient",
        "username": "alozanop@encuentroconmexico.org",
        "password": "3FFV4lkuqqC9IuP05+K3dQ=="
      });
    
    var response = await http.post(
      url, 
      headers: headers,
      body: bodyMsg
    );

    print(response.body);
    print(response.statusCode);

    switch (response.statusCode) {
        case 200:
          final responseTokenEmiWeb = getTokenEmiWebFromMap(
          response.body);
          tokenGlobal = responseTokenEmiWeb.accessToken;
          return true;
        case 401:
          return false;
        case 404:
          return false;
        default:
          return false;
      }
  }

//Función para limpiar el contenido de registros en las bases de datos para catálogos
  void clearDataBase() {
    dataBase.comunidadesBox.removeAll();
    dataBase.municipiosBox.removeAll();
    dataBase.estadosBox.removeAll();
  }

//Función para recuperar el catálogo de estados desde Emi Web
  Future<bool> getEstados() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/estado");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListEstados = getEstadosEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListEstados.payload!.length; i++) {
          final nuevoEstado = Estados(
          nombre: responseListEstados.payload![i].estado,
          activo: responseListEstados.payload![i].activo,
          idEmiWeb: responseListEstados.payload![i].idCatEstado,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para estados
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
          nuevoEstado.statusSync.target = nuevoSync;
          dataBase.estadosBox.put(nuevoEstado);
          print('Estado Emi Web agregado éxitosamente');
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getEstados();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
    }
  }

//Función para recuperar el catálogo de municipios desde Emi Web
  Future<bool> getMunicipios() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/municipio");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListMunicipios = getMunicipiosEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListMunicipios.payload!.length; i++) {
          final nuevoMunicipio = Municipios(
          nombre: responseListMunicipios.payload![i].municipio,
          activo: responseListMunicipios.payload![i].activo,
          idEmiWeb: responseListMunicipios.payload![i].idCatMunicipio,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para municipios y lo asociamos a su estado correspondiente
          final estado = dataBase.estadosBox.query(Estados_.idEmiWeb.equals(responseListMunicipios.payload![i].idCatEstado)).build().findUnique();
          if (estado != null) {
            final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
            nuevoMunicipio.statusSync.target = nuevoSync;
            nuevoMunicipio.estados.target = estado;
            dataBase.municipiosBox.put(nuevoMunicipio);
            print('Municipio Emi Web agregado éxitosamente');
          } else{
            return false;
          }
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getMunicipios();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
    }
  }

//Función para recuperar el catálogo de comunidades desde Emi Web
  Future<bool> getComunidades() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/comunidad");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListComunidades = getComunidadesEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListComunidades.payload!.length; i++) {
          final nuevaComunidad = Comunidades(
          nombre: responseListComunidades.payload![i].comunidad,
          activo: responseListComunidades.payload![i].activo,
          idEmiWeb: responseListComunidades.payload![i].idCatComunidad,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para comunidades y lo asociamos a su municipio correspondiente
          final municipio = dataBase.municipiosBox.query(Municipios_.idEmiWeb.equals(responseListComunidades.payload![i].idCatMunicipio)).build().findUnique();
          if (municipio != null) {
            final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
            nuevaComunidad.statusSync.target = nuevoSync;
            nuevaComunidad.municipios.target = municipio;
            dataBase.comunidadesBox.put(nuevaComunidad);
            print('Comunidad Emi Web agregada éxitosamente');
          } else{
            return false;
          }
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getComunidades();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
    }
  }

//Función para recuperar el catálogo de tipos de Proyecto desde Emi Web
  Future<bool> getTipoProyecto() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/tipoProyecto");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListTipoProyecto = getTipoProyectoEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListTipoProyecto.payload!.length; i++) {
          final nuevoTipoProyecto = TipoProyecto(
          tipoProyecto: responseListTipoProyecto.payload![i].tipoProyecto,
          activo: responseListTipoProyecto.payload![i].activo,
          idEmiWeb: responseListTipoProyecto.payload![i].idCatTipoProyecto,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para tipos de proyecto
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
          nuevoTipoProyecto.statusSync.target = nuevoSync;
          dataBase.tipoProyectoBox.put(nuevoTipoProyecto);
          print('Tipo Proyecto Emi Web agregada éxitosamente');
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getComunidades();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
    }
  }

//Función para recuperar el catálogo de catálogos proyecto desde Emi Web == Tabla "Proyectos" en Emi Web
  Future<bool> getCatalogosProyectos() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/proyecto");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListCatalogoProyecto = getCatalogoProyectosEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListCatalogoProyecto.payload!.length; i++) {
          final nuevoCatalogoProyecto = CatalogoProyecto(
          nombre: responseListCatalogoProyecto.payload![i].proyecto,
          activo: responseListCatalogoProyecto.payload![i].activo,
          idEmiWeb: responseListCatalogoProyecto.payload![i].idCatProyecto,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para catalogo proyecto y lo asociamos a su tipo de proyecto
          final tipoProyecto = dataBase.tipoProyectoBox.query(TipoProyecto_.idEmiWeb.equals(responseListCatalogoProyecto.payload![i].catTipoProyecto!.idCatTipoProyecto)).build().findUnique();
          if (tipoProyecto != null) {
            final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
            nuevoCatalogoProyecto.statusSync.target = nuevoSync;
            nuevoCatalogoProyecto.tipoProyecto.target = tipoProyecto;
            dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
            print('Catalogo Proyecto Web agregado éxitosamente');
          } else{
            return false;
          }
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getComunidades();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
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

//Función para recuperar el catálogo de ambito consultoría desde Emi Web 
  Future<bool> getAmbitoConsultoria() async {
    var url = Uri.parse("$baseUrlEmiWebServices/catalogos/ambito");
    final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
    var response = await http.get(
      url,
      headers: headers
    );

    switch (response.statusCode) {
      case 200: //Caso éxitoso
        final responseListAmbitoConsultoria = getAmbitoConsultoriaEmiWebFromMap(
        response.body);
        for (var i = 0; i < responseListAmbitoConsultoria.payload!.length; i++) {
          final nuevoAmbitoConsultoria = AmbitoConsultoria(
          nombreAmbito: responseListAmbitoConsultoria.payload![i].ambito,
          activo: responseListAmbitoConsultoria.payload![i].activo,
          idEmiWeb: responseListAmbitoConsultoria.payload![i].idCatAmbito,
          fechaRegistro: DateTime.now(), //Agregamos la fecha de registro actual porque no sabemos la del backend
          );
          //Modificamos el estado de sincronización sólo de forma local para ambito consultoria
          final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_, es nuestra bandera de sincronización por registro
          nuevoAmbitoConsultoria.statusSync.target = nuevoSync;
          dataBase.ambitoConsultoriaBox.put(nuevoAmbitoConsultoria);
          print('Ambito Consultoria Web agregado éxitosamente');
        }
        return true;
      case 401: //Error de Token incorrecto
        if(await getTokenOAuth()) {
          getComunidades();
          return true;
        } else{
          return false;
        }
      case 404: //Error de ruta incorrecta
        return true;
      default:
        return false;
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
}
