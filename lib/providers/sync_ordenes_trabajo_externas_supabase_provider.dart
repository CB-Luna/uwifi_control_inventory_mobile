import 'dart:convert';
import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/main.dart';

import 'package:taller_alex_app_asesor/modelsSupabase/get_orden_trabajo_supabase.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class SyncOrdenesTrabajoExternasSupabaseProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  int? idOrdenTrabajoObjectBox;
  List<bool> banderasExitoSync = [];
  bool exitoso = true;
  bool usuarioExit = false;
  var uuid = Uuid();

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

  Future<bool> getOrdenesTrabajoExternasSupabaseCliente(
      Usuarios cliente) async {
    String queryGetOrdenesTrabajoCliente = """
      query Query {
        orden_trabajoCollection (filter: { id_cliente_fk: { eq: "${cliente.idDBR}"} }){
          edges {
            node {
              id
              created_at
              fecha_orden
              gasolina
              descripcion_falla
              kilometraje
              completado
              vehiculo {
                id
                created_at
                marca
                modelo
                vin
                placas
                imagen
                anio
                color
                motor
              }
              estatus {
                id
                estatus
                avance
              }
            }
          }
        }
      }
      """;
    try {
      //Se recupera toda la colección de roles en Supabase
      final records = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetOrdenesTrabajoCliente),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
      if (records.data != null) {
        //Existen datos de roles en Supabase
        print("****Órdenes de Trabajo: ${jsonEncode(records.data.toString())}");
        final responseListOrdenesTrabajo = GetOrdenTrabajoSupabase.fromJson(jsonEncode(records.data).toString());
        for (var element in responseListOrdenesTrabajo.ordenTrabajoCollection.edges) {
          //Se valida que la órden de Trabajo aún no existe en Objectbox
          final ordenTrabajoExistente = dataBase.ordenTrabajoBox.query(OrdenTrabajo_.idDBR.equals(element.node.id)).build().findUnique();
          if (ordenTrabajoExistente == null) {
            final nuevaOrdenTrabajo = OrdenTrabajo(
              fechaOrden: element.node.fechaOrden,
              gasolina: element.node.gasolina,
              kilometrajeMillaje: element.node.kilometraje,
              descripcionFalla: element.node.descripcionFalla,
              completado: element.node.completado,
              fechaRegistro: element.node.createdAt,
              idDBR: element.node.id, 
            );
            //Se valida que el vehículo aún no existe en Objectbox
            final vehiculoExistente = dataBase.vehiculoBox.query(Vehiculo_.idDBR.equals(element.node.vehiculo.id)).build().findUnique();
            if (vehiculoExistente == null) {
              final uInt8ListImagen = base64Decode(element.node.vehiculo.imagen);
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
              file.writeAsBytesSync(uInt8ListImagen);
              final nuevoVehiculo = Vehiculo(
                marca: element.node.vehiculo.marca, 
                modelo:element.node.vehiculo.modelo, 
                anio: element.node.vehiculo.anio, 
                imagen: element.node.vehiculo.imagen, 
                path: file.path, 
                vin: element.node.vehiculo.vin, 
                placas: element.node.vehiculo.placas, 
                motor: element.node.vehiculo.motor, 
                color: element.node.vehiculo.color,
                fechaRegistro: element.node.vehiculo.createdAt,
                idDBR: element.node.vehiculo.id,
              );

              nuevaOrdenTrabajo.vehiculo.target = nuevoVehiculo;
              nuevaOrdenTrabajo.cliente.target = cliente;
              nuevoVehiculo.cliente.target = cliente;
              dataBase.vehiculoBox.put(nuevoVehiculo);
              cliente.vehiculos.add(nuevoVehiculo);
            } else {
              final uInt8ListImagen = base64Decode(element.node.vehiculo.imagen);
              final tempDir = await getTemporaryDirectory();
              File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
              file.writeAsBytesSync(uInt8ListImagen);
              vehiculoExistente.marca = element.node.vehiculo.marca; 
              vehiculoExistente.modelo = element.node.vehiculo.modelo; 
              vehiculoExistente.anio = element.node.vehiculo.anio; 
              vehiculoExistente.imagen = element.node.vehiculo.imagen; 
              vehiculoExistente.path = file.path; 
              vehiculoExistente.vin = element.node.vehiculo.vin; 
              vehiculoExistente.placas = element.node.vehiculo.placas; 
              vehiculoExistente.motor = element.node.vehiculo.motor; 
              vehiculoExistente.color = element.node.vehiculo.color;
              vehiculoExistente.fechaRegistro = element.node.vehiculo.createdAt;

              nuevaOrdenTrabajo.vehiculo.target = vehiculoExistente;
              nuevaOrdenTrabajo.cliente.target = cliente;
              vehiculoExistente.cliente.target = cliente;
              dataBase.vehiculoBox.put(vehiculoExistente);
              cliente.vehiculos.add(vehiculoExistente);
            }
            //Se recupera el estatus de la Orden de Trabajo
            final estatusActual = dataBase.estatusBox.query(Estatus_.idDBR.equals(element.node.estatus.id)).build().findUnique();
            nuevaOrdenTrabajo.estatus.target = estatusActual;
            idOrdenTrabajoObjectBox =
              dataBase.ordenTrabajoBox.put(nuevaOrdenTrabajo);
            cliente.ordenesTrabajo.add(nuevaOrdenTrabajo);
            dataBase.usuariosBox.put(cliente);
          } else {
              //Se actualiza el registro del Vehículo en ObjectBox
              final vehiculoExistente = dataBase.vehiculoBox.query(Vehiculo_.idDBR.equals(element.node.vehiculo.id)).build().findUnique();
              if (vehiculoExistente == null) {
                final uInt8ListImagen = base64Decode(element.node.vehiculo.imagen);
                final tempDir = await getTemporaryDirectory();
                File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
                file.writeAsBytesSync(uInt8ListImagen);
                final nuevoVehiculo = Vehiculo(
                  marca: element.node.vehiculo.marca, 
                  modelo: element.node.vehiculo.modelo, 
                  anio: element.node.vehiculo.anio, 
                  imagen: element.node.vehiculo.imagen, 
                  path: file.path, 
                  vin: element.node.vehiculo.vin, 
                  placas: element.node.vehiculo.placas, 
                  motor: element.node.vehiculo.motor, 
                  color: element.node.vehiculo.color,
                  fechaRegistro: element.node.vehiculo.createdAt,
                  idDBR: element.node.vehiculo.id,
                );

                ordenTrabajoExistente.vehiculo.target = nuevoVehiculo;
                ordenTrabajoExistente.cliente.target = cliente;
                nuevoVehiculo.cliente.target = cliente;
                dataBase.vehiculoBox.put(nuevoVehiculo);
                cliente.vehiculos.add(nuevoVehiculo);
              } else {
                final uInt8ListImagen = base64Decode(element.node.vehiculo.imagen);
                final tempDir = await getTemporaryDirectory();
                File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
                file.writeAsBytesSync(uInt8ListImagen);
                vehiculoExistente.marca = element.node.vehiculo.marca; 
                vehiculoExistente.modelo = element.node.vehiculo.modelo; 
                vehiculoExistente.anio = element.node.vehiculo.anio; 
                vehiculoExistente.imagen = element.node.vehiculo.imagen; 
                vehiculoExistente.path = file.path; 
                vehiculoExistente.vin = element.node.vehiculo.vin; 
                vehiculoExistente.placas = element.node.vehiculo.placas; 
                vehiculoExistente.motor = element.node.vehiculo.motor; 
                vehiculoExistente.color = element.node.vehiculo.color;
                vehiculoExistente.fechaRegistro = element.node.vehiculo.createdAt;

                ordenTrabajoExistente.vehiculo.target = vehiculoExistente;
                ordenTrabajoExistente.cliente.target = cliente;
                vehiculoExistente.cliente.target = cliente;
                dataBase.vehiculoBox.put(vehiculoExistente);
                cliente.vehiculos.add(vehiculoExistente);
              }
              //Se actualiza el registro de la Orden de Trabajo en Objectbox
              idOrdenTrabajoObjectBox = ordenTrabajoExistente.id;
              ordenTrabajoExistente.fechaOrden = element.node.fechaOrden;
              ordenTrabajoExistente.gasolina = element.node.gasolina;
              ordenTrabajoExistente.kilometrajeMillaje = element.node.kilometraje;
              ordenTrabajoExistente.descripcionFalla = element.node.descripcionFalla;
              ordenTrabajoExistente.completado = element.node.completado;
              ordenTrabajoExistente.fechaRegistro = element.node.createdAt;
              //Se recupera el estatus de la Orden de Trabajo
              final estatusActual = dataBase.estatusBox.query(Estatus_.idDBR.equals(element.node.estatus.id)).build().findUnique();
              ordenTrabajoExistente.estatus.target = estatusActual;
              dataBase.ordenTrabajoBox.put(ordenTrabajoExistente);
              cliente.ordenesTrabajo.add(ordenTrabajoExistente);
              dataBase.usuariosBox.put(cliente);
          }
        }
        return true;
      } else {
        //No existen datos de ordenes de Trabajo en Supabase
        return false;
      }
    } catch (e) {
      //print("Catch de Descarga Productos Externos Pocketbase: $e");
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      await deleteOrdenTrabajoLocal(idOrdenTrabajoObjectBox ?? -1);
      banderasExitoSync.clear();
      notifyListeners();
      return false;
    }
  }
}

//Función para quitar instrucciones asociadas a la Orden de Trabajo que se eliminará localmente

Future<void> deleteOrdenTrabajoLocal(int idOrdenTrabajo) async {
  final listIntruccionesEmp = dataBase.bitacoraBox.getAll().toList();
  for (var element in listIntruccionesEmp) {
    if (element.idOrdenTrabajo == idOrdenTrabajo) {
      dataBase.bitacoraBox.remove(element.id);
    }
  }

  if (idOrdenTrabajo != -1) {
    //Se elimina la orden de trabajo
    dataBase.ordenTrabajoBox.remove(idOrdenTrabajo);
  }
}
