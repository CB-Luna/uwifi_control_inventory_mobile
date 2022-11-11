import 'package:bizpro_app/modelsPocketbase/get_bancos.dart';
import 'package:bizpro_app/modelsPocketbase/get_condiciones_pago.dart';
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
import 'package:bizpro_app/modelsPocketbase/get_unidades_medida.dart';
import 'package:bizpro_app/modelsPocketbase/get_estados.dart';
import 'package:bizpro_app/modelsPocketbase/get_municipios.dart';
import 'package:bizpro_app/modelsPocketbase/get_estado_inversiones.dart';
import 'package:bizpro_app/modelsPocketbase/get_familia_productos.dart';
import 'package:bizpro_app/modelsPocketbase/get_fases_emp.dart';
import 'package:bizpro_app/modelsPocketbase/get_tipo_empaques.dart';
import '../objectbox.g.dart';

class CatalogoPocketbaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
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

  Future<void> getCatalogos() async {
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
    banderasExistoSync.add(await getProveedores());
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
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExistoSync.clear();
      notifyListeners();
    }
  }

//Función para limpiar el contenido de registros en las bases de datos para todos los catálogos
  void clearDataBase() {
    // dataBase.comunidadesBox.removeAll();
    // dataBase.municipiosBox.removeAll();
    // dataBase.estadosBox.removeAll();
    // dataBase.tipoProyectoBox.removeAll();
  }
  
