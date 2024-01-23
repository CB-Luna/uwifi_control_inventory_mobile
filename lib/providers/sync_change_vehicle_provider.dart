import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/temp/instruccion_no_sincronizada.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
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
