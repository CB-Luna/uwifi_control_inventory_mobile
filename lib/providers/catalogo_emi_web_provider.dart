import 'dart:convert';

import 'package:bizpro_app/modelsEmiWeb/get_ambito_consultoria_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_area_circulo_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_bancos_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_catalogo_proyectos_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_condiciones_pago_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_estado_inversiones_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_familia_producto_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_fase_emprendimiento_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_porcentaje_avance_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_empaques_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_tipo_tipo_proveedor_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/get_unidad_medida_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:bizpro_app/modelsPocketbase/get_comunidades.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_proyecto.dart';
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
      // await getEstadosProdCotizados();
      // await getProveedores();
      // await getProductosProv();
      // await getProdProyecto();
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
        return exitoso;
      } else {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        notifyListeners();
        return exitoso;
      }
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return false;
    }
  }

//Función inicial para recuperar el Token para el llamado de catálogos
  Future<bool> getTokenOAuth() async {
    // try {
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
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de estados desde Emi Web
  Future<bool> getEstados() async {
    // try {
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
                    "nombre_estado": recordEstadoParse.nombreEstado,
                    "activo": recordEstadoParse.activo,
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
          return true;
        default:
          return false;
      }  
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de municipios desde Emi Web
  Future<bool> getMunicipios() async {
    // try {
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
                    "nombre_municipio": recordMunicipioParse.nombreMunicipio,
                    "activo": recordMunicipioParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de comunidades desde Emi Web
  Future<bool> getComunidades() async {
    // try {
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
                    "nombre_comunidad": recordComunidadParse.nombreComunidad,
                    "activo": recordComunidadParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de tipos de Proyecto desde Emi Web
  Future<bool> getTipoProyecto() async {
    // try {
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
                    "tipo_proyecto": recordTipoProyectoParse.tipoProyecto,
                    "activo": recordTipoProyectoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de catálogos proyecto desde Emi Web == Tabla "Proyectos" en Emi Web
  Future<bool> getCatalogosProyectos() async {
    // try {
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
                    "nombre_proyecto": recordCatalogoProyectoParse.nombreProyecto,
                    "activo": recordCatalogoProyectoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de Familia Producto desde Emi Web
  Future<bool> getFamiliaProd() async {
    // try {
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
                    "nombre_tipo_prod": recordFamiliaProductoParse.nombreTipoProd,
                    "activo": recordFamiliaProductoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de unidad de medida proyecto desde Emi Web
  Future<bool> getUnidadMedida() async {
    // try {
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
                    "unidad_medida": recordUnidadMedidaParse.unidadMedida,
                    "activo": recordUnidadMedidaParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de ambito consultoría desde Emi Web 
  Future<bool> getAmbitoConsultoria() async {
    // try {
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
                    "nombre_ambito": recordAmbitoConsultoriaParse.nombreAmbito,
                    "activo": recordAmbitoConsultoriaParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de área círculo desde Emi Web 
  Future<bool> getAreaCirculo() async {
    // try {
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
                    "nombre_area": recordAreaCirculoParse.nombreArea,
                    "activo": recordAreaCirculoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }


//Función para recuperar el catálogo de fases de emprendimiento desde Emi Web 
  Future<bool> getFasesEmp() async {
    // try {
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
                    "fase": recordFaseEmprendimientoParse.fase,
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
          return true;
        default:
          return false;
      }  
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de tipo de empaques desde Emi Web 
  Future<bool> getTipoEmpaque() async {
    // try {
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
                    "tipo_empaque": recordTipoEmpaqueParse.tipoEmpaque,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de estado de inversion desde Emi Web 
  Future<bool> getEstadoInversion() async {
    // try {
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
                    "estado": recordEstadoInversionParse.estado,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de tipo de proveedor de inversion desde Emi Web 
  Future<bool> getTipoProveedor() async {
    // try {
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
                    "tipo_proveedor": recordTipoProveedorParse.tipoProveedor,
                    "activo": recordTipoProveedorParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de condiciones de pago desde Emi Web 
  Future<bool> getCondicionesPago() async {
    // try {
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
                    "condicion_pago": recordCondicionPagoParse.condicionPago,
                    "activo": recordCondicionPagoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de bancos desde Emi Web 
Future<bool> getBancos() async {
  // try {
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
                    "nombre_banco": recordBancoParse.nombreBanco,
                    "activo": recordBancoParse.activo,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
  }

//Función para recuperar el catálogo de porcentaje avance desde Emi Web 
Future<bool> getPorcentajeAvance() async {
  //  try {
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
                    "porcentaje": recordPorcentajeAvanceParse.porcentaje,
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
          return true;
        default:
          return false;
      }
    // } catch (e) {
    //   return false;
    // }
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
