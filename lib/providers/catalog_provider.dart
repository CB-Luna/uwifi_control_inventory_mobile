import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/models/get_clasificacion_emp.dart';
import 'package:bizpro_app/models/get_comunidades.dart';
import 'package:bizpro_app/models/get_familia_inversion.dart';

import 'package:bizpro_app/models/get_estados.dart';
import 'package:bizpro_app/models/get_municipios.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

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
    await getFamiliaInversion();
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

  Future<void> getClasificacionesEmp() async {
    final records = await client.records.
      getFullList('clasificaciones_emp', batch: 200, sort: '-created');

    print("****Informacion clasificaciones_emp****");
    for (var i = 0; i < records.length; i++) {
      final clasificacionEmpResponse = getClasificacionEmpFromMap(records[i].toString());
      if (clasificacionEmpResponse.id.isNotEmpty) {
      final nuevaClasificacionEmp = ClasificacionEmp(
      clasificacion: clasificacionEmpResponse.clasificacion,
      activo: clasificacionEmpResponse.activo,
      idDBR: clasificacionEmpResponse.id,
      );
      final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
      nuevaClasificacionEmp.statusSync.target = nuevoSync;
      dataBase.clasificacionesEmpBox.put(nuevaClasificacionEmp);
      print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
      print('Clasificacion Emp agregado exitosamente');
      final record = await client.records.update('clasificaciones_emp', clasificacionEmpResponse.id, body: {
        'id_status_sync_fk': 'HoI36PzYw1wtbO1',
      });
      if (record.id.isNotEmpty) {
          print('Clasificacion Emp actualizado en el backend exitosamente');
        }
      }
    }
    notifyListeners();
  }

  Future<void> getFamiliaInversion() async {
    final records = await client.records.
      getFullList('familia_inversion', batch: 200, sort: '-created');

    print("****Informacion familia_inversion****");
    for (var i = 0; i < records.length; i++) {
      final familiaInversionResponse = getFamiliaInversionFromMap(records[i].toString());
      if (familiaInversionResponse.id.isNotEmpty) {
      final nuevaFamiliaInversion = FamiliaInversion(
      nombre: familiaInversionResponse.nombreFamiliaInver,
      activo: familiaInversionResponse.activo,
      idDBR: familiaInversionResponse.id,
      );
      final nuevoSync = StatusSync(status: "HoI36PzYw1wtbO1"); //Se crea el objeto estatus sync //MO_
      nuevaFamiliaInversion.statusSync.target = nuevoSync;
      dataBase.familiaInversionBox.put(nuevaFamiliaInversion);
      print("TAMANÑO STATUSSYNC: ${dataBase.statusSyncBox.getAll().length}");
      print('Familia Inversion agregada exitosamente');
      final record = await client.records.update('familia_inversion', familiaInversionResponse.id, body: {
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
