import 'dart:convert';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsEmiWeb/get_ambito_consultoria_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_area_circulo_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_bancos_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_catalogo_proyectos_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_condiciones_pago_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_estado_inversiones_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_familia_producto_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_fase_emprendimiento_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_porcentaje_avance_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_prod_proyecto_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_productos_prov_by_id_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_productos_prov_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_proveedores_by_id_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_proveedores_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_empaques_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_tipo_proveedor_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_unidad_medida_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:bizpro_app/modelsPocketbase/get_comunidades.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proyecto.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsEmiWeb/get_comunidades_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_estados_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_municipios_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_proyecto_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
import 'package:bizpro_app/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:bizpro_app/modelsPocketbase/get_prod_proyecto.dart';
import 'package:bizpro_app/modelsPocketbase/get_productos_prov.dart';
import 'package:bizpro_app/modelsPocketbase/get_proveedores.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proveedor.dart';


import 'package:bizpro_app/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:bizpro_app/modelsPocketbase/get_area_circulo.dart';
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';

import 'package:http/http.dart' as http;

class CatalogoEmiWebProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
  bool exitoso = true;

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

  Future<bool> getCatalogosEmiWeb() async {
    if (await getTokenOAuth()) {
      banderasExistoSync.add(await getEstados());
      banderasExistoSync.add(await getMunicipios());
      banderasExistoSync.add(await getComunidades());
      banderasExistoSync.add(await getTipoProyecto());
      banderasExistoSync.add(await getCatalogosProyectos());
      banderasExistoSync.add(await getFamiliaProd());
      banderasExistoSync.add(await getUnidadMedida());
      banderasExistoSync.add(await getAmbitoConsultoria());
      banderasExistoSync.add(await getAreaCirculo());
      banderasExistoSync.add(await getFasesEmp());
      banderasExistoSync.add(await getTipoEmpaque());
      banderasExistoSync.add(await getEstadoInversion());
      banderasExistoSync.add(await getTipoProveedor());
      banderasExistoSync.add(await getCondicionesPago());
      banderasExistoSync.add(await getBancos());
      banderasExistoSync.add(await getPorcentajeAvance());
      banderasExistoSync.add(await getProveedoresNoArchivados());
      banderasExistoSync.add(await getProveedoresArchivados());
      banderasExistoSync.add(await getProductosProv());
      banderasExistoSync.add(await getProdProyecto());
      for (var element in banderasExistoSync) {
        //Aplicamos una operación and para validar que no haya habido un catálogo con False
        exitoso = exitoso && element;
      }
      //Verificamos que no haya habido errores al sincronizar con las banderas
      if (exitoso) {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = true;
        banderasExistoSync.clear();
        notifyListeners();
        return exitoso;
      } else {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        banderasExistoSync.clear();
        notifyListeners();
        return exitoso;
      }
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExistoSync.clear();
      notifyListeners();
      return false;
    }
  }

