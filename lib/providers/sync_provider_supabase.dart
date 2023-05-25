import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_alex_app_asesor/helpers/sync_instruction.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/instruccion_no_sincronizada.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:http/http.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';

class SyncProviderSupabase extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
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

  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    // Se recuperan instrucciones fallidas anteriores
    for (var i = 0; i < instruccionesBitacora.length; i++) {
      switch (instruccionesBitacora[i].instruccion) {
        case "syncAgregarCliente":
          final clienteToSync = getFirstCliente(
              dataBase.usuariosBox.getAll(), instruccionesBitacora[i].id);
          if (clienteToSync != null) {
            final responseSyncAddCliente = await syncAddCliente(
                clienteToSync, instruccionesBitacora[i]);
            if (responseSyncAddCliente.exitoso) {
              banderasExistoSync.add(responseSyncAddCliente.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddCliente.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddCliente.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local un cliente no recuperado.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarVehiculo":
          final vehiculoToSync = getFirstVehiculo(
              dataBase.vehicleBox.getAll(), instruccionesBitacora[i].id);
          if (vehiculoToSync != null) {
            final responseSyncAddVehiculo = await syncAddVehiculo(
                vehiculoToSync, instruccionesBitacora[i]);
            if (responseSyncAddVehiculo.exitoso) {
              banderasExistoSync.add(responseSyncAddVehiculo.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddVehiculo.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddVehiculo.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local un vehículo no recuperado.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        default:
          continue;
      }
    }
    for (var element in banderasExistoSync) {
      //Aplicamos una operación and para validar que no haya habido una acción con False
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
  }

  Usuarios? getFirstUsuario(
      List<Usuarios> usuarios, int idInstruccionesBitacora) {
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < usuarios[i].bitacora.length; j++) {
          if (usuarios[i].bitacora[j].id == idInstruccionesBitacora) {
            return usuarios[i];
          }
        }
      }
    }
    return null;
  }

  Usuarios? getFirstCliente(
      List<Usuarios> clientes, int idInstruccionesBitacora) {
    for (var i = 0; i < clientes.length; i++) {
      if (clientes[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < clientes[i].bitacora.length; j++) {
          if (clientes[i].bitacora[j].id == idInstruccionesBitacora) {
            return clientes[i];
          }
        }
      }
    }
    return null;
  }

  Vehicle? getFirstVehiculo(
      List<Vehicle> vehiculos, int idInstruccionesBitacora) {
    for (var i = 0; i < vehiculos.length; i++) {
      if (vehiculos[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < vehiculos[i].bitacora.length; j++) {
          if (vehiculos[i].bitacora[j].id == idInstruccionesBitacora) {
            return vehiculos[i];
          }
        }
      }
    }
    return null;
  }

  ControlForm? getFirstControlForm(
      List<ControlForm> ordenesTrabajo, int idInstruccionesBitacora) {
    for (var i = 0; i < ordenesTrabajo.length; i++) {
      if (ordenesTrabajo[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < ordenesTrabajo[i].bitacora.length; j++) {
          if (ordenesTrabajo[i].bitacora[j].id == idInstruccionesBitacora) {
            return ordenesTrabajo[i];
          }
        }
      }
    }
    return null;
  }


  Future<SyncInstruction> syncAddCliente(
      Usuarios usuario, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (usuario.idDBR.contains("sinIdDBR")) {
          //Registrar al usuario con una contraseña temporal
          final response = await post(
            Uri.parse('$supabaseURL/auth/v1/signup'),
            headers: {'Content-Type': 'application/json', 'apiKey': anonKey},
            body: json.encode(
              {
                "email": usuario.correo,
                "password": usuario.password,
              },
            ),
          );
          if (response.statusCode == 400) {
            final recordClienteExistente = await supabaseClient.from('users').select<PostgrestList>().eq('email', usuario.correo);
            if (recordClienteExistente.isEmpty) {
              //Aún no hay registro en la tabla perfil_usuario
              final recordInviteCliente = await supabaseClient.auth.admin.inviteUserByEmail(usuario.correo);
              if (recordInviteCliente.user?.id != null) {
                final String clienteId = recordInviteCliente.user!.id;
                final recordCliente = await supabaseClient.from('perfil_usuario').insert(
                  {
                    'user_profile_id': clienteId,
                    'nombre': usuario.nombre,
                    'apellido_p': usuario.apellidoP,
                    'apellido_m': usuario.apellidoM,
                    'imagen': usuario.imagen,
                    'rol_fk': usuario.rol.target!.idDBR,
                    'asesor_fk': usuario.asesor.target!.idDBR,
                    'telefono': usuario.telefono,
                    'celular': usuario.celular,
                    'domicilio': usuario.domicilio,
                  },
                ).select<PostgrestList>('user_profile_id');
                if (recordCliente.isNotEmpty) {
                  //Se recupera el idDBR de Supabase del Usuario
                  usuario.idDBR = recordCliente.first['user_profile_id'].toString();
                  dataBase.usuariosBox.put(usuario);
                  //Se marca como ejecutada la instrucción en Bitacora
                  bitacora.executeSupabase = true;
                  dataBase.bitacoraBox.put(bitacora);
                  dataBase.bitacoraBox.remove(bitacora.id);
                  return SyncInstruction(exitoso: true, descripcion: "");
                } else {
                  return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló en proceso de sincronizar alta de Cliente en el Servidor Local: Problema al postear los datos del Cliente con correo '${usuario.correo}'.");
                }
              } else {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Falló en proceso de sincronizar alta de Cliente en el Servidor Local: Problema al recuperar el id del Cliente Existente con correo '${usuario.correo}'.");
              }
            } else {
              return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló en proceso de sincronizar alta de Cliente en el Servidor Local: El Cliente con correo '${usuario.correo}' ya existe.");
            }
          } else {
            final String? clienteId = jsonDecode(response.body)['user']['id'];
            if(clienteId != null){
              final recordCliente = await supabaseClient.from('perfil_usuario').insert(
                {
                  'user_profile_id': clienteId,
                  'nombre': usuario.nombre,
                  'apellido_p': usuario.apellidoP,
                  'apellido_m': usuario.apellidoM,
                  'imagen': usuario.imagen,
                  'rol_fk': usuario.rol.target!.idDBR,
                  'asesor_fk': usuario.asesor.target!.idDBR,
                  'telefono': usuario.telefono,
                  'celular': usuario.celular,
                  'domicilio': usuario.domicilio,
                },
              ).select<PostgrestList>('user_profile_id');
              if (recordCliente.isNotEmpty) {
                //Se recupera el idDBR de Supabase del Usuario
                usuario.idDBR = recordCliente.first['user_profile_id'].toString();
                dataBase.usuariosBox.put(usuario);
                //Se marca como ejecutada la instrucción en Bitacora
                bitacora.executeSupabase = true;
                dataBase.bitacoraBox.put(bitacora);
                dataBase.bitacoraBox.remove(bitacora.id);
                return SyncInstruction(exitoso: true, descripcion: "");
              } else {
                return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló en proceso de sincronizar alta de Cliente en el Servidor Local: Problema al postear los datos del Cliente con correo '${usuario.correo}'.");
              }
            } else {
              return SyncInstruction(
                exitoso: false,
                descripcion:
                    "Falló en proceso de sincronizar alta de Cliente en el Servidor Local: Problema al recuperar id del Cliente con correo '${usuario.correo}'.");
            }
          }
        } else {
          //Se marca como ejecutada la instrucción en Bitacora
          bitacora.executeSupabase = true;
          dataBase.bitacoraBox.put(bitacora);
          dataBase.bitacoraBox.remove(bitacora.id);
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        dataBase.bitacoraBox.remove(bitacora.id);
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      //print('ERROR - function syncAddEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Cliente con correo '${usuario.correo}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddVehiculo(
      Vehicle vehiculo, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (vehiculo.idDBR == null) {
          //Registrar el vehiculo
          final recordVehiculo = await supabaseClient.from('vehiculo').insert(
            {
              'marca': vehiculo.make,
              'modelo': vehiculo.model,
              'anio': vehiculo.year,
              'imagen': vehiculo.image,
              'vin': vehiculo.vin,
              'placas': vehiculo.licesePlates,
              'color': vehiculo.color,
              'motor': vehiculo.motor,
            },
          ).select<PostgrestList>('id');
          if (recordVehiculo.isNotEmpty) {
            //Se recupera el idDBR de Supabase del Vehiculo
            vehiculo.idDBR = recordVehiculo.first['id'].toString();
            dataBase.vehicleBox.put(vehiculo);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Vehiculo en el Servidor Local: Problema al postear los datos del Vehiculo con VIN '${vehiculo.vin}'.");
          }
        } else {
          //Se marca como ejecutada la instrucción en Bitacora
          bitacora.executeSupabase = true;
          dataBase.bitacoraBox.put(bitacora);
          dataBase.bitacoraBox.remove(bitacora.id);
          return SyncInstruction(exitoso: true, descripcion: "");
        }
      } else {
        dataBase.bitacoraBox.remove(bitacora.id);
        return SyncInstruction(exitoso: true, descripcion: "");
      }
    } catch (e) {
      //print('ERROR - function syncAddEmprendedor(): $e');
      return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar alta de Vehiculo con VIN '${vehiculo.vin}' en el Servidor Local, detalles: '$e'");
    }
  }


}