//Función para recuperar el catálogo de estados desde Pocketbase
  Future<bool> getEstados() async {
    try {
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
              idEmiWeb: listEstados[i].idEmiWeb,
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
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de municipios desde Pocketbase
  Future<bool> getMunicipios() async {
    try {
      //Se recupera toda la colección de municipios en Pocketbase
      final records = await client.records.
        getFullList('municipios', batch: 200, sort: '+nombre_municipio');
      if (records.isNotEmpty) {
        //Existen datos de muncipios en Pocketbase
        final List<GetMunicipios> listMunicipios = [];
        for (var element in records) {
          listMunicipios.add(getMunicipiosFromMap(element.toString()));
        }
        for (var i = 0; i < listMunicipios.length; i++) {
          //Se valida que el nuevo municipio aún no existe en Objectbox
          final estado = dataBase.estadosBox.query(Estados_.idDBR.equals(listMunicipios[i].idEstadoFk)).build().findUnique();
          final municipioExistente = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listMunicipios[i].id)).build().findUnique();
          if (municipioExistente == null) {
            if (listMunicipios[i].id.isNotEmpty) {
              final nuevoMunicipio = Municipios(
                nombre: listMunicipios[i].nombreMunicipio,
                activo: listMunicipios[i].activo,
                idDBR: listMunicipios[i].id,
                fechaRegistro: listMunicipios[i].updated, 
                idEmiWeb: listMunicipios[i].idEmiWeb,
                );
              if (estado != null) {
                nuevoMunicipio.estados.target = estado;
                dataBase.municipiosBox.put(nuevoMunicipio);
                print('Municipio Nuevo agregado éxitosamente');
              }
              else {
                return false;
              }
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (municipioExistente.fechaRegistro != listMunicipios[i].updated) {
              if (estado != null) {
                //Se actualiza el registro en Objectbox
                municipioExistente.nombre = listMunicipios[i].nombreMunicipio;
                municipioExistente.activo = listMunicipios[i].activo;
                municipioExistente.estados.target = estado;
                municipioExistente.fechaRegistro = listMunicipios[i].updated!;
                dataBase.municipiosBox.put(municipioExistente);
              }
              else {
                return false;
              }
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de comunidades desde Pocketbase
  Future<bool> getComunidades() async {
    try {
      //Se recupera toda la colección de comunidades en Pocketbase
      final records = await client.records.
        getFullList('comunidades', batch: 200, sort: '+nombre_comunidad');
      if (records.isNotEmpty) {
        //Existen datos de comunidades en Pocketbase
        final List<GetComunidades> listComunidades = [];
        for (var element in records) {
          listComunidades.add(getComunidadesFromMap(element.toString()));
        }
        for (var i = 0; i < listComunidades.length; i++) {
          //Se valida que la nueva comunidad aún no existe en Objectbox
          final municipio = dataBase.municipiosBox.query(Municipios_.idDBR.equals(listComunidades[i].idMunicipioFk)).build().findUnique();
          final comunidadExistente = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listComunidades[i].id)).build().findUnique();
          if (comunidadExistente == null) {
            if (listComunidades[i].id.isNotEmpty) {
              final nuevaComunidad = Comunidades(
                nombre: listComunidades[i].nombreComunidad,
                activo: listComunidades[i].activo,
                idDBR: listComunidades[i].id,
                fechaRegistro: listComunidades[i].updated, 
                idEmiWeb: listComunidades[i].idEmiWeb,
                );
              if (municipio != null) {
                nuevaComunidad.municipios.target = municipio;
                dataBase.comunidadesBox.put(nuevaComunidad);
                print('Comunidad Nueva agregada éxitosamente');
              }
              else {
                return false;
              }
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (comunidadExistente.fechaRegistro != listComunidades[i].updated) {
              if (municipio != null) {
                //Se actualiza el registro en Objectbox
                comunidadExistente.nombre = listComunidades[i].nombreComunidad;
                comunidadExistente.activo = listComunidades[i].activo;
                comunidadExistente.municipios.target = municipio;
                comunidadExistente.fechaRegistro = listComunidades[i].updated!;
                dataBase.comunidadesBox.put(comunidadExistente);
              }
              else {
                return false;
              }
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de proyectos desde Pocketbase
  Future<bool> getTipoProyecto() async {
    try {
      //Se recupera toda la colección de tipo de proyecto en Pocketbase
      final records = await client.records.
          getFullList('tipo_proyecto', batch: 200, sort: '+tipo_proyecto');
      if (records.isNotEmpty) {
        //Existen datos de tipo de proyecto en Pocketbase
        final List<GetTipoProyecto> listTipoProyecto = [];
        for (var element in records) {
          listTipoProyecto.add(getTipoProyectoFromMap(element.toString()));
        }
        for (var i = 0; i < listTipoProyecto.length; i++) {
          //Se valida que el nuevo tipo de Proyecto aún no existe en Objectbox
          final tipoProyectoExistente = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listTipoProyecto[i].id)).build().findUnique();
          if (tipoProyectoExistente == null) {
            if (listTipoProyecto[i].id.isNotEmpty) {
              final nuevoTipoProyecto = TipoProyecto(
              tipoProyecto: listTipoProyecto[i].tipoProyecto,
              activo: listTipoProyecto[i].activo,
              idDBR: listTipoProyecto[i].id, 
              idEmiWeb: listTipoProyecto[i].idEmiWeb,
              );
              dataBase.tipoProyectoBox.put(nuevoTipoProyecto);
              print('Tipo Proyecto Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (tipoProyectoExistente.fechaRegistro != listTipoProyecto[i].updated) {
              //Se actualiza el registro en Objectbox
              tipoProyectoExistente.tipoProyecto = listTipoProyecto[i].tipoProyecto;
              tipoProyectoExistente.activo = listTipoProyecto[i].activo;
              tipoProyectoExistente.fechaRegistro = listTipoProyecto[i].updated!;
              dataBase.tipoProyectoBox.put(tipoProyectoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de catalogo proyecto desde Pocketbase
  Future<bool> getCatalogosProyectos() async {
    try {
      //Se recupera toda la colección de catalogo proyecto en Pocketbase
      final records = await client.records.
        getFullList('cat_proyecto', batch: 200, sort: '+nombre_proyecto');
      if (records.isNotEmpty) {
        //Existen datos de catalogo proyecto en Pocketbase
        final List<GetCatalogoProyectos> listCatalogoProyecto = [];
        for (var element in records) {
          listCatalogoProyecto.add(getCatalogoProyectosFromMap(element.toString()));
        }
        for (var i = 0; i < listCatalogoProyecto.length; i++) {
          //Se valida que el nuevo catalogo proyecto aún no existe en Objectbox
          final tipoProyecto = dataBase.tipoProyectoBox.query(TipoProyecto_.idDBR.equals(listCatalogoProyecto[i].idTipoProyectoFk)).build().findUnique();
          final catalogoProyectoExistente = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listCatalogoProyecto[i].id)).build().findUnique();
          if (catalogoProyectoExistente == null) {
            if (listCatalogoProyecto[i].id.isNotEmpty) {
              final nuevoCatalogoProyecto = CatalogoProyecto(
                nombre: listCatalogoProyecto[i].nombreProyecto,
                activo: listCatalogoProyecto[i].activo,
                idDBR: listCatalogoProyecto[i].id,
                fechaRegistro: listCatalogoProyecto[i].updated, 
                idEmiWeb: listCatalogoProyecto[i].idEmiWeb,
                );
              if (tipoProyecto != null) {
                nuevoCatalogoProyecto.tipoProyecto.target = tipoProyecto;
                dataBase.catalogoProyectoBox.put(nuevoCatalogoProyecto);
                print('Catalogo Proyecto Nuevo agregado éxitosamente');
              }
              else {
                return false;
              }
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (catalogoProyectoExistente.fechaRegistro != listCatalogoProyecto[i].updated) {
              if (tipoProyecto != null) {
                //Se actualiza el registro en Objectbox
                catalogoProyectoExistente.nombre = listCatalogoProyecto[i].nombreProyecto;
                catalogoProyectoExistente.activo = listCatalogoProyecto[i].activo;
                catalogoProyectoExistente.tipoProyecto.target = tipoProyecto;
                catalogoProyectoExistente.fechaRegistro = listCatalogoProyecto[i].updated!;
                dataBase.catalogoProyectoBox.put(catalogoProyectoExistente);
              }
              else {
                return false;
              }
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de familia de producto desde Pocketbase
  Future<bool> getFamiliaProd() async {
    try {
      //Se recupera toda la colección de familia producto en Pocketbase
      final records = await client.records.
        getFullList('familia_prod', batch: 200, sort: '+nombre_tipo_prod');
      if (records.isNotEmpty) {
        //Existen datos de familia producto en Pocketbase
        final List<GetFamiliaProductos> listFamiliaProductos = [];
        for (var element in records) {
          listFamiliaProductos.add(getFamiliaProductosFromMap(element.toString()));
        }
        for (var i = 0; i < listFamiliaProductos.length; i++) {
          //Se valida que la nueva familia producto aún no existe en Objectbox
          final familiaProductoExistente = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listFamiliaProductos[i].id)).build().findUnique();
          if (familiaProductoExistente == null) {
            if (listFamiliaProductos[i].id.isNotEmpty) {
              final nuevaFamiliaProducto = FamiliaProd(
              nombre: listFamiliaProductos[i].nombreTipoProd,
              activo: listFamiliaProductos[i].activo,
              idDBR: listFamiliaProductos[i].id, 
              idEmiWeb: listFamiliaProductos[i].idEmiWeb,
              );
              dataBase.familiaProductosBox.put(nuevaFamiliaProducto);
              print('Familia Producto Nueva agregada exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (familiaProductoExistente.fechaRegistro != listFamiliaProductos[i].updated) {
              //Se actualiza el registro en Objectbox
              familiaProductoExistente.nombre = listFamiliaProductos[i].nombreTipoProd;
              familiaProductoExistente.activo = listFamiliaProductos[i].activo;
              familiaProductoExistente.fechaRegistro = listFamiliaProductos[i].updated!;
              dataBase.familiaProductosBox.put(familiaProductoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de unidad de medida desde Pocketbase
  Future<bool> getUnidadMedida() async {
    try {
      //Se recupera toda la colección de unidad de medida en Pocketbase
      final records = await client.records.
        getFullList('und_medida', batch: 200, sort: '+unidad_medida');
      if (records.isNotEmpty) {
        //Existen datos de unidad de medida en Pocketbase
        final List<GetUnidadesMedida> listUnidadMedida = [];
        for (var element in records) {
          listUnidadMedida.add(getUnidadesMedidaFromMap(element.toString()));
        }
        for (var i = 0; i < listUnidadMedida.length; i++) {
          //Se valida que la nueva unidad de medida aún no existe en Objectbox
          final unidadMedidaExistente = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listUnidadMedida[i].id)).build().findUnique();
          if (unidadMedidaExistente == null) {
            if (listUnidadMedida[i].id.isNotEmpty) {
              final nuevaUnidadMedida = UnidadMedida(
              unidadMedida: listUnidadMedida[i].unidadMedida,
              activo: listUnidadMedida[i].activo,
              idDBR: listUnidadMedida[i].id, 
              idEmiWeb: listUnidadMedida[i].idEmiWeb,
              );
              dataBase.unidadesMedidaBox.put(nuevaUnidadMedida);
              print('Unidad de Medida Nueva agregada exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (unidadMedidaExistente.fechaRegistro != listUnidadMedida[i].updated) {
              //Se actualiza el registro en Objectbox
              unidadMedidaExistente.unidadMedida = listUnidadMedida[i].unidadMedida;
              unidadMedidaExistente.activo = listUnidadMedida[i].activo;
              unidadMedidaExistente.fechaRegistro = listUnidadMedida[i].updated!;
              dataBase.unidadesMedidaBox.put(unidadMedidaExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de ámbito consultoría desde Pocketbase
  Future<bool> getAmbitoConsultoria() async {
    try {
      //Se recupera toda la colección de ámbito consultoría en Pocketbase
      final records = await client.records.
        getFullList('ambito_consultoria', batch: 200, sort: '+nombre_ambito');
      if (records.isNotEmpty) {
        //Existen datos de ámbito consultoría en Pocketbase
        final List<GetAmbitoConsultoria> listAmbitoConsultoria = [];
        for (var element in records) {
          listAmbitoConsultoria.add(getAmbitoConsultoriaFromMap(element.toString()));
        }
        for (var i = 0; i < listAmbitoConsultoria.length; i++) {
          //Se valida que la nueva ámbito consultoría aún no existe en Objectbox
          final ambitoConsultoriaExistente = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idDBR.equals(listAmbitoConsultoria[i].id)).build().findUnique();
          if (ambitoConsultoriaExistente == null) {
            if (listAmbitoConsultoria[i].id.isNotEmpty) {
              final nuevoAmbitoConsultoria = AmbitoConsultoria(
              nombreAmbito: listAmbitoConsultoria[i].nombreAmbito,
              activo: listAmbitoConsultoria[i].activo,
              idDBR: listAmbitoConsultoria[i].id, 
              idEmiWeb: listAmbitoConsultoria[i].idEmiWeb,
              );
              dataBase.ambitoConsultoriaBox.put(nuevoAmbitoConsultoria);
              print('Ámbito Consultoría Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (ambitoConsultoriaExistente.fechaRegistro != listAmbitoConsultoria[i].updated) {
              //Se actualiza el registro en Objectbox
              ambitoConsultoriaExistente.nombreAmbito = listAmbitoConsultoria[i].nombreAmbito;
              ambitoConsultoriaExistente.activo = listAmbitoConsultoria[i].activo;
              ambitoConsultoriaExistente.fechaRegistro = listAmbitoConsultoria[i].updated!;
              dataBase.ambitoConsultoriaBox.put(ambitoConsultoriaExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de área círculo desde Pocketbase
  Future<bool> getAreaCirculo() async {
    try {
      //Se recupera toda la colección de área círculo en Pocketbase
      final records = await client.records.
        getFullList('area_circulo', batch: 200, sort: '+nombre_area');
      if (records.isNotEmpty) {
        //Existen datos de área círculo en Pocketbase
        final List<GetAreaCirculo> listAreaCirculo = [];
        for (var element in records) {
          listAreaCirculo.add(getAreaCirculoFromMap(element.toString()));
        }
        for (var i = 0; i < listAreaCirculo.length; i++) {
          //Se valida que la nueva área círculo aún no existe en Objectbox
          final areaCirculoExistente = dataBase.areaCirculoBox.query(AreaCirculo_.idDBR.equals(listAreaCirculo[i].id)).build().findUnique();
          if (areaCirculoExistente == null) {
            if (listAreaCirculo[i].id.isNotEmpty) {
              final nuevaAreaCirculo = AreaCirculo(
              nombreArea: listAreaCirculo[i].nombreArea,
              activo: listAreaCirculo[i].activo,
              idDBR: listAreaCirculo[i].id, 
              idEmiWeb: listAreaCirculo[i].idEmiWeb,
              );
              dataBase.areaCirculoBox.put(nuevaAreaCirculo);
              print('Área Círculo Nueva agregada exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (areaCirculoExistente.fechaRegistro != listAreaCirculo[i].updated) {
              //Se actualiza el registro en Objectbox
              areaCirculoExistente.nombreArea = listAreaCirculo[i].nombreArea;
              areaCirculoExistente.activo = listAreaCirculo[i].activo;
              areaCirculoExistente.fechaRegistro = listAreaCirculo[i].updated!;
              dataBase.areaCirculoBox.put(areaCirculoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de fases de emprendimiento desde Pocketbase
  Future<bool> getFasesEmp() async {
    try {
      //Se recupera toda la colección de fases de emprendimiento en Pocketbase
      final records = await client.records.
        getFullList('fases_emp', batch: 200);
      if (records.isNotEmpty) {
        //Existen datos de fases de emprendimiento en Pocketbase
        final List<GetFasesEmp> listFasesEmp = [];
        for (var element in records) {
          listFasesEmp.add(getFasesEmpFromMap(element.toString()));
        }
        for (var i = 0; i < listFasesEmp.length; i++) {
          //Se valida que la nueva fase de emprendimiento aún no existe en Objectbox
          final faseEmprendimientoExistente = dataBase.fasesEmpBox.query(FasesEmp_.idDBR.equals(listFasesEmp[i].id)).build().findUnique();
          if (faseEmprendimientoExistente == null) {
            if (listFasesEmp[i].id.isNotEmpty) {
              final nuevaFaseEmp = FasesEmp(
              fase: listFasesEmp[i].fase,
              idDBR: listFasesEmp[i].id, 
              idEmiWeb: listFasesEmp[i].idEmiWeb,
              );
              dataBase.fasesEmpBox.put(nuevaFaseEmp);
              print('Fase Emprendimiento Nueva agregada exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (faseEmprendimientoExistente.fechaRegistro != listFasesEmp[i].updated) {
              //Se actualiza el registro en Objectbox
              faseEmprendimientoExistente.fase = listFasesEmp[i].fase;
              faseEmprendimientoExistente.fechaRegistro = listFasesEmp[i].updated!;
              dataBase.fasesEmpBox.put(faseEmprendimientoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de empaque desde Pocketbase
  Future<bool> getTipoEmpaque() async {
    try {
      //Se recupera toda la colección de tipo de empaque en Pocketbase
      final records = await client.records.
        getFullList('tipo_empaques', batch: 200, sort: '+tipo_empaque');
      if (records.isNotEmpty) {
        //Existen datos de tipo de empaque en Pocketbase
        final List<GetTipoEmpaques> listTipoEmpaques = [];
        for (var element in records) {
          listTipoEmpaques.add(getTipoEmpaquesFromMap(element.toString()));
        }
        for (var i = 0; i < listTipoEmpaques.length; i++) {
          //Se valida que el nuevo tipo empaque aún no existe en Objectbox
          final tipoEmpaqueExistente = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listTipoEmpaques[i].id)).build().findUnique();
          if (tipoEmpaqueExistente == null) {
            if (listTipoEmpaques[i].id.isNotEmpty) {
              final nuevaFaseEmp = TipoEmpaques(
              tipo: listTipoEmpaques[i].tipoEmpaque,
              idDBR: listTipoEmpaques[i].id, 
              activo: listTipoEmpaques[i].activo,
              idEmiWeb: listTipoEmpaques[i].idEmiWeb,
              );
              dataBase.tipoEmpaquesBox.put(nuevaFaseEmp);
              print('Tipo Empaque Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (tipoEmpaqueExistente.fechaRegistro != listTipoEmpaques[i].updated) {
              //Se actualiza el registro en Objectbox
              tipoEmpaqueExistente.tipo = listTipoEmpaques[i].tipoEmpaque;
              tipoEmpaqueExistente.activo = listTipoEmpaques[i].activo;
              tipoEmpaqueExistente.fechaRegistro = listTipoEmpaques[i].updated!;
              dataBase.tipoEmpaquesBox.put(tipoEmpaqueExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de estado de inversión desde Pocketbase
  Future<bool> getEstadoInversion() async {
    try {
      //Se recupera toda la colección de estado de inversión en Pocketbase
      final records = await client.records.
        getFullList('estado_inversiones', batch: 200, sort: '+estado');
      if (records.isNotEmpty) {
        //Existen datos de estado de inversión en Pocketbase
        final List<GetEstadoInversiones> listEstadoInversiones = [];
        for (var element in records) {
          listEstadoInversiones.add(getEstadoInversionesFromMap(element.toString()));
        }
        for (var i = 0; i < listEstadoInversiones.length; i++) {
          //Se valida que el nuevo estado de inversión aún no existe en Objectbox
          final estadoInversionExistente = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(listEstadoInversiones[i].id)).build().findUnique();
          if (estadoInversionExistente == null) {
            if (listEstadoInversiones[i].id.isNotEmpty) {
              final nuevaFaseEmp = EstadoInversion(
              estado: listEstadoInversiones[i].estado,
              idDBR: listEstadoInversiones[i].id, 
              idEmiWeb: listEstadoInversiones[i].idEmiWeb,
              );
              dataBase.estadoInversionBox.put(nuevaFaseEmp);
              print('Estado de Inversión Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (estadoInversionExistente.fechaRegistro != listEstadoInversiones[i].updated) {
              //Se actualiza el registro en Objectbox
              estadoInversionExistente.estado = listEstadoInversiones[i].estado;
              estadoInversionExistente.fechaRegistro = listEstadoInversiones[i].updated!;
              dataBase.estadoInversionBox.put(estadoInversionExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de tipo de proveedor desde Pocketbase
  Future<bool> getTipoProveedor() async {
    try {
      //Se recupera toda la colección de tipo de proveedor en Pocketbase
      final records = await client.records.
        getFullList('tipo_proveedor', batch: 200, sort: '+tipo_proveedor');
      if (records.isNotEmpty) {
        //Existen datos de tipo de proveedor en Pocketbase
        final List<GetTipoProveedor> listTipoProveedor = [];
        for (var element in records) {
          listTipoProveedor.add(getTipoProveedorFromMap(element.toString()));
        }
        for (var i = 0; i < listTipoProveedor.length; i++) {
          //Se valida que el nuevo tipo de proveedor aún no existe en Objectbox
          final tipoProveedorExistente = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listTipoProveedor[i].id)).build().findUnique();
          if (tipoProveedorExistente == null) {
            if (listTipoProveedor[i].id.isNotEmpty) {
              final nuevoTipoProveedor = TipoProveedor(
              tipo: listTipoProveedor[i].tipoProveedor,
              activo: listTipoProveedor[i].activo,
              idDBR: listTipoProveedor[i].id, 
              idEmiWeb: listTipoProveedor[i].idEmiWeb,
              );
              dataBase.tipoProveedorBox.put(nuevoTipoProveedor);
              print('Tipo de Proveedor Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (tipoProveedorExistente.fechaRegistro != listTipoProveedor[i].updated) {
              //Se actualiza el registro en Objectbox
              tipoProveedorExistente.tipo = listTipoProveedor[i].tipoProveedor;
              tipoProveedorExistente.activo = listTipoProveedor[i].activo;
              tipoProveedorExistente.fechaRegistro = listTipoProveedor[i].updated!;
              dataBase.tipoProveedorBox.put(tipoProveedorExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de condiciones de pago desde Pocketbase
  Future<bool> getCondicionesPago() async {
    try {
      //Se recupera toda la colección de condición de pago en Pocketbase
      final records = await client.records.
      getFullList('condiciones_pago', batch: 200, sort: '+condicion_pago');
      if (records.isNotEmpty) {
        //Existen datos de condición de pago en Pocketbase
        final List<GetCondicionesPago> listCondicionesPago = [];
        for (var element in records) {
          listCondicionesPago.add(getCondicionesPagoFromMap(element.toString()));
        }
        for (var i = 0; i < listCondicionesPago.length; i++) {
          //Se valida que la nueva condición de pago aún no existe en Objectbox
          final condicionPagoExistente = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listCondicionesPago[i].id)).build().findUnique();
          if (condicionPagoExistente == null) {
            if (listCondicionesPago[i].id.isNotEmpty) {
              final nuevoTipoProveedor = CondicionesPago(
              condicion: listCondicionesPago[i].condicionPago,
              activo: listCondicionesPago[i].activo,
              idDBR: listCondicionesPago[i].id, 
              idEmiWeb: listCondicionesPago[i].idEmiWeb,
              );
              dataBase.condicionesPagoBox.put(nuevoTipoProveedor);
              print('Condición de Pago Nueva agregada exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (condicionPagoExistente.fechaRegistro != listCondicionesPago[i].updated) {
              //Se actualiza el registro en Objectbox
              condicionPagoExistente.condicion = listCondicionesPago[i].condicionPago;
              condicionPagoExistente.activo = listCondicionesPago[i].activo;
              condicionPagoExistente.fechaRegistro = listCondicionesPago[i].updated!;
              dataBase.condicionesPagoBox.put(condicionPagoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de bancos desde Pocketbase
Future<bool> getBancos() async {
  try {
      //Se recupera toda la colección de bancos en Pocketbase
      final records = await client.records.
      getFullList('bancos', batch: 200, sort: '+nombre_banco');
      if (records.isNotEmpty) {
        //Existen datos de bancos en Pocketbase
        final List<GetBancos> listBancos = [];
        for (var element in records) {
          listBancos.add(getBancosFromMap(element.toString()));
        }
        for (var i = 0; i < listBancos.length; i++) {
          //Se valida que el nuevo banco aún no existe en Objectbox
          final bancoExistente = dataBase.bancosBox.query(Bancos_.idDBR.equals(listBancos[i].id)).build().findUnique();
          if (bancoExistente == null) {
            if (listBancos[i].id.isNotEmpty) {
              final nuevoTipoProveedor = Bancos(
              banco: listBancos[i].nombreBanco,
              activo: listBancos[i].activo,
              idDBR: listBancos[i].id, 
              idEmiWeb: listBancos[i].idEmiWeb,
              );
              dataBase.bancosBox.put(nuevoTipoProveedor);
              print('Banco Nuevo agregado exitosamente');
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (bancoExistente.fechaRegistro != listBancos[i].updated) {
              //Se actualiza el registro en Objectbox
              bancoExistente.banco = listBancos[i].nombreBanco;
              bancoExistente.activo = listBancos[i].activo;
              bancoExistente.fechaRegistro = listBancos[i].updated!;
              dataBase.bancosBox.put(bancoExistente);
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de porcentaje avance desde Pocketbase
Future<bool> getPorcentajeAvance() async {
  try {
    //Se recupera toda la colección de porcentaje avance en Pocketbase
    final records = await client.records.
      getFullList('porcentaje_avance', batch: 200, sort: '+porcentaje');
    if (records.isNotEmpty) {
      //Existen datos de porcentaje avance en Pocketbase
      final List<GetPorcentajeAvance> listPorcentaje = [];
      for (var element in records) {
        listPorcentaje.add(getPorcentajeAvanceFromMap(element.toString()));
      }
      for (var i = 0; i < listPorcentaje.length; i++) {
        //Se valida que el nuevo porcentaje avance aún no existe en Objectbox
        final porcentajeAvanceExistente = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idDBR.equals(listPorcentaje[i].id)).build().findUnique();
        if (porcentajeAvanceExistente == null) {
          if (listPorcentaje[i].id.isNotEmpty) {
            final nuevoPorcentajeAvance = PorcentajeAvance(
            porcentajeAvance: listPorcentaje[i].porcentaje,
            idDBR: listPorcentaje[i].id, 
            idEmiWeb: listPorcentaje[i].idEmiWeb,
            );
            dataBase.porcentajeAvanceBox.put(nuevoPorcentajeAvance);
            print('Porcentaje Avance Nuevo agregado exitosamente');
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (porcentajeAvanceExistente.fechaRegistro != listPorcentaje[i].updated) {
            //Se actualiza el registro en Objectbox
            porcentajeAvanceExistente.porcentajeAvance = listPorcentaje[i].porcentaje;
            porcentajeAvanceExistente.fechaRegistro = listPorcentaje[i].updated!;
            dataBase.porcentajeAvanceBox.put(porcentajeAvanceExistente);
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  } catch (e) {
    return false;
  }
  }

//Función para recuperar el catálogo de proveedores desde Pocketbase
Future<bool> getProveedores() async {
  try {
    //Se recupera toda la colección de proveedores en Pocketbase
    final records = await client.records.
      getFullList('proveedores', batch: 200, sort: '+nombre_fiscal');
    if (records.isNotEmpty) {
      //Existen datos de proveedores en Pocketbase
      final List<GetProveedores> listProveedores = [];
      for (var element in records) {
        listProveedores.add(getProveedoresFromMap(element.toString()));
      }
      for (var i = 0; i < listProveedores.length; i++) {
        //Se valida que el nuevo proveedor aún no existe en Objectbox
        final tipoProveedor = dataBase.tipoProveedorBox.query(TipoProveedor_.idDBR.equals(listProveedores[i].idTipoProveedorFk)).build().findUnique();
        final condicionPago = dataBase.condicionesPagoBox.query(CondicionesPago_.idDBR.equals(listProveedores[i].idCondicionPagoFk)).build().findUnique();
        final banco = dataBase.bancosBox.query(Bancos_.idDBR.equals(listProveedores[i].idBancoFk)).build().findUnique();
        final comunidad = dataBase.comunidadesBox.query(Comunidades_.idDBR.equals(listProveedores[i].idComunidadFk)).build().findUnique();
        final proveedorExistente = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProveedores[i].id)).build().findUnique();
        if (proveedorExistente == null) {
          if (listProveedores[i].id.isNotEmpty) {
            final nuevoProveedor = Proveedores(
              nombreFiscal: listProveedores[i].nombreFiscal,
              rfc: listProveedores[i].rfc,
              direccion: listProveedores[i].direccion,
              nombreEncargado: listProveedores[i].nombreEncargado,
              clabe: listProveedores[i].clabe,
              telefono: listProveedores[i].telefono,
              idDBR: listProveedores[i].id,
              fechaRegistro: listProveedores[i].updated, 
              idEmiWeb: listProveedores[i].idEmiWeb, 
              archivado: listProveedores[i].archivado,
              );
            if (tipoProveedor != null && condicionPago != null
                && banco != null && comunidad != null) {
              nuevoProveedor.tipoProveedor.target = tipoProveedor;
              nuevoProveedor.condicionPago.target = condicionPago;
              nuevoProveedor.banco.target = banco;
              nuevoProveedor.comunidades.target = comunidad;
              dataBase.proveedoresBox.put(nuevoProveedor);
              print('Proveedor Nuevo agregado éxitosamente');
            }
            else {
              return false;
            }
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (proveedorExistente.fechaRegistro != listProveedores[i].updated) {
            if (tipoProveedor != null && condicionPago != null
                && banco != null && comunidad != null) {
              //Se actualiza el registro en Objectbox
              proveedorExistente.nombreFiscal = listProveedores[i].nombreFiscal;
              proveedorExistente.rfc = listProveedores[i].rfc;
              proveedorExistente.direccion = listProveedores[i].direccion;
              proveedorExistente.nombreEncargado = listProveedores[i].nombreEncargado;
              proveedorExistente.clabe = listProveedores[i].clabe;
              proveedorExistente.telefono = listProveedores[i].telefono;
              proveedorExistente.fechaRegistro = listProveedores[i].updated!;
              proveedorExistente.archivado = listProveedores[i].archivado;
              dataBase.proveedoresBox.put(proveedorExistente);
            }
            else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  } catch (e) {
    return false;
  }
  }

//Función para recuperar el catálogo de productos proveedores desde Pocketbase
Future<bool> getProductosProv() async {
  try {
    //Se recupera toda la colección de productos proveedores en Pocketbase
    final records = await client.records.
    getFullList('productos_prov', batch: 200, sort: '+nombre_prod_prov');
    if (records.isNotEmpty) {
      //Existen datos de productos proveedores en Pocketbase
      final List<GetProductosProv> listProductosProv = [];
      for (var element in records) {
        listProductosProv.add(getProductosProvFromMap(element.toString()));
      }
      for (var i = 0; i < listProductosProv.length; i++) {
        //Se valida que el nuevo producto proveedor aún no existe en Objectbox
        final proveedor = dataBase.proveedoresBox.query(Proveedores_.idDBR.equals(listProductosProv[i].idProveedorFk)).build().findUnique();
        final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProductosProv[i].idFamiliaProdFk)).build().findUnique();
        final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idDBR.equals(listProductosProv[i].idUndMedidaFk)).build().findUnique();
        final productoProveedorExistente = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(listProductosProv[i].id)).build().findUnique();
        if (productoProveedorExistente == null) {
          if (listProductosProv[i].id.isNotEmpty) {
            final nuevoProductoProveedor = ProductosProv(
              nombre: listProductosProv[i].nombreProdProv,
              descripcion: listProductosProv[i].descripcionProdProv,
              marca: listProductosProv[i].marca,
              costo: listProductosProv[i].costoProdProv,
              tiempoEntrega: listProductosProv[i].tiempoEntrega,
              idDBR: listProductosProv[i].id,
              fechaRegistro: listProductosProv[i].updated, 
              idEmiWeb: listProductosProv[i].idEmiWeb, 
              archivado: listProductosProv[i].archivado,
              );
            if (proveedor != null && familiaProd != null
                && unidadMedida != null) {
              nuevoProductoProveedor.proveedor.target = proveedor;
              nuevoProductoProveedor.familiaProducto.target = familiaProd;
              nuevoProductoProveedor.unidadMedida.target = unidadMedida;
              dataBase.productosProvBox.put(nuevoProductoProveedor);
              print('Producto Proveedor Nuevo agregado éxitosamente');
            }
            else {
              return false;
            }
          }
        } else {
          //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
          if (productoProveedorExistente.fechaRegistro != listProductosProv[i].updated) {
            if (proveedor != null && familiaProd != null
                && unidadMedida != null) {
              //Se actualiza el registro en Objectbox
              productoProveedorExistente.nombre = listProductosProv[i].nombreProdProv;
              productoProveedorExistente.descripcion = listProductosProv[i].descripcionProdProv;
              productoProveedorExistente.marca = listProductosProv[i].marca;
              productoProveedorExistente.costo = listProductosProv[i].costoProdProv;
              productoProveedorExistente.tiempoEntrega = listProductosProv[i].tiempoEntrega;
              productoProveedorExistente.fechaRegistro = listProductosProv[i].updated!;
              productoProveedorExistente.archivado = listProductosProv[i].archivado;
              productoProveedorExistente.proveedor.target = proveedor;
              productoProveedorExistente.familiaProducto.target = familiaProd;
              productoProveedorExistente.unidadMedida.target = unidadMedida;
              dataBase.productosProvBox.put(productoProveedorExistente);
            }
            else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      //No existen datos de estados en Pocketbase
      return false;
    }
  } catch (e) {
    return false;
  }
  }

//Función para recuperar el catálogo de productos proyecto desde Pocketbase
  Future<bool> getProdProyecto() async {
    try {
      //Se recupera toda la colección de productos proveedores en Pocketbase
      final records = await client.records.
        getFullList('prod_proyecto', batch: 200, sort: '+producto');
      if (records.isNotEmpty) {
        //Existen datos de productos proyecto en Pocketbase
        final List<GetProdProyecto> listProdProyecto = [];
        for (var element in records) {
          listProdProyecto.add(getProdProyectoFromMap(element.toString()));
        }
        for (var i = 0; i < listProdProyecto.length; i++) {
          //Se valida que el nuevo producto proyecto aún no existe en Objectbox
          final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.idDBR.equals(listProdProyecto[i].idCatalogoProyectoFk)).build().findUnique();
          final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(listProdProyecto[i].idFamiliaProdFk)).build().findUnique();
          final tipoEmpaque = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(listProdProyecto[i].idTipoEmpaqueFk)).build().findUnique();
          final productoProyectoExistente = dataBase.productosProyectoBox.query(ProdProyecto_.idDBR.equals(listProdProyecto[i].id)).build().findUnique();
          if (productoProyectoExistente == null) {
            if (listProdProyecto[i].id.isNotEmpty) {
              final nuevoProductoProyecto = ProdProyecto(
                producto: listProdProyecto[i].producto,
                marcaSugerida: listProdProyecto[i].marcaSugerida,
                descripcion: listProdProyecto[i].descripcion,
                proveedorSugerido: listProdProyecto[i].proveedorSugerido,
                cantidad: listProdProyecto[i].cantidad,
                costoEstimado: listProdProyecto[i].costoEstimado,
                fechaRegistro: listProdProyecto[i].updated, 
                idDBR: listProdProyecto[i].id, 
                idEmiWeb: listProdProyecto[i].idEmiWeb,
                );
              if (catalogoProyecto != null && familiaProd != null
                  && tipoEmpaque != null) {
                nuevoProductoProyecto.catalogoProyecto.target = catalogoProyecto;
                nuevoProductoProyecto.familiaProducto.target = familiaProd;
                nuevoProductoProyecto.tipoEmpaque.target = tipoEmpaque;
                //Se agrega desde catálogo proyecto para visualizarlo en pantallas
                catalogoProyecto.prodProyecto.add(nuevoProductoProyecto);
                dataBase.catalogoProyectoBox.put(catalogoProyecto);
                print('Producto Proyecto Nuevo agregado éxitosamente');
              }
              else {
                return false;
              }
            }
          } else {
            //Se valida que no se hayan hecho actualizaciones del registro en Pocketbase
            if (productoProyectoExistente.fechaRegistro != listProdProyecto[i].updated) {
              if (catalogoProyecto != null && familiaProd != null
                  && tipoEmpaque != null) {
                //Se actualiza el registro en Objectbox
                productoProyectoExistente.producto = listProdProyecto[i].producto;
                productoProyectoExistente.marcaSugerida = listProdProyecto[i].marcaSugerida;
                productoProyectoExistente.descripcion = listProdProyecto[i].descripcion;
                productoProyectoExistente.proveedorSugerido = listProdProyecto[i].proveedorSugerido;
                productoProyectoExistente.cantidad = listProdProyecto[i].cantidad;
                productoProyectoExistente.fechaRegistro = listProdProyecto[i].updated!;
                productoProyectoExistente.costoEstimado = listProdProyecto[i].costoEstimado;
                productoProyectoExistente.catalogoProyecto.target = catalogoProyecto;
                productoProyectoExistente.familiaProducto.target = familiaProd;
                productoProyectoExistente.tipoEmpaque.target = tipoEmpaque;
                dataBase.productosProyectoBox.put(productoProyectoExistente);
              }
              else {
                return false;
              }
            }
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
