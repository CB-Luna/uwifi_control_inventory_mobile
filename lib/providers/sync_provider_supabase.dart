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
        case "syncAddControlForm":
          final controlFormToSync = getFirstControlForm(
              dataBase.controlFormBox.getAll(), instruccionesBitacora[i].id);
          if (controlFormToSync != null) {
            final responseSyncAddControlForm = await syncAddControlForm(
                controlFormToSync, instruccionesBitacora[i]);
            if (responseSyncAddControlForm.exitoso) {
              banderasExistoSync.add(responseSyncAddControlForm.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddControlForm.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddControlForm.descripcion,
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

  Users? getFirstUsuario(
      List<Users> usuarios, int idInstruccionesBitacora) {
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

  Users? getFirstCliente(
      List<Users> clientes, int idInstruccionesBitacora) {
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
      List<ControlForm> controlForm, int idInstruccionesBitacora) {
    for (var i = 0; i < controlForm.length; i++) {
      if (controlForm[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < controlForm[i].bitacora.length; j++) {
          if (controlForm[i].bitacora[j].id == idInstruccionesBitacora) {
            return controlForm[i];
          }
        }
      }
    }
    return null;
  }


  Future<SyncInstruction> syncAddCliente(
      Users usuario, Bitacora bitacora) async {
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
                    'nombre': usuario.name,
                    'apellido_p': usuario.lastName,
                    'apellido_m': usuario.middleName,
                    'imagen': usuario.image,
                    'rol_fk': usuario.role.target!.idDBR,
                    'telefono': usuario.homePhone,
                    'celular': usuario.mobilePhone,
                    'domicilio': usuario.address,
                  },
                ).select<PostgrestList>('user_profile_id');
                if (recordCliente.isNotEmpty) {
                  //Se recupera el idDBR de Supabase del Usuario
                  usuario.idDBR = recordCliente.first['user_profile_id'].toString();
                  dataBase.usersBox.put(usuario);
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
                  'nombre': usuario.name,
                  'apellido_p': usuario.lastName,
                  'apellido_m': usuario.middleName,
                  'imagen': usuario.image,
                  'rol_fk': usuario.role.target!.idDBR,
                  'telefono': usuario.homePhone,
                  'celular': usuario.mobilePhone,
                  'domicilio': usuario.address,
                },
              ).select<PostgrestList>('user_profile_id');
              if (recordCliente.isNotEmpty) {
                //Se recupera el idDBR de Supabase del Usuario
                usuario.idDBR = recordCliente.first['user_profile_id'].toString();
                dataBase.usersBox.put(usuario);
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

  Future<SyncInstruction> syncAddControlForm(
      ControlForm controlForm, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (controlForm.idDBR == null) {
          //Registrar measures
          final recordMeasure = await supabaseClient.from('measures').insert(
            {
              'gas': controlForm.measures.target!.gas,
              'gas_comments': controlForm.measures.target!.gasComments,
              // 'gas_image': controlForm.measures.target?.gasImages.isEmpty == true ? null : controlForm.measures.target?.gasImages.first.base64,
              'mileage': controlForm.measures.target!.mileage,
              'mileage_comments': controlForm.measures.target!.mileageComments,
              // 'milage_image': controlForm.measures.target?.mileageImages.isEmpty == true ? null : controlForm.measures.target?.mileageImages.first.base64,
              'date_added': controlForm.measures.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_measure');
          if (recordMeasure.isNotEmpty) {
            final recordControlForm = await supabaseClient.from('control_form').insert(
              {
                'id_vehicle_fk': controlForm.vehicle.target!.idDBR,
                'id_user_fk': controlForm.employee.target!.idDBR,
                'type_form': controlForm.typeForm,
                'id_measure_fk': recordMeasure.first['id_measure'],
                'date_added': controlForm.dateAdded.toIso8601String(),
              },
            ).select<PostgrestList>('id_control_form');
            //Registrar control Form
            if (recordControlForm.isNotEmpty) {
              //Se recupera el idDBR de Supabase del Measure
              controlForm.measures.target!.idDBR = recordMeasure.first['id_measure'].toString();
              dataBase.measuresFormBox.put(controlForm.measures.target!);
              //Se recupera el idDBR de Supabase del Control Form
              controlForm.idDBR = recordControlForm.first['id_control_form'].toString();
              dataBase.controlFormBox.put(controlForm);
              //Se marca como ejecutada la instrucción en Bitacora
              bitacora.executeSupabase = true;
              dataBase.bitacoraBox.put(bitacora);
              dataBase.bitacoraBox.remove(bitacora.id);
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync all data Control Form on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
            }
          } else {
            return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data measure Control Form on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
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
              "Failed to sync data measure Control Form on Local Server with vehicle ID ${controlForm.vehicle.target!.idDBR}:, details: '$e'");
    }
  }


}
