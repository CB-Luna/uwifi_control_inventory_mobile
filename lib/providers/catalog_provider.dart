import 'package:bizpro_app/models/get_comunidades.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/models/get_estados.dart';
import 'package:bizpro_app/models/get_municipios.dart';


import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';

import 'package:bizpro_app/models/response_post_emprendedor.dart';

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
  }

  Future<void> getEstados() async {
    final records = await client.records.
      getFullList('estados', batch: 200, sort: '-created');

    print("*****Informacion estados*****");
    for (var i = 0; i < records.length; i++) {
      final estadoResponse = getEstadosFromMap(records[i].toString());
      if (estadoResponse.id.isNotEmpty) {
      final nuevoEstado = Estados(
      nombre: estadoResponse.nombreEstado,
      activo: estadoResponse.activo,
      idDBR: estadoResponse.id,
      );
      final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
      nuevoEstado.statusSync.target = nuevoSync;
      dataBase.estadosBox.put(nuevoEstado);
      print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
      print('Estado agregado exitosamente');
      final record = await client.records.update('estados', estadoResponse.id, body: {
        'id_status_sync_fk': 'HoI36PzYw1wtbO1',
      });
      if (record.id.isNotEmpty) {
          print('Estado actualizado en el backend exitosamente');
        }

      }
    }
    notifyListeners();
  }

  Future<void> getMunicipios() async {
    final records = await client.records.
      getFullList('municipios', batch: 200, sort: '-created');

    print("*****Informacion municipios****");
    for (var i = 0; i < records.length; i++) {
     final municipioResponse = getMunicipiosFromMap(records[i].toString());
      if (municipioResponse.id.isNotEmpty) {
      final nuevoMunicipio = Municipios(
      nombre: municipioResponse.nombreMunicipio,
      activo: municipioResponse.activo,
      idDBR: municipioResponse.id,
      );
      final estado = dataBase.estadosBox.query(Estados_.idDBR.equals(municipioResponse.idEstadoFk)).build().findUnique();
      if (estado != null) {
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevoMunicipio.statusSync.target = nuevoSync;
        nuevoMunicipio.estados.target = estado;
        dataBase.municipiosBox.put(nuevoMunicipio);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Municipio agregado exitosamente');
        final record = await client.records.update('municipios', municipioResponse.id, body: {
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

  Future<void> getComunidades() async {
    final records = await client.records.
      getFullList('comunidades', batch: 200, sort: '-created');

    print("****Informacion comunidades****");
    for (var i = 0; i < records.length; i++) {
      final comunidadResponse = getComunidadesFromMap(records[i].toString());
      if (comunidadResponse.id.isNotEmpty) {
      final nuevaComunidad = Comunidades(
      nombre: comunidadResponse.nombreComunidad,
      activo: comunidadResponse.activo,
      idDBR: comunidadResponse.id,
      );
      final municipio = dataBase.municipiosBox.query(Municipios_.idDBR.equals(comunidadResponse.idMunicipioFk)).build().findUnique();
      if (municipio != null) {
        final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
        nuevaComunidad.statusSync.target = nuevoSync;
        nuevaComunidad.municipios.target = municipio;
        dataBase.comunidadesBox.put(nuevaComunidad);
        print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
        print('Comunidad agregada exitosamente');
        final record = await client.records.update('comunidades', comunidadResponse.id, body: {
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
