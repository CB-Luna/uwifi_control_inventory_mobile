import 'package:fleet_management_tool_rta/objectbox.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/models/temp/instruccion_no_sincronizada.dart';
import 'package:flutter/material.dart';
import 'package:fleet_management_tool_rta/main.dart';
import 'package:fleet_management_tool_rta/database/entitys.dart';
class SyncChangeVehicleProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  List<InstruccionNoSincronizada> instruccionesFallidas = [];
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

  Future<bool> executeInstrucciones(Users usuario) async {
    // Se recuperan el vehículo del usuario
      final vehicle = getFirstVehiculo(
        dataBase.vehicleBox.getAll(), usuario.vehicle.targetId);
        final status = dataBase.statusBox.query(Status_.status.equals('Available')).build().findUnique();
      if (vehicle != null && status != null) {
        try {
          // Se actualiza vehículo asignado de Usuario en Supabase
          final recordUser = await supabase.from('user_profile').update(
              {
                'id_vehicle_fk': null,
              },
            ).eq('user_profile_id', usuario.idDBR)
          .select<PostgrestList>("user_profile_id");   
          // Se actualiza estatus de vehículo en Supabase
          final recordVehicle = await supabaseCtrlV.from('vehicle').update(
            {
              'id_status_fk': int.parse(status.idDBR!)
            },
          ).eq('id_vehicle', int.parse(vehicle.idDBR!))
          .select<PostgrestList>("id_vehicle");  

          if (recordUser.isNotEmpty && recordVehicle.isNotEmpty) {
            //Se actualiza localmente el usuario y el vehículo
            usuario.vehicle.target == null;
            vehicle.status.target == status;

            dataBase.usersBox.put(usuario);
            dataBase.vehicleBox.put(vehicle);
            //Se marca como exitoso el proceso
            exitoso = true;
          } else {
            //Se marca como fallido el proceso
            exitoso = false;
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: "Failed to sync data Update Data on Local Server to User '${usuario.correo}' and vehicle with License Plates '${vehicle.licensePlates}'.",
                  fecha: DateTime.now());
            instruccionesFallidas.add(instruccionNoSincronizada);
          }
        } catch (e) {
          //print('ERROR - function syncAddEmprendedor(): $e');
          exitoso = false;
          final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: "Failed to sync data Update Data on Local Server to User '${usuario.correo}' and vehicle with License Plates '${vehicle.licensePlates}', details: '$e'.",
                  fecha: DateTime.now());
          instruccionesFallidas.add(instruccionNoSincronizada);
        }
      } else {
        //Se marca como fallido el proceso
          exitoso = false;
          final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion: "Failed to recover User '${usuario.correo}' and its vehicle assigned.",
                fecha: DateTime.now());
          instruccionesFallidas.add(instruccionNoSincronizada);
      }
    //Verificamos que no haya habido errores al sincronizar con la bandera
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
  }


  Vehicle? getFirstVehiculo(
      List<Vehicle> vehiculos, int? idVehicle) {
    for (var i = 0; i < vehiculos.length; i++) {
      if (vehiculos[i].id == idVehicle) {
        return vehiculos[i];
      }
    }
    return null;
  }

}
