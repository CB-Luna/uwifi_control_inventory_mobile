import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
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
        case "syncAddControlFormR":
          final controlFormToSync = getFirstControlForm(
              dataBase.controlFormBox.getAll(), instruccionesBitacora[i].id);
          if (controlFormToSync != null) {
            final responseSyncAddControlForm = await syncAddControlFormR(
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
                    "Problems sync to Local Server, Control Form not recovered.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAddControlFormD":
          final controlFormToSync = getFirstControlForm(
              dataBase.controlFormBox.getAll(), instruccionesBitacora[i].id);
          if (controlFormToSync != null) {
            final responseSyncAddControlForm = await syncAddControlFormD(
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
                    "Problems sync to Local Server, Control Form not recovered.",
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
            Uri.parse('$supabaseUrl/auth/v1/signup'),
            headers: {'Content-Type': 'application/json', 'apiKey': anonKey},
            body: json.encode(
              {
                "email": usuario.correo,
                "password": usuario.password,
              },
            ),
          );
          if (response.statusCode == 400) {
            final recordClienteExistente = await supabase.from('users').select<PostgrestList>().eq('email', usuario.correo);
            if (recordClienteExistente.isEmpty) {
              //Aún no hay registro en la tabla perfil_usuario
              final recordInviteCliente = await supabase.auth.admin.inviteUserByEmail(usuario.correo);
              if (recordInviteCliente.user?.id != null) {
                final String clienteId = recordInviteCliente.user!.id;
                final recordCliente = await supabase.from('user_profile').insert(
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
              final recordCliente = await supabase.from('user_profile').insert(
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

  Future<SyncInstruction> syncAddControlFormR(
      ControlForm controlForm, Bitacora bitacora) async {
    String gasImages = "";
    String mileageImages = "";

    String headlightsImages = "";
    String brakeLightsImages = "";
    String reverseLightsImages = "";
    String warningLightsImages = "";
    String turnSignalsImages = "";
    String fourWayFlashersImages = "";
    String dashLightsImages = "";
    String strobeLightsImages = "";
    String cabRoofLightsImages = "";
    String clearanceLightsImages = "";

    String wiperBladesFrontImages = "";
    String wiperBladesBackImages = "";
    String windshieldWiperFrontImages = "";
    String windshieldWiperBackImages = "";
    String generalBodyImages = "";
    String decalingImages = "";
    String tiresImages = "";
    String glassImages = "";
    String mirrorsImages = "";
    String parkingImages = "";
    String brakesImages = "";
    String emgBrakesImages = "";
    String hornImages = "";

    String engineOilImages = "";
    String transmissionImages = "";
    String coolantImages = "";
    String powerSteeringImages = "";
    String dieselExhaustFluidImages = "";
    String windshieldWasherFluidImages = "";

    String insulatedImages = "";
    String holesDrilledImages = "";
    String bucketLinerImages = "";

    String rtaMagnetImages = "";
    String triangleReflectorsImages = "";
    String wheelChocksImages = "";
    String fireExtinguisherImages = "";
    String firstAidKitSafetyVestImages = "";
    String backUpAlarmImages = "";

    String ladderImages = "";
    String stepLadderImages = "";
    String ladderStrapsImages = "";
    String hydraulicFluidForBucketImages = "";
    String fiberReelRackImages = "";
    String binsLockedAndSecureImages = "";
    String safetyHarnessImages = "";
    String lanyardSafetyHarnessImages = "";

    String ignitionKeyImages = "";
    String binsBoxKeyImages = "";
    String vehicleRegistrationCopyImages = "";
    String vehicleInsuranceCopyImages = "";
    String bucketLiftOperatorManualImages = "";
    

    try {
      if (bitacora.executeSupabase == false) {
        if (controlForm.idDBR == null) {
          //Registrar measures
          List<String> listNamesMeasures = [];
          final listImagesMeasures = await supabase.storage.from('measures').list();
          for (var element in listImagesMeasures) {listNamesMeasures.add(element.name);}
          if (controlForm.measuresR.target!.gasImages.isNotEmpty) {
            for (var i = 0; i < controlForm.measuresR.target!.gasImages.toList().length; i++) {
              if (!listNamesMeasures.contains(controlForm.measuresR.target!.gasNames.toList()[i])) {
              //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('measures').uploadBinary(
                controlForm.measuresR.target!.gasNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.measuresR.target!.gasImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Gas-Measures in Control Form Check Out on Local Server named ${controlForm.measuresR.target!.gasNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresR.target!.gasNames.toList()[i]);
                  gasImages = "$gasImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresR.target!.gasNames.toList()[i]);
                  gasImages = "$gasImages$urlImage|";
              }
            }
          }
          if (controlForm.measuresR.target!.mileageImages.isNotEmpty) {
            for (var i = 0; i < controlForm.measuresR.target!.mileageImages.toList().length; i++) {
              if (!listNamesMeasures.contains(controlForm.measuresR.target!.mileageNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('measures').uploadBinary(
                controlForm.measuresR.target!.mileageNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.measuresR.target!.mileageImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Mileage-Measures in Control Form Check Out on Local Server named ${controlForm.measuresR.target!.mileageNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresR.target!.mileageNames.toList()[i]);
                  mileageImages = "$mileageImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresR.target!.mileageNames.toList()[i]);
                  mileageImages = "$mileageImages$urlImage|";
              }
            }
          }
          final recordMeasure = await supabaseCtrlV.from('measures').insert(
            {
              'gas': controlForm.measuresR.target!.gas,
              'gas_comments': controlForm.measuresR.target!.gasComments,
              'gas_image': controlForm.measuresR.target!.gasImages.isEmpty == true ? null : gasImages,
              'mileage': controlForm.measuresR.target!.mileage,
              'mileage_comments': controlForm.measuresR.target!.mileageComments,
              'milage_image': controlForm.measuresR.target?.mileageImages.isEmpty == true ? null : mileageImages,
              'date_added': controlForm.measuresR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_measure');
          //Registrar lights
          List<String> listNamesLights = [];
          final listImagesLights = await supabase.storage.from('lights').list();
          for (var element in listImagesLights) {listNamesLights.add(element.name);}
          if (controlForm.lightsR.target!.headLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.headLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.headLightsNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('lights').uploadBinary(
                controlForm.lightsR.target!.headLightsNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.headLightsImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Head-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.headLightsNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.headLightsNames.toList()[i]);
                  headlightsImages = "$headlightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.headLightsNames.toList()[i]);
                  headlightsImages = "$headlightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.brakeLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.brakeLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.brakeLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.brakeLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.brakeLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Brake-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.brakeLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.brakeLightsNames.toList()[i]);
                brakeLightsImages = "$brakeLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.brakeLightsNames.toList()[i]);
                  brakeLightsImages = "$brakeLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.reverseLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.reverseLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.reverseLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.reverseLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.reverseLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Reverse-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.reverseLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.reverseLightsNames.toList()[i]);
                reverseLightsImages = "$reverseLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.reverseLightsNames.toList()[i]);
                reverseLightsImages = "$reverseLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.warningLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.warningLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.warningLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.warningLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.warningLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Warning-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.warningLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.warningLightsNames.toList()[i]);
                warningLightsImages = "$warningLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.warningLightsNames.toList()[i]);
                warningLightsImages = "$warningLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.turnSignalsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.turnSignalsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.turnSignalsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.turnSignalsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.turnSignalsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on turn Signals in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.turnSignalsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.turnSignalsNames.toList()[i]);
                turnSignalsImages = "$turnSignalsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.turnSignalsNames.toList()[i]);
                turnSignalsImages = "$turnSignalsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.fourWayFlashersImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.fourWayFlashersImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.fourWayFlashersNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.fourWayFlashersNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.fourWayFlashersImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Four Way Flashers in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.fourWayFlashersNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.fourWayFlashersNames.toList()[i]);
                fourWayFlashersImages = "$fourWayFlashersImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.fourWayFlashersNames.toList()[i]);
                fourWayFlashersImages = "$fourWayFlashersImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.dashLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.dashLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.dashLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.dashLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.dashLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Dash-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.dashLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.dashLightsNames.toList()[i]);
                dashLightsImages = "$dashLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.dashLightsNames.toList()[i]);
                dashLightsImages = "$dashLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.strobeLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.strobeLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.strobeLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.strobeLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.strobeLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Strobe-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.strobeLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.strobeLightsNames.toList()[i]);
                strobeLightsImages = "$strobeLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.strobeLightsNames.toList()[i]);
                strobeLightsImages = "$strobeLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.cabRoofLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.cabRoofLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.cabRoofLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.cabRoofLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.cabRoofLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Cab Roof Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.cabRoofLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.cabRoofLightsNames.toList()[i]);
                cabRoofLightsImages = "$cabRoofLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.cabRoofLightsNames.toList()[i]);
                cabRoofLightsImages = "$cabRoofLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsR.target!.clearanceLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsR.target!.clearanceLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsR.target!.clearanceLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsR.target!.clearanceLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsR.target!.clearanceLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Clearance-Lights in Control Form Check Out on Local Server named ${controlForm.lightsR.target!.clearanceLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.clearanceLightsNames.toList()[i]);
                clearanceLightsImages = "$clearanceLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsR.target!.clearanceLightsNames.toList()[i]);
                clearanceLightsImages = "$clearanceLightsImages$urlImage|";
              }
            }
          }
          final recordLights = await supabaseCtrlV.from('lights').insert(
            {
              'headlights': controlForm.lightsR.target!.headLights,
              'headlights_comments': controlForm.lightsR.target!.headLightsComments,
              'headlights_image': controlForm.lightsR.target!.headLightsImages.isEmpty == true ? null : headlightsImages,
              'brake_lights': controlForm.lightsR.target!.brakeLights,
              'brake_lights_comments': controlForm.lightsR.target!.brakeLightsComments,
              'brake_lights_image': controlForm.lightsR.target?.brakeLightsImages.isEmpty == true ? null : brakeLightsImages,
              'reverse_lights': controlForm.lightsR.target!.reverseLights,
              'reverse_lights_comments': controlForm.lightsR.target!.reverseLightsComments,
              'reverse_lights_image': controlForm.lightsR.target?.reverseLightsImages.isEmpty == true ? null : reverseLightsImages,
              'warning_lights': controlForm.lightsR.target!.warningLights,
              'warning_lights_comments': controlForm.lightsR.target!.warningLightsComments,
              'warning_lights_image': controlForm.lightsR.target?.warningLightsImages.isEmpty == true ? null : warningLightsImages,
              'turn_signals': controlForm.lightsR.target!.turnSignals,
              'turn_signals_comments': controlForm.lightsR.target!.turnSignalsComments,
              'turn_signals_image': controlForm.lightsR.target?.turnSignalsImages.isEmpty == true ? null : turnSignalsImages,
              '_4_way_flashers': controlForm.lightsR.target!.fourWayFlashers,
              '_4_way_flashers_comments': controlForm.lightsR.target!.fourWayFlashersComments,
              '_4_way_flashers_image': controlForm.lightsR.target?.fourWayFlashersImages.isEmpty == true ? null : fourWayFlashersImages,
              'dash_lights': controlForm.lightsR.target!.dashLights,
              'dash_lights_comments': controlForm.lightsR.target!.dashLightsComments,
              'dash_lights_image': controlForm.lightsR.target?.dashLightsImages.isEmpty == true ? null : dashLightsImages,
              'strobe_lights': controlForm.lightsR.target!.strobeLights,
              'strobe_lights_comments': controlForm.lightsR.target!.strobeLightsComments,
              'strobe_lights_image': controlForm.lightsR.target?.strobeLightsImages.isEmpty == true ? null : strobeLightsImages,
              'cab_roof_lights': controlForm.lightsR.target!.cabRoofLights,
              'cab_roof_lights_comments': controlForm.lightsR.target!.cabRoofLightsComments,
              'cab_roof_lights_image': controlForm.lightsR.target?.cabRoofLightsImages.isEmpty == true ? null : cabRoofLightsImages,
              'clearance_lights': controlForm.lightsR.target!.clearanceLights,
              'clearance_lights_comments': controlForm.lightsR.target!.clearanceLightsComments,
              'clearance_lights_image': controlForm.lightsR.target?.clearanceLightsImages.isEmpty == true ? null : clearanceLightsImages,
              'date_added': controlForm.lightsR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_lights');
          //Registrar car bodywork
          List<String> listNamesCarBodywork = [];
          final listImagesCarBodywork = await supabase.storage.from('car-bodywork').list();
          for (var element in listImagesCarBodywork) {listNamesCarBodywork.add(element.name);}
          if (controlForm.carBodyworkR.target!.wiperBladesFrontImages.isNotEmpty) {
              for (var i = 0; i < controlForm.carBodyworkR.target!.wiperBladesFrontImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.wiperBladesFrontNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.wiperBladesFrontImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wiper Blades Front in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.wiperBladesFrontNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.wiperBladesFrontNames.toList()[i]);
                wiperBladesFrontImages = "$wiperBladesFrontImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.wiperBladesFrontNames.toList()[i]);
                wiperBladesFrontImages = "$wiperBladesFrontImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.wiperBladesBackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.wiperBladesBackImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.wiperBladesBackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.wiperBladesBackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.wiperBladesBackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wiper Blades Back in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.wiperBladesBackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.wiperBladesBackNames.toList()[i]);
                wiperBladesBackImages = "$wiperBladesBackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.wiperBladesBackNames.toList()[i]);
                wiperBladesBackImages = "$wiperBladesBackImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.windshieldWiperFrontImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.windshieldWiperFrontImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.windshieldWiperFrontImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Wiper Front in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i]);
                windshieldWiperFrontImages = "$windshieldWiperFrontImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.windshieldWiperFrontNames.toList()[i]);
                windshieldWiperFrontImages = "$windshieldWiperFrontImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.windshieldWiperBackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.windshieldWiperBackImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.windshieldWiperBackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.windshieldWiperBackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.windshieldWiperBackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Wiper Back in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.windshieldWiperBackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.windshieldWiperBackNames.toList()[i]);
                windshieldWiperBackImages = "$windshieldWiperBackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.windshieldWiperBackNames.toList()[i]);
                windshieldWiperBackImages = "$windshieldWiperBackImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.generalBodyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.generalBodyImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.generalBodyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.generalBodyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.generalBodyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on General Body in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.generalBodyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.generalBodyNames.toList()[i]);
                generalBodyImages = "$generalBodyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.generalBodyNames.toList()[i]);
                generalBodyImages = "$generalBodyImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.decalingImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.decalingImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.decalingNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.decalingNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.decalingImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Decaling in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.decalingNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.decalingNames.toList()[i]);
                decalingImages = "$decalingImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.decalingNames.toList()[i]);
                decalingImages = "$decalingImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.tiresImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.tiresImages.toList().length; i++) {
              //Parsear a Uint8List
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.tiresNames.toList()[i])) {
                final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.tiresNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.tiresImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Tires in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.tiresNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.tiresNames.toList()[i]);
                tiresImages = "$tiresImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.tiresNames.toList()[i]);
                tiresImages = "$tiresImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.glassImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.glassImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.glassNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.glassNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.glassImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Glass in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.glassNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.glassNames.toList()[i]);
                glassImages = "$glassImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.glassNames.toList()[i]);
                glassImages = "$glassImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.mirrorsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.mirrorsImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.mirrorsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.mirrorsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.mirrorsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Mirrors in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.mirrorsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.mirrorsNames.toList()[i]);
                mirrorsImages = "$mirrorsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.mirrorsNames.toList()[i]);
                mirrorsImages = "$mirrorsImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.parkingImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.parkingImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.parkingNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.parkingNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.parkingImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Parking in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.parkingNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.parkingNames.toList()[i]);
                parkingImages = "$parkingImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.parkingNames.toList()[i]);
                parkingImages = "$parkingImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.brakesImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.brakesImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.brakesNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.brakesNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.brakesImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Brakes in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.brakesNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.brakesNames.toList()[i]);
                brakesImages = "$brakesImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.brakesNames.toList()[i]);
                brakesImages = "$brakesImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.emgBrakesImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.emgBrakesImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.emgBrakesNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.emgBrakesNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.emgBrakesImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on EMG Brakes in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.emgBrakesNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.emgBrakesNames.toList()[i]);
                emgBrakesImages = "$emgBrakesImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.emgBrakesNames.toList()[i]);
                emgBrakesImages = "$emgBrakesImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkR.target!.hornImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkR.target!.hornImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkR.target!.hornNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkR.target!.hornNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkR.target!.hornImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Horn in Control Form Check Out on Local Server named ${controlForm.carBodyworkR.target!.hornNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.hornNames.toList()[i]);
                hornImages = "$hornImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkR.target!.hornNames.toList()[i]);
                hornImages = "$hornImages$urlImage|";
              }
            }
          }
          final recordCarBodywork = await supabaseCtrlV.from('car_bodywork').insert(
            {
              'wiper_blades_front': controlForm.carBodyworkR.target!.wiperBladesFront,
              'wiper_blades_front_comments': controlForm.carBodyworkR.target!.wiperBladesFrontComments,
              'wiper_blades_front_image': controlForm.carBodyworkR.target!.wiperBladesFrontImages.isEmpty == true ? null : wiperBladesFrontImages,
              'wiper_blades_back': controlForm.carBodyworkR.target!.wiperBladesBack,
              'wiper_blades_back_comments': controlForm.carBodyworkR.target!.wiperBladesBackComments,
              'wiper_blades_back_image': controlForm.carBodyworkR.target?.wiperBladesBackImages.isEmpty == true ? null : wiperBladesBackImages,
              'windshield_wiper_front': controlForm.carBodyworkR.target!.windshieldWiperFront,
              'windshield_wiper_front_comments': controlForm.carBodyworkR.target!.windshieldWiperFrontComments,
              'windshield_wiper_front_image': controlForm.carBodyworkR.target?.windshieldWiperFrontImages.isEmpty == true ? null : windshieldWiperFrontImages,
              'windshield_wiper_back': controlForm.carBodyworkR.target!.windshieldWiperBack,
              'windshield_wiper_back_comments': controlForm.carBodyworkR.target!.windshieldWiperBackComments,
              'windshield_wiper_back_image': controlForm.carBodyworkR.target?.windshieldWiperBackImages.isEmpty == true ? null : windshieldWiperBackImages,
              'general_body': controlForm.carBodyworkR.target!.generalBody,
              'general_body_comments': controlForm.carBodyworkR.target!.generalBodyComments,
              'general_body_image': controlForm.carBodyworkR.target?.generalBodyImages.isEmpty == true ? null : generalBodyImages,
              'decaling': controlForm.carBodyworkR.target!.decaling,
              'decaling_comments': controlForm.carBodyworkR.target!.decalingComments,
              'decaling_image': controlForm.carBodyworkR.target?.decalingImages.isEmpty == true ? null : decalingImages,
              'tires': controlForm.carBodyworkR.target!.tires,
              'tires_comments': controlForm.carBodyworkR.target!.tiresComments,
              'tires_image': controlForm.carBodyworkR.target?.tiresImages.isEmpty == true ? null : tiresImages,
              'glass': controlForm.carBodyworkR.target!.glass,
              'glass_comments': controlForm.carBodyworkR.target!.glassComments,
              'glass_image': controlForm.carBodyworkR.target?.glassImages.isEmpty == true ? null : glassImages,
              'mirrors': controlForm.carBodyworkR.target!.mirrors,
              'mirrors_comments': controlForm.carBodyworkR.target!.mirrorsComments,
              'mirrors_image': controlForm.carBodyworkR.target?.mirrorsImages.isEmpty == true ? null : mirrorsImages,
              'parking': controlForm.carBodyworkR.target!.parking,
              'parking_comments': controlForm.carBodyworkR.target!.parkingComments,
              'parking_image': controlForm.carBodyworkR.target?.parkingImages.isEmpty == true ? null : parkingImages,
              'brakes': controlForm.carBodyworkR.target!.brakes,
              'brakes_comments': controlForm.carBodyworkR.target!.brakesComments,
              'brakes_image': controlForm.carBodyworkR.target?.brakesImages.isEmpty == true ? null : brakesImages,
              'emg_brakes': controlForm.carBodyworkR.target!.emgBrakes,
              'emg_brakes_comments': controlForm.carBodyworkR.target!.emgBrakesComments,
              'emg_brakes_image': controlForm.carBodyworkR.target?.emgBrakesImages.isEmpty == true ? null : emgBrakesImages,
              'horn': controlForm.carBodyworkR.target!.horn,
              'horn_comments': controlForm.carBodyworkR.target!.hornComments,
              'horn_image': controlForm.carBodyworkR.target?.hornImages.isEmpty == true ? null : hornImages,
              'date_added': controlForm.carBodyworkR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_car_bodywork');
          //Registrar fluids check
          List<String> listNamesFluidsCheck = [];
          final listImagesFluidsCheck = await supabase.storage.from('fluids-check').list();
          for (var element in listImagesFluidsCheck) {listNamesFluidsCheck.add(element.name);}
          if (controlForm.fluidsCheckR.target!.engineOilImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.engineOilImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.engineOilNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckR.target!.engineOilNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.engineOilImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Engine Oil in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.engineOilNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.engineOilNames.toList()[i]);
                engineOilImages = "$engineOilImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.engineOilNames.toList()[i]);
                engineOilImages = "$engineOilImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckR.target!.transmissionImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.transmissionImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.transmissionNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckR.target!.transmissionNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.transmissionImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Transmission in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.transmissionNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.transmissionNames.toList()[i]);
                transmissionImages = "$transmissionImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.transmissionNames.toList()[i]);
                transmissionImages = "$transmissionImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckR.target!.coolantImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.coolantImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.coolantNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckR.target!.coolantNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.coolantImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Coolant in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.coolantNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.coolantNames.toList()[i]);
                coolantImages = "$coolantImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.coolantNames.toList()[i]);
                coolantImages = "$coolantImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckR.target!.powerSteeringImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.powerSteeringImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.powerSteeringNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
                controlForm.fluidsCheckR.target!.powerSteeringNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.powerSteeringImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Power Steering in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.powerSteeringNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.powerSteeringNames.toList()[i]);
                  powerSteeringImages = "$powerSteeringImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.powerSteeringNames.toList()[i]);
                  powerSteeringImages = "$powerSteeringImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckR.target!.dieselExhaustFluidImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.dieselExhaustFluidImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.dieselExhaustFluidNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckR.target!.dieselExhaustFluidNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.dieselExhaustFluidImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Diesel Exhaust Fluid in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.dieselExhaustFluidNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.dieselExhaustFluidNames.toList()[i]);
                dieselExhaustFluidImages = "$dieselExhaustFluidImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.dieselExhaustFluidNames.toList()[i]);
                dieselExhaustFluidImages = "$dieselExhaustFluidImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckR.target!.windshieldWasherFluidImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckR.target!.windshieldWasherFluidImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckR.target!.windshieldWasherFluidNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckR.target!.windshieldWasherFluidNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckR.target!.windshieldWasherFluidImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Washer Fluid in Control Form Check Out on Local Server named ${controlForm.fluidsCheckR.target!.windshieldWasherFluidNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.windshieldWasherFluidNames.toList()[i]);
                windshieldWasherFluidImages = "$windshieldWasherFluidImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckR.target!.windshieldWasherFluidNames.toList()[i]);
                windshieldWasherFluidImages = "$windshieldWasherFluidImages$urlImage|";
              }
            }
          }
          final recordFluidsCheck = await supabaseCtrlV.from('fluids_check').insert(
            {
              'engine_oil': controlForm.fluidsCheckR.target!.engineOil,
              'engine_oil_comments': controlForm.fluidsCheckR.target!.engineOilComments,
              'engine_oil_image': controlForm.fluidsCheckR.target!.engineOilImages.isEmpty == true ? null : engineOilImages,
              'transmission': controlForm.fluidsCheckR.target!.transmission,
              'transmission_comments': controlForm.fluidsCheckR.target!.transmissionComments,
              'transmission_image': controlForm.fluidsCheckR.target?.transmissionImages.isEmpty == true ? null : transmissionImages,
              'coolant': controlForm.fluidsCheckR.target!.coolant,
              'coolant_comments': controlForm.fluidsCheckR.target!.coolantComments,
              'coolant_image': controlForm.fluidsCheckR.target?.coolantImages.isEmpty == true ? null : coolantImages,
              'power_steering': controlForm.fluidsCheckR.target!.powerSteering,
              'power_steering_comments': controlForm.fluidsCheckR.target!.powerSteeringComments,
              'power_steering_image': controlForm.fluidsCheckR.target?.powerSteeringImages.isEmpty == true ? null : powerSteeringImages,
              'diesel_exhaust_fluid': controlForm.fluidsCheckR.target!.dieselExhaustFluid,
              'diesel_exhaust_fluid_comments': controlForm.fluidsCheckR.target!.dieselExhaustFluidComments,
              'diesel_exhaust_fluid_image': controlForm.fluidsCheckR.target?.dieselExhaustFluidImages.isEmpty == true ? null : dieselExhaustFluidImages,
              'windshield_washer_fluid': controlForm.fluidsCheckR.target!.windshieldWasherFluid,
              'windshield_washer_fluid_comments': controlForm.fluidsCheckR.target!.windshieldWasherFluidComments,
              'windshield_washer_fluid_image': controlForm.fluidsCheckR.target?.windshieldWasherFluidImages.isEmpty == true ? null : windshieldWasherFluidImages,
              'date_added': controlForm.fluidsCheckR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_fluids_check');
          //Registrar bucket inspection
          List<String> listNamesBucketInspection = [];
          final listImagesBucketInspection = await supabase.storage.from('bucket-inspection').list();
          for (var element in listImagesBucketInspection) {listNamesBucketInspection.add(element.name);}
          if (controlForm.bucketInspectionR.target!.insulatedImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionR.target!.insulatedImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionR.target!.insulatedNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionR.target!.insulatedNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionR.target!.insulatedImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Insulated in Control Form Check Out on Local Server named ${controlForm.bucketInspectionR.target!.insulatedNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.insulatedNames.toList()[i]);
                insulatedImages = "$insulatedImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.insulatedNames.toList()[i]);
                insulatedImages = "$insulatedImages$urlImage|";
              }
            }
          }
          if (controlForm.bucketInspectionR.target!.holesDrilledImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionR.target!.holesDrilledImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionR.target!.holesDrilledNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionR.target!.holesDrilledNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionR.target!.holesDrilledImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Holes Drilled in Control Form Check Out on Local Server named ${controlForm.bucketInspectionR.target!.holesDrilledNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.holesDrilledNames.toList()[i]);
                holesDrilledImages = "$holesDrilledImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.holesDrilledNames.toList()[i]);
                holesDrilledImages = "$holesDrilledImages$urlImage|";
              }
            }
          }
          if (controlForm.bucketInspectionR.target!.bucketLinerImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionR.target!.bucketLinerImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionR.target!.bucketLinerNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionR.target!.bucketLinerNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionR.target!.bucketLinerImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bucket Liner in Control Form Check Out on Local Server named ${controlForm.bucketInspectionR.target!.bucketLinerNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.bucketLinerNames.toList()[i]);
                bucketLinerImages = "$bucketLinerImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionR.target!.bucketLinerNames.toList()[i]);
                bucketLinerImages = "$bucketLinerImages$urlImage|";
              }
            }
          }
          final recordBucketInspection = await supabaseCtrlV.from('bucket_inspection').insert(
            {
              'insulated': controlForm.bucketInspectionR.target!.insulated,
              'insulated_comments': controlForm.bucketInspectionR.target!.insulatedComments,
              'insulated_image': controlForm.bucketInspectionR.target!.insulatedImages.isEmpty == true ? null : insulatedImages,
              'holes_drilled': controlForm.bucketInspectionR.target!.holesDrilled,
              'holes_drilled_comments': controlForm.bucketInspectionR.target!.holesDrilledComments,
              'holes_drilled_image': controlForm.bucketInspectionR.target?.holesDrilledImages.isEmpty == true ? null : holesDrilledImages,
              'bucket_liner': controlForm.bucketInspectionR.target!.bucketLiner,
              'bucket_liner_comments': controlForm.bucketInspectionR.target!.bucketLinerComments,
              'bucket_liner_image': controlForm.bucketInspectionR.target?.bucketLinerImages.isEmpty == true ? null : bucketLinerImages,
              'date_added': controlForm.bucketInspectionR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_bucket_inspection');
          //Registrar security
          List<String> listNamesSecurity = [];
          final listImagesSecurity = await supabase.storage.from('security').list();
          for (var element in listImagesSecurity) {listNamesSecurity.add(element.name);}
          if (controlForm.securityR.target!.rtaMagnetImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.rtaMagnetImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.rtaMagnetNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.rtaMagnetNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.rtaMagnetImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on RTA Mganet in Control Form Check Out on Local Server named ${controlForm.securityR.target!.rtaMagnetNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.rtaMagnetNames.toList()[i]);
                rtaMagnetImages = "$rtaMagnetImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.rtaMagnetNames.toList()[i]);
                rtaMagnetImages = "$rtaMagnetImages$urlImage|";
              }
            }
          }
          if (controlForm.securityR.target!.triangleReflectorsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.triangleReflectorsImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.triangleReflectorsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.triangleReflectorsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.triangleReflectorsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Triangle Reflectors in Control Form Check Out on Local Server named ${controlForm.securityR.target!.triangleReflectorsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.triangleReflectorsNames.toList()[i]);
                triangleReflectorsImages = "$triangleReflectorsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.triangleReflectorsNames.toList()[i]);
                triangleReflectorsImages = "$triangleReflectorsImages$urlImage|";
              }
            }
          }
          if (controlForm.securityR.target!.wheelChocksImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.wheelChocksImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.wheelChocksNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.wheelChocksNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.wheelChocksImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wheel Chocks in Control Form Check Out on Local Server named ${controlForm.securityR.target!.wheelChocksNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.wheelChocksNames.toList()[i]);
                wheelChocksImages = "$wheelChocksImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.wheelChocksNames.toList()[i]);
                wheelChocksImages = "$wheelChocksImages$urlImage|";
              }
            }
          }
          if (controlForm.securityR.target!.fireExtinguisherImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.fireExtinguisherImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.fireExtinguisherNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.fireExtinguisherNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.fireExtinguisherImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Fire Extinguisher in Control Form Check Out on Local Server named ${controlForm.securityR.target!.fireExtinguisherNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.fireExtinguisherNames.toList()[i]);
                fireExtinguisherImages = "$fireExtinguisherImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.fireExtinguisherNames.toList()[i]);
                fireExtinguisherImages = "$fireExtinguisherImages$urlImage|";
              }
            }
          }
          if (controlForm.securityR.target!.firstAidKitSafetyVestImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.firstAidKitSafetyVestImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.firstAidKitSafetyVestNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.firstAidKitSafetyVestNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.firstAidKitSafetyVestImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on First Aid Kit Safety Vest in Control Form Check Out on Local Server named ${controlForm.securityR.target!.firstAidKitSafetyVestNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.firstAidKitSafetyVestNames.toList()[i]);
                firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.firstAidKitSafetyVestNames.toList()[i]);
                firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$urlImage|";
              }
            }
          }
          if (controlForm.securityR.target!.backUpAlarmImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityR.target!.backUpAlarmImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityR.target!.backUpAlarmNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityR.target!.backUpAlarmNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityR.target!.backUpAlarmImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Backup Alarm in Control Form Check Out on Local Server named ${controlForm.securityR.target!.backUpAlarmNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.backUpAlarmNames.toList()[i]);
                backUpAlarmImages = "$backUpAlarmImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityR.target!.backUpAlarmNames.toList()[i]);
                backUpAlarmImages = "$backUpAlarmImages$urlImage|";
              }
            }
          }
          final recordSecurity = await supabaseCtrlV.from('security').insert(
            {
              'rta_magnet': controlForm.securityR.target!.rtaMagnet,
              'rta_magnet_comments': controlForm.securityR.target!.rtaMagnetComments,
              'rta_magnet_image': controlForm.securityR.target!.rtaMagnetImages.isEmpty == true ? null : rtaMagnetImages,
              'triangle_reflectors': controlForm.securityR.target!.triangleReflectors,
              'triangle_reflectors_comments': controlForm.securityR.target!.triangleReflectorsComments,
              'triangle_reflectors_image': controlForm.securityR.target?.triangleReflectorsImages.isEmpty == true ? null : triangleReflectorsImages,
              'wheel_chocks': controlForm.securityR.target!.wheelChocks,
              'wheel_chocks_comments': controlForm.securityR.target!.wheelChocksComments,
              'wheel_chocks_image': controlForm.securityR.target?.wheelChocksImages.isEmpty == true ? null : wheelChocksImages,
              'fire_extinguisher': controlForm.securityR.target!.fireExtinguisher,
              'fire_extinguisher_comments': controlForm.securityR.target!.fireExtinguisherComments,
              'fire_extinguisher_image': controlForm.securityR.target?.fireExtinguisherImages.isEmpty == true ? null : fireExtinguisherImages,
              'first_aid_kit_safety_vest': controlForm.securityR.target!.firstAidKitSafetyVest,
              'first_aid_kit_safety_vest_comments': controlForm.securityR.target!.firstAidKitSafetyVestComments,
              'first_aid_kit_safety_vest_image': controlForm.securityR.target?.firstAidKitSafetyVestImages.isEmpty == true ? null : firstAidKitSafetyVestImages,
              'back_up_alarm': controlForm.securityR.target!.backUpAlarm,
              'back_up_alarm_comments': controlForm.securityR.target!.backUpAlarmComments,
              'back_up_alarm_image': controlForm.securityR.target?.backUpAlarmImages.isEmpty == true ? null : backUpAlarmImages,
              'date_added': controlForm.securityR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_security');
          //Registrar extra
          List<String> listNamesExtra = [];
          final listImagesExtra = await supabase.storage.from('extras').list();
          for (var element in listImagesExtra) {listNamesExtra.add(element.name);}
          if (controlForm.extraR.target!.ladderImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.ladderImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.ladderNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.ladderNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.ladderImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ladder in Control Form Check Out on Local Server named ${controlForm.extraR.target!.ladderNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.ladderNames.toList()[i]);
                ladderImages = "$ladderImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.ladderNames.toList()[i]);
                ladderImages = "$ladderImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.stepLadderImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.stepLadderImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.stepLadderNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.stepLadderNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.stepLadderImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Step Ladder in Control Form Check Out on Local Server named ${controlForm.extraR.target!.stepLadderNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.stepLadderNames.toList()[i]);
                stepLadderImages = "$stepLadderImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.stepLadderNames.toList()[i]);
                stepLadderImages = "$stepLadderImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.ladderStrapsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.ladderStrapsImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.ladderStrapsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.ladderStrapsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.ladderStrapsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ladder Straps in Control Form Check Out on Local Server named ${controlForm.extraR.target!.ladderStrapsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.ladderStrapsNames.toList()[i]);
                ladderStrapsImages = "$ladderStrapsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.ladderStrapsNames.toList()[i]);
                ladderStrapsImages = "$ladderStrapsImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.hydraulicFluidForBucketImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.hydraulicFluidForBucketImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.hydraulicFluidForBucketNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.hydraulicFluidForBucketNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.hydraulicFluidForBucketImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Hydraulic Fluid For Bucket in Control Form Check Out on Local Server named ${controlForm.extraR.target!.hydraulicFluidForBucketNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.hydraulicFluidForBucketNames.toList()[i]);
                hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.hydraulicFluidForBucketNames.toList()[i]);
                hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.fiberReelRackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.fiberReelRackImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.fiberReelRackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.fiberReelRackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.fiberReelRackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Fiber Reel Rack in Control Form Check Out on Local Server named ${controlForm.extraR.target!.fiberReelRackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.fiberReelRackNames.toList()[i]);
                fiberReelRackImages = "$fiberReelRackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.fiberReelRackNames.toList()[i]);
                fiberReelRackImages = "$fiberReelRackImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.binsLockedAndSecureImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.binsLockedAndSecureImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.binsLockedAndSecureNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.binsLockedAndSecureNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.binsLockedAndSecureImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bins Locked And Secure in Control Form Check Out on Local Server named ${controlForm.extraR.target!.binsLockedAndSecureNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.binsLockedAndSecureNames.toList()[i]);
                binsLockedAndSecureImages = "$binsLockedAndSecureImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.binsLockedAndSecureNames.toList()[i]);
                binsLockedAndSecureImages = "$binsLockedAndSecureImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.safetyHarnessImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.safetyHarnessImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.safetyHarnessNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.safetyHarnessNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.safetyHarnessImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Safety Harness in Control Form Check Out on Local Server named ${controlForm.extraR.target!.safetyHarnessNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.safetyHarnessNames.toList()[i]);
                safetyHarnessImages = "$safetyHarnessImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.safetyHarnessNames.toList()[i]);
                safetyHarnessImages = "$safetyHarnessImages$urlImage|";
              }
            }
          }
          if (controlForm.extraR.target!.lanyardSafetyHarnessImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraR.target!.lanyardSafetyHarnessImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraR.target!.lanyardSafetyHarnessNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraR.target!.lanyardSafetyHarnessNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraR.target!.lanyardSafetyHarnessImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Lanyard Safety Harness in Control Form Check Out on Local Server named ${controlForm.extraR.target!.lanyardSafetyHarnessNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.lanyardSafetyHarnessNames.toList()[i]);
                lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraR.target!.lanyardSafetyHarnessNames.toList()[i]);
                lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$urlImage|";
              }
            }
          }
          final recordExtra = await supabaseCtrlV.from('extra').insert(
            {
              'ladder': controlForm.extraR.target!.ladder,
              'ladder_comments': controlForm.extraR.target!.ladderComments,
              'ladder_image': controlForm.extraR.target!.ladderImages.isEmpty == true ? null : ladderImages,
              'step_ladder': controlForm.extraR.target!.stepLadder,
              'step_ladder_comments': controlForm.extraR.target!.stepLadderComments,
              'step_ladder_image': controlForm.extraR.target?.stepLadderImages.isEmpty == true ? null : stepLadderImages,
              'ladder_straps': controlForm.extraR.target!.ladderStraps,
              'ladder_straps_comments': controlForm.extraR.target!.ladderStrapsComments,
              'ladder_straps_image': controlForm.extraR.target?.ladderStrapsImages.isEmpty == true ? null : ladderStrapsImages,
              'hydraulic_fluid_for_bucket': controlForm.extraR.target!.hydraulicFluidForBucket,
              'hydraulic_fluid_for_bucket_comments': controlForm.extraR.target!.hydraulicFluidForBucketComments,
              'hydraulic_fluid_for_bucket_image': controlForm.extraR.target?.hydraulicFluidForBucketImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'fiber_reel_rack': controlForm.extraR.target!.fiberReelRack,
              'fiber_reel_rack_comments': controlForm.extraR.target!.fiberReelRackComments,
              'fiber_reel_rack_image': controlForm.extraR.target?.fiberReelRackImages.isEmpty == true ? null : fiberReelRackImages,
              'bins_locked_and_secure': controlForm.extraR.target!.binsLockedAndSecure,
              'bins_locked_and_secure_comments': controlForm.extraR.target!.binsLockedAndSecureComments,
              'bins_locked_and_secure_image': controlForm.extraR.target?.binsLockedAndSecureImages.isEmpty == true ? null : binsLockedAndSecureImages,
              'safety_harness': controlForm.extraR.target!.safetyHarness,
              'safety_harness_comments': controlForm.extraR.target!.safetyHarnessComments,
              'safety_harness_image': controlForm.extraR.target?.safetyHarnessImages.isEmpty == true ? null : safetyHarnessImages,
              'lanyard_safety_harness': controlForm.extraR.target!.lanyardSafetyHarness,
              'lanyard_safety_harness_comments': controlForm.extraR.target!.lanyardSafetyHarnessComments,
              'lanyard_safety_harness_image': controlForm.extraR.target?.lanyardSafetyHarnessImages.isEmpty == true ? null : lanyardSafetyHarnessImages,
              'date_added': controlForm.extraR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_extra');
          //Registrar equipment
          List<String> listNamesEquipment = [];
          final listImagesEquipment = await supabase.storage.from('equipment').list();
          for (var element in listImagesEquipment) {listNamesEquipment.add(element.name);}
          if (controlForm.equipmentR.target!.ignitionKeyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentR.target!.ignitionKeyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentR.target!.ignitionKeyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentR.target!.ignitionKeyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentR.target!.ignitionKeyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ignition Key in Control Form Check Out on Local Server named ${controlForm.equipmentR.target!.ignitionKeyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.ignitionKeyNames.toList()[i]);
                ignitionKeyImages = "$ignitionKeyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.ignitionKeyNames.toList()[i]);
                ignitionKeyImages = "$ignitionKeyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentR.target!.binsBoxKeyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentR.target!.binsBoxKeyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentR.target!.binsBoxKeyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentR.target!.binsBoxKeyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentR.target!.binsBoxKeyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bins Box Key in Control Form Check Out on Local Server named ${controlForm.equipmentR.target!.binsBoxKeyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.binsBoxKeyNames.toList()[i]);
                binsBoxKeyImages = "$binsBoxKeyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.binsBoxKeyNames.toList()[i]);
                binsBoxKeyImages = "$binsBoxKeyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentR.target!.vehicleInsuranceCopyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentR.target!.vehicleInsuranceCopyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentR.target!.vehicleInsuranceCopyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentR.target!.vehicleInsuranceCopyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentR.target!.vehicleInsuranceCopyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Vehicle Insurance Copy in Control Form Check Out on Local Server named ${controlForm.equipmentR.target!.vehicleInsuranceCopyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.vehicleInsuranceCopyNames.toList()[i]);
                vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.vehicleInsuranceCopyNames.toList()[i]);
                vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentR.target!.vehicleRegistrationCopyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentR.target!.vehicleRegistrationCopyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentR.target!.vehicleRegistrationCopyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentR.target!.vehicleRegistrationCopyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentR.target!.vehicleRegistrationCopyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Vehicle Registration Copy in Control Form Check Out on Local Server named ${controlForm.equipmentR.target!.vehicleRegistrationCopyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.vehicleRegistrationCopyNames.toList()[i]);
                vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.vehicleRegistrationCopyNames.toList()[i]);
                vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentR.target!.bucketLiftOperatorManualImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentR.target!.bucketLiftOperatorManualImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentR.target!.bucketLiftOperatorManualNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentR.target!.bucketLiftOperatorManualNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentR.target!.bucketLiftOperatorManualImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bucket Lift Operator Manual in Control Form Check Out on Local Server named ${controlForm.equipmentR.target!.bucketLiftOperatorManualNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.bucketLiftOperatorManualNames.toList()[i]);
                bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentR.target!.bucketLiftOperatorManualNames.toList()[i]);
                bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$urlImage|";
              }
            }
          }
          final recordEquipment = await supabaseCtrlV.from('equipment').insert(
            {
              'ignition_key': controlForm.equipmentR.target!.ignitionKey,
              'ignition_key_comments': controlForm.equipmentR.target!.ignitionKeyComments,
              'ignition_key_image': controlForm.equipmentR.target?.ignitionKeyImages.isEmpty == true ? null : ignitionKeyImages,
              'bins_box_key': controlForm.equipmentR.target!.binsBoxKey,
              'bins_box_key_comments': controlForm.equipmentR.target!.binsBoxKeyComments,
              'bins_box_key_image': controlForm.equipmentR.target?.binsBoxKeyImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'vehicle_registration_copy': controlForm.equipmentR.target!.vehicleInsuranceCopy,
              'vehicle_registration_copy_comments': controlForm.equipmentR.target!.vehicleInsuranceCopyComments,
              'vehicle_registration_copy_image': controlForm.equipmentR.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'vehicle_insurance_copy': controlForm.equipmentR.target!.vehicleInsuranceCopy,
              'vehicle_insurance_copy_comments': controlForm.equipmentR.target!.vehicleInsuranceCopyComments,
              'vehicle_insurance_copy_image': controlForm.equipmentR.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'bucket_lift_operator_manual': controlForm.equipmentR.target!.bucketLiftOperatorManual,
              'bucket_lift_operator_manual_comments': controlForm.equipmentR.target!.bucketLiftOperatorManualComments,
              'bucket_lift_operator_manual_image': controlForm.equipmentR.target?.bucketLiftOperatorManualImages.isEmpty == true ? null : bucketLiftOperatorManualImages,
              'date_added': controlForm.equipmentR.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_equipment');
          
          if (recordMeasure.isNotEmpty && recordLights.isNotEmpty && recordCarBodywork.isNotEmpty && recordFluidsCheck.isNotEmpty 
              && recordBucketInspection.isNotEmpty && recordSecurity.isNotEmpty && recordExtra.isNotEmpty && recordEquipment.isNotEmpty) {
            final recordControlForm = await supabaseCtrlV.from('control_form').insert(
              {
                'id_vehicle_fk': controlForm.vehicle.target!.idDBR,
                'id_user_fk': controlForm.employee.target!.idDBR,
                'id_measure_r_fk': recordMeasure.first['id_measure'],
                'id_lights_r_fk': recordLights.first['id_lights'],
                'id_car_bodywork_r_fk': recordCarBodywork.first['id_car_bodywork'],
                'id_fluids_check_r_fk': recordFluidsCheck.first['id_fluids_check'],
                'id_bucket_inspection_r_fk': recordBucketInspection.first['id_bucket_inspection'],
                'id_security_r_fk': recordSecurity.first['id_security'],
                'id_extra_r_fk': recordExtra.first['id_extra'],
                'id_equipment_r_fk': recordEquipment.first['id_equipment'],
                'issues_r': controlForm.issuesR,
                'date_added_r': controlForm.dateAddedR.toIso8601String(),
              },
            ).select<PostgrestList>('id_control_form');
            //Registrar control Form
            if (recordControlForm.isNotEmpty) {
              //Se recupera el idDBR de Supabase de Measure
              controlForm.measuresR.target!.idDBR = recordMeasure.first['id_measure'].toString();
              dataBase.measuresFormBox.put(controlForm.measuresR.target!);
              //Se recupera el idDBR de Supabase de Lights
              controlForm.lightsR.target!.idDBR = recordLights.first['id_lights'].toString();
              dataBase.lightsFormBox.put(controlForm.lightsR.target!);
              //Se recupera el idDBR de Supabase de Car Bodywork
              controlForm.carBodyworkR.target!.idDBR = recordCarBodywork.first['id_car_bodywork'].toString();
              dataBase.carBodyworkFormBox.put(controlForm.carBodyworkR.target!);
              //Se recupera el idDBR de Supabase de Fluids Check
              controlForm.fluidsCheckR.target!.idDBR = recordFluidsCheck.first['id_fluids_check'].toString();
              dataBase.fluidsCheckFormBox.put(controlForm.fluidsCheckR.target!);
              //Se recupera el idDBR de Supabase de Bucket Inspection
              controlForm.bucketInspectionR.target!.idDBR = recordBucketInspection.first['id_bucket_inspection'].toString();
              dataBase.bucketInspectionFormBox.put(controlForm.bucketInspectionR.target!);
              //Se recupera el idDBR de Supabase de Security
              controlForm.securityR.target!.idDBR = recordSecurity.first['id_security'].toString();
              dataBase.securityFormBox.put(controlForm.securityR.target!);
              //Se recupera el idDBR de Supabase de Extra
              controlForm.extraR.target!.idDBR = recordExtra.first['id_extra'].toString();
              dataBase.extraFormBox.put(controlForm.extraR.target!);
              //Se recupera el idDBR de Supabase de Equipment
              controlForm.equipmentR.target!.idDBR = recordEquipment.first['id_equipment'].toString();
              dataBase.equipmentFormBox.put(controlForm.equipmentR.target!);
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
                  "Failed to sync all data Control Form Check Out on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
            }
          } else {
            return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data Control Form Check Out on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
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
              "Failed to sync data Control Form Check Out on Local Server with vehicle ID ${controlForm.vehicle.target!.idDBR}:, details: '$e'");
    }
  }

  Future<SyncInstruction> syncAddControlFormD(
      ControlForm controlForm, Bitacora bitacora) async {
    String gasImages = "";
    String mileageImages = "";

    String headlightsImages = "";
    String brakeLightsImages = "";
    String reverseLightsImages = "";
    String warningLightsImages = "";
    String turnSignalsImages = "";
    String fourWayFlashersImages = "";
    String dashLightsImages = "";
    String strobeLightsImages = "";
    String cabRoofLightsImages = "";
    String clearanceLightsImages = "";

    String wiperBladesFrontImages = "";
    String wiperBladesBackImages = "";
    String windshieldWiperFrontImages = "";
    String windshieldWiperBackImages = "";
    String generalBodyImages = "";
    String decalingImages = "";
    String tiresImages = "";
    String glassImages = "";
    String mirrorsImages = "";
    String parkingImages = "";
    String brakesImages = "";
    String emgBrakesImages = "";
    String hornImages = "";

    String engineOilImages = "";
    String transmissionImages = "";
    String coolantImages = "";
    String powerSteeringImages = "";
    String dieselExhaustFluidImages = "";
    String windshieldWasherFluidImages = "";

    String insulatedImages = "";
    String holesDrilledImages = "";
    String bucketLinerImages = "";

    String rtaMagnetImages = "";
    String triangleReflectorsImages = "";
    String wheelChocksImages = "";
    String fireExtinguisherImages = "";
    String firstAidKitSafetyVestImages = "";
    String backUpAlarmImages = "";

    String ladderImages = "";
    String stepLadderImages = "";
    String ladderStrapsImages = "";
    String hydraulicFluidForBucketImages = "";
    String fiberReelRackImages = "";
    String binsLockedAndSecureImages = "";
    String safetyHarnessImages = "";
    String lanyardSafetyHarnessImages = "";

    String ignitionKeyImages = "";
    String binsBoxKeyImages = "";
    String vehicleRegistrationCopyImages = "";
    String vehicleInsuranceCopyImages = "";
    String bucketLiftOperatorManualImages = "";
    

    try {
      if (bitacora.executeSupabase == false) {
        if (controlForm.idDBR != null) {
          //Registrar measures
          List<String> listNamesMeasures = [];
          final listImagesMeasures = await supabase.storage.from('measures').list();
          for (var element in listImagesMeasures) {listNamesMeasures.add(element.name);}
          if (controlForm.measuresD.target!.gasImages.isNotEmpty) {
            for (var i = 0; i < controlForm.measuresD.target!.gasImages.toList().length; i++) {
              if (!listNamesMeasures.contains(controlForm.measuresD.target!.gasNames.toList()[i])) {
              //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('measures').uploadBinary(
                controlForm.measuresD.target!.gasNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.measuresD.target!.gasImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Gas-Measures in Control Form Check In on Local Server named ${controlForm.measuresD.target!.gasNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresD.target!.gasNames.toList()[i]);
                  gasImages = "$gasImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresD.target!.gasNames.toList()[i]);
                  gasImages = "$gasImages$urlImage|";
              }
            }
          }
          if (controlForm.measuresD.target!.mileageImages.isNotEmpty) {
            for (var i = 0; i < controlForm.measuresD.target!.mileageImages.toList().length; i++) {
              if (!listNamesMeasures.contains(controlForm.measuresD.target!.mileageNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('measures').uploadBinary(
                controlForm.measuresD.target!.mileageNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.measuresD.target!.mileageImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Mileage-Measures in Control Form Check In on Local Server named ${controlForm.measuresD.target!.mileageNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresD.target!.mileageNames.toList()[i]);
                  mileageImages = "$mileageImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('measures').getPublicUrl(controlForm.measuresD.target!.mileageNames.toList()[i]);
                  mileageImages = "$mileageImages$urlImage|";
              }
            }
          }
          final recordMeasure = await supabaseCtrlV.from('measures').insert(
            {
              'gas': controlForm.measuresD.target!.gas,
              'gas_comments': controlForm.measuresD.target!.gasComments,
              'gas_image': controlForm.measuresD.target!.gasImages.isEmpty == true ? null : gasImages,
              'mileage': controlForm.measuresD.target!.mileage,
              'mileage_comments': controlForm.measuresD.target!.mileageComments,
              'milage_image': controlForm.measuresD.target?.mileageImages.isEmpty == true ? null : mileageImages,
              'date_added': controlForm.measuresD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_measure');
          //Registrar lights
          List<String> listNamesLights = [];
          final listImagesLights = await supabase.storage.from('lights').list();
          for (var element in listImagesLights) {listNamesLights.add(element.name);}
          if (controlForm.lightsD.target!.headLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.headLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.headLightsNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('lights').uploadBinary(
                controlForm.lightsD.target!.headLightsNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.headLightsImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Head-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.headLightsNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.headLightsNames.toList()[i]);
                  headlightsImages = "$headlightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.headLightsNames.toList()[i]);
                  headlightsImages = "$headlightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.brakeLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.brakeLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.brakeLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.brakeLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.brakeLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Brake-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.brakeLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.brakeLightsNames.toList()[i]);
                brakeLightsImages = "$brakeLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.brakeLightsNames.toList()[i]);
                  brakeLightsImages = "$brakeLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.reverseLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.reverseLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.reverseLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.reverseLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.reverseLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Reverse-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.reverseLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.reverseLightsNames.toList()[i]);
                reverseLightsImages = "$reverseLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.reverseLightsNames.toList()[i]);
                reverseLightsImages = "$reverseLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.warningLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.warningLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.warningLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.warningLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.warningLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Warning-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.warningLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.warningLightsNames.toList()[i]);
                warningLightsImages = "$warningLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.warningLightsNames.toList()[i]);
                warningLightsImages = "$warningLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.turnSignalsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.turnSignalsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.turnSignalsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.turnSignalsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.turnSignalsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on turn Signals in Control Form Check In on Local Server named ${controlForm.lightsD.target!.turnSignalsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.turnSignalsNames.toList()[i]);
                turnSignalsImages = "$turnSignalsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.turnSignalsNames.toList()[i]);
                turnSignalsImages = "$turnSignalsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.fourWayFlashersImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.fourWayFlashersImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.fourWayFlashersNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.fourWayFlashersNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.fourWayFlashersImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Four Way Flashers in Control Form Check In on Local Server named ${controlForm.lightsD.target!.fourWayFlashersNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.fourWayFlashersNames.toList()[i]);
                fourWayFlashersImages = "$fourWayFlashersImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.fourWayFlashersNames.toList()[i]);
                fourWayFlashersImages = "$fourWayFlashersImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.dashLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.dashLightsImages.toList().length; i++) {
              //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.dashLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.dashLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Dash-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.dashLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.dashLightsNames.toList()[i]);
                dashLightsImages = "$dashLightsImages$urlImage|";
            }
          }
          if (controlForm.lightsD.target!.strobeLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.strobeLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.strobeLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.strobeLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.strobeLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Strobe-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.strobeLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.strobeLightsNames.toList()[i]);
                strobeLightsImages = "$strobeLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.strobeLightsNames.toList()[i]);
                strobeLightsImages = "$strobeLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.cabRoofLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.cabRoofLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.cabRoofLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.cabRoofLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.cabRoofLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Cab Roof Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.cabRoofLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.cabRoofLightsNames.toList()[i]);
                cabRoofLightsImages = "$cabRoofLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.cabRoofLightsNames.toList()[i]);
                cabRoofLightsImages = "$cabRoofLightsImages$urlImage|";
              }
            }
          }
          if (controlForm.lightsD.target!.clearanceLightsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.lightsD.target!.clearanceLightsImages.toList().length; i++) {
              if (!listNamesLights.contains(controlForm.lightsD.target!.clearanceLightsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('lights').uploadBinary(
              controlForm.lightsD.target!.clearanceLightsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.lightsD.target!.clearanceLightsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Clearance-Lights in Control Form Check In on Local Server named ${controlForm.lightsD.target!.clearanceLightsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.clearanceLightsNames.toList()[i]);
                clearanceLightsImages = "$clearanceLightsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('lights').getPublicUrl(controlForm.lightsD.target!.clearanceLightsNames.toList()[i]);
                clearanceLightsImages = "$clearanceLightsImages$urlImage|";
              }
            }
          }
          final recordLights = await supabaseCtrlV.from('lights').insert(
            {
              'headlights': controlForm.lightsD.target!.headLights,
              'headlights_comments': controlForm.lightsD.target!.headLightsComments,
              'headlights_image': controlForm.lightsD.target!.headLightsImages.isEmpty == true ? null : headlightsImages,
              'brake_lights': controlForm.lightsD.target!.brakeLights,
              'brake_lights_comments': controlForm.lightsD.target!.brakeLightsComments,
              'brake_lights_image': controlForm.lightsD.target?.brakeLightsImages.isEmpty == true ? null : brakeLightsImages,
              'reverse_lights': controlForm.lightsD.target!.reverseLights,
              'reverse_lights_comments': controlForm.lightsD.target!.reverseLightsComments,
              'reverse_lights_image': controlForm.lightsD.target?.reverseLightsImages.isEmpty == true ? null : reverseLightsImages,
              'warning_lights': controlForm.lightsD.target!.warningLights,
              'warning_lights_comments': controlForm.lightsD.target!.warningLightsComments,
              'warning_lights_image': controlForm.lightsD.target?.warningLightsImages.isEmpty == true ? null : warningLightsImages,
              'turn_signals': controlForm.lightsD.target!.turnSignals,
              'turn_signals_comments': controlForm.lightsD.target!.turnSignalsComments,
              'turn_signals_image': controlForm.lightsD.target?.turnSignalsImages.isEmpty == true ? null : turnSignalsImages,
              '_4_way_flashers': controlForm.lightsD.target!.fourWayFlashers,
              '_4_way_flashers_comments': controlForm.lightsD.target!.fourWayFlashersComments,
              '_4_way_flashers_image': controlForm.lightsD.target?.fourWayFlashersImages.isEmpty == true ? null : fourWayFlashersImages,
              'dash_lights': controlForm.lightsD.target!.dashLights,
              'dash_lights_comments': controlForm.lightsD.target!.dashLightsComments,
              'dash_lights_image': controlForm.lightsD.target?.dashLightsImages.isEmpty == true ? null : dashLightsImages,
              'strobe_lights': controlForm.lightsD.target!.strobeLights,
              'strobe_lights_comments': controlForm.lightsD.target!.strobeLightsComments,
              'strobe_lights_image': controlForm.lightsD.target?.strobeLightsImages.isEmpty == true ? null : strobeLightsImages,
              'cab_roof_lights': controlForm.lightsD.target!.cabRoofLights,
              'cab_roof_lights_comments': controlForm.lightsD.target!.cabRoofLightsComments,
              'cab_roof_lights_image': controlForm.lightsD.target?.cabRoofLightsImages.isEmpty == true ? null : cabRoofLightsImages,
              'clearance_lights': controlForm.lightsD.target!.clearanceLights,
              'clearance_lights_comments': controlForm.lightsD.target!.clearanceLightsComments,
              'clearance_lights_image': controlForm.lightsD.target?.clearanceLightsImages.isEmpty == true ? null : clearanceLightsImages,
              'date_added': controlForm.lightsD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_lights');
          //Registrar car bodywork
          List<String> listNamesCarBodywork = [];
          final listImagesCarBodywork = await supabase.storage.from('car-bodywork').list();
          for (var element in listImagesCarBodywork) {listNamesCarBodywork.add(element.name);}
          if (controlForm.carBodyworkD.target!.wiperBladesFrontImages.isNotEmpty) {
              for (var i = 0; i < controlForm.carBodyworkD.target!.wiperBladesFrontImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.wiperBladesFrontNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.wiperBladesFrontImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wiper Blades Front in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.wiperBladesFrontNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.wiperBladesFrontNames.toList()[i]);
                wiperBladesFrontImages = "$wiperBladesFrontImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.wiperBladesFrontNames.toList()[i]);
                wiperBladesFrontImages = "$wiperBladesFrontImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.wiperBladesBackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.wiperBladesBackImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.wiperBladesBackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.wiperBladesBackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.wiperBladesBackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wiper Blades Back in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.wiperBladesBackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.wiperBladesBackNames.toList()[i]);
                wiperBladesBackImages = "$wiperBladesBackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.wiperBladesBackNames.toList()[i]);
                wiperBladesBackImages = "$wiperBladesBackImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.windshieldWiperFrontImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.windshieldWiperFrontImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.windshieldWiperFrontImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Wiper Front in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i]);
                windshieldWiperFrontImages = "$windshieldWiperFrontImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.windshieldWiperFrontNames.toList()[i]);
                windshieldWiperFrontImages = "$windshieldWiperFrontImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.windshieldWiperBackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.windshieldWiperBackImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.windshieldWiperBackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.windshieldWiperBackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.windshieldWiperBackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Wiper Back in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.windshieldWiperBackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.windshieldWiperBackNames.toList()[i]);
                windshieldWiperBackImages = "$windshieldWiperBackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.windshieldWiperBackNames.toList()[i]);
                windshieldWiperBackImages = "$windshieldWiperBackImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.generalBodyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.generalBodyImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.generalBodyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.generalBodyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.generalBodyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on General Body in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.generalBodyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.generalBodyNames.toList()[i]);
                generalBodyImages = "$generalBodyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.generalBodyNames.toList()[i]);
                generalBodyImages = "$generalBodyImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.decalingImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.decalingImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.decalingNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.decalingNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.decalingImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Decaling in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.decalingNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.decalingNames.toList()[i]);
                decalingImages = "$decalingImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.decalingNames.toList()[i]);
                decalingImages = "$decalingImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.tiresImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.tiresImages.toList().length; i++) {
              //Parsear a Uint8List
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.tiresNames.toList()[i])) {
                final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.tiresNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.tiresImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Tires in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.tiresNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.tiresNames.toList()[i]);
                tiresImages = "$tiresImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.tiresNames.toList()[i]);
                tiresImages = "$tiresImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.glassImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.glassImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.glassNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.glassNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.glassImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Glass in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.glassNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.glassNames.toList()[i]);
                glassImages = "$glassImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.glassNames.toList()[i]);
                glassImages = "$glassImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.mirrorsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.mirrorsImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.mirrorsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.mirrorsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.mirrorsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Mirrors in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.mirrorsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.mirrorsNames.toList()[i]);
                mirrorsImages = "$mirrorsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.mirrorsNames.toList()[i]);
                mirrorsImages = "$mirrorsImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.parkingImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.parkingImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.parkingNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.parkingNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.parkingImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Parking in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.parkingNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.parkingNames.toList()[i]);
                parkingImages = "$parkingImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.parkingNames.toList()[i]);
                parkingImages = "$parkingImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.brakesImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.brakesImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.brakesNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.brakesNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.brakesImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Brakes in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.brakesNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.brakesNames.toList()[i]);
                brakesImages = "$brakesImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.brakesNames.toList()[i]);
                brakesImages = "$brakesImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.emgBrakesImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.emgBrakesImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.emgBrakesNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.emgBrakesNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.emgBrakesImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on EMG Brakes in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.emgBrakesNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.emgBrakesNames.toList()[i]);
                emgBrakesImages = "$emgBrakesImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.emgBrakesNames.toList()[i]);
                emgBrakesImages = "$emgBrakesImages$urlImage|";
              }
            }
          }
          if (controlForm.carBodyworkD.target!.hornImages.isNotEmpty) {
            for (var i = 0; i < controlForm.carBodyworkD.target!.hornImages.toList().length; i++) {
              if (!listNamesCarBodywork.contains(controlForm.carBodyworkD.target!.hornNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('car-bodywork').uploadBinary(
              controlForm.carBodyworkD.target!.hornNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.carBodyworkD.target!.hornImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Horn in Control Form Check In on Local Server named ${controlForm.carBodyworkD.target!.hornNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.hornNames.toList()[i]);
                hornImages = "$hornImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('car-bodywork').getPublicUrl(controlForm.carBodyworkD.target!.hornNames.toList()[i]);
                hornImages = "$hornImages$urlImage|";
              }
            }
          }
          final recordCarBodywork = await supabaseCtrlV.from('car_bodywork').insert(
            {
              'wiper_blades_front': controlForm.carBodyworkD.target!.wiperBladesFront,
              'wiper_blades_front_comments': controlForm.carBodyworkD.target!.wiperBladesFrontComments,
              'wiper_blades_front_image': controlForm.carBodyworkD.target!.wiperBladesFrontImages.isEmpty == true ? null : wiperBladesFrontImages,
              'wiper_blades_back': controlForm.carBodyworkD.target!.wiperBladesBack,
              'wiper_blades_back_comments': controlForm.carBodyworkD.target!.wiperBladesBackComments,
              'wiper_blades_back_image': controlForm.carBodyworkD.target?.wiperBladesBackImages.isEmpty == true ? null : wiperBladesBackImages,
              'windshield_wiper_front': controlForm.carBodyworkD.target!.windshieldWiperFront,
              'windshield_wiper_front_comments': controlForm.carBodyworkD.target!.windshieldWiperFrontComments,
              'windshield_wiper_front_image': controlForm.carBodyworkD.target?.windshieldWiperFrontImages.isEmpty == true ? null : windshieldWiperFrontImages,
              'windshield_wiper_back': controlForm.carBodyworkD.target!.windshieldWiperBack,
              'windshield_wiper_back_comments': controlForm.carBodyworkD.target!.windshieldWiperBackComments,
              'windshield_wiper_back_image': controlForm.carBodyworkD.target?.windshieldWiperBackImages.isEmpty == true ? null : windshieldWiperBackImages,
              'general_body': controlForm.carBodyworkD.target!.generalBody,
              'general_body_comments': controlForm.carBodyworkD.target!.generalBodyComments,
              'general_body_image': controlForm.carBodyworkD.target?.generalBodyImages.isEmpty == true ? null : generalBodyImages,
              'decaling': controlForm.carBodyworkD.target!.decaling,
              'decaling_comments': controlForm.carBodyworkD.target!.decalingComments,
              'decaling_image': controlForm.carBodyworkD.target?.decalingImages.isEmpty == true ? null : decalingImages,
              'tires': controlForm.carBodyworkD.target!.tires,
              'tires_comments': controlForm.carBodyworkD.target!.tiresComments,
              'tires_image': controlForm.carBodyworkD.target?.tiresImages.isEmpty == true ? null : tiresImages,
              'glass': controlForm.carBodyworkD.target!.glass,
              'glass_comments': controlForm.carBodyworkD.target!.glassComments,
              'glass_image': controlForm.carBodyworkD.target?.glassImages.isEmpty == true ? null : glassImages,
              'mirrors': controlForm.carBodyworkD.target!.mirrors,
              'mirrors_comments': controlForm.carBodyworkD.target!.mirrorsComments,
              'mirrors_image': controlForm.carBodyworkD.target?.mirrorsImages.isEmpty == true ? null : mirrorsImages,
              'parking': controlForm.carBodyworkD.target!.parking,
              'parking_comments': controlForm.carBodyworkD.target!.parkingComments,
              'parking_image': controlForm.carBodyworkD.target?.parkingImages.isEmpty == true ? null : parkingImages,
              'brakes': controlForm.carBodyworkD.target!.brakes,
              'brakes_comments': controlForm.carBodyworkD.target!.brakesComments,
              'brakes_image': controlForm.carBodyworkD.target?.brakesImages.isEmpty == true ? null : brakesImages,
              'emg_brakes': controlForm.carBodyworkD.target!.emgBrakes,
              'emg_brakes_comments': controlForm.carBodyworkD.target!.emgBrakesComments,
              'emg_brakes_image': controlForm.carBodyworkD.target?.emgBrakesImages.isEmpty == true ? null : emgBrakesImages,
              'horn': controlForm.carBodyworkD.target!.horn,
              'horn_comments': controlForm.carBodyworkD.target!.hornComments,
              'horn_image': controlForm.carBodyworkD.target?.hornImages.isEmpty == true ? null : hornImages,
              'date_added': controlForm.carBodyworkD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_car_bodywork');
          //Registrar fluids check
          List<String> listNamesFluidsCheck = [];
          final listImagesFluidsCheck = await supabase.storage.from('fluids-check').list();
          for (var element in listImagesFluidsCheck) {listNamesFluidsCheck.add(element.name);}
          if (controlForm.fluidsCheckD.target!.engineOilImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.engineOilImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.engineOilNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckD.target!.engineOilNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.engineOilImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Engine Oil in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.engineOilNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.engineOilNames.toList()[i]);
                engineOilImages = "$engineOilImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.engineOilNames.toList()[i]);
                engineOilImages = "$engineOilImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckD.target!.transmissionImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.transmissionImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.transmissionNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckD.target!.transmissionNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.transmissionImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Transmission in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.transmissionNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.transmissionNames.toList()[i]);
                transmissionImages = "$transmissionImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.transmissionNames.toList()[i]);
                transmissionImages = "$transmissionImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckD.target!.coolantImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.coolantImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.coolantNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckD.target!.coolantNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.coolantImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Coolant in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.coolantNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.coolantNames.toList()[i]);
                coolantImages = "$coolantImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.coolantNames.toList()[i]);
                coolantImages = "$coolantImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckD.target!.powerSteeringImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.powerSteeringImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.powerSteeringNames.toList()[i])) {
                //Parsear a Uint8List
                final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
                controlForm.fluidsCheckD.target!.powerSteeringNames.toList()[i],
                Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.powerSteeringImages.toList()[i])),
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );
                if (storageResponse.isEmpty) {
                  return SyncInstruction(
                    exitoso: false,
                    descripcion:
                        "Failed to sync image on Power Steering in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.powerSteeringNames.toList()[i]}");
                }
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.powerSteeringNames.toList()[i]);
                  powerSteeringImages = "$powerSteeringImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.powerSteeringNames.toList()[i]);
                  powerSteeringImages = "$powerSteeringImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckD.target!.dieselExhaustFluidImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.dieselExhaustFluidImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.dieselExhaustFluidNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckD.target!.dieselExhaustFluidNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.dieselExhaustFluidImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Diesel Exhaust Fluid in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.dieselExhaustFluidNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.dieselExhaustFluidNames.toList()[i]);
                dieselExhaustFluidImages = "$dieselExhaustFluidImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.dieselExhaustFluidNames.toList()[i]);
                dieselExhaustFluidImages = "$dieselExhaustFluidImages$urlImage|";
              }
            }
          }
          if (controlForm.fluidsCheckD.target!.windshieldWasherFluidImages.isNotEmpty) {
            for (var i = 0; i < controlForm.fluidsCheckD.target!.windshieldWasherFluidImages.toList().length; i++) {
              if (!listNamesFluidsCheck.contains(controlForm.fluidsCheckD.target!.windshieldWasherFluidNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('fluids-check').uploadBinary(
              controlForm.fluidsCheckD.target!.windshieldWasherFluidNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.fluidsCheckD.target!.windshieldWasherFluidImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Windshield Washer Fluid in Control Form Check In on Local Server named ${controlForm.fluidsCheckD.target!.windshieldWasherFluidNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.windshieldWasherFluidNames.toList()[i]);
                windshieldWasherFluidImages = "$windshieldWasherFluidImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('fluids-check').getPublicUrl(controlForm.fluidsCheckD.target!.windshieldWasherFluidNames.toList()[i]);
                windshieldWasherFluidImages = "$windshieldWasherFluidImages$urlImage|";
              }
            }
          }
          final recordFluidsCheck = await supabaseCtrlV.from('fluids_check').insert(
            {
              'engine_oil': controlForm.fluidsCheckD.target!.engineOil,
              'engine_oil_comments': controlForm.fluidsCheckD.target!.engineOilComments,
              'engine_oil_image': controlForm.fluidsCheckD.target!.engineOilImages.isEmpty == true ? null : engineOilImages,
              'transmission': controlForm.fluidsCheckD.target!.transmission,
              'transmission_comments': controlForm.fluidsCheckD.target!.transmissionComments,
              'transmission_image': controlForm.fluidsCheckD.target?.transmissionImages.isEmpty == true ? null : transmissionImages,
              'coolant': controlForm.fluidsCheckD.target!.coolant,
              'coolant_comments': controlForm.fluidsCheckD.target!.coolantComments,
              'coolant_image': controlForm.fluidsCheckD.target?.coolantImages.isEmpty == true ? null : coolantImages,
              'power_steering': controlForm.fluidsCheckD.target!.powerSteering,
              'power_steering_comments': controlForm.fluidsCheckD.target!.powerSteeringComments,
              'power_steering_image': controlForm.fluidsCheckD.target?.powerSteeringImages.isEmpty == true ? null : powerSteeringImages,
              'diesel_exhaust_fluid': controlForm.fluidsCheckD.target!.dieselExhaustFluid,
              'diesel_exhaust_fluid_comments': controlForm.fluidsCheckD.target!.dieselExhaustFluidComments,
              'diesel_exhaust_fluid_image': controlForm.fluidsCheckD.target?.dieselExhaustFluidImages.isEmpty == true ? null : dieselExhaustFluidImages,
              'windshield_washer_fluid': controlForm.fluidsCheckD.target!.windshieldWasherFluid,
              'windshield_washer_fluid_comments': controlForm.fluidsCheckD.target!.windshieldWasherFluidComments,
              'windshield_washer_fluid_image': controlForm.fluidsCheckD.target?.windshieldWasherFluidImages.isEmpty == true ? null : windshieldWasherFluidImages,
              'date_added': controlForm.fluidsCheckD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_fluids_check');
          //Registrar bucket inspection
          List<String> listNamesBucketInspection = [];
          final listImagesBucketInspection = await supabase.storage.from('bucket-inspection').list();
          for (var element in listImagesBucketInspection) {listNamesBucketInspection.add(element.name);}
          if (controlForm.bucketInspectionD.target!.insulatedImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionD.target!.insulatedImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionD.target!.insulatedNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionD.target!.insulatedNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionD.target!.insulatedImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Insulated in Control Form Check In on Local Server named ${controlForm.bucketInspectionD.target!.insulatedNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.insulatedNames.toList()[i]);
                insulatedImages = "$insulatedImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.insulatedNames.toList()[i]);
                insulatedImages = "$insulatedImages$urlImage|";
              }
            }
          }
          if (controlForm.bucketInspectionD.target!.holesDrilledImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionD.target!.holesDrilledImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionD.target!.holesDrilledNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionD.target!.holesDrilledNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionD.target!.holesDrilledImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Holes Drilled in Control Form Check In on Local Server named ${controlForm.bucketInspectionD.target!.holesDrilledNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.holesDrilledNames.toList()[i]);
                holesDrilledImages = "$holesDrilledImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.holesDrilledNames.toList()[i]);
                holesDrilledImages = "$holesDrilledImages$urlImage|";
              }
            }
          }
          if (controlForm.bucketInspectionD.target!.bucketLinerImages.isNotEmpty) {
            for (var i = 0; i < controlForm.bucketInspectionD.target!.bucketLinerImages.toList().length; i++) {
              if (!listNamesBucketInspection.contains(controlForm.bucketInspectionD.target!.bucketLinerNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('bucket-inspection').uploadBinary(
              controlForm.bucketInspectionD.target!.bucketLinerNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.bucketInspectionD.target!.bucketLinerImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bucket Liner in Control Form Check In on Local Server named ${controlForm.bucketInspectionD.target!.bucketLinerNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.bucketLinerNames.toList()[i]);
                bucketLinerImages = "$bucketLinerImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('bucket-inspection').getPublicUrl(controlForm.bucketInspectionD.target!.bucketLinerNames.toList()[i]);
                bucketLinerImages = "$bucketLinerImages$urlImage|";
              }
            }
          }
          final recordBucketInspection = await supabaseCtrlV.from('bucket_inspection').insert(
            {
              'insulated': controlForm.bucketInspectionD.target!.insulated,
              'insulated_comments': controlForm.bucketInspectionD.target!.insulatedComments,
              'insulated_image': controlForm.bucketInspectionD.target!.insulatedImages.isEmpty == true ? null : insulatedImages,
              'holes_drilled': controlForm.bucketInspectionD.target!.holesDrilled,
              'holes_drilled_comments': controlForm.bucketInspectionD.target!.holesDrilledComments,
              'holes_drilled_image': controlForm.bucketInspectionD.target?.holesDrilledImages.isEmpty == true ? null : holesDrilledImages,
              'bucket_liner': controlForm.bucketInspectionD.target!.bucketLiner,
              'bucket_liner_comments': controlForm.bucketInspectionD.target!.bucketLinerComments,
              'bucket_liner_image': controlForm.bucketInspectionD.target?.bucketLinerImages.isEmpty == true ? null : bucketLinerImages,
              'date_added': controlForm.bucketInspectionD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_bucket_inspection');
          //Registrar security
          List<String> listNamesSecurity = [];
          final listImagesSecurity = await supabase.storage.from('security').list();
          for (var element in listImagesSecurity) {listNamesSecurity.add(element.name);}
          if (controlForm.securityD.target!.rtaMagnetImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.rtaMagnetImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.rtaMagnetNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.rtaMagnetNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.rtaMagnetImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on RTA Mganet in Control Form Check In on Local Server named ${controlForm.securityD.target!.rtaMagnetNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.rtaMagnetNames.toList()[i]);
                rtaMagnetImages = "$rtaMagnetImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.rtaMagnetNames.toList()[i]);
                rtaMagnetImages = "$rtaMagnetImages$urlImage|";
              }
            }
          }
          if (controlForm.securityD.target!.triangleReflectorsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.triangleReflectorsImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.triangleReflectorsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.triangleReflectorsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.triangleReflectorsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Triangle Reflectors in Control Form Check In on Local Server named ${controlForm.securityD.target!.triangleReflectorsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.triangleReflectorsNames.toList()[i]);
                triangleReflectorsImages = "$triangleReflectorsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.triangleReflectorsNames.toList()[i]);
                triangleReflectorsImages = "$triangleReflectorsImages$urlImage|";
              }
            }
          }
          if (controlForm.securityD.target!.wheelChocksImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.wheelChocksImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.wheelChocksNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.wheelChocksNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.wheelChocksImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Wheel Chocks in Control Form Check In on Local Server named ${controlForm.securityD.target!.wheelChocksNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.wheelChocksNames.toList()[i]);
                wheelChocksImages = "$wheelChocksImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.wheelChocksNames.toList()[i]);
                wheelChocksImages = "$wheelChocksImages$urlImage|";
              }
            }
          }
          if (controlForm.securityD.target!.fireExtinguisherImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.fireExtinguisherImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.fireExtinguisherNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.fireExtinguisherNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.fireExtinguisherImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Fire Extinguisher in Control Form Check In on Local Server named ${controlForm.securityD.target!.fireExtinguisherNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.fireExtinguisherNames.toList()[i]);
                fireExtinguisherImages = "$fireExtinguisherImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.fireExtinguisherNames.toList()[i]);
                fireExtinguisherImages = "$fireExtinguisherImages$urlImage|";
              }
            }
          }
          if (controlForm.securityD.target!.firstAidKitSafetyVestImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.firstAidKitSafetyVestImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.firstAidKitSafetyVestNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.firstAidKitSafetyVestNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.firstAidKitSafetyVestImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on First Aid Kit Safety Vest in Control Form Check In on Local Server named ${controlForm.securityD.target!.firstAidKitSafetyVestNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.firstAidKitSafetyVestNames.toList()[i]);
                firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.firstAidKitSafetyVestNames.toList()[i]);
                firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$urlImage|";
              }
            }
          }
          if (controlForm.securityD.target!.backUpAlarmImages.isNotEmpty) {
            for (var i = 0; i < controlForm.securityD.target!.backUpAlarmImages.toList().length; i++) {
              if (!listNamesSecurity.contains(controlForm.securityD.target!.backUpAlarmNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('security').uploadBinary(
              controlForm.securityD.target!.backUpAlarmNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.securityD.target!.backUpAlarmImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Backup Alarm in Control Form Check In on Local Server named ${controlForm.securityD.target!.backUpAlarmNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.backUpAlarmNames.toList()[i]);
                backUpAlarmImages = "$backUpAlarmImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('security').getPublicUrl(controlForm.securityD.target!.backUpAlarmNames.toList()[i]);
                backUpAlarmImages = "$backUpAlarmImages$urlImage|";
              }
            }
          }
          final recordSecurity = await supabaseCtrlV.from('security').insert(
            {
              'rta_magnet': controlForm.securityD.target!.rtaMagnet,
              'rta_magnet_comments': controlForm.securityD.target!.rtaMagnetComments,
              'rta_magnet_image': controlForm.securityD.target!.rtaMagnetImages.isEmpty == true ? null : rtaMagnetImages,
              'triangle_reflectors': controlForm.securityD.target!.triangleReflectors,
              'triangle_reflectors_comments': controlForm.securityD.target!.triangleReflectorsComments,
              'triangle_reflectors_image': controlForm.securityD.target?.triangleReflectorsImages.isEmpty == true ? null : triangleReflectorsImages,
              'wheel_chocks': controlForm.securityD.target!.wheelChocks,
              'wheel_chocks_comments': controlForm.securityD.target!.wheelChocksComments,
              'wheel_chocks_image': controlForm.securityD.target?.wheelChocksImages.isEmpty == true ? null : wheelChocksImages,
              'fire_extinguisher': controlForm.securityD.target!.fireExtinguisher,
              'fire_extinguisher_comments': controlForm.securityD.target!.fireExtinguisherComments,
              'fire_extinguisher_image': controlForm.securityD.target?.fireExtinguisherImages.isEmpty == true ? null : fireExtinguisherImages,
              'first_aid_kit_safety_vest': controlForm.securityD.target!.firstAidKitSafetyVest,
              'first_aid_kit_safety_vest_comments': controlForm.securityD.target!.firstAidKitSafetyVestComments,
              'first_aid_kit_safety_vest_image': controlForm.securityD.target?.firstAidKitSafetyVestImages.isEmpty == true ? null : firstAidKitSafetyVestImages,
              'back_up_alarm': controlForm.securityD.target!.backUpAlarm,
              'back_up_alarm_comments': controlForm.securityD.target!.backUpAlarmComments,
              'back_up_alarm_image': controlForm.securityD.target?.backUpAlarmImages.isEmpty == true ? null : backUpAlarmImages,
              'date_added': controlForm.securityD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_security');
          //Registrar extra
          List<String> listNamesExtra = [];
          final listImagesExtra = await supabase.storage.from('extras').list();
          for (var element in listImagesExtra) {listNamesExtra.add(element.name);}
          if (controlForm.extraD.target!.ladderImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.ladderImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.ladderNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.ladderNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.ladderImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ladder in Control Form Check In on Local Server named ${controlForm.extraD.target!.ladderNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.ladderNames.toList()[i]);
                ladderImages = "$ladderImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.ladderNames.toList()[i]);
                ladderImages = "$ladderImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.stepLadderImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.stepLadderImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.stepLadderNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.stepLadderNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.stepLadderImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Step Ladder in Control Form Check In on Local Server named ${controlForm.extraD.target!.stepLadderNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.stepLadderNames.toList()[i]);
                stepLadderImages = "$stepLadderImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.stepLadderNames.toList()[i]);
                stepLadderImages = "$stepLadderImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.ladderStrapsImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.ladderStrapsImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.ladderStrapsNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.ladderStrapsNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.ladderStrapsImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ladder Straps in Control Form Check In on Local Server named ${controlForm.extraD.target!.ladderStrapsNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.ladderStrapsNames.toList()[i]);
                ladderStrapsImages = "$ladderStrapsImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.ladderStrapsNames.toList()[i]);
                ladderStrapsImages = "$ladderStrapsImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.hydraulicFluidForBucketImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.hydraulicFluidForBucketImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.hydraulicFluidForBucketNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.hydraulicFluidForBucketNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.hydraulicFluidForBucketImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Hydraulic Fluid For Bucket in Control Form Check In on Local Server named ${controlForm.extraD.target!.hydraulicFluidForBucketNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.hydraulicFluidForBucketNames.toList()[i]);
                hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.hydraulicFluidForBucketNames.toList()[i]);
                hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.fiberReelRackImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.fiberReelRackImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.fiberReelRackNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.fiberReelRackNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.fiberReelRackImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Fiber Reel Rack in Control Form Check In on Local Server named ${controlForm.extraD.target!.fiberReelRackNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.fiberReelRackNames.toList()[i]);
                fiberReelRackImages = "$fiberReelRackImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.fiberReelRackNames.toList()[i]);
                fiberReelRackImages = "$fiberReelRackImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.binsLockedAndSecureImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.binsLockedAndSecureImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.binsLockedAndSecureNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.binsLockedAndSecureNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.binsLockedAndSecureImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bins Locked And Secure in Control Form Check In on Local Server named ${controlForm.extraD.target!.binsLockedAndSecureNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.binsLockedAndSecureNames.toList()[i]);
                binsLockedAndSecureImages = "$binsLockedAndSecureImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.binsLockedAndSecureNames.toList()[i]);
                binsLockedAndSecureImages = "$binsLockedAndSecureImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.safetyHarnessImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.safetyHarnessImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.safetyHarnessNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.safetyHarnessNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.safetyHarnessImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Safety Harness in Control Form Check In on Local Server named ${controlForm.extraD.target!.safetyHarnessNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.safetyHarnessNames.toList()[i]);
                safetyHarnessImages = "$safetyHarnessImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.safetyHarnessNames.toList()[i]);
                safetyHarnessImages = "$safetyHarnessImages$urlImage|";
              }
            }
          }
          if (controlForm.extraD.target!.lanyardSafetyHarnessImages.isNotEmpty) {
            for (var i = 0; i < controlForm.extraD.target!.lanyardSafetyHarnessImages.toList().length; i++) {
              if (!listNamesExtra.contains(controlForm.extraD.target!.lanyardSafetyHarnessNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('extras').uploadBinary(
              controlForm.extraD.target!.lanyardSafetyHarnessNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.extraD.target!.lanyardSafetyHarnessImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Lanyard Safety Harness in Control Form Check In on Local Server named ${controlForm.extraD.target!.lanyardSafetyHarnessNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.lanyardSafetyHarnessNames.toList()[i]);
                lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('extras').getPublicUrl(controlForm.extraD.target!.lanyardSafetyHarnessNames.toList()[i]);
                lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$urlImage|";
              }
            }
          }
          final recordExtra = await supabaseCtrlV.from('extra').insert(
            {
              'ladder': controlForm.extraD.target!.ladder,
              'ladder_comments': controlForm.extraD.target!.ladderComments,
              'ladder_image': controlForm.extraD.target!.ladderImages.isEmpty == true ? null : ladderImages,
              'step_ladder': controlForm.extraD.target!.stepLadder,
              'step_ladder_comments': controlForm.extraD.target!.stepLadderComments,
              'step_ladder_image': controlForm.extraD.target?.stepLadderImages.isEmpty == true ? null : stepLadderImages,
              'ladder_straps': controlForm.extraD.target!.ladderStraps,
              'ladder_straps_comments': controlForm.extraD.target!.ladderStrapsComments,
              'ladder_straps_image': controlForm.extraD.target?.ladderStrapsImages.isEmpty == true ? null : ladderStrapsImages,
              'hydraulic_fluid_for_bucket': controlForm.extraD.target!.hydraulicFluidForBucket,
              'hydraulic_fluid_for_bucket_comments': controlForm.extraD.target!.hydraulicFluidForBucketComments,
              'hydraulic_fluid_for_bucket_image': controlForm.extraD.target?.hydraulicFluidForBucketImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'fiber_reel_rack': controlForm.extraD.target!.fiberReelRack,
              'fiber_reel_rack_comments': controlForm.extraD.target!.fiberReelRackComments,
              'fiber_reel_rack_image': controlForm.extraD.target?.fiberReelRackImages.isEmpty == true ? null : fiberReelRackImages,
              'bins_locked_and_secure': controlForm.extraD.target!.binsLockedAndSecure,
              'bins_locked_and_secure_comments': controlForm.extraD.target!.binsLockedAndSecureComments,
              'bins_locked_and_secure_image': controlForm.extraD.target?.binsLockedAndSecureImages.isEmpty == true ? null : binsLockedAndSecureImages,
              'safety_harness': controlForm.extraD.target!.safetyHarness,
              'safety_harness_comments': controlForm.extraD.target!.safetyHarnessComments,
              'safety_harness_image': controlForm.extraD.target?.safetyHarnessImages.isEmpty == true ? null : safetyHarnessImages,
              'lanyard_safety_harness': controlForm.extraD.target!.lanyardSafetyHarness,
              'lanyard_safety_harness_comments': controlForm.extraD.target!.lanyardSafetyHarnessComments,
              'lanyard_safety_harness_image': controlForm.extraD.target?.lanyardSafetyHarnessImages.isEmpty == true ? null : lanyardSafetyHarnessImages,
              'date_added': controlForm.extraD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_extra');
          //Registrar equipment
          List<String> listNamesEquipment = [];
          final listImagesEquipment = await supabase.storage.from('equipment').list();
          for (var element in listImagesEquipment) {listNamesEquipment.add(element.name);}
          if (controlForm.equipmentD.target!.ignitionKeyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentD.target!.ignitionKeyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentD.target!.ignitionKeyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentD.target!.ignitionKeyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentD.target!.ignitionKeyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Ignition Key in Control Form Check In on Local Server named ${controlForm.equipmentD.target!.ignitionKeyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.ignitionKeyNames.toList()[i]);
                ignitionKeyImages = "$ignitionKeyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.ignitionKeyNames.toList()[i]);
                ignitionKeyImages = "$ignitionKeyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentD.target!.binsBoxKeyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentD.target!.binsBoxKeyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentD.target!.binsBoxKeyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentD.target!.binsBoxKeyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentD.target!.binsBoxKeyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bins Box Key in Control Form Check In on Local Server named ${controlForm.equipmentD.target!.binsBoxKeyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.binsBoxKeyNames.toList()[i]);
                binsBoxKeyImages = "$binsBoxKeyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.binsBoxKeyNames.toList()[i]);
                binsBoxKeyImages = "$binsBoxKeyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentD.target!.vehicleInsuranceCopyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentD.target!.vehicleInsuranceCopyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentD.target!.vehicleInsuranceCopyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentD.target!.vehicleInsuranceCopyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentD.target!.vehicleInsuranceCopyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Vehicle Insurance Copy in Control Form Check In on Local Server named ${controlForm.equipmentD.target!.vehicleInsuranceCopyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.vehicleInsuranceCopyNames.toList()[i]);
                vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.vehicleInsuranceCopyNames.toList()[i]);
                vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentD.target!.vehicleRegistrationCopyImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentD.target!.vehicleRegistrationCopyImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentD.target!.vehicleRegistrationCopyNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentD.target!.vehicleRegistrationCopyNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentD.target!.vehicleRegistrationCopyImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Vehicle Registration Copy in Control Form Check In on Local Server named ${controlForm.equipmentD.target!.vehicleRegistrationCopyNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.vehicleRegistrationCopyNames.toList()[i]);
                vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.vehicleRegistrationCopyNames.toList()[i]);
                vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$urlImage|";
              }
            }
          }
          if (controlForm.equipmentD.target!.bucketLiftOperatorManualImages.isNotEmpty) {
            for (var i = 0; i < controlForm.equipmentD.target!.bucketLiftOperatorManualImages.toList().length; i++) {
              if (!listNamesEquipment.contains(controlForm.equipmentD.target!.bucketLiftOperatorManualNames.toList()[i])) {
                //Parsear a Uint8List
              final storageResponse = await supabase.storage.from('equipment').uploadBinary(
              controlForm.equipmentD.target!.bucketLiftOperatorManualNames.toList()[i],
              Uint8List.fromList(utf8.encode(controlForm.equipmentD.target!.bucketLiftOperatorManualImages.toList()[i])),
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );
              if (storageResponse.isEmpty) {
                return SyncInstruction(
                  exitoso: false,
                  descripcion:
                      "Failed to sync image on Bucket Lift Operator Manual in Control Form Check In on Local Server named ${controlForm.equipmentD.target!.bucketLiftOperatorManualNames.toList()[i]}");
              }
              final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.bucketLiftOperatorManualNames.toList()[i]);
                bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$urlImage|";
              } else {
                final urlImage = supabase.storage.from('equipment').getPublicUrl(controlForm.equipmentD.target!.bucketLiftOperatorManualNames.toList()[i]);
                bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$urlImage|";
              }
            }
          }
          final recordEquipment = await supabaseCtrlV.from('equipment').insert(
            {
              'ignition_key': controlForm.equipmentD.target!.ignitionKey,
              'ignition_key_comments': controlForm.equipmentD.target!.ignitionKeyComments,
              'ignition_key_image': controlForm.equipmentD.target?.ignitionKeyImages.isEmpty == true ? null : ignitionKeyImages,
              'bins_box_key': controlForm.equipmentD.target!.binsBoxKey,
              'bins_box_key_comments': controlForm.equipmentD.target!.binsBoxKeyComments,
              'bins_box_key_image': controlForm.equipmentD.target?.binsBoxKeyImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'vehicle_registration_copy': controlForm.equipmentD.target!.vehicleInsuranceCopy,
              'vehicle_registration_copy_comments': controlForm.equipmentD.target!.vehicleInsuranceCopyComments,
              'vehicle_registration_copy_image': controlForm.equipmentD.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'vehicle_insurance_copy': controlForm.equipmentD.target!.vehicleInsuranceCopy,
              'vehicle_insurance_copy_comments': controlForm.equipmentD.target!.vehicleInsuranceCopyComments,
              'vehicle_insurance_copy_image': controlForm.equipmentD.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'bucket_lift_operator_manual': controlForm.equipmentD.target!.bucketLiftOperatorManual,
              'bucket_lift_operator_manual_comments': controlForm.equipmentD.target!.bucketLiftOperatorManualComments,
              'bucket_lift_operator_manual_image': controlForm.equipmentD.target?.bucketLiftOperatorManualImages.isEmpty == true ? null : bucketLiftOperatorManualImages,
              'date_added': controlForm.equipmentD.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_equipment');
          

          if (recordMeasure.isNotEmpty && recordLights.isNotEmpty && recordCarBodywork.isNotEmpty && recordFluidsCheck.isNotEmpty 
              && recordBucketInspection.isNotEmpty && recordSecurity.isNotEmpty && recordExtra.isNotEmpty && recordEquipment.isNotEmpty) {
            final recordControlForm = await supabaseCtrlV.from('control_form').update(
              {
                'id_measure_d_fk': recordMeasure.first['id_measure'],
                'id_lights_d_fk': recordLights.first['id_lights'],
                'id_car_bodywork_d_fk': recordCarBodywork.first['id_car_bodywork'],
                'id_fluids_check_d_fk': recordFluidsCheck.first['id_fluids_check'],
                'id_bucket_inspection_d_fk': recordBucketInspection.first['id_bucket_inspection'],
                'id_security_d_fk': recordSecurity.first['id_security'],
                'id_extra_d_fk': recordExtra.first['id_extra'],
                'id_equipment_d_fk': recordEquipment.first['id_equipment'],
                'issues_d': controlForm.issuesD,
                'date_added_d': controlForm.dateAddedD!.toIso8601String(),
              },
            ).eq("id_control_form", controlForm.idDBR)
            .select<PostgrestList>('id_control_form');
            //Registrar control Form
            if (recordControlForm.isNotEmpty) {
              //Se recupera el idDBR de Supabase de Measure
              controlForm.measuresD.target!.idDBR = recordMeasure.first['id_measure'].toString();
              dataBase.measuresFormBox.put(controlForm.measuresD.target!);
              //Se recupera el idDBR de Supabase de Lights
              controlForm.lightsD.target!.idDBR = recordLights.first['id_lights'].toString();
              dataBase.lightsFormBox.put(controlForm.lightsD.target!);
              //Se recupera el idDBR de Supabase de Car Bodywork
              controlForm.carBodyworkD.target!.idDBR = recordCarBodywork.first['id_car_bodywork'].toString();
              dataBase.carBodyworkFormBox.put(controlForm.carBodyworkD.target!);
              //Se recupera el idDBR de Supabase de Fluids Check
              controlForm.fluidsCheckD.target!.idDBR = recordFluidsCheck.first['id_fluids_check'].toString();
              dataBase.fluidsCheckFormBox.put(controlForm.fluidsCheckD.target!);
              //Se recupera el idDBR de Supabase de Bucket Inspection
              controlForm.bucketInspectionD.target!.idDBR = recordBucketInspection.first['id_bucket_inspection'].toString();
              dataBase.bucketInspectionFormBox.put(controlForm.bucketInspectionD.target!);
              //Se recupera el idDBR de Supabase de Security
              controlForm.securityD.target!.idDBR = recordSecurity.first['id_security'].toString();
              dataBase.securityFormBox.put(controlForm.securityD.target!);
              //Se recupera el idDBR de Supabase de Extra
              controlForm.extraD.target!.idDBR = recordExtra.first['id_extra'].toString();
              dataBase.extraFormBox.put(controlForm.extraD.target!);
              //Se recupera el idDBR de Supabase de Equipment
              controlForm.equipmentD.target!.idDBR = recordEquipment.first['id_equipment'].toString();
              dataBase.equipmentFormBox.put(controlForm.equipmentD.target!);
              //Se acuatila el Control Form
              dataBase.controlFormBox.put(controlForm);
              // //Se actualiza el número de current Month Forms del usuario
              // if (controlForm.typeForm) {
              //   final updateUsuario = dataBase.usersBox.query(Users_.idDBR.equals(controlForm.employee.target!.idDBR)).build().findUnique();
              //   if(updateUsuario != null) 
              //   {
              //     int newRecordsMonthCurrentR = updateUsuario.recordsMonthCurrentR + 1;
              //     updateUsuario.recordsMonthCurrentR = newRecordsMonthCurrentR;
              //     dataBase.usersBox.put(updateUsuario);
              //   }
              // } else {
              //   final updateUsuario = dataBase.usersBox.query(Users_.idDBR.equals(controlForm.employee.target!.idDBR)).build().findUnique();
              //   if(updateUsuario != null) 
              //   {
              //     int newRecordsMonthCurrentD = updateUsuario.recordsMonthCurrentD + 1;
              //     updateUsuario.recordsMonthCurrentD = newRecordsMonthCurrentD;
              //     dataBase.usersBox.put(updateUsuario);
              //   }
              // }
              //Se marca como ejecutada la instrucción en Bitacora
              bitacora.executeSupabase = true;
              dataBase.bitacoraBox.put(bitacora);
              dataBase.bitacoraBox.remove(bitacora.id);
              return SyncInstruction(exitoso: true, descripcion: "");
            } else {
              return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync all data Control Form Check In on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
            }
          } else {
            return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data Control Form Check In on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
          }
          
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data Control Form Check In on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
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
              "Failed to sync data Control Form Check In on Local Server with vehicle ID ${controlForm.vehicle.target!.idDBR}:, details: '$e'");
    }
  }

}