//Función inicial para recuperar el Token para el llamado de catálogos
  Future<bool> getTokenOAuth() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": prefs.getString("userId"),
          "password": prefs.getString("passEncrypted"),
        });
      
      var response = await http.post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      print(response.body);

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
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de estados desde Emi Web
  Future<bool> getEstados() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListEstados.payload!.length; i++) {
            //Verificamos que el nuevo estado no exista en Pocketbase
            final recordEstado = await client.records.getFullList(
              'estados', 
              batch: 200, 
              filter: "id_emi_web='${responseListEstados.payload![i].idCatEstado}'");
            if (recordEstado.isEmpty) {
              //Se agrega el estado como nuevo en la colección de Pocketbase
              final newRecordEstado = await client.records.create('estados', body: {
              "nombre_estado": responseListEstados.payload![i].estado,
              "activo": responseListEstados.payload![i].activo,
              "id_emi_web": responseListEstados.payload![i].idCatEstado.toString(),
              });
              if (newRecordEstado.id.isNotEmpty) {
                print('Estado Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordEstadoParse = getEstadosFromMap(recordEstado.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordEstadoParse.nombreEstado != responseListEstados.payload![i].estado ||
                  recordEstadoParse.activo != responseListEstados.payload![i].activo) {
                  final updateRecordEstado = await client.records.update('estados', recordEstadoParse.id, 
                  body: {
                    "nombre_estado": responseListEstados.payload![i].estado,
                    "activo": responseListEstados.payload![i].activo,
                  });
                  if (updateRecordEstado.id.isNotEmpty) {
                    print('Estado Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
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
          return false;
        default:
          return false;
      }  
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de municipios desde Emi Web
  Future<bool> getMunicipios() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListMunicipios.payload!.length; i++) {
            //Verificamos que el nuevo municipio no exista en Pocketbase
            final recordMunicipio = await client.records.getFullList(
              'municipios', 
              batch: 200, 
              filter: "id_emi_web='${responseListMunicipios.payload![i].idCatMunicipio}'");
            if (recordMunicipio.isEmpty) {
              //Se recupera el id del estado en Pocketbase y se acocia con el nuevo Municipio
              final recordEstado = await client.records.getFullList(
                'estados', 
                batch: 200, 
                filter: "id_emi_web='${responseListMunicipios.payload![i].idCatEstado}'");
              if (recordEstado.isNotEmpty) {
                //Se agrega el municipio como nuevo en la colección de Pocketbase
                final recordMunicipio = await client.records.create('municipios', body: {
                "nombre_municipio": responseListMunicipios.payload![i].municipio,
                "id_estado_fk": recordEstado.first.id,
                "activo": responseListMunicipios.payload![i].activo,
                "id_emi_web": responseListMunicipios.payload![i].idCatMunicipio.toString(),
                });
                if (recordMunicipio.id.isNotEmpty) {
                  print('Municipio Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza el municipio en la colección de Pocketbase
              final recordMunicipioParse = getMunicipiosFromMap(recordMunicipio.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordMunicipioParse.nombreMunicipio != responseListMunicipios.payload![i].municipio ||
                  recordMunicipioParse.activo != responseListMunicipios.payload![i].activo) {
                  final updateRecordMunicipio = await client.records.update('municipios', recordMunicipioParse.id, 
                  body: {
                    "nombre_municipio": responseListMunicipios.payload![i].municipio,
                    "activo": responseListMunicipios.payload![i].activo,
                  });
                  if (updateRecordMunicipio.id.isNotEmpty) {
                    print('Municipio Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
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
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de comunidades desde Emi Web
  Future<bool> getComunidades() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListComunidades.payload!.length; i++) {
            //Verificamos que la nueva comunidad no exista en Pocketbase
            final recordComunidad = await client.records.getFullList(
              'comunidades', 
              batch: 200, 
              filter: "id_emi_web='${responseListComunidades.payload![i].idCatComunidad}'");
            if (recordComunidad.isEmpty) {
              //Se recupera el id del municipio en Pocketbase y se acocia con la nueva Comunidad
              final recordMunicipio = await client.records.getFullList(
                'municipios', 
                batch: 200, 
                filter: "id_emi_web='${responseListComunidades.payload![i].idCatMunicipio}'");
              if (recordMunicipio.isNotEmpty) {
                //Se agrega la comunidad como nueva en la colección de Pocketbase
                final recordComunidad = await client.records.create('comunidades', body: {
                "nombre_comunidad": responseListComunidades.payload![i].comunidad,
                "id_municipio_fk": recordMunicipio.first.id,
                "activo": responseListComunidades.payload![i].activo,
                "id_emi_web": responseListComunidades.payload![i].idCatComunidad.toString(),
                });
                if (recordComunidad.id.isNotEmpty) {
                  print('Comunidad Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza la comunidad en la colección de Pocketbase
              final recordComunidadParse = getComunidadesFromMap(recordComunidad.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordComunidadParse.nombreComunidad != responseListComunidades.payload![i].comunidad ||
                  recordComunidadParse.activo != responseListComunidades.payload![i].activo) {
                  final updateRecordComunidad = await client.records.update('comunidades', recordComunidadParse.id, 
                  body: {
                    "nombre_comunidad": responseListComunidades.payload![i].comunidad,
                    "activo": responseListComunidades.payload![i].activo,
                  });
                  if (updateRecordComunidad.id.isNotEmpty) {
                    print('Comunidad Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
                }
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
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipos de Proyecto desde Emi Web
  Future<bool> getTipoProyecto() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoProyecto.payload!.length; i++) {
            //Verificamos que el nuevo tipo proyecto no exista en Pocketbase
            final recordTipoProyecto = await client.records.getFullList(
              'tipo_proyecto', 
              batch: 200, 
              filter: "id_emi_web='${responseListTipoProyecto.payload![i].idCatTipoProyecto}'");
            if (recordTipoProyecto.isEmpty) {
              //Se agrega el tipo proyecto como nuevo en la colección de Pocketbase
              final newRecordTipoProyecto = await client.records.create('tipo_proyecto', body: {
              "tipo_proyecto": responseListTipoProyecto.payload![i].tipoProyecto,
              "activo": responseListTipoProyecto.payload![i].activo,
              "id_emi_web": responseListTipoProyecto.payload![i].idCatTipoProyecto.toString(),
              });
              if (newRecordTipoProyecto.id.isNotEmpty) {
                print('Tipo Proyecto Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el tipo proyecto en la colección de Pocketbase
              final recordTipoProyectoParse = getTipoProyectoFromMap(recordTipoProyecto.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoProyectoParse.tipoProyecto != responseListTipoProyecto.payload![i].tipoProyecto ||
                  recordTipoProyectoParse.activo != responseListTipoProyecto.payload![i].activo) {
                  final updateRecordEstado = await client.records.update('tipo_proyecto', recordTipoProyectoParse.id, 
                  body: {
                    "tipo_proyecto": responseListTipoProyecto.payload![i].tipoProyecto,
                    "activo": responseListTipoProyecto.payload![i].activo,
                  });
                  if (updateRecordEstado.id.isNotEmpty) {
                    print('Tipo Proyecto Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getTipoProyecto();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de catálogos proyecto desde Emi Web == Tabla "Proyectos" en Emi Web
  Future<bool> getCatalogosProyectos() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListCatalogoProyecto.payload!.length; i++) {
            //Verificamos que el nuevo catálogo proyecto no exista en Pocketbase
            final recordCatalogoProyecto = await client.records.getFullList(
              'cat_proyecto', 
              batch: 200, 
              filter: "id_emi_web='${responseListCatalogoProyecto.payload![i].idCatProyecto}'");
            if (recordCatalogoProyecto.isEmpty) {
              //Se recupera el id del tipo proyecto en Pocketbase y se acocia con el nuevo Catálogo Proyecto
              final recordTipoProyecto = await client.records.getFullList(
                'tipo_proyecto', 
                batch: 200, 
                filter: "id_emi_web='${responseListCatalogoProyecto.payload![i].catTipoProyecto!.idCatTipoProyecto}'");
              if (recordTipoProyecto.isNotEmpty) {
                //Se agrega el catálogo proyecto como nuevo en la colección de Pocketbase
                final recordCatalogoProyecto = await client.records.create('cat_proyecto', body: {
                "nombre_proyecto": responseListCatalogoProyecto.payload![i].proyecto,
                "id_tipo_proyecto_fk": recordTipoProyecto.first.id,
                "activo": responseListCatalogoProyecto.payload![i].activo,
                "id_emi_web": responseListCatalogoProyecto.payload![i].idCatProyecto.toString(),
                });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  print('Catálogo Proyecto Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza el catálogo proyecto en la colección de Pocketbase
              final recordCatalogoProyectoParse = getCatalogoProyectosFromMap(recordCatalogoProyecto.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordCatalogoProyectoParse.nombreProyecto != responseListCatalogoProyecto.payload![i].proyecto ||
                  recordCatalogoProyectoParse.activo != responseListCatalogoProyecto.payload![i].activo) {
                  final updateRecordCatalogoProyecto = await client.records.update('cat_proyecto', recordCatalogoProyectoParse.id, 
                  body: {
                    "nombre_proyecto": responseListCatalogoProyecto.payload![i].proyecto,
                    "activo": responseListCatalogoProyecto.payload![i].activo,
                  });
                  if (updateRecordCatalogoProyecto.id.isNotEmpty) {
                    print('Comunidad Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getCatalogosProyectos();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de Familia Producto desde Emi Web
  Future<bool> getFamiliaProd() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/familiainversion");
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
          final responseListFamiliaProducto = getFamiliaProductoEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListFamiliaProducto.payload!.length; i++) {
            //Verificamos que el nuevo area circulo no exista en Pocketbase
            final recordFamiliaProducto = await client.records.getFullList(
              'familia_prod', 
              batch: 200, 
              filter: "id_emi_web='${responseListFamiliaProducto.payload![i].idCatFamiliaInversion}'");
            if (recordFamiliaProducto.isEmpty) {
              //Se agrega el area circulo como nuevo en la colección de Pocketbase
              final recordFamiliaProducto = await client.records.create('familia_prod', body: {
              "nombre_tipo_prod": responseListFamiliaProducto.payload![i].familiaInversionNecesaria,
              "activo": responseListFamiliaProducto.payload![i].activo,
              "id_emi_web": responseListFamiliaProducto.payload![i].idCatFamiliaInversion.toString(),
              });
              if (recordFamiliaProducto.id.isNotEmpty) {
                print('Familia Producto Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la familia producto en la colección de Pocketbase
              final recordFamiliaProductoParse = getFamiliaProductosFromMap(recordFamiliaProducto.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordFamiliaProductoParse.nombreTipoProd != responseListFamiliaProducto.payload![i].familiaInversionNecesaria ||
                  recordFamiliaProductoParse.activo != responseListFamiliaProducto.payload![i].activo) {
                  final updateRecordFamiliaProducto = await client.records.update('familia_prod', recordFamiliaProductoParse.id, 
                  body: {
                    "nombre_tipo_prod": responseListFamiliaProducto.payload![i].familiaInversionNecesaria,
                    "activo": responseListFamiliaProducto.payload![i].activo,
                  });
                  if (updateRecordFamiliaProducto.id.isNotEmpty) {
                    print('Familia Producto Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getFamiliaProd();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de unidad de medida proyecto desde Emi Web
  Future<bool> getUnidadMedida() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/unidadMedidaEmprendedor");
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
          final responseListUnidadMedida = getUnidadMedidaEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListUnidadMedida.payload!.length; i++) {
            //Verificamos que la nueva unidad de medida no exista en Pocketbase
            final recordUnidadMedida = await client.records.getFullList(
              'und_medida', 
              batch: 200, 
              filter: "id_emi_web='${responseListUnidadMedida.payload![i].idCatUnidadMedida}'");
            if (recordUnidadMedida.isEmpty) {
              //Se agrega la unidad de medida como nueva en la colección de Pocketbase
              final recordUnidadMedida = await client.records.create('und_medida', body: {
              "unidad_medida": responseListUnidadMedida.payload![i].unidadMedida,
              "activo": responseListUnidadMedida.payload![i].activo,
              "id_emi_web": responseListUnidadMedida.payload![i].idCatUnidadMedida.toString(),
              });
              if (recordUnidadMedida.id.isNotEmpty) {
                print('Unidad de Medida Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la unidad de medida en la colección de Pocketbase
              final recordUnidadMedidaParse = getUnidadesMedidaFromMap(recordUnidadMedida.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordUnidadMedidaParse.unidadMedida != responseListUnidadMedida.payload![i].unidadMedida ||
                  recordUnidadMedidaParse.activo != responseListUnidadMedida.payload![i].activo) {
                  final updateRecordUnidadMedida = await client.records.update('und_medida', recordUnidadMedidaParse.id, 
                  body: {
                    "unidad_medida": responseListUnidadMedida.payload![i].unidadMedida,
                    "activo": responseListUnidadMedida.payload![i].activo,
                  });
                  if (updateRecordUnidadMedida.id.isNotEmpty) {
                    print('Unidad de Medida Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getUnidadMedida();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de ambito consultoría desde Emi Web 
  Future<bool> getAmbitoConsultoria() async {
    try {
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
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListAmbitoConsultoria.payload!.length; i++) {
            //Verificamos que el nuevo ámbito consultoría no exista en Pocketbase
            final recordAmbitoConsultoria = await client.records.getFullList(
              'ambito_consultoria', 
              batch: 200, 
              filter: "id_emi_web='${responseListAmbitoConsultoria.payload![i].idCatAmbito}'");
            if (recordAmbitoConsultoria.isEmpty) {
              //Se agrega el ámbito consultoría como nuevo en la colección de Pocketbase
              final recordAmbitoConsultoria = await client.records.create('ambito_consultoria', body: {
              "nombre_ambito": responseListAmbitoConsultoria.payload![i].ambito,
              "activo": responseListAmbitoConsultoria.payload![i].activo,
              "id_emi_web": responseListAmbitoConsultoria.payload![i].idCatAmbito.toString(),
              });
              if (recordAmbitoConsultoria.id.isNotEmpty) {
                print('Ámbito Consultoría Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el ámbito consultoría en la colección de Pocketbase
              final recordAmbitoConsultoriaParse = getAmbitoConsultoriaFromMap(recordAmbitoConsultoria.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordAmbitoConsultoriaParse.nombreAmbito != responseListAmbitoConsultoria.payload![i].ambito ||
                  recordAmbitoConsultoriaParse.activo != responseListAmbitoConsultoria.payload![i].activo) {
                  final updateRecordAmbitoConsultoria = await client.records.update('ambito_consultoria', recordAmbitoConsultoriaParse.id, 
                  body: {
                    "nombre_ambito": responseListAmbitoConsultoria.payload![i].ambito,
                    "activo": responseListAmbitoConsultoria.payload![i].activo,
                  });
                  if (updateRecordAmbitoConsultoria.id.isNotEmpty) {
                    print('Ámbito Consultoría Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getAmbitoConsultoria();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de área círculo desde Emi Web 
  Future<bool> getAreaCirculo() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/areadelcirculo");
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
          final responseListAreaCirculo = getAreaCirculoEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListAreaCirculo.payload!.length; i++) {
            //Verificamos que el nuevo area circulo no exista en Pocketbase
            final recordAreaCirculo = await client.records.getFullList(
              'area_circulo', 
              batch: 200, 
              filter: "id_emi_web='${responseListAreaCirculo.payload![i].idCatAreaCirculo}'");
            if (recordAreaCirculo.isEmpty) {
              //Se agrega el area circulo como nuevo en la colección de Pocketbase
              final recordAreaCirculo = await client.records.create('area_circulo', body: {
              "nombre_area": responseListAreaCirculo.payload![i].areaCirculo,
              "activo": responseListAreaCirculo.payload![i].activo,
              "id_emi_web": responseListAreaCirculo.payload![i].idCatAreaCirculo.toString(),
              });
              if (recordAreaCirculo.id.isNotEmpty) {
                print('Area Circulo Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el area circulo en la colección de Pocketbase
              final recordAreaCirculoParse = getAreaCirculoFromMap(recordAreaCirculo.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordAreaCirculoParse.nombreArea != responseListAreaCirculo.payload![i].areaCirculo ||
                  recordAreaCirculoParse.activo != responseListAreaCirculo.payload![i].activo) {
                  final updateRecordAmbitoConsultoria = await client.records.update('area_circulo', recordAreaCirculoParse.id, 
                  body: {
                    "nombre_area": responseListAreaCirculo.payload![i].areaCirculo,
                    "activo": responseListAreaCirculo.payload![i].activo,
                  });
                  if (updateRecordAmbitoConsultoria.id.isNotEmpty) {
                    print('Ámbito Consultoría Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getAreaCirculo();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }


//Función para recuperar el catálogo de fases de emprendimiento desde Emi Web 
  Future<bool> getFasesEmp() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/fase");
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
          final responseListFaseEmprendimiento = getFaseEmprendimientoEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListFaseEmprendimiento.payload!.length; i++) {
            //Verificamos que la nueva fase del emprendimiento no exista en Pocketbase
            final recordFaseEmprendimiento = await client.records.getFullList(
              'fases_emp', 
              batch: 200, 
              filter: "id_emi_web='${responseListFaseEmprendimiento.payload![i].idCatFase}'");
            if (recordFaseEmprendimiento.isEmpty) {
              //Se agrega la fase del emprendimiento como nueva en la colección de Pocketbase
              final newRecordFaseEmprendimiento = await client.records.create('fases_emp', body: {
              "fase": responseListFaseEmprendimiento.payload![i].fase,
              "id_emi_web": responseListFaseEmprendimiento.payload![i].idCatFase.toString(),
              });
              if (newRecordFaseEmprendimiento.id.isNotEmpty) {
                print('Fase Emprendimiento Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordFaseEmprendimientoParse = getFasesEmpFromMap(recordFaseEmprendimiento.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordFaseEmprendimientoParse.fase != responseListFaseEmprendimiento.payload![i].fase) {
                  final updateRecordEstado = await client.records.update('fases_emp', recordFaseEmprendimientoParse.id, 
                  body: {
                    "fase": responseListFaseEmprendimiento.payload![i].fase,
                  });
                  if (updateRecordEstado.id.isNotEmpty) {
                    print('Fase Emprendimiento Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getFasesEmp();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }  
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de empaques desde Emi Web 
  Future<bool> getTipoEmpaque() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/tipoempaque");
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
          final responseListTipoEmpaques = getTipoEmpaquesEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoEmpaques.payload!.length; i++) {
            //Verificamos que el nuevo tipo de empaque no exista en Pocketbase
            final recordTipoEmpaque = await client.records.getFullList(
              'tipo_empaques', 
              batch: 200, 
              filter: "id_emi_web='${responseListTipoEmpaques.payload![i].idCatTipoEmpaque}'");
            if (recordTipoEmpaque.isEmpty) {
              //Se agrega lo tipo de empaque como nuevo en la colección de Pocketbase
              final newRecordTipoEmpaque = await client.records.create('tipo_empaques', body: {
              "tipo_empaque": responseListTipoEmpaques.payload![i].tipoEmpaque,
              "id_emi_web": responseListTipoEmpaques.payload![i].idCatTipoEmpaque.toString(),
              });
              if (newRecordTipoEmpaque.id.isNotEmpty) {
                print('Tipo Empaque Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordTipoEmpaqueParse = getTipoEmpaquesFromMap(recordTipoEmpaque.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoEmpaqueParse.tipoEmpaque != responseListTipoEmpaques.payload![i].tipoEmpaque) {
                  final updateRecordTipoEmpaque = await client.records.update('tipo_empaques', recordTipoEmpaqueParse.id, 
                  body: {
                    "tipo_empaque": responseListTipoEmpaques.payload![i].tipoEmpaque,
                  });
                  if (updateRecordTipoEmpaque.id.isNotEmpty) {
                    print('Tipo Empaque Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getTipoEmpaque();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de estado de inversion desde Emi Web 
  Future<bool> getEstadoInversion() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/estadoinversion");
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
          final responseListEstadoInversion = getEstadoInversionesEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListEstadoInversion.payload!.length; i++) {
            //Verificamos que el nuevo estado de inversión no exista en Pocketbase
            final recordEstadoInversion = await client.records.getFullList(
              'estado_inversiones', 
              batch: 200, 
              filter: "id_emi_web='${responseListEstadoInversion.payload![i].idCatEstadoInversion}'");
            if (recordEstadoInversion.isEmpty) {
              //Se agrega el estado de inversión como nuevo en la colección de Pocketbase
              final newRecordEstadoInversion = await client.records.create('estado_inversiones', body: {
              "estado": responseListEstadoInversion.payload![i].estadoInversion,
              "id_emi_web": responseListEstadoInversion.payload![i].idCatEstadoInversion.toString(),
              });
              if (newRecordEstadoInversion.id.isNotEmpty) {
                print('Estado Inversión Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado de inversión en la colección de Pocketbase
              final recordEstadoInversionParse = getEstadoInversionesFromMap(recordEstadoInversion.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordEstadoInversionParse.estado!= responseListEstadoInversion.payload![i].estadoInversion) {
                  final updateRecordEstado = await client.records.update('estado_inversiones', recordEstadoInversionParse.id, 
                  body: {
                    "estado": responseListEstadoInversion.payload![i].estadoInversion,
                  });
                  if (updateRecordEstado.id.isNotEmpty) {
                    print('Estado Inversión Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getEstadoInversion();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de proveedor de inversion desde Emi Web 
  Future<bool> getTipoProveedor() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/tipoProveedor");
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
          final responseListTipoProveedor = getTipoProveedorEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoProveedor.payload!.length; i++) {
            //Verificamos que el nuevo tipo de proveedor no exista en Pocketbase
            final recordTipoProveedor = await client.records.getFullList(
              'tipo_proveedor', 
              batch: 200, 
              filter: "id_emi_web='${responseListTipoProveedor.payload![i].idCatTipoProveedor}'");
            if (recordTipoProveedor.isEmpty) {
              //Se agrega el tipo de proveedor como nuevo en la colección de Pocketbase
              final newRecordEstadoInversion = await client.records.create('tipo_proveedor', body: {
              "tipo_proveedor": responseListTipoProveedor.payload![i].tipoProveedor,
              "activo": responseListTipoProveedor.payload![i].activo,
              "id_emi_web": responseListTipoProveedor.payload![i].idCatTipoProveedor.toString(),
              });
              if (newRecordEstadoInversion.id.isNotEmpty) {
                print('Tipo Proveedor Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el tipo de proveedor en la colección de Pocketbase
              final recordTipoProveedorParse = getTipoProveedorFromMap(recordTipoProveedor.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoProveedorParse.tipoProveedor != responseListTipoProveedor.payload![i].tipoProveedor) {
                  final updateRecordTipoProveedor = await client.records.update('tipo_proveedor', recordTipoProveedorParse.id, 
                  body: {
                    "tipo_proveedor": responseListTipoProveedor.payload![i].tipoProveedor,
                    "activo": responseListTipoProveedor.payload![i].activo,
                  });
                  if (updateRecordTipoProveedor.id.isNotEmpty) {
                    print('Tipo Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getTipoProveedor();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de condiciones de pago desde Emi Web 
  Future<bool> getCondicionesPago() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/condicionPago");
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
          final responseListCondicionPago = getCondicionesPagoEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListCondicionPago.payload!.length; i++) {
            //Verificamos que la nueva condicion de pago no exista en Pocketbase
            final recordCondicionPago = await client.records.getFullList(
              'condiciones_pago', 
              batch: 200, 
              filter: "id_emi_web='${responseListCondicionPago.payload![i].idCatCondicionesPago}'");
            if (recordCondicionPago.isEmpty) {
              //Se agrega la condicion de pago como nuevo en la colección de Pocketbase
              final newRecordCondicionPago = await client.records.create('condiciones_pago', body: {
              "condicion_pago": responseListCondicionPago.payload![i].condicionesPago,
              "activo": responseListCondicionPago.payload![i].activo,
              "id_emi_web": responseListCondicionPago.payload![i].idCatCondicionesPago.toString(),
              });
              if (newRecordCondicionPago.id.isNotEmpty) {
                print('Condición Pago Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la condicion de pago en la colección de Pocketbase
              final recordCondicionPagoParse = getCondicionesPagoFromMap(recordCondicionPago.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordCondicionPagoParse.condicionPago != responseListCondicionPago.payload![i].condicionesPago) {
                  final updateRecordTipoProveedor = await client.records.update('condiciones_pago', recordCondicionPagoParse.id, 
                  body: {
                    "condicion_pago": responseListCondicionPago.payload![i].condicionesPago,
                    "activo": responseListCondicionPago.payload![i].activo,
                  });
                  if (updateRecordTipoProveedor.id.isNotEmpty) {
                    print('Condición Pago Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getCondicionesPago();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de bancos desde Emi Web 
Future<bool> getBancos() async {
  try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/bancos");
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
          final responseListBancos = getBancosEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListBancos.payload!.length; i++) {
            //Verificamos que el nuevo banco no exista en Pocketbase
            final recordBanco = await client.records.getFullList(
              'bancos', 
              batch: 200, 
              filter: "id_emi_web='${responseListBancos.payload![i].idCatBancos}'");
            if (recordBanco.isEmpty) {
              //Se agrega el banco como nuevo en la colección de Pocketbase
              final newRecordBanco = await client.records.create('bancos', body: {
              "nombre_banco": responseListBancos.payload![i].banco,
              "activo": responseListBancos.payload![i].activo,
              "id_emi_web": responseListBancos.payload![i].idCatBancos.toString(),
              });
              if (newRecordBanco.id.isNotEmpty) {
                print('Banco Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el banco en la colección de Pocketbase
              final recordBancoParse = getBancosFromMap(recordBanco.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordBancoParse.nombreBanco != responseListBancos.payload![i].banco) {
                  final updateRecordBanco = await client.records.update('bancos', recordBancoParse.id, 
                  body: {
                    "nombre_banco": responseListBancos.payload![i].banco,
                    "activo": responseListBancos.payload![i].activo,
                  });
                  if (updateRecordBanco.id.isNotEmpty) {
                    print('Banco Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getBancos();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de porcentaje avance desde Emi Web 
Future<bool> getPorcentajeAvance() async {
   try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/porcentajeavance");
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
          final responseListPorcentajeAvance = getPorcentajeAvanceEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListPorcentajeAvance.payload!.length; i++) {
            //Verificamos que el nuevo porcentaje avance no exista en Pocketbase
            final recordPorcentajeAvance = await client.records.getFullList(
              'porcentaje_avance', 
              batch: 200, 
              filter: "id_emi_web='${responseListPorcentajeAvance.payload![i].idCatPorcentajeAvance}'");
            if (recordPorcentajeAvance.isEmpty) {
              //Se agrega el porcentaje avance como nuevo en la colección de Pocketbase
              final newRecordPorcentajeAvance = await client.records.create('porcentaje_avance', body: {
              "porcentaje": responseListPorcentajeAvance.payload![i].porcentajeAvance,
              "id_emi_web": responseListPorcentajeAvance.payload![i].idCatPorcentajeAvance.toString(),
              });
              if (newRecordPorcentajeAvance.id.isNotEmpty) {
                print('Porcentaje Avance Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el porcentaje avance en la colección de Pocketbase
              final recordPorcentajeAvanceParse = getPorcentajeAvanceFromMap(recordPorcentajeAvance.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordPorcentajeAvanceParse.porcentaje != responseListPorcentajeAvance.payload![i].porcentajeAvance) {
                  final updateRecordPorcentajeAvance = await client.records.update('porcentaje_avance', recordPorcentajeAvanceParse.id, 
                  body: {
                    "porcentaje": responseListPorcentajeAvance.payload![i].porcentajeAvance,
                  });
                  if (updateRecordPorcentajeAvance.id.isNotEmpty) {
                    print('Porcentaje Avance Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getPorcentajeAvance();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de proveedores no archivados desde Emi Web 
Future<bool> getProveedoresNoArchivados() async {
  try {
      var url = Uri.parse("$baseUrlEmiWebServices/proveedores?archivado=false");
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
          final responseListProveedores = getProveedoresEmiWebFromMap(
            const Utf8Decoder().convert(response.bodyBytes)
          );
          for(var i = 0; i < responseListProveedores.payload!.length; i++) {
            var url = Uri.parse("$baseUrlEmiWebServices/proveedores/registro/${responseListProveedores.payload![i].id}");
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
              final responseProveedor = getProveedorByIdEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
              //Verificamos que el nuevo proveedor no exista en Pocketbase
              final recordProveedor = await client.records.getFullList(
                'proveedores', 
                batch: 200, 
                filter: "id_emi_web='${responseProveedor.payload!.idProveedor}'");
              if (recordProveedor.isEmpty) {
                //Se recupera el id del tipoProveedor, condicionPago, banco y comunidad en Pocketbase y se acocia con el nuevo Proveedor
                final recordTipoProveedor = await client.records.getFullList(
                  'tipo_proveedor', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idTipoProveedor}'");
                final recordCondicionPago = await client.records.getFullList(
                  'condiciones_pago', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idCondicionesPago}'");
                final recordBanco = await client.records.getFullList(
                  'bancos', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idBanco}'");
                final recordComunidad = await client.records.getFullList(
                  'comunidades', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idCatComunidad}'");
                if (recordTipoProveedor.isNotEmpty && recordCondicionPago.isNotEmpty 
                    && recordBanco.isNotEmpty && recordComunidad.isNotEmpty) {
                    //Se agrega el proveedor como nuevo en la colección de Pocketbase
                    final recordProveedor = await client.records.create('proveedores', body: {
                    "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                    "rfc": responseProveedor.payload!.rfc,
                    "id_tipo_proveedor_fk": recordTipoProveedor.first.id,
                    "direccion": responseProveedor.payload!.direccion,
                    "id_comunidad_fk": recordComunidad.first.id,
                    "nombre_encargado": responseProveedor.payload!.nombreEncargado,
                    "id_condicion_pago_fk": recordCondicionPago.first.id,
                    "clabe": responseProveedor.payload!.cuentaClabe,
                    "telefono": responseProveedor.payload!.telefono,
                    "id_banco_fk": recordBanco.first.id,
                    "archivado": responseProveedor.payload!.archivado,
                    "id_emi_web": responseProveedor.payload!.idProveedor.toString(),
                    });
                    if (recordProveedor.id.isNotEmpty) {
                      print('Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                } else {
                  return false;
                }
              } else {
                //Se actualiza el proveedor en la colección de Pocketbase
                final recordProveedorParse = getProveedoresFromMap(recordProveedor.first.toString());
                //Verificamos que los campos de este registro sean diferentes para actualizarlo
                if (recordProveedorParse.nombreFiscal != responseProveedor.payload!.nombreFiscal ||
                    recordProveedorParse.rfc != responseProveedor.payload!.rfc ||
                    recordProveedorParse.direccion != responseProveedor.payload!.direccion ||
                    recordProveedorParse.nombreEncargado != responseProveedor.payload!.nombreEncargado ||
                    recordProveedorParse.clabe != responseProveedor.payload!.cuentaClabe ||
                    recordProveedorParse.telefono != responseProveedor.payload!.telefono ||
                    recordProveedorParse.archivado != responseProveedor.payload!.archivado
                    ) {
                    final updateRecordProveedor = await client.records.update('proveedores', recordProveedorParse.id, 
                    body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "direccion": responseProveedor.payload!.direccion,
                      "nombre_encargado": responseProveedor.payload!.nombreEncargado,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "archivado": responseProveedor.payload!.archivado,
                    });
                    if (updateRecordProveedor.id.isNotEmpty) {
                      print('Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                }
              }
              break;
            case 401: //Error de Token incorrecto
              if(await getTokenOAuth()) {
                getProveedoresNoArchivados();
                return true;
              } else{
                return false;
              }
            case 404: //Error de ruta incorrecta
              return false;
            default:
              return false;
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getProveedoresNoArchivados();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de proveedores archivados desde Emi Web 
Future<bool> getProveedoresArchivados() async {
  try {
      var url = Uri.parse("$baseUrlEmiWebServices/proveedores?archivado=true");
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
          final responseListProveedores = getProveedoresEmiWebFromMap(
            const Utf8Decoder().convert(response.bodyBytes)
          );
          for(var i = 0; i < responseListProveedores.payload!.length; i++) {
            var url = Uri.parse("$baseUrlEmiWebServices/proveedores/registro/${responseListProveedores.payload![i].id}");
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
              final responseProveedor = getProveedorByIdEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
              //Verificamos que el nuevo proveedor no exista en Pocketbase
              final recordProveedor = await client.records.getFullList(
                'proveedores', 
                batch: 200, 
                filter: "id_emi_web='${responseProveedor.payload!.idProveedor}'");
              if (recordProveedor.isEmpty) {
                //Se recupera el id del tipoProveedor, condicionPago, banco y comunidad en Pocketbase y se acocia con el nuevo Proveedor
                final recordTipoProveedor = await client.records.getFullList(
                  'tipo_proveedor', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idTipoProveedor}'");
                final recordCondicionPago = await client.records.getFullList(
                  'condiciones_pago', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idCondicionesPago}'");
                final recordBanco = await client.records.getFullList(
                  'bancos', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idBanco}'");
                final recordComunidad = await client.records.getFullList(
                  'comunidades', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProveedor.payload!.idCatComunidad}'");
                if (recordTipoProveedor.isNotEmpty && recordCondicionPago.isNotEmpty 
                    && recordBanco.isNotEmpty && recordComunidad.isNotEmpty) {
                    //Se agrega el proveedor como nuevo en la colección de Pocketbase
                    final recordProveedor = await client.records.create('proveedores', body: {
                    "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                    "rfc": responseProveedor.payload!.rfc,
                    "id_tipo_proveedor_fk": recordTipoProveedor.first.id,
                    "direccion": responseProveedor.payload!.direccion,
                    "id_comunidad_fk": recordComunidad.first.id,
                    "nombre_encargado": responseProveedor.payload!.nombreEncargado,
                    "id_condicion_pago_fk": recordCondicionPago.first.id,
                    "clabe": responseProveedor.payload!.cuentaClabe,
                    "telefono": responseProveedor.payload!.telefono,
                    "id_banco_fk": recordBanco.first.id,
                    "archivado": responseProveedor.payload!.archivado,
                    "id_emi_web": responseProveedor.payload!.idProveedor.toString(),
                    });
                    if (recordProveedor.id.isNotEmpty) {
                      print('Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                } else {
                  return false;
                }
              } else {
                //Se actualiza el proveedor en la colección de Pocketbase
                final recordProveedorParse = getProveedoresFromMap(recordProveedor.first.toString());
                //Verificamos que los campos de este registro sean diferentes para actualizarlo
                if (recordProveedorParse.nombreFiscal != responseProveedor.payload!.nombreFiscal ||
                    recordProveedorParse.rfc != responseProveedor.payload!.rfc ||
                    recordProveedorParse.direccion != responseProveedor.payload!.direccion ||
                    recordProveedorParse.nombreEncargado != responseProveedor.payload!.nombreEncargado ||
                    recordProveedorParse.clabe != responseProveedor.payload!.cuentaClabe ||
                    recordProveedorParse.telefono != responseProveedor.payload!.telefono ||
                    recordProveedorParse.archivado != responseProveedor.payload!.archivado
                    ) {
                    final updateRecordProveedor = await client.records.update('proveedores', recordProveedorParse.id, 
                    body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "direccion": responseProveedor.payload!.direccion,
                      "nombre_encargado": responseProveedor.payload!.nombreEncargado,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "archivado": responseProveedor.payload!.archivado,
                    });
                    if (updateRecordProveedor.id.isNotEmpty) {
                      print('Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                }
              }
              break;
            case 401: //Error de Token incorrecto
              if(await getTokenOAuth()) {
                getProveedoresArchivados();
                return true;
              } else{
                return false;
              }
            case 404: //Error de ruta incorrecta
              return false;
            default:
              return false;
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getProveedoresArchivados();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de productos proveedores desde Emi Web 
Future<bool> getProductosProv() async {
   try {
      var url = Uri.parse("$baseUrlEmiWebServices/productos/proveedores/filtros");
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
          final responseListProductosProv = getProductosProvEmiWebFromMap(
            const Utf8Decoder().convert(response.bodyBytes)
          );
          for(var i = 0; i < responseListProductosProv.payload!.ids!.length; i++) {
            var url = Uri.parse("$baseUrlEmiWebServices/productos/proveedores/registro/${responseListProductosProv.payload!.ids![i]}");
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
              final responseProductoProveedor = getProductosProvByIdEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
              //Verificamos que el nuevo producto proveedor no exista en Pocketbase
              final recordProductoProveedor = await client.records.getFullList(
                'productos_prov', 
                batch: 200, 
                filter: "id_emi_web='${responseProductoProveedor.payload!.idProductosProveedor}'");
              if (recordProductoProveedor.isEmpty) {
                //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el nuevo Producto Proveedor
                final recordProveedor = await client.records.getFullList(
                  'proveedores', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");
                final recordFamiliaProd = await client.records.getFullList(
                  'familia_prod', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProductoProveedor.payload!.idCatTipoProducto}'");
                final recordUnidadMedida = await client.records.getFullList(
                  'und_medida', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                if (recordProveedor.isNotEmpty && recordFamiliaProd.isNotEmpty 
                    && recordUnidadMedida.isNotEmpty) {
                    //Se agrega el producto proveedor como nuevo en la colección de Pocketbase
                    final recordProductoProveedor = await client.records.create('productos_prov', body: {
                    "nombre_prod_prov": responseProductoProveedor.payload!.producto,
                    "descripcion_prod_prov": responseProductoProveedor.payload!.descripcion,
                    "marca": responseProductoProveedor.payload!.marca,
                    "is_und_medida_fk": recordUnidadMedida.first.id,
                    "costo_prod_prov": responseProductoProveedor.payload!.costoUnidadMedida,
                    "id_proveedor_fk": recordProveedor.first.id,
                    "id_familia_prod_fk": recordFamiliaProd.first.id,
                    "tiempo_entrega": responseProductoProveedor.payload!.tiempoEntrega,
                    "archivado": responseProductoProveedor.payload!.archivado,
                    "id_emi_web": responseProductoProveedor.payload!.idProductosProveedor.toString(),
                    });
                    if (recordProductoProveedor.id.isNotEmpty) {
                      print('Producto Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                } else {
                  return false;
                }
              } else {
                //Se actualiza el producto proveedor en la colección de Pocketbase
                final recordProductoProveedorParse = getProductosProvFromMap(recordProductoProveedor.first.toString());
                //Verificamos que los campos de este registro sean diferentes para actualizarlo
                if (recordProductoProveedorParse.nombreProdProv != responseProductoProveedor.payload!.producto ||
                    recordProductoProveedorParse.descripcionProdProv != responseProductoProveedor.payload!.descripcion||
                    recordProductoProveedorParse.marca != responseProductoProveedor.payload!.marca ||
                    recordProductoProveedorParse.costoProdProv != responseProductoProveedor.payload!.costoUnidadMedida ||
                    recordProductoProveedorParse.tiempoEntrega != responseProductoProveedor.payload!.tiempoEntrega ||
                    recordProductoProveedorParse.archivado != responseProductoProveedor.payload!.archivado
                    ) {
                    final updateRecordProductoProveedor = await client.records.update('productos_prov', recordProductoProveedorParse.id, 
                    body: {
                      "nombre_prod_prov": responseProductoProveedor.payload!.producto,
                      "descripcion_prod_prov": responseProductoProveedor.payload!.descripcion,
                      "marca": responseProductoProveedor.payload!.marca,
                      "costo_prod_prov": responseProductoProveedor.payload!.costoUnidadMedida,
                      "tiempo_entrega": responseProductoProveedor.payload!.tiempoEntrega,
                      "archivado": responseProductoProveedor.payload!.archivado,
                      "id_emi_web": responseProductoProveedor.payload!.idProductosProveedor.toString(),
                    });
                    if (updateRecordProductoProveedor.id.isNotEmpty) {
                      print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                }
              }
              break;
            case 401: //Error de Token incorrecto
              if(await getTokenOAuth()) {
                getProductosProv();
                return true;
              } else{
                return false;
              }
            case 404: //Error de ruta incorrecta
              return false;
            default:
              return false;
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getProductosProv();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de productos del proyecto desde Emi Web 
  Future<bool> getProdProyecto() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/inversionxproyecto");
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
          final responseListProdProyecto = getProdProyectoEmiWebFromMap(
            const Utf8Decoder().convert(response.bodyBytes)
          );
          for(var i = 0; i < responseListProdProyecto.payload!.length; i++) {
            var url = Uri.parse("$baseUrlEmiWebServices/productos/proveedores/registro/${responseListProdProyecto.payload![i].producto!.idProductosProveedor}");
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
              final responseProductoProveedor = getProductosProvByIdEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
              //Verificamos que el nuevo producto del proyecto no exista en Pocketbase
              final recordProductoProyecto = await client.records.getFullList(
                'prod_proyecto', 
                batch: 200, 
                filter: "id_emi_web='${responseListProdProyecto.payload![i].idCatInversionProyecto}'");
              if (recordProductoProyecto.isEmpty) {
                //Se recupera el id familia producto, catalogo proyecto y tipo empaque en Pocketbase y se acocia con el nuevo Producto Proyecto
                final recordFamiliaProd = await client.records.getFullList(
                  'familia_prod', 
                  batch: 200, 
                  filter: "id_emi_web='${responseListProdProyecto.payload![i].familiaInversion!.idCatFamiliaInversion}'");
                final recordCatalogoProyecto = await client.records.getFullList(
                  'cat_proyecto', 
                  batch: 200, 
                  filter: "id_emi_web='${responseListProdProyecto.payload![i].idCatProyecto}'");
                final recordUnidadMedida = await client.records.getFullList(
                  'und_medida', 
                  batch: 200, 
                  filter: "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                if (recordFamiliaProd.isNotEmpty && recordCatalogoProyecto.isNotEmpty
                    && recordUnidadMedida.isNotEmpty) {
                    //Se agrega el producto proveedor como nuevo en la colección de Pocketbase
                    final recordProductoProyecto = await client.records.create('prod_proyecto', body: {
                    "producto": responseListProdProyecto.payload![i].producto!.producto,
                    "marca_sugerida": responseProductoProveedor.payload!.marca,
                    "descripcion": responseProductoProveedor.payload!.descripcion,
                    "proveedor_sugerido": responseListProdProyecto.payload![i].proveedorSugerido!.nombreFiscal,
                    "cantidad": responseListProdProyecto.payload![i].cantidad,
                    "costo_estimado": responseListProdProyecto.payload![i].costoEstimado,
                    "id_familia_prod_fk": recordFamiliaProd.first.id,
                    "id_unidad_medida_fk": recordUnidadMedida.first.id,
                    "id_catalogo_proyecto_fk": recordCatalogoProyecto.first.id,
                    "id_emi_web": responseListProdProyecto.payload![i].idCatInversionProyecto,
                    });
                    if (recordProductoProyecto.id.isNotEmpty) {
                      print('Producto Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                } else {
                  return false;
                }
              } else {
                //Se actualiza el producto proveedor en la colección de Pocketbase
                final recordProductoProyectoParse = getProdProyectoFromMap(recordProductoProyecto.first.toString());
                //Verificamos que los campos de este registro sean diferentes para actualizarlo
                if (recordProductoProyectoParse.producto != responseListProdProyecto.payload![i].producto!.producto ||
                    recordProductoProyectoParse.descripcion != responseProductoProveedor.payload!.descripcion||
                    recordProductoProyectoParse.marcaSugerida != responseProductoProveedor.payload!.marca ||
                    recordProductoProyectoParse.proveedorSugerido != responseListProdProyecto.payload![i].proveedorSugerido!.nombreFiscal ||
                    recordProductoProyectoParse.cantidad != responseListProdProyecto.payload![i].cantidad ||
                    recordProductoProyectoParse.costoEstimado != responseListProdProyecto.payload![i].costoEstimado
                    ) {
                    final updateRecordProductoProyecto = await client.records.update('prod_proyecto', recordProductoProyectoParse.id, 
                    body: {
                      "producto": responseListProdProyecto.payload![i].producto!.producto,
                      "marca_sugerida": responseProductoProveedor.payload!.marca,
                      "descripcion": responseProductoProveedor.payload!.descripcion,
                      "proveedor_sugerido": responseListProdProyecto.payload![i].proveedorSugerido!.nombreFiscal,
                      "cantidad": responseListProdProyecto.payload![i].cantidad,
                      "costo_estimado": responseListProdProyecto.payload![i].costoEstimado,
                      "id_emi_web": responseListProdProyecto.payload![i].producto!.idProductosProveedor.toString(),
                    });
                    if (updateRecordProductoProyecto.id.isNotEmpty) {
                      print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                }
              }
              break;
            case 401: //Error de Token incorrecto
              if(await getTokenOAuth()) {
                getProdProyecto();
                return true;
              } else{
                return false;
              }
            case 404: //Error de ruta incorrecta
              return false;
            default:
              return false;
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          if(await getTokenOAuth()) {
            getProdProyecto();
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
    }
}
