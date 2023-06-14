import 'dart:convert';

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
          if (controlForm.measuresR.target!.gasImages.isNotEmpty) {
            for (var element in controlForm.measuresR.target!.gasImages.toList()) {
              gasImages = "$gasImages$element|";
            }
          }
          if (controlForm.measuresR.target!.mileageImages.isNotEmpty) {
            for (var element in controlForm.measuresR.target!.mileageImages.toList()) {
              mileageImages = "$mileageImages$element|";
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
          if (controlForm.lightsR.target!.headLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.headLightsImages.toList()) {
              headlightsImages = "$headlightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.brakeLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.brakeLightsImages.toList()) {
              brakeLightsImages = "$brakeLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.reverseLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.reverseLightsImages.toList()) {
              reverseLightsImages = "$reverseLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.warningLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.warningLightsImages.toList()) {
              warningLightsImages = "$warningLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.turnSignalsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.turnSignalsImages.toList()) {
              turnSignalsImages = "$turnSignalsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.fourWayFlashersImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.fourWayFlashersImages.toList()) {
              fourWayFlashersImages = "$fourWayFlashersImages$element|";
            }
          }
          if (controlForm.lightsR.target!.dashLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.dashLightsImages.toList()) {
              dashLightsImages = "$dashLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.strobeLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.strobeLightsImages.toList()) {
              strobeLightsImages = "$strobeLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.cabRoofLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.cabRoofLightsImages.toList()) {
              cabRoofLightsImages = "$cabRoofLightsImages$element|";
            }
          }
          if (controlForm.lightsR.target!.clearanceLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsR.target!.clearanceLightsImages.toList()) {
              clearanceLightsImages = "$clearanceLightsImages$element|";
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
          if (controlForm.carBodyworkR.target!.wiperBladesFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.wiperBladesFrontImages.toList()) {
              wiperBladesFrontImages = "$wiperBladesFrontImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.wiperBladesBackImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.wiperBladesBackImages.toList()) {
              wiperBladesBackImages = "$wiperBladesBackImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.windshieldWiperFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.windshieldWiperFrontImages.toList()) {
              windshieldWiperFrontImages = "$windshieldWiperFrontImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.windshieldWiperBackImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.windshieldWiperBackImages.toList()) {
              windshieldWiperBackImages = "$windshieldWiperBackImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.generalBodyImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.generalBodyImages.toList()) {
              generalBodyImages = "$generalBodyImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.decalingImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.decalingImages.toList()) {
              decalingImages = "$decalingImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.tiresImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.tiresImages.toList()) {
              tiresImages = "$tiresImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.glassImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.glassImages.toList()) {
              glassImages = "$glassImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.mirrorsImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.mirrorsImages.toList()) {
              mirrorsImages = "$mirrorsImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.parkingImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.parkingImages.toList()) {
              parkingImages = "$parkingImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.brakesImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.brakesImages.toList()) {
              brakesImages = "$brakesImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.emgBrakesImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.emgBrakesImages.toList()) {
              emgBrakesImages = "$emgBrakesImages$element|";
            }
          }
          if (controlForm.carBodyworkR.target!.hornImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkR.target!.hornImages.toList()) {
              hornImages = "$hornImages$element|";
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
          if (controlForm.fluidsCheckR.target!.engineOilImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.engineOilImages.toList()) {
              engineOilImages = "$engineOilImages$element|";
            }
          }
          if (controlForm.fluidsCheckR.target!.transmissionImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.transmissionImages.toList()) {
              transmissionImages = "$transmissionImages$element|";
            }
          }
          if (controlForm.fluidsCheckR.target!.coolantImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.coolantImages.toList()) {
              coolantImages = "$coolantImages$element|";
            }
          }
          if (controlForm.fluidsCheckR.target!.powerSteeringImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.powerSteeringImages.toList()) {
              powerSteeringImages = "$powerSteeringImages$element|";
            }
          }
          if (controlForm.fluidsCheckR.target!.dieselExhaustFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.dieselExhaustFluidImages.toList()) {
              dieselExhaustFluidImages = "$dieselExhaustFluidImages$element|";
            }
          }
          if (controlForm.fluidsCheckR.target!.windshieldWasherFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckR.target!.windshieldWasherFluidImages.toList()) {
              windshieldWasherFluidImages = "$windshieldWasherFluidImages$element|";
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
          if (controlForm.bucketInspectionR.target!.insulatedImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionR.target!.insulatedImages.toList()) {
              insulatedImages = "$insulatedImages$element|";
            }
          }
          if (controlForm.bucketInspectionR.target!.holesDrilledImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionR.target!.holesDrilledImages.toList()) {
              holesDrilledImages = "$holesDrilledImages$element|";
            }
          }
          if (controlForm.bucketInspectionR.target!.bucketLinerImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionR.target!.bucketLinerImages.toList()) {
              bucketLinerImages = "$bucketLinerImages$element|";
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
          if (controlForm.securityR.target!.rtaMagnetImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.rtaMagnetImages.toList()) {
              rtaMagnetImages = "$rtaMagnetImages$element|";
            }
          }
          if (controlForm.securityR.target!.triangleReflectorsImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.triangleReflectorsImages.toList()) {
              triangleReflectorsImages = "$triangleReflectorsImages$element|";
            }
          }
          if (controlForm.securityR.target!.wheelChocksImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.wheelChocksImages.toList()) {
              wheelChocksImages = "$wheelChocksImages$element|";
            }
          }
          if (controlForm.securityR.target!.fireExtinguisherImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.fireExtinguisherImages.toList()) {
              fireExtinguisherImages = "$fireExtinguisherImages$element|";
            }
          }
          if (controlForm.securityR.target!.firstAidKitSafetyVestImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.firstAidKitSafetyVestImages.toList()) {
              firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$element|";
            }
          }
          if (controlForm.securityR.target!.backUpAlarmImages.isNotEmpty) {
            for (var element in controlForm.securityR.target!.backUpAlarmImages.toList()) {
              backUpAlarmImages = "$backUpAlarmImages$element|";
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
          if (controlForm.extraR.target!.ladderImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.ladderImages.toList()) {
              ladderImages = "$ladderImages$element|";
            }
          }
          if (controlForm.extraR.target!.stepLadderImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.stepLadderImages.toList()) {
              stepLadderImages = "$stepLadderImages$element|";
            }
          }
          if (controlForm.extraR.target!.ladderStrapsImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.ladderStrapsImages.toList()) {
              ladderStrapsImages = "$ladderStrapsImages$element|";
            }
          }
          if (controlForm.extraR.target!.hydraulicFluidForBucketImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.hydraulicFluidForBucketImages.toList()) {
              hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$element|";
            }
          }
          if (controlForm.extraR.target!.fiberReelRackImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.fiberReelRackImages.toList()) {
              fiberReelRackImages = "$fiberReelRackImages$element|";
            }
          }
          if (controlForm.extraR.target!.binsLockedAndSecureImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.binsLockedAndSecureImages.toList()) {
              binsLockedAndSecureImages = "$binsLockedAndSecureImages$element|";
            }
          }
          if (controlForm.extraR.target!.safetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.safetyHarnessImages.toList()) {
              safetyHarnessImages = "$safetyHarnessImages$element|";
            }
          }
          if (controlForm.extraR.target!.lanyardSafetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extraR.target!.lanyardSafetyHarnessImages.toList()) {
              lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$element|";
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
          if (controlForm.equipmentR.target!.ignitionKeyImages.isNotEmpty) {
            for (var element in controlForm.equipmentR.target!.ignitionKeyImages.toList()) {
              ignitionKeyImages = "$ignitionKeyImages$element|";
            }
          }
          if (controlForm.equipmentR.target!.binsBoxKeyImages.isNotEmpty) {
            for (var element in controlForm.equipmentR.target!.binsBoxKeyImages.toList()) {
              binsBoxKeyImages = "$binsBoxKeyImages$element|";
            }
          }
          if (controlForm.equipmentR.target!.vehicleInsuranceCopyImages.isNotEmpty) {
            for (var element in controlForm.equipmentR.target!.vehicleInsuranceCopyImages.toList()) {
              vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$element|";
            }
          }
          if (controlForm.equipmentR.target!.vehicleRegistrationCopyImages.isNotEmpty) {
            for (var element in controlForm.equipmentR.target!.vehicleRegistrationCopyImages.toList()) {
              vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$element|";
            }
          }
          if (controlForm.equipmentR.target!.bucketLiftOperatorManualImages.isNotEmpty) {
            for (var element in controlForm.equipmentR.target!.bucketLiftOperatorManualImages.toList()) {
              bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$element|";
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
                  "Failed to sync all data Control Form Received on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
            }
          } else {
            return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data measure Control Form Received on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
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
              "Failed to sync data measure Control Form Received on Local Server with vehicle ID ${controlForm.vehicle.target!.idDBR}:, details: '$e'");
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
          if (controlForm.measuresD.target!.gasImages.isNotEmpty) {
            for (var element in controlForm.measuresD.target!.gasImages.toList()) {
              gasImages = "$gasImages$element|";
            }
          }
          if (controlForm.measuresD.target!.mileageImages.isNotEmpty) {
            for (var element in controlForm.measuresD.target!.mileageImages.toList()) {
              mileageImages = "$mileageImages$element|";
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
          if (controlForm.lightsD.target!.headLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.headLightsImages.toList()) {
              headlightsImages = "$headlightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.brakeLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.brakeLightsImages.toList()) {
              brakeLightsImages = "$brakeLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.reverseLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.reverseLightsImages.toList()) {
              reverseLightsImages = "$reverseLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.warningLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.warningLightsImages.toList()) {
              warningLightsImages = "$warningLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.turnSignalsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.turnSignalsImages.toList()) {
              turnSignalsImages = "$turnSignalsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.fourWayFlashersImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.fourWayFlashersImages.toList()) {
              fourWayFlashersImages = "$fourWayFlashersImages$element|";
            }
          }
          if (controlForm.lightsD.target!.dashLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.dashLightsImages.toList()) {
              dashLightsImages = "$dashLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.strobeLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.strobeLightsImages.toList()) {
              strobeLightsImages = "$strobeLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.cabRoofLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.cabRoofLightsImages.toList()) {
              cabRoofLightsImages = "$cabRoofLightsImages$element|";
            }
          }
          if (controlForm.lightsD.target!.clearanceLightsImages.isNotEmpty) {
            for (var element in controlForm.lightsD.target!.clearanceLightsImages.toList()) {
              clearanceLightsImages = "$clearanceLightsImages$element|";
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
          if (controlForm.carBodyworkD.target!.wiperBladesFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.wiperBladesFrontImages.toList()) {
              wiperBladesFrontImages = "$wiperBladesFrontImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.wiperBladesBackImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.wiperBladesBackImages.toList()) {
              wiperBladesBackImages = "$wiperBladesBackImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.windshieldWiperFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.windshieldWiperFrontImages.toList()) {
              windshieldWiperFrontImages = "$windshieldWiperFrontImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.windshieldWiperBackImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.windshieldWiperBackImages.toList()) {
              windshieldWiperBackImages = "$windshieldWiperBackImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.generalBodyImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.generalBodyImages.toList()) {
              generalBodyImages = "$generalBodyImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.decalingImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.decalingImages.toList()) {
              decalingImages = "$decalingImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.tiresImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.tiresImages.toList()) {
              tiresImages = "$tiresImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.glassImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.glassImages.toList()) {
              glassImages = "$glassImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.mirrorsImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.mirrorsImages.toList()) {
              mirrorsImages = "$mirrorsImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.parkingImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.parkingImages.toList()) {
              parkingImages = "$parkingImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.brakesImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.brakesImages.toList()) {
              brakesImages = "$brakesImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.emgBrakesImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.emgBrakesImages.toList()) {
              emgBrakesImages = "$emgBrakesImages$element|";
            }
          }
          if (controlForm.carBodyworkD.target!.hornImages.isNotEmpty) {
            for (var element in controlForm.carBodyworkD.target!.hornImages.toList()) {
              hornImages = "$hornImages$element|";
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
          if (controlForm.fluidsCheckD.target!.engineOilImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.engineOilImages.toList()) {
              engineOilImages = "$engineOilImages$element|";
            }
          }
          if (controlForm.fluidsCheckD.target!.transmissionImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.transmissionImages.toList()) {
              transmissionImages = "$transmissionImages$element|";
            }
          }
          if (controlForm.fluidsCheckD.target!.coolantImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.coolantImages.toList()) {
              coolantImages = "$coolantImages$element|";
            }
          }
          if (controlForm.fluidsCheckD.target!.powerSteeringImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.powerSteeringImages.toList()) {
              powerSteeringImages = "$powerSteeringImages$element|";
            }
          }
          if (controlForm.fluidsCheckD.target!.dieselExhaustFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.dieselExhaustFluidImages.toList()) {
              dieselExhaustFluidImages = "$dieselExhaustFluidImages$element|";
            }
          }
          if (controlForm.fluidsCheckD.target!.windshieldWasherFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheckD.target!.windshieldWasherFluidImages.toList()) {
              windshieldWasherFluidImages = "$windshieldWasherFluidImages$element|";
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
          if (controlForm.bucketInspectionD.target!.insulatedImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionD.target!.insulatedImages.toList()) {
              insulatedImages = "$insulatedImages$element|";
            }
          }
          if (controlForm.bucketInspectionD.target!.holesDrilledImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionD.target!.holesDrilledImages.toList()) {
              holesDrilledImages = "$holesDrilledImages$element|";
            }
          }
          if (controlForm.bucketInspectionD.target!.bucketLinerImages.isNotEmpty) {
            for (var element in controlForm.bucketInspectionD.target!.bucketLinerImages.toList()) {
              bucketLinerImages = "$bucketLinerImages$element|";
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
          if (controlForm.securityD.target!.rtaMagnetImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.rtaMagnetImages.toList()) {
              rtaMagnetImages = "$rtaMagnetImages$element|";
            }
          }
          if (controlForm.securityD.target!.triangleReflectorsImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.triangleReflectorsImages.toList()) {
              triangleReflectorsImages = "$triangleReflectorsImages$element|";
            }
          }
          if (controlForm.securityD.target!.wheelChocksImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.wheelChocksImages.toList()) {
              wheelChocksImages = "$wheelChocksImages$element|";
            }
          }
          if (controlForm.securityD.target!.fireExtinguisherImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.fireExtinguisherImages.toList()) {
              fireExtinguisherImages = "$fireExtinguisherImages$element|";
            }
          }
          if (controlForm.securityD.target!.firstAidKitSafetyVestImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.firstAidKitSafetyVestImages.toList()) {
              firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$element|";
            }
          }
          if (controlForm.securityD.target!.backUpAlarmImages.isNotEmpty) {
            for (var element in controlForm.securityD.target!.backUpAlarmImages.toList()) {
              backUpAlarmImages = "$backUpAlarmImages$element|";
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
          if (controlForm.extraD.target!.ladderImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.ladderImages.toList()) {
              ladderImages = "$ladderImages$element|";
            }
          }
          if (controlForm.extraD.target!.stepLadderImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.stepLadderImages.toList()) {
              stepLadderImages = "$stepLadderImages$element|";
            }
          }
          if (controlForm.extraD.target!.ladderStrapsImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.ladderStrapsImages.toList()) {
              ladderStrapsImages = "$ladderStrapsImages$element|";
            }
          }
          if (controlForm.extraD.target!.hydraulicFluidForBucketImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.hydraulicFluidForBucketImages.toList()) {
              hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$element|";
            }
          }
          if (controlForm.extraD.target!.fiberReelRackImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.fiberReelRackImages.toList()) {
              fiberReelRackImages = "$fiberReelRackImages$element|";
            }
          }
          if (controlForm.extraD.target!.binsLockedAndSecureImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.binsLockedAndSecureImages.toList()) {
              binsLockedAndSecureImages = "$binsLockedAndSecureImages$element|";
            }
          }
          if (controlForm.extraD.target!.safetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.safetyHarnessImages.toList()) {
              safetyHarnessImages = "$safetyHarnessImages$element|";
            }
          }
          if (controlForm.extraD.target!.lanyardSafetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extraD.target!.lanyardSafetyHarnessImages.toList()) {
              lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$element|";
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
          if (controlForm.equipmentD.target!.ignitionKeyImages.isNotEmpty) {
            for (var element in controlForm.equipmentD.target!.ignitionKeyImages.toList()) {
              ignitionKeyImages = "$ignitionKeyImages$element|";
            }
          }
          if (controlForm.equipmentD.target!.binsBoxKeyImages.isNotEmpty) {
            for (var element in controlForm.equipmentD.target!.binsBoxKeyImages.toList()) {
              binsBoxKeyImages = "$binsBoxKeyImages$element|";
            }
          }
          if (controlForm.equipmentD.target!.vehicleInsuranceCopyImages.isNotEmpty) {
            for (var element in controlForm.equipmentD.target!.vehicleInsuranceCopyImages.toList()) {
              vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$element|";
            }
          }
          if (controlForm.equipmentD.target!.vehicleRegistrationCopyImages.isNotEmpty) {
            for (var element in controlForm.equipmentD.target!.vehicleRegistrationCopyImages.toList()) {
              vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$element|";
            }
          }
          if (controlForm.equipmentD.target!.bucketLiftOperatorManualImages.isNotEmpty) {
            for (var element in controlForm.equipmentD.target!.bucketLiftOperatorManualImages.toList()) {
              bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$element|";
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
                'issues_d': controlForm.issuesR,
                'date_added_d': controlForm.dateAddedR.toIso8601String(),
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
                  "Failed to sync all data Control Form Delivered on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
            }
          } else {
            return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data measure Control Form Delivered on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
          }
          
        } else {
          return SyncInstruction(
              exitoso: false,
              descripcion:
                  "Failed to sync data measure Control Form Delivered on Local Server: Control Form with vehicle ID ${controlForm.vehicle.target!.idDBR}.");
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
              "Failed to sync data measure Control Form Delivered on Local Server with vehicle ID ${controlForm.vehicle.target!.idDBR}:, details: '$e'");
    }
  }

}
