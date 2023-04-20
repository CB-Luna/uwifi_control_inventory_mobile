import 'dart:convert';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_ambito_consultoria_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_area_circulo_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_bancos_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_catalogo_proyectos_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_condiciones_pago_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_estado_inversiones_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_familia_inversion_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_fase_emprendimiento_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_imagen_producto_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_imagen_usuario_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_porcentaje_avance_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_prod_proyecto_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_productos_prov_by_id_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_productos_prov_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_proveedores_by_id_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_proveedores_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_tipo_empaques_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_tipo_tipo_proveedor_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_unidad_medida_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_usuario_completo_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_usuario_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_catalogo_proyectos.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_comunidades.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_estados.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_familia_inversion.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_municipios.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_tipo_proyecto.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';

import 'package:taller_alex_app_asesor/modelsEmiWeb/get_comunidades_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_estados_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_municipios_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_token_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsEmiWeb/get_tipo_proyecto_emi_web.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_bancos.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_condiciones_pago.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_porcentaje_avance.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_prod_proyecto.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_productos_prov.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_proveedores.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_tipo_proveedor.dart';

import 'package:taller_alex_app_asesor/modelsPocketbase/get_ambito_consultoria.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_area_circulo.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_unidades_medida.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_estado_inversiones.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_fases_emp.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_tipo_empaques.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image/image.dart';

class CatalogoEmiWebProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
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

  Future<bool> getCatalogosEmiWeb() async {
    if (await getTokenOAuth()) {
      banderasExistoSync.add(await getEstados());
      banderasExistoSync.add(await getMunicipios());
      banderasExistoSync.add(await getComunidades());
      banderasExistoSync.add(await getTipoProyecto());
      banderasExistoSync.add(await getCatalogosProyectos());
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
      banderasExistoSync.add(await getFamiliaInversion());
      banderasExistoSync.add(await getProductosProv());
      banderasExistoSync.add(await getProdProyecto());
      banderasExistoSync.add(await getInfoUsuarioPerfil());
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

      var response = await http.post(url, headers: headers, body: bodyMsg);

      //print(response.body);

      switch (response.statusCode) {
        case 200:
          final responseTokenEmiWeb = getTokenEmiWebFromMap(response.body);
          tokenGlobal = responseTokenEmiWeb.accessToken;
          return true;
        case 400:
          usuarioExit = true;
          return false;
        case 401:
          //Se actualiza Usuario archivado en Pocketbase y objectBox
          return false;
        default:
          snackbarKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Falló al conectarse con el servidor Emi Web."),
          ));
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListEstados = getEstadosEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListEstados.payload!.length; i++) {
            //Verificamos que el nuevo estado no exista en Pocketbase
            final recordEstado = await client.records.getFullList('estados',
                batch: 200,
                filter:
                    "id_emi_web='${responseListEstados.payload![i].idCatEstado}'");
            if (recordEstado.isEmpty) {
              //Se agrega el estado como nuevo en la colección de Pocketbase
              final newRecordEstado =
                  await client.records.create('estados', body: {
                "nombre_estado": responseListEstados.payload![i].estado,
                "activo": responseListEstados.payload![i].activo,
                "id_emi_web":
                    responseListEstados.payload![i].idCatEstado.toString(),
              });
              if (newRecordEstado.id.isNotEmpty) {
                //print('Estado Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordEstadoParse =
                  getEstadosFromMap(recordEstado.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordEstadoParse.nombreEstado !=
                      responseListEstados.payload![i].estado ||
                  recordEstadoParse.activo !=
                      responseListEstados.payload![i].activo) {
                final updateRecordEstado = await client.records
                    .update('estados', recordEstadoParse.id, body: {
                  "nombre_estado": responseListEstados.payload![i].estado,
                  "activo": responseListEstados.payload![i].activo,
                });
                if (updateRecordEstado.id.isNotEmpty) {
                  //print(
                  //    'Estado Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 1");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getEstados();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListMunicipios = getMunicipiosEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListMunicipios.payload!.length; i++) {
            //Verificamos que el nuevo municipio no exista en Pocketbase
            final recordMunicipio = await client.records.getFullList(
                'municipios',
                batch: 200,
                filter:
                    "id_emi_web='${responseListMunicipios.payload![i].idCatMunicipio}'");
            if (recordMunicipio.isEmpty) {
              //Se recupera el id del estado en Pocketbase y se acocia con el nuevo Municipio
              final recordEstado = await client.records.getFullList('estados',
                  batch: 200,
                  filter:
                      "id_emi_web='${responseListMunicipios.payload![i].idCatEstado}'");
              if (recordEstado.isNotEmpty) {
                //Se agrega el municipio como nuevo en la colección de Pocketbase
                final recordMunicipio =
                    await client.records.create('municipios', body: {
                  "nombre_municipio":
                      responseListMunicipios.payload![i].municipio,
                  "id_estado_fk": recordEstado.first.id,
                  "activo": responseListMunicipios.payload![i].activo,
                  "id_emi_web": responseListMunicipios
                      .payload![i].idCatMunicipio
                      .toString(),
                });
                if (recordMunicipio.id.isNotEmpty) {
                  //print('Municipio Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza el municipio en la colección de Pocketbase
              final recordMunicipioParse =
                  getMunicipiosFromMap(recordMunicipio.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordMunicipioParse.nombreMunicipio !=
                      responseListMunicipios.payload![i].municipio ||
                  recordMunicipioParse.activo !=
                      responseListMunicipios.payload![i].activo) {
                final updateRecordMunicipio = await client.records
                    .update('municipios', recordMunicipioParse.id, body: {
                  "nombre_municipio":
                      responseListMunicipios.payload![i].municipio,
                  "activo": responseListMunicipios.payload![i].activo,
                });
                if (updateRecordMunicipio.id.isNotEmpty) {
                  //print(
                  //    'Municipio Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 2");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getMunicipios();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListComunidades = getComunidadesEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListComunidades.payload!.length; i++) {
            //Verificamos que la nueva comunidad no exista en Pocketbase
            final recordComunidad = await client.records.getFullList(
                'comunidades',
                batch: 200,
                filter:
                    "id_emi_web='${responseListComunidades.payload![i].idCatComunidad}'");
            if (recordComunidad.isEmpty) {
              //Se recupera el id del municipio en Pocketbase y se acocia con la nueva Comunidad
              final recordMunicipio = await client.records.getFullList(
                  'municipios',
                  batch: 200,
                  filter:
                      "id_emi_web='${responseListComunidades.payload![i].idCatMunicipio}'");
              if (recordMunicipio.isNotEmpty) {
                //Se agrega la comunidad como nueva en la colección de Pocketbase
                final recordComunidad =
                    await client.records.create('comunidades', body: {
                  "nombre_comunidad":
                      responseListComunidades.payload![i].comunidad,
                  "id_municipio_fk": recordMunicipio.first.id,
                  "activo": responseListComunidades.payload![i].activo,
                  "id_emi_web": responseListComunidades
                      .payload![i].idCatComunidad
                      .toString(),
                });
                if (recordComunidad.id.isNotEmpty) {
                  //print('Comunidad Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza la comunidad en la colección de Pocketbase
              final recordComunidadParse =
                  getComunidadesFromMap(recordComunidad.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordComunidadParse.nombreComunidad !=
                      responseListComunidades.payload![i].comunidad ||
                  recordComunidadParse.activo !=
                      responseListComunidades.payload![i].activo) {
                final updateRecordComunidad = await client.records
                    .update('comunidades', recordComunidadParse.id, body: {
                  "nombre_comunidad":
                      responseListComunidades.payload![i].comunidad,
                  "activo": responseListComunidades.payload![i].activo,
                });
                if (updateRecordComunidad.id.isNotEmpty) {
                  //print(
                  //    'Comunidad Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 3");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getComunidades();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);
      //print("Tipo proyecto ${response.statusCode}");
      //print("Tipo Proyecto ${response.body}");
      switch (response.statusCode) {
        case 200: //Caso éxitoso
          //print("200 en Tipo Proyecto");
          final responseListTipoProyecto = getTipoProyectoEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoProyecto.payload!.length; i++) {
            //Verificamos que el nuevo tipo proyecto no exista en Pocketbase
            final recordTipoProyecto = await client.records.getFullList(
                'tipo_proyecto',
                batch: 200,
                filter:
                    "id_emi_web='${responseListTipoProyecto.payload![i].idCatTipoProyecto}'");
            if (recordTipoProyecto.isEmpty) {
              //print("Se agrega");
              //Se agrega el tipo proyecto como nuevo en la colección de Pocketbase
              final newRecordTipoProyecto =
                  await client.records.create('tipo_proyecto', body: {
                "tipo_proyecto":
                    responseListTipoProyecto.payload![i].tipoProyecto,
                "activo": responseListTipoProyecto.payload![i].activo,
                "id_emi_web": responseListTipoProyecto
                    .payload![i].idCatTipoProyecto
                    .toString(),
              });
              if (newRecordTipoProyecto.id.isNotEmpty) {
                //print(
                //    'Tipo Proyecto Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //print("Se actualiza");
              //Se actualiza el tipo proyecto en la colección de Pocketbase
              final recordTipoProyectoParse =
                  getTipoProyectoFromMap(recordTipoProyecto.first.toString());
              //print("Paso 1");
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoProyectoParse.tipoProyecto !=
                      responseListTipoProyecto.payload![i].tipoProyecto ||
                  recordTipoProyectoParse.activo !=
                      responseListTipoProyecto.payload![i].activo) {
                //print("Paso 2");
                final updateRecordEstado = await client.records
                    .update('tipo_proyecto', recordTipoProyectoParse.id, body: {
                  "tipo_proyecto":
                      responseListTipoProyecto.payload![i].tipoProyecto,
                  "activo": responseListTipoProyecto.payload![i].activo,
                });
                if (updateRecordEstado.id.isNotEmpty) {
                  //print(
                  //    'Tipo Proyecto Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 4");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getTipoProyecto();
            return true;
          } else {
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      //print("Catch Exito 4: $e");
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListCatalogoProyecto =
              getCatalogoProyectosEmiWebFromMap(
                  const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListCatalogoProyecto.payload!.length;
              i++) {
            //Verificamos que el nuevo catálogo proyecto no exista en Pocketbase
            final recordCatalogoProyecto = await client.records.getFullList(
                'cat_proyecto',
                batch: 200,
                filter:
                    "id_emi_web='${responseListCatalogoProyecto.payload![i].idCatProyecto}'");
            if (recordCatalogoProyecto.isEmpty) {
              //Se recupera el id del tipo proyecto en Pocketbase y se acocia con el nuevo Catálogo Proyecto
              final recordTipoProyecto = await client.records.getFullList(
                  'tipo_proyecto',
                  batch: 200,
                  filter:
                      "id_emi_web='${responseListCatalogoProyecto.payload![i].catTipoProyecto!.idCatTipoProyecto}'");
              if (recordTipoProyecto.isNotEmpty) {
                //Se agrega el catálogo proyecto como nuevo en la colección de Pocketbase
                final recordCatalogoProyecto =
                    await client.records.create('cat_proyecto', body: {
                  "nombre_proyecto":
                      responseListCatalogoProyecto.payload![i].proyecto,
                  "id_tipo_proyecto_fk": recordTipoProyecto.first.id,
                  "activo": responseListCatalogoProyecto.payload![i].activo,
                  "id_emi_web": responseListCatalogoProyecto
                      .payload![i].idCatProyecto
                      .toString(),
                });
                if (recordCatalogoProyecto.id.isNotEmpty) {
                  //print(
                  //    'Catálogo Proyecto Emi Web agregado éxitosamente a Pocketbase');
                } else {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              //Se actualiza el catálogo proyecto en la colección de Pocketbase
              final recordCatalogoProyectoParse = getCatalogoProyectosFromMap(
                  recordCatalogoProyecto.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordCatalogoProyectoParse.nombreProyecto !=
                      responseListCatalogoProyecto.payload![i].proyecto ||
                  recordCatalogoProyectoParse.activo !=
                      responseListCatalogoProyecto.payload![i].activo) {
                final updateRecordCatalogoProyecto = await client.records
                    .update('cat_proyecto', recordCatalogoProyectoParse.id,
                        body: {
                      "nombre_proyecto":
                          responseListCatalogoProyecto.payload![i].proyecto,
                      "activo": responseListCatalogoProyecto.payload![i].activo,
                    });
                if (updateRecordCatalogoProyecto.id.isNotEmpty) {
                  //print('Comunidad Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 5");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getCatalogosProyectos();
            return true;
          } else {
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
      var url =
          Uri.parse("$baseUrlEmiWebServices/catalogos/unidadMedidaEmprendedor");
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListUnidadMedida = getUnidadMedidaEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListUnidadMedida.payload!.length; i++) {
            //Verificamos que la nueva unidad de medida no exista en Pocketbase
            final recordUnidadMedida = await client.records.getFullList(
                'und_medida',
                batch: 200,
                filter:
                    "id_emi_web='${responseListUnidadMedida.payload![i].idCatUnidadMedida}'");
            if (recordUnidadMedida.isEmpty) {
              //Se agrega la unidad de medida como nueva en la colección de Pocketbase
              final recordUnidadMedida =
                  await client.records.create('und_medida', body: {
                "unidad_medida":
                    responseListUnidadMedida.payload![i].unidadMedida,
                "activo": responseListUnidadMedida.payload![i].activo,
                "id_emi_web": responseListUnidadMedida
                    .payload![i].idCatUnidadMedida
                    .toString(),
              });
              if (recordUnidadMedida.id.isNotEmpty) {
                //print('Unidad de Medida Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la unidad de medida en la colección de Pocketbase
              final recordUnidadMedidaParse =
                  getUnidadesMedidaFromMap(recordUnidadMedida.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordUnidadMedidaParse.unidadMedida !=
                      responseListUnidadMedida.payload![i].unidadMedida ||
                  recordUnidadMedidaParse.activo !=
                      responseListUnidadMedida.payload![i].activo) {
                final updateRecordUnidadMedida = await client.records
                    .update('und_medida', recordUnidadMedidaParse.id, body: {
                  "unidad_medida":
                      responseListUnidadMedida.payload![i].unidadMedida,
                  "activo": responseListUnidadMedida.payload![i].activo,
                });
                if (updateRecordUnidadMedida.id.isNotEmpty) {
                  //print('Unidad de Medida Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 7");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getUnidadMedida();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListAmbitoConsultoria =
              getAmbitoConsultoriaEmiWebFromMap(
                  const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListAmbitoConsultoria.payload!.length;
              i++) {
            //Verificamos que el nuevo ámbito consultoría no exista en Pocketbase
            final recordAmbitoConsultoria = await client.records.getFullList(
                'ambito_consultoria',
                batch: 200,
                filter:
                    "id_emi_web='${responseListAmbitoConsultoria.payload![i].idCatAmbito}'");
            if (recordAmbitoConsultoria.isEmpty) {
              //Se agrega el ámbito consultoría como nuevo en la colección de Pocketbase
              final recordAmbitoConsultoria =
                  await client.records.create('ambito_consultoria', body: {
                "nombre_ambito":
                    responseListAmbitoConsultoria.payload![i].ambito,
                "activo": responseListAmbitoConsultoria.payload![i].activo,
                "id_emi_web": responseListAmbitoConsultoria
                    .payload![i].idCatAmbito
                    .toString(),
              });
              if (recordAmbitoConsultoria.id.isNotEmpty) {
                //print('Ámbito Consultoría Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el ámbito consultoría en la colección de Pocketbase
              final recordAmbitoConsultoriaParse = getAmbitoConsultoriaFromMap(
                  recordAmbitoConsultoria.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordAmbitoConsultoriaParse.nombreAmbito !=
                      responseListAmbitoConsultoria.payload![i].ambito ||
                  recordAmbitoConsultoriaParse.activo !=
                      responseListAmbitoConsultoria.payload![i].activo) {
                final updateRecordAmbitoConsultoria = await client.records
                    .update(
                        'ambito_consultoria', recordAmbitoConsultoriaParse.id,
                        body: {
                      "nombre_ambito":
                          responseListAmbitoConsultoria.payload![i].ambito,
                      "activo":
                          responseListAmbitoConsultoria.payload![i].activo,
                    });
                if (updateRecordAmbitoConsultoria.id.isNotEmpty) {
                  //print('Ámbito Consultoría Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 8");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getAmbitoConsultoria();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListAreaCirculo = getAreaCirculoEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListAreaCirculo.payload!.length; i++) {
            //Verificamos que el nuevo area circulo no exista en Pocketbase
            final recordAreaCirculo = await client.records.getFullList(
                'area_circulo',
                batch: 200,
                filter:
                    "id_emi_web='${responseListAreaCirculo.payload![i].idCatAreaCirculo}'");
            if (recordAreaCirculo.isEmpty) {
              //Se agrega el area circulo como nuevo en la colección de Pocketbase
              final recordAreaCirculo =
                  await client.records.create('area_circulo', body: {
                "nombre_area": responseListAreaCirculo.payload![i].areaCirculo,
                "activo": responseListAreaCirculo.payload![i].activo,
                "id_emi_web": responseListAreaCirculo
                    .payload![i].idCatAreaCirculo
                    .toString(),
              });
              if (recordAreaCirculo.id.isNotEmpty) {
                //print('Area Circulo Emi Web agregado éxitosamente a Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el area circulo en la colección de Pocketbase
              final recordAreaCirculoParse =
                  getAreaCirculoFromMap(recordAreaCirculo.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordAreaCirculoParse.nombreArea !=
                      responseListAreaCirculo.payload![i].areaCirculo ||
                  recordAreaCirculoParse.activo !=
                      responseListAreaCirculo.payload![i].activo) {
                final updateRecordAmbitoConsultoria = await client.records
                    .update('area_circulo', recordAreaCirculoParse.id, body: {
                  "nombre_area":
                      responseListAreaCirculo.payload![i].areaCirculo,
                  "activo": responseListAreaCirculo.payload![i].activo,
                });
                if (updateRecordAmbitoConsultoria.id.isNotEmpty) {
                  //print('Ámbito Consultoría Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 9");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getAreaCirculo();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListFaseEmprendimiento =
              getFaseEmprendimientoEmiWebFromMap(
                  const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListFaseEmprendimiento.payload!.length;
              i++) {
            //Verificamos que la nueva fase del emprendimiento no exista en Pocketbase
            final recordFaseEmprendimiento = await client.records.getFullList(
                'fases_emp',
                batch: 200,
                filter:
                    "id_emi_web='${responseListFaseEmprendimiento.payload![i].idCatFase}'");
            if (recordFaseEmprendimiento.isEmpty) {
              //Se agrega la fase del emprendimiento como nueva en la colección de Pocketbase
              final newRecordFaseEmprendimiento =
                  await client.records.create('fases_emp', body: {
                "fase": responseListFaseEmprendimiento.payload![i].fase,
                "id_emi_web": responseListFaseEmprendimiento
                    .payload![i].idCatFase
                    .toString(),
              });
              if (newRecordFaseEmprendimiento.id.isNotEmpty) {
                //print('Fase Emprendimiento Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordFaseEmprendimientoParse =
                  getFasesEmpFromMap(recordFaseEmprendimiento.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordFaseEmprendimientoParse.fase !=
                  responseListFaseEmprendimiento.payload![i].fase) {
                final updateRecordEstado = await client.records.update(
                    'fases_emp', recordFaseEmprendimientoParse.id,
                    body: {
                      "fase": responseListFaseEmprendimiento.payload![i].fase,
                    });
                if (updateRecordEstado.id.isNotEmpty) {
                  //print('Fase Emprendimiento Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 10");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getFasesEmp();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListTipoEmpaques = getTipoEmpaquesEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoEmpaques.payload!.length; i++) {
            //Verificamos que el nuevo tipo de empaque no exista en Pocketbase
            final recordTipoEmpaque = await client.records.getFullList(
                'tipo_empaques',
                batch: 200,
                filter:
                    "id_emi_web='${responseListTipoEmpaques.payload![i].idCatTipoEmpaque}'");
            if (recordTipoEmpaque.isEmpty) {
              //Se agrega lo tipo de empaque como nuevo en la colección de Pocketbase
              final newRecordTipoEmpaque =
                  await client.records.create('tipo_empaques', body: {
                "tipo_empaque":
                    responseListTipoEmpaques.payload![i].tipoEmpaque,
                "id_emi_web": responseListTipoEmpaques
                    .payload![i].idCatTipoEmpaque
                    .toString(),
              });
              if (newRecordTipoEmpaque.id.isNotEmpty) {
                //print('Tipo Empaque Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado en la colección de Pocketbase
              final recordTipoEmpaqueParse =
                  getTipoEmpaquesFromMap(recordTipoEmpaque.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoEmpaqueParse.tipoEmpaque !=
                  responseListTipoEmpaques.payload![i].tipoEmpaque) {
                final updateRecordTipoEmpaque = await client.records
                    .update('tipo_empaques', recordTipoEmpaqueParse.id, body: {
                  "tipo_empaque":
                      responseListTipoEmpaques.payload![i].tipoEmpaque,
                });
                if (updateRecordTipoEmpaque.id.isNotEmpty) {
                  //print('Tipo Empaque Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 11");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getTipoEmpaque();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListEstadoInversion = getEstadoInversionesEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListEstadoInversion.payload!.length;
              i++) {
            //Verificamos que el nuevo estado de inversión no exista en Pocketbase
            final recordEstadoInversion = await client.records.getFullList(
                'estado_inversiones',
                batch: 200,
                filter:
                    "id_emi_web='${responseListEstadoInversion.payload![i].idCatEstadoInversion}'");
            if (recordEstadoInversion.isEmpty) {
              //Se agrega el estado de inversión como nuevo en la colección de Pocketbase
              final newRecordEstadoInversion =
                  await client.records.create('estado_inversiones', body: {
                "estado":
                    responseListEstadoInversion.payload![i].estadoInversion,
                "id_emi_web": responseListEstadoInversion
                    .payload![i].idCatEstadoInversion
                    .toString(),
              });
              if (newRecordEstadoInversion.id.isNotEmpty) {
                //print('Estado Inversión Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el estado de inversión en la colección de Pocketbase
              final recordEstadoInversionParse = getEstadoInversionesFromMap(
                  recordEstadoInversion.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordEstadoInversionParse.estado !=
                  responseListEstadoInversion.payload![i].estadoInversion) {
                final updateRecordEstado = await client.records.update(
                    'estado_inversiones', recordEstadoInversionParse.id,
                    body: {
                      "estado": responseListEstadoInversion
                          .payload![i].estadoInversion,
                    });
                if (updateRecordEstado.id.isNotEmpty) {
                  //print('Estado Inversión Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 12");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getEstadoInversion();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListTipoProveedor = getTipoProveedorEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListTipoProveedor.payload!.length; i++) {
            //Verificamos que el nuevo tipo de proveedor no exista en Pocketbase
            final recordTipoProveedor = await client.records.getFullList(
                'tipo_proveedor',
                batch: 200,
                filter:
                    "id_emi_web='${responseListTipoProveedor.payload![i].idCatTipoProveedor}'");
            if (recordTipoProveedor.isEmpty) {
              //Se agrega el tipo de proveedor como nuevo en la colección de Pocketbase
              final newRecordEstadoInversion =
                  await client.records.create('tipo_proveedor', body: {
                "tipo_proveedor":
                    responseListTipoProveedor.payload![i].tipoProveedor,
                "activo": responseListTipoProveedor.payload![i].activo,
                "id_emi_web": responseListTipoProveedor
                    .payload![i].idCatTipoProveedor
                    .toString(),
              });
              if (newRecordEstadoInversion.id.isNotEmpty) {
                //print('Tipo Proveedor Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el tipo de proveedor en la colección de Pocketbase
              final recordTipoProveedorParse =
                  getTipoProveedorFromMap(recordTipoProveedor.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordTipoProveedorParse.tipoProveedor !=
                  responseListTipoProveedor.payload![i].tipoProveedor) {
                final updateRecordTipoProveedor = await client.records.update(
                    'tipo_proveedor', recordTipoProveedorParse.id,
                    body: {
                      "tipo_proveedor":
                          responseListTipoProveedor.payload![i].tipoProveedor,
                      "activo": responseListTipoProveedor.payload![i].activo,
                    });
                if (updateRecordTipoProveedor.id.isNotEmpty) {
                  //print('Tipo Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 13");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getTipoProveedor();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListCondicionPago = getCondicionesPagoEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListCondicionPago.payload!.length; i++) {
            //Verificamos que la nueva condicion de pago no exista en Pocketbase
            final recordCondicionPago = await client.records.getFullList(
                'condiciones_pago',
                batch: 200,
                filter:
                    "id_emi_web='${responseListCondicionPago.payload![i].idCatCondicionesPago}'");
            if (recordCondicionPago.isEmpty) {
              //Se agrega la condicion de pago como nuevo en la colección de Pocketbase
              final newRecordCondicionPago =
                  await client.records.create('condiciones_pago', body: {
                "condicion_pago":
                    responseListCondicionPago.payload![i].condicionesPago,
                "activo": responseListCondicionPago.payload![i].activo,
                "id_emi_web": responseListCondicionPago
                    .payload![i].idCatCondicionesPago
                    .toString(),
              });
              if (newRecordCondicionPago.id.isNotEmpty) {
                //print('Condición Pago Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la condicion de pago en la colección de Pocketbase
              final recordCondicionPagoParse = getCondicionesPagoFromMap(
                  recordCondicionPago.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordCondicionPagoParse.condicionPago !=
                  responseListCondicionPago.payload![i].condicionesPago) {
                final updateRecordTipoProveedor = await client.records.update(
                    'condiciones_pago', recordCondicionPagoParse.id,
                    body: {
                      "condicion_pago":
                          responseListCondicionPago.payload![i].condicionesPago,
                      "activo": responseListCondicionPago.payload![i].activo,
                    });
                if (updateRecordTipoProveedor.id.isNotEmpty) {
                  //print('Condición Pago Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 14");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getCondicionesPago();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListBancos = getBancosEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListBancos.payload!.length; i++) {
            //Verificamos que el nuevo banco no exista en Pocketbase
            final recordBanco = await client.records.getFullList('bancos',
                batch: 200,
                filter:
                    "id_emi_web='${responseListBancos.payload![i].idCatBancos}'");
            if (recordBanco.isEmpty) {
              //Se agrega el banco como nuevo en la colección de Pocketbase
              final newRecordBanco =
                  await client.records.create('bancos', body: {
                "nombre_banco": responseListBancos.payload![i].banco,
                "activo": responseListBancos.payload![i].activo,
                "id_emi_web":
                    responseListBancos.payload![i].idCatBancos.toString(),
              });
              if (newRecordBanco.id.isNotEmpty) {
                //print('Banco Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el banco en la colección de Pocketbase
              final recordBancoParse =
                  getBancosFromMap(recordBanco.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordBancoParse.nombreBanco !=
                  responseListBancos.payload![i].banco) {
                final updateRecordBanco = await client.records
                    .update('bancos', recordBancoParse.id, body: {
                  "nombre_banco": responseListBancos.payload![i].banco,
                  "activo": responseListBancos.payload![i].activo,
                });
                if (updateRecordBanco.id.isNotEmpty) {
                  //print('Banco Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 15");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getBancos();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListPorcentajeAvance = getPorcentajeAvanceEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListPorcentajeAvance.payload!.length;
              i++) {
            //Verificamos que el nuevo porcentaje avance no exista en Pocketbase
            final recordPorcentajeAvance = await client.records.getFullList(
                'porcentaje_avance',
                batch: 200,
                filter:
                    "id_emi_web='${responseListPorcentajeAvance.payload![i].idCatPorcentajeAvance}'");
            if (recordPorcentajeAvance.isEmpty) {
              //Se agrega el porcentaje avance como nuevo en la colección de Pocketbase
              final newRecordPorcentajeAvance =
                  await client.records.create('porcentaje_avance', body: {
                "porcentaje":
                    responseListPorcentajeAvance.payload![i].porcentajeAvance,
                "id_emi_web": responseListPorcentajeAvance
                    .payload![i].idCatPorcentajeAvance
                    .toString(),
              });
              if (newRecordPorcentajeAvance.id.isNotEmpty) {
                //print('Porcentaje Avance Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el porcentaje avance en la colección de Pocketbase
              final recordPorcentajeAvanceParse = getPorcentajeAvanceFromMap(
                  recordPorcentajeAvance.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordPorcentajeAvanceParse.porcentaje !=
                  responseListPorcentajeAvance.payload![i].porcentajeAvance) {
                final updateRecordPorcentajeAvance = await client.records
                    .update('porcentaje_avance', recordPorcentajeAvanceParse.id,
                        body: {
                      "porcentaje": responseListPorcentajeAvance
                          .payload![i].porcentajeAvance,
                    });
                if (updateRecordPorcentajeAvance.id.isNotEmpty) {
                  //print('Porcentaje Avance Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 16");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getPorcentajeAvance();
            return true;
          } else {
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListProveedores = getProveedoresEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListProveedores.payload!.length; i++) {
            var url = Uri.parse(
                "$baseUrlEmiWebServices/proveedores/registro/${responseListProveedores.payload![i].id}");
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var response = await http.get(url, headers: headers);
            switch (response.statusCode) {
              case 200: //Caso éxitoso
                final responseProveedor = getProveedorByIdEmiWebFromMap(
                    const Utf8Decoder().convert(response.bodyBytes));
                //Verificamos que el nuevo proveedor no exista en Pocketbase
                final recordProveedor = await client.records.getFullList(
                    'proveedores',
                    batch: 200,
                    filter:
                        "id_emi_web='${responseProveedor.payload!.idProveedor}'");
                if (recordProveedor.isEmpty) {
                  //Se recupera el id del tipoProveedor, condicionPago, banco y comunidad en Pocketbase y se acocia con el nuevo Proveedor
                  final recordTipoProveedor = await client.records.getFullList(
                      'tipo_proveedor',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idTipoProveedor}'");
                  final recordCondicionPago = await client.records.getFullList(
                      'condiciones_pago',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idCondicionesPago}'");
                  final recordBanco = await client.records.getFullList('bancos',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idBanco}'");
                  final recordComunidad = await client.records.getFullList(
                      'comunidades',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idCatComunidad}'");
                  if (recordTipoProveedor.isNotEmpty &&
                      recordCondicionPago.isNotEmpty &&
                      recordBanco.isNotEmpty &&
                      recordComunidad.isNotEmpty) {
                    //Se agrega el proveedor como nuevo en la colección de Pocketbase
                    final recordProveedor =
                        await client.records.create('proveedores', body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "id_tipo_proveedor_fk": recordTipoProveedor.first.id,
                      "direccion": responseProveedor.payload!.direccion,
                      "id_comunidad_fk": recordComunidad.first.id,
                      "nombre_encargado":
                          responseProveedor.payload!.nombreEncargado,
                      "id_condicion_pago_fk": recordCondicionPago.first.id,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "id_banco_fk": recordBanco.first.id,
                      "archivado": responseProveedor.payload!.archivado,
                      "id_emi_web":
                          responseProveedor.payload!.idProveedor.toString(),
                    });
                    if (recordProveedor.id.isNotEmpty) {
                      //print('Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                  } else {
                    return false;
                  }
                } else {
                  //Se actualiza el proveedor en la colección de Pocketbase
                  final recordProveedorParse =
                      getProveedoresFromMap(recordProveedor.first.toString());
                  //Verificamos que los campos de este registro sean diferentes para actualizarlo
                  if (recordProveedorParse.nombreFiscal !=
                          responseProveedor.payload!.nombreFiscal ||
                      recordProveedorParse.rfc !=
                          responseProveedor.payload!.rfc ||
                      recordProveedorParse.direccion !=
                          responseProveedor.payload!.direccion ||
                      recordProveedorParse.nombreEncargado !=
                          responseProveedor.payload!.nombreEncargado ||
                      recordProveedorParse.clabe !=
                          responseProveedor.payload!.cuentaClabe ||
                      recordProveedorParse.telefono !=
                          responseProveedor.payload!.telefono ||
                      recordProveedorParse.archivado !=
                          responseProveedor.payload!.archivado) {
                    final updateRecordProveedor = await client.records
                        .update('proveedores', recordProveedorParse.id, body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "direccion": responseProveedor.payload!.direccion,
                      "nombre_encargado":
                          responseProveedor.payload!.nombreEncargado,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "archivado": responseProveedor.payload!.archivado,
                    });
                    if (updateRecordProveedor.id.isNotEmpty) {
                      //print('Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                  }
                }
                break;
              case 401: //Error de Token incorrecto
                if (await getTokenOAuth()) {
                  getProveedoresNoArchivados();
                  return true;
                } else {
                  return false;
                }
              case 404: //Error de ruta incorrecta
                return false;
              default:
                return false;
            }
          }
          //print("Exito 17");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getProveedoresNoArchivados();
            return true;
          } else {
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      //print("Error en getProveedoresNoArchivados: $e");
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
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListProveedores = getProveedoresEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListProveedores.payload!.length; i++) {
            var url = Uri.parse(
                "$baseUrlEmiWebServices/proveedores/registro/${responseListProveedores.payload![i].id}");
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var response = await http.get(url, headers: headers);
            switch (response.statusCode) {
              case 200: //Caso éxitoso
                final responseProveedor = getProveedorByIdEmiWebFromMap(
                    const Utf8Decoder().convert(response.bodyBytes));
                //Verificamos que el nuevo proveedor no exista en Pocketbase
                final recordProveedor = await client.records.getFullList(
                    'proveedores',
                    batch: 200,
                    filter:
                        "id_emi_web='${responseProveedor.payload!.idProveedor}'");
                if (recordProveedor.isEmpty) {
                  //Se recupera el id del tipoProveedor, condicionPago, banco y comunidad en Pocketbase y se acocia con el nuevo Proveedor
                  final recordTipoProveedor = await client.records.getFullList(
                      'tipo_proveedor',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idTipoProveedor}'");
                  final recordCondicionPago = await client.records.getFullList(
                      'condiciones_pago',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idCondicionesPago}'");
                  final recordBanco = await client.records.getFullList('bancos',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idBanco}'");
                  final recordComunidad = await client.records.getFullList(
                      'comunidades',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProveedor.payload!.idCatComunidad}'");
                  if (recordTipoProveedor.isNotEmpty &&
                      recordCondicionPago.isNotEmpty &&
                      recordBanco.isNotEmpty &&
                      recordComunidad.isNotEmpty) {
                    //Se agrega el proveedor como nuevo en la colección de Pocketbase
                    final recordProveedor =
                        await client.records.create('proveedores', body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "id_tipo_proveedor_fk": recordTipoProveedor.first.id,
                      "direccion": responseProveedor.payload!.direccion,
                      "id_comunidad_fk": recordComunidad.first.id,
                      "nombre_encargado":
                          responseProveedor.payload!.nombreEncargado,
                      "id_condicion_pago_fk": recordCondicionPago.first.id,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "id_banco_fk": recordBanco.first.id,
                      "archivado": responseProveedor.payload!.archivado,
                      "id_emi_web":
                          responseProveedor.payload!.idProveedor.toString(),
                    });
                    if (recordProveedor.id.isNotEmpty) {
                      //print('Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                  } else {
                    return false;
                  }
                } else {
                  //Se actualiza el proveedor en la colección de Pocketbase
                  final recordProveedorParse =
                      getProveedoresFromMap(recordProveedor.first.toString());
                  //Verificamos que los campos de este registro sean diferentes para actualizarlo
                  if (recordProveedorParse.nombreFiscal !=
                          responseProveedor.payload!.nombreFiscal ||
                      recordProveedorParse.rfc !=
                          responseProveedor.payload!.rfc ||
                      recordProveedorParse.direccion !=
                          responseProveedor.payload!.direccion ||
                      recordProveedorParse.nombreEncargado !=
                          responseProveedor.payload!.nombreEncargado ||
                      recordProveedorParse.clabe !=
                          responseProveedor.payload!.cuentaClabe ||
                      recordProveedorParse.telefono !=
                          responseProveedor.payload!.telefono ||
                      recordProveedorParse.archivado !=
                          responseProveedor.payload!.archivado) {
                    final updateRecordProveedor = await client.records
                        .update('proveedores', recordProveedorParse.id, body: {
                      "nombre_fiscal": responseProveedor.payload!.nombreFiscal,
                      "rfc": responseProveedor.payload!.rfc,
                      "direccion": responseProveedor.payload!.direccion,
                      "nombre_encargado":
                          responseProveedor.payload!.nombreEncargado,
                      "clabe": responseProveedor.payload!.cuentaClabe,
                      "telefono": responseProveedor.payload!.telefono,
                      "archivado": responseProveedor.payload!.archivado,
                    });
                    if (updateRecordProveedor.id.isNotEmpty) {
                      //print('Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                    } else {
                      return false;
                    }
                  }
                }
                break;
              case 401: //Error de Token incorrecto
                if (await getTokenOAuth()) {
                  getProveedoresArchivados();
                  return true;
                } else {
                  return false;
                }
              case 404: //Error de ruta incorrecta
                return false;
              default:
                return false;
            }
          }
          //print("Exito 18");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getProveedoresArchivados();
            return true;
          } else {
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      //print("Error en getProveedoresArchivados: $e");
      return false;
    }
  }

//Función para recuperar el catálogo de familia de inversión desde Emi Web
  Future<bool> getFamiliaInversion() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/familiainversion");
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListFamiliaInversion = getFamiliaInversionEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListFamiliaInversion.payload!.length;
              i++) {
            //Verificamos que la nueva familia de inversion no exista en Pocketbase
            final recordFamiliaInversion = await client.records.getFullList(
                'familia_inversion',
                batch: 200,
                filter:
                    "id_emi_web='${responseListFamiliaInversion.payload![i].idCatFamiliaInversion}'");
            if (recordFamiliaInversion.isEmpty) {
              //Se agrega la familia inversión como nueva en la colección de Pocketbase
              final newRecordFamiliaInversion =
                  await client.records.create('familia_inversion', body: {
                "familia_inversion":
                    responseListFamiliaInversion.payload![i].familiaInversionNecesaria,
                "activo": responseListFamiliaInversion.payload![i].activo,
                "id_emi_web": responseListFamiliaInversion
                    .payload![i].idCatFamiliaInversion
                    .toString(),
              });
              if (newRecordFamiliaInversion.id.isNotEmpty) {
                //print('Familia Inversión Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza la familia inversion en la colección de Pocketbase
              final recordFamiliaInversionParse = getFamiliaInversionFromMap(
                  recordFamiliaInversion.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordFamiliaInversionParse.familiaInversion !=
                  responseListFamiliaInversion.payload![i].familiaInversionNecesaria ||
                  recordFamiliaInversionParse.activo !=
                  responseListFamiliaInversion.payload![i].activo) {
                final updateRecordFamiliaInversion = await client.records
                    .update('familia_inversion', recordFamiliaInversionParse.id,
                        body: {
                      "familia_inversion":
                        responseListFamiliaInversion.payload![i].familiaInversionNecesaria,
                      "activo": responseListFamiliaInversion.payload![i].activo
                    });
                if (updateRecordFamiliaInversion.id.isNotEmpty) {
                  //print('Familia Inversion Emi Web actualizado éxitosamente en Pocketbase');
                } else {
                  return false;
                }
              }
            }
          }
          //print("Exito 19");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getFamiliaInversion();
            return true;
          } else {
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
      var url =
          Uri.parse("$baseUrlEmiWebServices/productos/proveedores/filtros");
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListProductosProv = getProductosProvEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0;
              i < responseListProductosProv.payload!.ids!.length;
              i++) {
            var url = Uri.parse(
                "$baseUrlEmiWebServices/productos/proveedores/registro/${responseListProductosProv.payload!.ids![i]}");
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var response = await http.get(url, headers: headers);
            switch (response.statusCode) {
              case 200: //Caso éxitoso
                final responseProductoProveedor =
                    getProductosProvByIdEmiWebFromMap(
                        const Utf8Decoder().convert(response.bodyBytes));

                final recordProductoProveedor = await client.records.getFullList(
                    'productos_prov',
                    batch: 200,
                    filter:
                        "id_emi_web='${responseProductoProveedor.payload!.idProductosProveedor}'");
                //Verificamos que el nuevo producto proveedor no exista en Pocketbase
                if (recordProductoProveedor.isEmpty) {
                  //Se verifica que el Producto Proveedor a agregar tenga una imagen asociada
                  if (responseProductoProveedor.payload!.idDocumento != null) {
                    //Se recupera la información de la Imagen
                    var url = Uri.parse(
                        "$baseUrlEmiWebServices/documentos?id=${responseProductoProveedor.payload!.idDocumento}");
                    final headers = ({
                      "Content-Type": "application/json",
                      'Authorization': 'Bearer $tokenGlobal',
                    });
                    var response = await get(url, headers: headers);
                    switch (response.statusCode) {
                      case 200:
                        final responseImagenProductoProveedor =
                            getImagenProductoEmiWebFromMap(const Utf8Decoder()
                                .convert(response.bodyBytes));
                        // Decodificar imagen base 64
                        final image = decodeImage(base64.decode(responseImagenProductoProveedor.payload!.archivo));
                        // Redimendsionar imagen
                        final imageResized = copyResize(image!, width: 1920, height: 1080);
                        // Codificar imagen a nueva calidad
                        final List<int> imageBytes = encodeJpg(imageResized, quality: 30);
                        final recordImagenProductoProveedor =
                            await client.records.create('imagenes', body: {
                          "nombre": responseImagenProductoProveedor
                              .payload!.nombreArchivo,
                          "base64": base64.encode(imageBytes),
                          "id_emi_web":
                              responseProductoProveedor.payload!.idDocumento,
                        });
                        if (recordImagenProductoProveedor.id.isNotEmpty) {
                          //Se agrega Imagen de forma exitosa en Pocketbase
                          //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el nuevo Producto Proveedor
                          final recordProveedor = await client.records.getFullList(
                              'proveedores',
                              batch: 200,
                              filter:
                                  "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");

                          final recordUnidadMedida = await client.records
                              .getFullList('und_medida',
                                  batch: 200,
                                  filter:
                                      "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                          if (recordProveedor.isNotEmpty &&
                              recordUnidadMedida.isNotEmpty) {
                            //Se agrega el producto proveedor como nuevo en la colección de Pocketbase
                            final recordProductoProveedor = await client.records
                                .create('productos_prov', body: {
                              "nombre_prod_prov":
                                  responseProductoProveedor.payload!.producto,
                              "descripcion_prod_prov": responseProductoProveedor
                                  .payload!.descripcion,
                              "marca": responseProductoProveedor.payload!.marca,
                              "id_und_medida_fk": recordUnidadMedida.first.id,
                              "costo_prod_prov": responseProductoProveedor
                                  .payload!.costoUnidadMedida,
                              "id_proveedor_fk": recordProveedor.first.id,
                              "tiempo_entrega": responseProductoProveedor
                                  .payload!.tiempoEntrega,
                              "archivado":
                                  responseProductoProveedor.payload!.archivado,
                              "id_emi_web": responseProductoProveedor
                                  .payload!.idProductosProveedor
                                  .toString(),
                              "id_imagen_fk": recordImagenProductoProveedor.id,
                            });
                            if (recordProductoProveedor.id.isNotEmpty) {
                              //print('Producto Proveedor Emi Web agregado éxitosamente a Pocketbase');
                              //TODO: Sí es break o continue?
                              continue;
                            } else {
                              return false;
                            }
                          } else {
                            return false;
                          }
                        } else {
                          //Error al agregar imagen en Pocketbase
                          return false;
                        }

                      default:
                        return false;
                    }
                  } else {
                    //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el nuevo Producto Proveedor
                    final recordProveedor = await client.records.getFullList(
                        'proveedores',
                        batch: 200,
                        filter:
                            "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");
                    final recordUnidadMedida = await client.records.getFullList(
                        'und_medida',
                        batch: 200,
                        filter:
                            "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                    if (recordProveedor.isNotEmpty &&
                        recordUnidadMedida.isNotEmpty) {
                      //Se agrega el producto proveedor como nuevo en la colección de Pocketbase
                      final recordProductoProveedor =
                          await client.records.create('productos_prov', body: {
                        "nombre_prod_prov":
                            responseProductoProveedor.payload!.producto,
                        "descripcion_prod_prov":
                            responseProductoProveedor.payload!.descripcion,
                        "marca": responseProductoProveedor.payload!.marca,
                        "id_und_medida_fk": recordUnidadMedida.first.id,
                        "costo_prod_prov": responseProductoProveedor
                            .payload!.costoUnidadMedida,
                        "id_proveedor_fk": recordProveedor.first.id,
                        "tiempo_entrega":
                            responseProductoProveedor.payload!.tiempoEntrega,
                        "archivado":
                            responseProductoProveedor.payload!.archivado,
                        "id_emi_web": responseProductoProveedor
                            .payload!.idProductosProveedor
                            .toString(),
                      });
                      if (recordProductoProveedor.id.isNotEmpty) {
                        //print('Producto Proveedor Emi Web agregado éxitosamente a Pocketbase');
                      } else {
                        return false;
                      }
                    } else {
                      return false;
                    }
                  }
                } else {
                  // El Producto Proveedor ya existe en Pocketbase
                  // Se Aplica el Parseo para evaluar sus campos
                  final recordProductoProveedorParse = getProductosProvFromMap(
                      recordProductoProveedor.first.toString());
                  //Verificamos que haya imagen asociada al Producto
                  if (responseProductoProveedor.payload!.idDocumento == null) {
                    //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el nuevo Producto Proveedor
                    final recordProveedor = await client.records.getFullList(
                        'proveedores',
                        batch: 200,
                        filter:
                            "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");
                    final recordUnidadMedida = await client.records.getFullList(
                        'und_medida',
                        batch: 200,
                        filter:
                            "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                    if (recordProveedor.isNotEmpty &&
                        recordUnidadMedida.isNotEmpty) {
                      //Se actualiza el producto del proveedor
                      final updateRecordProductoProveedor = await client.records
                          .update(
                            'productos_prov', recordProductoProveedorParse.id,
                              body: {
                            "nombre_prod_prov":
                                responseProductoProveedor.payload!.producto,
                            "descripcion_prod_prov":
                                responseProductoProveedor.payload!.descripcion,
                            "marca": responseProductoProveedor.payload!.marca,
                            "id_und_medida_fk": recordUnidadMedida.first.id,
                            "costo_prod_prov": responseProductoProveedor
                                .payload!.costoUnidadMedida,
                            "id_proveedor_fk": recordProveedor.first.id,
                            "tiempo_entrega":
                                responseProductoProveedor.payload!.tiempoEntrega,
                            "archivado":
                                responseProductoProveedor.payload!.archivado,
                            "id_emi_web": responseProductoProveedor
                                .payload!.idProductosProveedor
                                .toString(),
                            "id_imagen_fk": ""
                          });
                      if (updateRecordProductoProveedor.id.isNotEmpty) {
                        //print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                      } else {
                        return false;
                      }
                    } else {
                      return false;
                    }
                  } else {
                    final recordImagenProductoProv = await client.records.getFullList(
                        'imagenes',
                        batch: 200,
                        filter:
                            "id_emi_web='${responseProductoProveedor.payload!.idDocumento}'");
                    if (recordImagenProductoProv.isEmpty) {
                     //Se recupera la información de la Imagen
                      var url = Uri.parse(
                          "$baseUrlEmiWebServices/documentos?id=${responseProductoProveedor.payload!.idDocumento}");
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      var response = await get(url, headers: headers);
                      switch (response.statusCode) {
                        case 200:
                          final responseImagenProductoProveedor =
                              getImagenProductoEmiWebFromMap(const Utf8Decoder()
                                  .convert(response.bodyBytes));
                          // Decodificar imagen base 64
                          final image = decodeImage(base64.decode(responseImagenProductoProveedor.payload!.archivo));
                          // Redimendsionar imagen
                          final imageResized = copyResize(image!, width: 1920, height: 1080);
                          // Codificar imagen a nueva calidad
                          final List<int> imageBytes = encodeJpg(imageResized, quality: 30);
                          final recordImagenProductoProveedor =
                              await client.records.create('imagenes', body: {
                            "nombre": responseImagenProductoProveedor
                                .payload!.nombreArchivo,
                            "base64": base64.encode(imageBytes),
                            "id_emi_web":
                                responseProductoProveedor.payload!.idDocumento,
                          });
                          if (recordImagenProductoProveedor.id.isNotEmpty) {
                            //Se agrega Imagen de forma exitosa en Pocketbase
                            //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el Producto Proveedor
                            final recordProveedor = await client.records.getFullList(
                                'proveedores',
                                batch: 200,
                                filter:
                                    "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");
                            final recordUnidadMedida = await client.records
                                .getFullList('und_medida',
                                    batch: 200,
                                    filter:
                                        "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                            if (recordProveedor.isNotEmpty &&
                                recordUnidadMedida.isNotEmpty) {
                              //Se actualiza el producto del proveedor
                              final updateRecordProductoProveedor = await client.records
                                  .update(
                                    'productos_prov', recordProductoProveedorParse.id,
                                      body: {
                                    "nombre_prod_prov":
                                        responseProductoProveedor.payload!.producto,
                                    "descripcion_prod_prov":
                                        responseProductoProveedor.payload!.descripcion,
                                    "marca": responseProductoProveedor.payload!.marca,
                                    "id_und_medida_fk": recordUnidadMedida.first.id,
                                    "costo_prod_prov": responseProductoProveedor
                                        .payload!.costoUnidadMedida,
                                    "id_proveedor_fk": recordProveedor.first.id,
                                    "tiempo_entrega":
                                        responseProductoProveedor.payload!.tiempoEntrega,
                                    "archivado":
                                        responseProductoProveedor.payload!.archivado,
                                    "id_imagen_fk": recordImagenProductoProveedor.id,
                                  });
                              if (updateRecordProductoProveedor.id.isNotEmpty) {
                                //print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                                    continue;
                              } else {
                                return false;
                              }
                            } else {
                              return false;
                            }
                          } else {
                            //Error al agregar imagen en Pocketbase
                            return false;
                          }
                        default:
                          return false;
                      }
                    } else {
                      //Se recupera la información de la Imagen
                      var url = Uri.parse(
                          "$baseUrlEmiWebServices/documentos?id=${responseProductoProveedor.payload!.idDocumento}");
                      final headers = ({
                        "Content-Type": "application/json",
                        'Authorization': 'Bearer $tokenGlobal',
                      });
                      var response = await get(url, headers: headers);
                      switch (response.statusCode) {
                        case 200:
                          final responseImagenProductoProveedor =
                              getImagenProductoEmiWebFromMap(const Utf8Decoder()
                                  .convert(response.bodyBytes));
                          // Decodificar imagen base 64
                          final image = decodeImage(base64.decode(responseImagenProductoProveedor.payload!.archivo));
                          // Redimendsionar imagen
                          final imageResized = copyResize(image!, width: 1920, height: 1080);
                          // Codificar imagen a nueva calidad
                          final List<int> imageBytes = encodeJpg(imageResized, quality: 30);
                          final recordImagenProductoProveedor =
                              await client.records.update('imagenes', recordImagenProductoProv.first.id, body: {
                            "nombre": responseImagenProductoProveedor
                                .payload!.nombreArchivo,
                            "base64": base64.encode(imageBytes),
                          });
                          if (recordImagenProductoProveedor.id.isNotEmpty) {
                            //Se actualiza Imagen de forma exitosa en Pocketbase
                            //Se recupera el id del proveedor, familia producto y unidad de medida en Pocketbase y se acocia con el Producto Proveedor
                            final recordProveedor = await client.records.getFullList(
                                'proveedores',
                                batch: 200,
                                filter:
                                    "id_emi_web='${responseProductoProveedor.payload!.idProveedor}'");
                            final recordUnidadMedida = await client.records
                                .getFullList('und_medida',
                                    batch: 200,
                                    filter:
                                        "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                            if (recordProveedor.isNotEmpty &&
                                recordUnidadMedida.isNotEmpty) {
                              //Se actualiza el producto del proveedor
                              final updateRecordProductoProveedor = await client.records
                                  .update(
                                    'productos_prov', recordProductoProveedorParse.id,
                                      body: {
                                    "nombre_prod_prov":
                                        responseProductoProveedor.payload!.producto,
                                    "descripcion_prod_prov":
                                        responseProductoProveedor.payload!.descripcion,
                                    "marca": responseProductoProveedor.payload!.marca,
                                    "id_und_medida_fk": recordUnidadMedida.first.id,
                                    "costo_prod_prov": responseProductoProveedor
                                        .payload!.costoUnidadMedida,
                                    "id_proveedor_fk": recordProveedor.first.id,
                                    "tiempo_entrega":
                                        responseProductoProveedor.payload!.tiempoEntrega,
                                    "archivado":
                                        responseProductoProveedor.payload!.archivado,
                                  });
                              if (updateRecordProductoProveedor.id.isNotEmpty) {
                                //print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                                    continue;
                              } else {
                                return false;
                              }
                            } else {
                              return false;
                            }
                          } else {
                            //Error al actualizar imagen en Pocketbase
                            return false;
                          }
                        default:
                          return false;
                      }
                    }
                  }
                }
                break;
              case 401: //Error de Token incorrecto
                if (await getTokenOAuth()) {
                  getProductosProv();
                  return true;
                } else {
                  return false;
                }
              case 404: //Error de ruta incorrecta
                return false;
              default:
                return false;
            }
          }
          //print("Exito 20");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getProductosProv();
            return true;
          } else {
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      //print("Error en getProductosProv: $e");
      return false;
    }
  }

//Función para recuperar el catálogo de productos del proyecto desde Emi Web
  Future<bool> getProdProyecto() async {
    try {
      var url =
          Uri.parse("$baseUrlEmiWebServices/catalogos/inversionxproyecto");
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      var response = await http.get(url, headers: headers);

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          final responseListProdProyecto = getProdProyectoEmiWebFromMap(
              const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListProdProyecto.payload!.length; i++) {
            var url = Uri.parse(
                "$baseUrlEmiWebServices/productos/proveedores/registro/${responseListProdProyecto.payload![i].producto!.idProductosProveedor}");
            final headers = ({
              "Content-Type": "application/json",
              'Authorization': 'Bearer $tokenGlobal',
            });
            var response = await http.get(url, headers: headers);
            switch (response.statusCode) {
              case 200: //Caso éxitoso
                final responseProductoProveedor =
                    getProductosProvByIdEmiWebFromMap(
                        const Utf8Decoder().convert(response.bodyBytes));
                //Verificamos que el nuevo producto del proyecto no exista en Pocketbase
                final recordProductoProyecto = await client.records.getFullList(
                    'prod_proyecto',
                    batch: 200,
                    filter:
                        "id_emi_web='${responseListProdProyecto.payload![i].idCatInversionProyecto}'");
                if (recordProductoProyecto.isEmpty) {
                  //Se recupera el id familia inversion, catalogo proyecto y tipo empaque en Pocketbase y se acocia con el nuevo Producto Proyecto
                  final recordFamiliaInversion = await client.records.getFullList(
                      'familia_inversion',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseListProdProyecto.payload![i].familiaInversion!.idCatFamiliaInversion}'");
                  final recordCatalogoProyecto = await client.records.getFullList(
                      'cat_proyecto',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseListProdProyecto.payload![i].idCatProyecto}'");
                  final recordTipoEmpaque = await client.records.getFullList(
                      'tipo_empaques',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                  if (recordFamiliaInversion.isNotEmpty && 
                      recordCatalogoProyecto.isNotEmpty &&
                      recordTipoEmpaque.isNotEmpty) {
                    //Se agrega el producto proveedor como nuevo en la colección de Pocketbase
                    final recordProductoProyecto =
                        await client.records.create('prod_proyecto', body: {
                      "producto": responseListProdProyecto
                          .payload![i].producto!.producto,
                      "marca_sugerida":
                          responseProductoProveedor.payload!.marca,
                      "descripcion":
                          responseProductoProveedor.payload!.descripcion,
                      "proveedor_sugerido": responseListProdProyecto
                          .payload![i].proveedorSugerido!.nombreFiscal,
                      "cantidad": responseListProdProyecto.payload![i].cantidad,
                      "costo_estimado":
                          responseListProdProyecto.payload![i].costoEstimado,
                      "id_tipo_empaque_fk": recordTipoEmpaque.first.id,
                      "id_catalogo_proyecto_fk":
                          recordCatalogoProyecto.first.id,
                      "id_emi_web": responseListProdProyecto
                          .payload![i].idCatInversionProyecto,
                      "id_familia_inversion_fk": recordFamiliaInversion.first.id,
                    });
                    if (recordProductoProyecto.id.isNotEmpty) {
                      //print('Producto Proveedor Emi Web agregado éxitosamente a Pocketbase');
                    } else {
                      return false;
                    }
                  } else {
                    return false;
                  }
                } else {
                  //Se recupera el id familia inversion, catalogo proyecto y tipo empaque en Pocketbase y se acocia con el nuevo Producto Proyecto
                  final recordFamiliaInversion = await client.records.getFullList(
                      'familia_inversion',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseListProdProyecto.payload![i].familiaInversion!.idCatFamiliaInversion}'");
                  final recordCatalogoProyecto = await client.records.getFullList(
                      'cat_proyecto',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseListProdProyecto.payload![i].idCatProyecto}'");
                  final recordTipoEmpaque = await client.records.getFullList(
                      'tipo_empaques',
                      batch: 200,
                      filter:
                          "id_emi_web='${responseProductoProveedor.payload!.idUnidadMedida}'");
                  if (recordFamiliaInversion.isNotEmpty && 
                      recordCatalogoProyecto.isNotEmpty &&
                      recordTipoEmpaque.isNotEmpty) {
                    //Se actualiza el producto proveedor en la colección de Pocketbase
                    final recordProductoProyectoParse = getProdProyectoFromMap(
                        recordProductoProyecto.first.toString());
                    //Verificamos que los campos de este registro sean diferentes para actualizarlo
                    if (recordProductoProyectoParse.producto !=
                            responseListProdProyecto
                                .payload![i].producto!.producto ||
                        recordProductoProyectoParse.descripcion !=
                            responseProductoProveedor.payload!.descripcion ||
                        recordProductoProyectoParse.marcaSugerida !=
                            responseProductoProveedor.payload!.marca ||
                        recordProductoProyectoParse.proveedorSugerido !=
                            responseListProdProyecto
                                .payload![i].proveedorSugerido!.nombreFiscal ||
                        recordProductoProyectoParse.cantidad !=
                            responseListProdProyecto.payload![i].cantidad ||
                        recordProductoProyectoParse.costoEstimado !=
                            responseListProdProyecto.payload![i].costoEstimado ||
                        recordProductoProyectoParse.idFamiliaInversionFk != 
                        recordFamiliaInversion.first.id ||
                        recordProductoProyectoParse.idCatalogoProyectoFk != 
                        recordCatalogoProyecto.first.id ||
                        recordProductoProyectoParse.idTipoEmpaqueFk != 
                        recordTipoEmpaque.first.id
                        ) {
                      final updateRecordProductoProyecto = await client.records
                          .update('prod_proyecto', recordProductoProyectoParse.id,
                              body: {
                            "producto": responseListProdProyecto
                                .payload![i].producto!.producto,
                            "marca_sugerida":
                                responseProductoProveedor.payload!.marca,
                            "descripcion":
                                responseProductoProveedor.payload!.descripcion,
                            "proveedor_sugerido": responseListProdProyecto
                                .payload![i].proveedorSugerido!.nombreFiscal,
                            "cantidad":
                                responseListProdProyecto.payload![i].cantidad,
                            "costo_estimado": responseListProdProyecto
                                .payload![i].costoEstimado,
                            "id_tipo_empaque_fk": recordTipoEmpaque.first.id,
                            "id_catalogo_proyecto_fk": recordCatalogoProyecto.first.id,
                            "id_familia_inversion_fk": recordFamiliaInversion.first.id,
                          });
                      if (updateRecordProductoProyecto.id.isNotEmpty) {
                        //print('Producto Proveedor Emi Web actualizado éxitosamente en Pocketbase');
                      } else {
                        return false;
                      }
                    }
                  } else {
                    return false;
                  }
                }
                break;
              case 401: //Error de Token incorrecto
                if (await getTokenOAuth()) {
                  getProdProyecto();
                  return true;
                } else {
                  return false;
                }
              case 404: //Error de ruta incorrecta
                return false;
              default:
                return false;
            }
          }
          //print("Exito 21");
          return true;
        case 401: //Error de Token incorrecto
          if (await getTokenOAuth()) {
            getProdProyecto();
            return true;
          } else {
            return false;
          }
        case 404: //Error de ruta incorrecta
          return false;
        default:
          return false;
      }
    } catch (e) {
      //print("Error en getProdProyecto: $e");
      return false;
    }
  }

  //Función para recuperar la información del usuario desde Emi Web
  Future<bool> getInfoUsuarioPerfil() async {
    try {
      //print("Si entro a función InfoUsuarioPerfil: ${prefs.getString("userId")}");
      //Se recupera la información básica del usuario desde Emi Web
      var urlGetUsuarioBasico = Uri.parse(
          "$baseUrlEmiWebServices/usuarios?correo=${prefs.getString("userId")}");
      final headers = ({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $tokenGlobal',
      });
      var responseGetUsuarioDataBasico =
          await get(urlGetUsuarioBasico, headers: headers);
      //print("${responseGetUsuarioDataBasico.body}");
      //print("${responseGetUsuarioDataBasico.statusCode}");
      switch (responseGetUsuarioDataBasico.statusCode) {
        case 200: //Caso éxitoso
          //print("Primer caso éxitoso");
          final responseGetUsuarioDataBasicoParse = getUsuarioEmiWebFromMap(
              const Utf8Decoder()
                  .convert(responseGetUsuarioDataBasico.bodyBytes));
          //print("Hola");
          var urlGetUsuarioDataCompleto = Uri.parse(
              "$baseUrlEmiWebServices/usuarios/registro/${responseGetUsuarioDataBasicoParse.payload!.idUsuario}");
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          var responseGetUsuarioDataCompleto =
              await http.get(urlGetUsuarioDataCompleto, headers: headers);
          //print("${responseGetUsuarioDataCompleto.statusCode}");
          //print("${responseGetUsuarioDataCompleto.body}");
          switch (responseGetUsuarioDataCompleto.statusCode) {
            case 200: //Caso éxitoso
              //print("Segundo caso éxitoso");
              final responseGetUsuarioDataCompletoParse =
                  getUsuarioCompletoEmiWebFromMap(const Utf8Decoder()
                      .convert(responseGetUsuarioDataCompleto.bodyBytes));
              List<String> listRoles = [];
              //Se recuperan los id Emi Web de los roles del Usuario
              for (var i = 0;
                  i <
                      responseGetUsuarioDataCompletoParse
                          .payload!.tiposUsuario!.length;
                  i++) {
                final rol = dataBase.rolesBox
                    .query(Roles_.idDBR.equals(
                        responseGetUsuarioDataCompletoParse
                            .payload!.tiposUsuario![i].idCatRoles
                            .toString()))
                    .build()
                    .findUnique();
                if (rol != null) {
                  if (rol.rol != "Staff Logística" &&
                      rol.rol != "Staff Dirección") {
                    listRoles.add(rol.idDBR);
                  }
                }
              }
              if (listRoles.isEmpty ||
                  responseGetUsuarioDataBasicoParse.payload!.archivado ==
                      true) {
                usuarioExit = true;
              }
              //Se recupera al usuario
              final updateUsuario = dataBase.usuariosBox
                  .query(Usuarios_.idDBR.equals(
                      responseGetUsuarioDataBasicoParse.payload!.idUsuario
                          .toString()))
                  .build()
                  .findUnique();
              if (updateUsuario != null) {
                //Se recupera la imagen del Usuario
                if (responseGetUsuarioDataCompletoParse.payload!.idDocumento ==
                    0) {
                  //print("No hay imagen asociada");
                  //No hay imagen nueva asociada al usuario
                  if (updateUsuario == null) {
                    //print("No había imagen previa");
                    //Se actualiza Usuario emi_users nuevo en colección de pocketbase
                    final updateRecordEmiUser = await client.records.update(
                        'emi_users', updateUsuario.idDBR.toString(),
                        body: {
                          "nombre_usuario": responseGetUsuarioDataCompletoParse
                              .payload!.nombre,
                          "apellido_p": responseGetUsuarioDataCompletoParse
                              .payload!.apellidoPaterno,
                          "apellido_m": responseGetUsuarioDataCompletoParse
                              .payload!.apellidoMaterno,
                          "telefono": responseGetUsuarioDataCompletoParse
                                      .payload!.telefono !=
                                  "Vacío"
                              ? responseGetUsuarioDataCompletoParse
                                  .payload!.telefono
                              : "",
                          "celular": responseGetUsuarioDataCompletoParse
                                      .payload!.celular !=
                                  "Vacío"
                              ? responseGetUsuarioDataCompletoParse
                                  .payload!.telefono
                              : "",
                          "id_roles_fk": listRoles,
                          "archivado": responseGetUsuarioDataBasicoParse
                              .payload!.archivado,
                        });
                    if (updateRecordEmiUser.id.isNotEmpty) {
                      // Usuario actualizado éxitosamente en Pocketbase
                      //print("éxito en la actualización Usuario Pocketbase");
                      return true;
                    } else {
                      // Usuario Emi Web no actualizado éxitosamente en Pocketbase
                      //print("no éxito en la actualización Usuario Pocketbase");
                      return false;
                    }
                  } else {
                    //print("Ya había imagen previa");
                    //Se actualiza Usuario emi_users nuevo en colección de pocketbase
                    final updateRecordEmiUser = await client.records.update(
                        'emi_users', updateUsuario.idDBR.toString(),
                        body: {
                          "nombre_usuario": responseGetUsuarioDataCompletoParse
                              .payload!.nombre,
                          "apellido_p": responseGetUsuarioDataCompletoParse
                              .payload!.apellidoPaterno,
                          "apellido_m": responseGetUsuarioDataCompletoParse
                              .payload!.apellidoMaterno,
                          "telefono": responseGetUsuarioDataCompletoParse
                                      .payload!.telefono !=
                                  "Vacío"
                              ? responseGetUsuarioDataCompletoParse
                                  .payload!.telefono
                              : "",
                          "celular": responseGetUsuarioDataCompletoParse
                                      .payload!.celular !=
                                  "Vacío"
                              ? responseGetUsuarioDataCompletoParse
                                  .payload!.telefono
                              : "",
                          "id_roles_fk": listRoles,
                          "id_imagen_fk": "",
                          "archivado": responseGetUsuarioDataBasicoParse
                              .payload!.archivado,
                        });
                    if (updateRecordEmiUser.id.isNotEmpty) {
                      // Usuario actualizado éxitosamente en Pocketbase
                      //Se elimina la imagen de Pocketbase anterior
                      // await client.records.delete(
                      //     'imagenes', '${updateUsuario.imagen.target!.idDBR}');
                      return true;
                    } else {
                      // Usuario Emi Web no actualizado éxitosamente en Pocketbase
                      return false;
                    }
                  }
                } else {
                  //print("Si hay imagen asociada");
                  //Si hay imagen asociada al usuario
                  //print("ID Documento: ${responseGetUsuarioDataCompletoParse.payload!.idDocumento}");
                  var url = Uri.parse(
                      "$baseUrlEmiWebServices/documentos?id=${responseGetUsuarioDataCompletoParse.payload!.idDocumento}");
                  final headers = ({
                    "Content-Type": "application/json",
                    'Authorization': 'Bearer $tokenGlobal',
                  });
                  var responseImagenUsuario = await get(url, headers: headers);
                  //print("${responseImagenUsuario.body}");
                  //print("${responseImagenUsuario.statusCode}");
                  switch (responseImagenUsuario.statusCode) {
                    case 200: //Caso éxitoso
                      //print("Hay imagen éxitoso");
                      final responseImagenUsuarioEmiWeb =
                          getImagenUsuarioEmiWebFromMap(const Utf8Decoder()
                              .convert(responseImagenUsuario.bodyBytes));
                      if (updateUsuario == null) {
                        // Se crea la imagen
                        //print("Se crea imagen");
                        // Decodificar imagen base 64
                        final image = decodeImage(base64.decode(responseImagenUsuarioEmiWeb.payload!.archivo));
                        // Redimendsionar imagen
                        final imageResized = copyResize(image!, width: 1920, height: 1080);
                        // Codificar imagen a nueva calidad
                        final List<int> imageBytes = encodeJpg(imageResized, quality: 30);
                        final newRecordImagenUsuario =
                            await client.records.create('imagenes', body: {
                          "nombre": responseImagenUsuarioEmiWeb
                              .payload!.nombreArchivo,
                          "id_emi_web": responseImagenUsuarioEmiWeb
                              .payload!.idUsuario
                              .toString(),
                          "base64": base64.encode(imageBytes),
                        });
                        if (newRecordImagenUsuario.id.isNotEmpty) {
                          //Se actualiza Usuario emi_users nuevo en colección de pocketbase
                          final updateRecordEmiUser = await client.records
                              .update(
                                  'emi_users', updateUsuario.idDBR.toString(),
                                  body: {
                                "nombre_usuario":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.nombre,
                                "apellido_p":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.apellidoPaterno,
                                "apellido_m":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.apellidoMaterno,
                                "telefono": responseGetUsuarioDataCompletoParse
                                            .payload!.telefono !=
                                        "Vacío"
                                    ? responseGetUsuarioDataCompletoParse
                                        .payload!.telefono
                                    : "",
                                "celular": responseGetUsuarioDataCompletoParse
                                            .payload!.celular !=
                                        "Vacío"
                                    ? responseGetUsuarioDataCompletoParse
                                        .payload!.telefono
                                    : "",
                                "id_roles_fk": listRoles,
                                "archivado": responseGetUsuarioDataBasicoParse
                                    .payload!.archivado,
                                "id_imagen_fk": newRecordImagenUsuario.id,
                              });
                          if (updateRecordEmiUser.id.isNotEmpty) {
                            // Usuario actualizado éxitosamente en Pocketbase
                            return true;
                          } else {
                            // Usuario Emi Web no actualizado éxitosamente en Pocketbase
                            return false;
                          }
                        } else {
                          // Imagen usuario Emi Web no agregado éxitosamente en Pocketbase
                          return false;
                        }
                      } else {
                        // Se actualiza la imagen
                        //print("Se actualiza imagen");
                        //print("${updateUsuario.imagen.target!.idDBR.toString()}");
                        // Decodificar imagen base 64
                        final image = decodeImage(base64.decode(responseImagenUsuarioEmiWeb.payload!.archivo));
                        // Redimendsionar imagen
                        final imageResized = copyResize(image!, width: 1920, height: 1080);
                        // Codificar imagen a nueva calidad
                        final List<int> imageBytes = encodeJpg(imageResized, quality: 30);
                        final updateRecordImagenUsuario = await client.records
                            .update('imagenes',
                                "",
                                body: {
                              "nombre": responseImagenUsuarioEmiWeb
                                  .payload!.nombreArchivo,
                              "id_emi_web": responseImagenUsuarioEmiWeb
                                  .payload!.idUsuario
                                  .toString(),
                              "base64": base64.encode(imageBytes),
                            });
                        if (updateRecordImagenUsuario.id.isNotEmpty) {
                          //Se actualiza Usuario emi_users nuevo en colección de pocketbase
                          final updateRecordEmiUser = await client.records
                              .update(
                                  'emi_users', updateUsuario.idDBR.toString(),
                                  body: {
                                "nombre_usuario":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.nombre,
                                "apellido_p":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.apellidoPaterno,
                                "apellido_m":
                                    responseGetUsuarioDataCompletoParse
                                        .payload!.apellidoMaterno,
                                "telefono": responseGetUsuarioDataCompletoParse
                                            .payload!.telefono !=
                                        "Vacío"
                                    ? responseGetUsuarioDataCompletoParse
                                        .payload!.telefono
                                    : "",
                                "celular": responseGetUsuarioDataCompletoParse
                                            .payload!.celular !=
                                        "Vacío"
                                    ? responseGetUsuarioDataCompletoParse
                                        .payload!.telefono
                                    : "",
                                "id_roles_fk": listRoles,
                                "archivado": responseGetUsuarioDataBasicoParse
                                    .payload!.archivado,
                                "id_imagen_fk": updateRecordImagenUsuario.id,
                              });
                          if (updateRecordEmiUser.id.isNotEmpty) {
                            // Usuario actualizado éxitosamente en Pocketbase
                            //print("Exito 22");
                            return true;
                          } else {
                            // Usuario Emi Web no actualizado éxitosamente en Pocketbase
                            return false;
                          }
                        } else {
                          // Imagen usuario Emi Web no agregado éxitosamente en Pocketbase
                          return false;
                        }
                      }
                    default:
                      // No se recuperó la imagen del usuario en Emi Web
                      return false;
                  }
                }
              } else {
                // No se encontró al usuario en ObjectBox
                return false;
              }
            default:
              // No se recuperaron los datos completos del usuario
              return false;
          }
        default:
          // No se recuperaron los datos básicos del usuario
          return false;
      }
    } catch (e) {
      //print("Error en getInfoUsuarioPerfil: $e");
      return false;
    }
  }
}
