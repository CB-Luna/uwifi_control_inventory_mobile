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

  Future<SyncInstruction> syncAddControlForm(
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
          if (controlForm.measures.target!.gasImages.isNotEmpty) {
            for (var element in controlForm.measures.target!.gasImages.toList()) {
              gasImages = "$gasImages$element|";
            }
          }
          if (controlForm.measures.target!.mileageImages.isNotEmpty) {
            for (var element in controlForm.measures.target!.mileageImages.toList()) {
              mileageImages = "$mileageImages$element|";
            }
          }
          final recordMeasure = await supabaseCtrlV.from('measures').insert(
            {
              'gas': controlForm.measures.target!.gas,
              'gas_comments': controlForm.measures.target!.gasComments,
              'gas_image': controlForm.measures.target!.gasImages.isEmpty == true ? null : gasImages,
              'mileage': controlForm.measures.target!.mileage,
              'mileage_comments': controlForm.measures.target!.mileageComments,
              'milage_image': controlForm.measures.target?.mileageImages.isEmpty == true ? null : mileageImages,
              'date_added': controlForm.measures.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_measure');
          //Registrar lights
          if (controlForm.lights.target!.headLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.headLightsImages.toList()) {
              headlightsImages = "$headlightsImages$element|";
            }
          }
          if (controlForm.lights.target!.brakeLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.brakeLightsImages.toList()) {
              brakeLightsImages = "$brakeLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.reverseLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.reverseLightsImages.toList()) {
              reverseLightsImages = "$reverseLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.warningLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.warningLightsImages.toList()) {
              warningLightsImages = "$warningLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.turnSignalsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.turnSignalsImages.toList()) {
              turnSignalsImages = "$turnSignalsImages$element|";
            }
          }
          if (controlForm.lights.target!.fourWayFlashersImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.fourWayFlashersImages.toList()) {
              fourWayFlashersImages = "$fourWayFlashersImages$element|";
            }
          }
          if (controlForm.lights.target!.dashLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.dashLightsImages.toList()) {
              dashLightsImages = "$dashLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.strobeLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.strobeLightsImages.toList()) {
              strobeLightsImages = "$strobeLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.cabRoofLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.cabRoofLightsImages.toList()) {
              cabRoofLightsImages = "$cabRoofLightsImages$element|";
            }
          }
          if (controlForm.lights.target!.clearanceLightsImages.isNotEmpty) {
            for (var element in controlForm.lights.target!.clearanceLightsImages.toList()) {
              clearanceLightsImages = "$clearanceLightsImages$element|";
            }
          }
          final recordLights = await supabaseCtrlV.from('lights').insert(
            {
              'headlights': controlForm.lights.target!.headLights,
              'headlights_comments': controlForm.lights.target!.headLightsComments,
              'headlights_image': controlForm.lights.target!.headLightsImages.isEmpty == true ? null : headlightsImages,
              'brake_lights': controlForm.lights.target!.brakeLights,
              'brake_lights_comments': controlForm.lights.target!.brakeLightsComments,
              'brake_lights_image': controlForm.lights.target?.brakeLightsImages.isEmpty == true ? null : brakeLightsImages,
              'reverse_lights': controlForm.lights.target!.reverseLights,
              'reverse_lights_comments': controlForm.lights.target!.reverseLightsComments,
              'reverse_lights_image': controlForm.lights.target?.reverseLightsImages.isEmpty == true ? null : reverseLightsImages,
              'warning_lights': controlForm.lights.target!.warningLights,
              'warning_lights_comments': controlForm.lights.target!.warningLightsComments,
              'warning_lights_image': controlForm.lights.target?.warningLightsImages.isEmpty == true ? null : warningLightsImages,
              'turn_signals': controlForm.lights.target!.turnSignals,
              'turn_signals_comments': controlForm.lights.target!.turnSignalsComments,
              'turn_signals_image': controlForm.lights.target?.turnSignalsImages.isEmpty == true ? null : turnSignalsImages,
              '4_way_flashers': controlForm.lights.target!.fourWayFlashers,
              '4_way_flashers_comments': controlForm.lights.target!.fourWayFlashersComments,
              '4_way_flashers_image': controlForm.lights.target?.fourWayFlashersImages.isEmpty == true ? null : fourWayFlashersImages,
              'dash_lights': controlForm.lights.target!.dashLights,
              'dash_lights_comments': controlForm.lights.target!.dashLightsComments,
              'dash_lights_image': controlForm.lights.target?.dashLightsImages.isEmpty == true ? null : dashLightsImages,
              'strobe_lights': controlForm.lights.target!.strobeLights,
              'strobe_lights_comments': controlForm.lights.target!.strobeLightsComments,
              'strobe_lights_image': controlForm.lights.target?.strobeLightsImages.isEmpty == true ? null : strobeLightsImages,
              'cab_roof_lights': controlForm.lights.target!.cabRoofLights,
              'cab_roof_lights_comments': controlForm.lights.target!.cabRoofLightsComments,
              'cab_roof_lights_image': controlForm.lights.target?.cabRoofLightsImages.isEmpty == true ? null : cabRoofLightsImages,
              'clearance_lights': controlForm.lights.target!.clearanceLights,
              'clearance_lights_comments': controlForm.lights.target!.clearanceLightsComments,
              'clearance_lights_image': controlForm.lights.target?.clearanceLightsImages.isEmpty == true ? null : clearanceLightsImages,
              'date_added': controlForm.lights.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_lights');
          //Registrar car bodywork
          if (controlForm.carBodywork.target!.wiperBladesFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.wiperBladesFrontImages.toList()) {
              wiperBladesFrontImages = "$wiperBladesFrontImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.wiperBladesBackImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.wiperBladesBackImages.toList()) {
              wiperBladesBackImages = "$wiperBladesBackImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.windshieldWiperFrontImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.windshieldWiperFrontImages.toList()) {
              windshieldWiperFrontImages = "$windshieldWiperFrontImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.windshieldWiperBackImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.windshieldWiperBackImages.toList()) {
              windshieldWiperBackImages = "$windshieldWiperBackImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.generalBodyImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.generalBodyImages.toList()) {
              generalBodyImages = "$generalBodyImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.decalingImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.decalingImages.toList()) {
              decalingImages = "$decalingImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.tiresImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.tiresImages.toList()) {
              tiresImages = "$tiresImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.glassImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.glassImages.toList()) {
              glassImages = "$glassImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.mirrorsImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.mirrorsImages.toList()) {
              mirrorsImages = "$mirrorsImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.parkingImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.parkingImages.toList()) {
              parkingImages = "$parkingImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.brakesImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.brakesImages.toList()) {
              brakesImages = "$brakesImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.emgBrakesImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.emgBrakesImages.toList()) {
              emgBrakesImages = "$emgBrakesImages$element|";
            }
          }
          if (controlForm.carBodywork.target!.hornImages.isNotEmpty) {
            for (var element in controlForm.carBodywork.target!.hornImages.toList()) {
              hornImages = "$hornImages$element|";
            }
          }
          final recordCarBodywork = await supabaseCtrlV.from('car_bodywork').insert(
            {
              'wiper_blades_front': controlForm.carBodywork.target!.wiperBladesFront,
              'wiper_blades_front_comments': controlForm.carBodywork.target!.wiperBladesFrontComments,
              'wiper_blades_front_image': controlForm.carBodywork.target!.wiperBladesFrontImages.isEmpty == true ? null : wiperBladesFrontImages,
              'wiper_blades_back': controlForm.carBodywork.target!.wiperBladesBack,
              'wiper_blades_back_comments': controlForm.carBodywork.target!.wiperBladesBackComments,
              'wiper_blades_back_image': controlForm.carBodywork.target?.wiperBladesBackImages.isEmpty == true ? null : wiperBladesBackImages,
              'windshield_wiper_front': controlForm.carBodywork.target!.windshieldWiperFront,
              'windshield_wiper_front_comments': controlForm.carBodywork.target!.windshieldWiperFrontComments,
              'windshield_wiper_front_image': controlForm.carBodywork.target?.windshieldWiperFrontImages.isEmpty == true ? null : windshieldWiperFrontImages,
              'windshield_wiper_back': controlForm.carBodywork.target!.windshieldWiperBack,
              'windshield_wiper_back_comments': controlForm.carBodywork.target!.windshieldWiperBackComments,
              'windshield_wiper_back_image': controlForm.carBodywork.target?.windshieldWiperBackImages.isEmpty == true ? null : windshieldWiperBackImages,
              'general_body': controlForm.carBodywork.target!.generalBody,
              'general_body_comments': controlForm.carBodywork.target!.generalBodyComments,
              'general_body_image': controlForm.carBodywork.target?.generalBodyImages.isEmpty == true ? null : generalBodyImages,
              'decaling': controlForm.carBodywork.target!.decaling,
              'decaling_comments': controlForm.carBodywork.target!.decalingComments,
              'decaling_image': controlForm.carBodywork.target?.decalingImages.isEmpty == true ? null : decalingImages,
              'tires': controlForm.carBodywork.target!.tires,
              'tires_comments': controlForm.carBodywork.target!.tiresComments,
              'tires_image': controlForm.carBodywork.target?.tiresImages.isEmpty == true ? null : tiresImages,
              'glass': controlForm.carBodywork.target!.glass,
              'glass_comments': controlForm.carBodywork.target!.glassComments,
              'glass_image': controlForm.carBodywork.target?.glassImages.isEmpty == true ? null : glassImages,
              'mirrors': controlForm.carBodywork.target!.mirrors,
              'mirrors_comments': controlForm.carBodywork.target!.mirrorsComments,
              'mirrors_image': controlForm.carBodywork.target?.mirrorsImages.isEmpty == true ? null : mirrorsImages,
              'parking': controlForm.carBodywork.target!.parking,
              'parking_comments': controlForm.carBodywork.target!.parkingComments,
              'parking_image': controlForm.carBodywork.target?.parkingImages.isEmpty == true ? null : parkingImages,
              'brakes': controlForm.carBodywork.target!.brakes,
              'brakes_comments': controlForm.carBodywork.target!.brakesComments,
              'brakes_image': controlForm.carBodywork.target?.brakesImages.isEmpty == true ? null : brakesImages,
              'emg_brakes': controlForm.carBodywork.target!.emgBrakes,
              'emg_brakes_comments': controlForm.carBodywork.target!.emgBrakesComments,
              'emg_brakes_image': controlForm.carBodywork.target?.emgBrakesImages.isEmpty == true ? null : emgBrakesImages,
              'horn': controlForm.carBodywork.target!.horn,
              'horn_comments': controlForm.carBodywork.target!.hornComments,
              'horn_image': controlForm.carBodywork.target?.hornImages.isEmpty == true ? null : hornImages,
              'date_added': controlForm.carBodywork.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_car_bodywork');
          //Registrar fluids check
          if (controlForm.fluidsCheck.target!.engineOilImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.engineOilImages.toList()) {
              engineOilImages = "$engineOilImages$element|";
            }
          }
          if (controlForm.fluidsCheck.target!.transmissionImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.transmissionImages.toList()) {
              transmissionImages = "$transmissionImages$element|";
            }
          }
          if (controlForm.fluidsCheck.target!.coolantImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.coolantImages.toList()) {
              coolantImages = "$coolantImages$element|";
            }
          }
          if (controlForm.fluidsCheck.target!.powerSteeringImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.powerSteeringImages.toList()) {
              powerSteeringImages = "$powerSteeringImages$element|";
            }
          }
          if (controlForm.fluidsCheck.target!.dieselExhaustFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.dieselExhaustFluidImages.toList()) {
              dieselExhaustFluidImages = "$dieselExhaustFluidImages$element|";
            }
          }
          if (controlForm.fluidsCheck.target!.windshieldWasherFluidImages.isNotEmpty) {
            for (var element in controlForm.fluidsCheck.target!.windshieldWasherFluidImages.toList()) {
              windshieldWasherFluidImages = "$windshieldWasherFluidImages$element|";
            }
          }
          final recordFluidsCheck = await supabaseCtrlV.from('fluids_check').insert(
            {
              'engine_oil': controlForm.fluidsCheck.target!.engineOil,
              'engine_oil_comments': controlForm.fluidsCheck.target!.engineOilComments,
              'engine_oil_image': controlForm.fluidsCheck.target!.engineOilImages.isEmpty == true ? null : engineOilImages,
              'transmission': controlForm.fluidsCheck.target!.transmission,
              'transmission_comments': controlForm.fluidsCheck.target!.transmissionComments,
              'transmission_image': controlForm.fluidsCheck.target?.transmissionImages.isEmpty == true ? null : transmissionImages,
              'coolant': controlForm.fluidsCheck.target!.coolant,
              'coolant_comments': controlForm.fluidsCheck.target!.coolantComments,
              'coolant_image': controlForm.fluidsCheck.target?.coolantImages.isEmpty == true ? null : coolantImages,
              'power_steering': controlForm.fluidsCheck.target!.powerSteering,
              'power_steering_comments': controlForm.fluidsCheck.target!.powerSteeringComments,
              'power_steering_image': controlForm.fluidsCheck.target?.powerSteeringImages.isEmpty == true ? null : powerSteeringImages,
              'diesel_exhaust_fluid': controlForm.fluidsCheck.target!.dieselExhaustFluid,
              'diesel_exhaust_fluid_comments': controlForm.fluidsCheck.target!.dieselExhaustFluidComments,
              'diesel_exhaust_fluid_image': controlForm.fluidsCheck.target?.dieselExhaustFluidImages.isEmpty == true ? null : dieselExhaustFluidImages,
              'windshield_washer_fluid': controlForm.fluidsCheck.target!.windshieldWasherFluid,
              'windshield_washer_fluid_comments': controlForm.fluidsCheck.target!.windshieldWasherFluidComments,
              'windshield_washer_fluid_image': controlForm.fluidsCheck.target?.windshieldWasherFluidImages.isEmpty == true ? null : windshieldWasherFluidImages,
              'date_added': controlForm.fluidsCheck.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_fluids_check');
          //Registrar bucket inspection
          if (controlForm.bucketInspection.target!.insulatedImages.isNotEmpty) {
            for (var element in controlForm.bucketInspection.target!.insulatedImages.toList()) {
              insulatedImages = "$insulatedImages$element|";
            }
          }
          if (controlForm.bucketInspection.target!.holesDrilledImages.isNotEmpty) {
            for (var element in controlForm.bucketInspection.target!.holesDrilledImages.toList()) {
              holesDrilledImages = "$holesDrilledImages$element|";
            }
          }
          if (controlForm.bucketInspection.target!.bucketLinerImages.isNotEmpty) {
            for (var element in controlForm.bucketInspection.target!.bucketLinerImages.toList()) {
              bucketLinerImages = "$bucketLinerImages$element|";
            }
          }
          final recordBucketInspection = await supabaseCtrlV.from('bucket_inspection').insert(
            {
              'insulated': controlForm.bucketInspection.target!.insulated,
              'insulated_comments': controlForm.bucketInspection.target!.insulatedComments,
              'insulated_image': controlForm.bucketInspection.target!.insulatedImages.isEmpty == true ? null : insulatedImages,
              'holes_drilled': controlForm.bucketInspection.target!.holesDrilled,
              'holes_drilled_comments': controlForm.bucketInspection.target!.holesDrilledComments,
              'holes_drilled_image': controlForm.bucketInspection.target?.holesDrilledImages.isEmpty == true ? null : holesDrilledImages,
              'bucket_liner': controlForm.bucketInspection.target!.bucketLiner,
              'bucket_liner_comments': controlForm.bucketInspection.target!.bucketLinerComments,
              'bucket_liner_image': controlForm.bucketInspection.target?.bucketLinerImages.isEmpty == true ? null : bucketLinerImages,
              'date_added': controlForm.bucketInspection.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_bucket_inspection');
          //Registrar security
          if (controlForm.security.target!.rtaMagnetImages.isNotEmpty) {
            for (var element in controlForm.security.target!.rtaMagnetImages.toList()) {
              rtaMagnetImages = "$rtaMagnetImages$element|";
            }
          }
          if (controlForm.security.target!.triangleReflectorsImages.isNotEmpty) {
            for (var element in controlForm.security.target!.triangleReflectorsImages.toList()) {
              triangleReflectorsImages = "$triangleReflectorsImages$element|";
            }
          }
          if (controlForm.security.target!.wheelChocksImages.isNotEmpty) {
            for (var element in controlForm.security.target!.wheelChocksImages.toList()) {
              wheelChocksImages = "$wheelChocksImages$element|";
            }
          }
          if (controlForm.security.target!.fireExtinguisherImages.isNotEmpty) {
            for (var element in controlForm.security.target!.fireExtinguisherImages.toList()) {
              fireExtinguisherImages = "$fireExtinguisherImages$element|";
            }
          }
          if (controlForm.security.target!.firstAidKitSafetyVestImages.isNotEmpty) {
            for (var element in controlForm.security.target!.firstAidKitSafetyVestImages.toList()) {
              firstAidKitSafetyVestImages = "$firstAidKitSafetyVestImages$element|";
            }
          }
          if (controlForm.security.target!.backUpAlarmImages.isNotEmpty) {
            for (var element in controlForm.security.target!.backUpAlarmImages.toList()) {
              backUpAlarmImages = "$backUpAlarmImages$element|";
            }
          }
          final recordSecurity = await supabaseCtrlV.from('security').insert(
            {
              'rta_magnet': controlForm.security.target!.rtaMagnet,
              'rta_magnet_comments': controlForm.security.target!.rtaMagnetComments,
              'rta_magnet_image': controlForm.security.target!.rtaMagnetImages.isEmpty == true ? null : rtaMagnetImages,
              'triangle_reflectors': controlForm.security.target!.triangleReflectors,
              'triangle_reflectors_comments': controlForm.security.target!.triangleReflectorsComments,
              'triangle_reflectors_image': controlForm.security.target?.triangleReflectorsImages.isEmpty == true ? null : triangleReflectorsImages,
              'wheel_chocks': controlForm.security.target!.wheelChocks,
              'wheel_chocks_comments': controlForm.security.target!.wheelChocksComments,
              'wheel_chocks_image': controlForm.security.target?.wheelChocksImages.isEmpty == true ? null : wheelChocksImages,
              'fire_extinguisher': controlForm.security.target!.fireExtinguisher,
              'fire_extinguisher_comments': controlForm.security.target!.fireExtinguisherComments,
              'fire_extinguisher_image': controlForm.security.target?.fireExtinguisherImages.isEmpty == true ? null : fireExtinguisherImages,
              'first_aid_kit_safety_vest': controlForm.security.target!.firstAidKitSafetyVest,
              'first_aid_kit_safety_vest_comments': controlForm.security.target!.firstAidKitSafetyVestComments,
              'first_aid_kit_safety_vest_image': controlForm.security.target?.firstAidKitSafetyVestImages.isEmpty == true ? null : firstAidKitSafetyVestImages,
              'back_up_alarm': controlForm.security.target!.backUpAlarm,
              'back_up_alarm_comments': controlForm.security.target!.backUpAlarmComments,
              'back_up_alarm_image': controlForm.security.target?.backUpAlarmImages.isEmpty == true ? null : backUpAlarmImages,
              'date_added': controlForm.security.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_security');
          //Registrar extra
          if (controlForm.extra.target!.ladderImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.ladderImages.toList()) {
              ladderImages = "$ladderImages$element|";
            }
          }
          if (controlForm.extra.target!.stepLadderImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.stepLadderImages.toList()) {
              stepLadderImages = "$stepLadderImages$element|";
            }
          }
          if (controlForm.extra.target!.ladderStrapsImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.ladderStrapsImages.toList()) {
              ladderStrapsImages = "$ladderStrapsImages$element|";
            }
          }
          if (controlForm.extra.target!.hydraulicFluidForBucketImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.hydraulicFluidForBucketImages.toList()) {
              hydraulicFluidForBucketImages = "$hydraulicFluidForBucketImages$element|";
            }
          }
          if (controlForm.extra.target!.fiberReelRackImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.fiberReelRackImages.toList()) {
              fiberReelRackImages = "$fiberReelRackImages$element|";
            }
          }
          if (controlForm.extra.target!.binsLockedAndSecureImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.binsLockedAndSecureImages.toList()) {
              binsLockedAndSecureImages = "$binsLockedAndSecureImages$element|";
            }
          }
          if (controlForm.extra.target!.safetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.safetyHarnessImages.toList()) {
              safetyHarnessImages = "$safetyHarnessImages$element|";
            }
          }
          if (controlForm.extra.target!.lanyardSafetyHarnessImages.isNotEmpty) {
            for (var element in controlForm.extra.target!.lanyardSafetyHarnessImages.toList()) {
              lanyardSafetyHarnessImages = "$lanyardSafetyHarnessImages$element|";
            }
          }
          final recordExtra = await supabaseCtrlV.from('extra').insert(
            {
              'ladder': controlForm.extra.target!.ladder,
              'ladder_comments': controlForm.extra.target!.ladderComments,
              'ladder_image': controlForm.extra.target!.ladderImages.isEmpty == true ? null : ladderImages,
              'step_ladder': controlForm.extra.target!.stepLadder,
              'step_ladder_comments': controlForm.extra.target!.stepLadderComments,
              'step_ladder_image': controlForm.extra.target?.stepLadderImages.isEmpty == true ? null : stepLadderImages,
              'ladder_straps': controlForm.extra.target!.ladderStraps,
              'ladder_straps_comments': controlForm.extra.target!.ladderStrapsComments,
              'ladder_straps_image': controlForm.extra.target?.ladderStrapsImages.isEmpty == true ? null : ladderStrapsImages,
              'hydraulic_fluid_for_bucket': controlForm.extra.target!.hydraulicFluidForBucket,
              'hydraulic_fluid_for_bucket_comments': controlForm.extra.target!.hydraulicFluidForBucketComments,
              'hydraulic_fluid_for_bucket_image': controlForm.extra.target?.hydraulicFluidForBucketImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'fiber_reel_rack': controlForm.extra.target!.fiberReelRack,
              'fiber_reel_rack_comments': controlForm.extra.target!.fiberReelRackComments,
              'fiber_reel_rack_image': controlForm.extra.target?.fiberReelRackImages.isEmpty == true ? null : fiberReelRackImages,
              'bins_locked_and_secure': controlForm.extra.target!.binsLockedAndSecure,
              'bins_locked_and_secure_comments': controlForm.extra.target!.binsLockedAndSecureComments,
              'bins_locked_and_secure_image': controlForm.extra.target?.binsLockedAndSecureImages.isEmpty == true ? null : binsLockedAndSecureImages,
              'safety_harness': controlForm.extra.target!.safetyHarness,
              'safety_harness_comments': controlForm.extra.target!.safetyHarnessComments,
              'safety_harness_image': controlForm.extra.target?.safetyHarnessImages.isEmpty == true ? null : safetyHarnessImages,
              'lanyard_safety_harness': controlForm.extra.target!.lanyardSafetyHarness,
              'lanyard_safety_harness_comments': controlForm.extra.target!.lanyardSafetyHarnessComments,
              'lanyard_safety_harness_image': controlForm.extra.target?.lanyardSafetyHarnessImages.isEmpty == true ? null : lanyardSafetyHarnessImages,
              'date_added': controlForm.extra.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_extra');
          //Registrar equipment
          if (controlForm.equipment.target!.ignitionKeyImages.isNotEmpty) {
            for (var element in controlForm.equipment.target!.ignitionKeyImages.toList()) {
              ignitionKeyImages = "$ignitionKeyImages$element|";
            }
          }
          if (controlForm.equipment.target!.binsBoxKeyImages.isNotEmpty) {
            for (var element in controlForm.equipment.target!.binsBoxKeyImages.toList()) {
              binsBoxKeyImages = "$binsBoxKeyImages$element|";
            }
          }
          if (controlForm.equipment.target!.vehicleInsuranceCopyImages.isNotEmpty) {
            for (var element in controlForm.equipment.target!.vehicleInsuranceCopyImages.toList()) {
              vehicleInsuranceCopyImages = "$vehicleInsuranceCopyImages$element|";
            }
          }
          if (controlForm.equipment.target!.vehicleRegistrationCopyImages.isNotEmpty) {
            for (var element in controlForm.equipment.target!.vehicleRegistrationCopyImages.toList()) {
              vehicleRegistrationCopyImages = "$vehicleRegistrationCopyImages$element|";
            }
          }
          if (controlForm.equipment.target!.bucketLiftOperatorManualImages.isNotEmpty) {
            for (var element in controlForm.equipment.target!.bucketLiftOperatorManualImages.toList()) {
              bucketLiftOperatorManualImages = "$bucketLiftOperatorManualImages$element|";
            }
          }
          final recordEquipment = await supabaseCtrlV.from('equipment').insert(
            {
              'ignition_key': controlForm.equipment.target!.ignitionKey,
              'ignition_key_comments': controlForm.equipment.target!.ignitionKeyComments,
              'ignition_key_image': controlForm.equipment.target?.ignitionKeyImages.isEmpty == true ? null : ignitionKeyImages,
              'bins_box_key': controlForm.equipment.target!.binsBoxKey,
              'bins_box_key_comments': controlForm.equipment.target!.binsBoxKeyComments,
              'bins_box_key_image': controlForm.equipment.target?.binsBoxKeyImages.isEmpty == true ? null : hydraulicFluidForBucketImages,
              'vehicle_registration_copy': controlForm.equipment.target!.vehicleInsuranceCopy,
              'vehicle_registration_copy_comments': controlForm.equipment.target!.vehicleInsuranceCopyComments,
              'vehicle_registration_copy_image': controlForm.equipment.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'vehicle_insurance_copy': controlForm.equipment.target!.vehicleInsuranceCopy,
              'vehicle_insurance_copy_comments': controlForm.equipment.target!.vehicleInsuranceCopyComments,
              'vehicle_insurance_copy_image': controlForm.equipment.target?.vehicleInsuranceCopyImages.isEmpty == true ? null : vehicleInsuranceCopyImages,
              'bucket_lift_operator_manual': controlForm.equipment.target!.bucketLiftOperatorManual,
              'bucket_lift_operator_manual_comments': controlForm.equipment.target!.bucketLiftOperatorManualComments,
              'bucket_lift_operator_manual_image': controlForm.equipment.target?.bucketLiftOperatorManualImages.isEmpty == true ? null : bucketLiftOperatorManualImages,
              'date_added': controlForm.equipment.target!.dateAdded.toIso8601String(),
            },
          ).select<PostgrestList>('id_equipment');
          if (recordMeasure.isNotEmpty && recordLights.isNotEmpty && recordCarBodywork.isNotEmpty && recordFluidsCheck.isNotEmpty 
              && recordBucketInspection.isNotEmpty && recordSecurity.isNotEmpty && recordExtra.isNotEmpty && recordEquipment.isNotEmpty) {
            final recordControlForm = await supabaseCtrlV.from('control_form').insert(
              {
                'id_vehicle_fk': controlForm.vehicle.target!.idDBR,
                'id_user_fk': controlForm.employee.target!.idDBR,
                'type_form': controlForm.typeForm,
                'id_measure_fk': recordMeasure.first['id_measure'],
                'id_lights_fk': recordLights.first['id_lights'],
                'id_car_bodywork_fk': recordCarBodywork.first['id_car_bodywork'],
                'id_fluids_check_fk': recordFluidsCheck.first['id_fluids_check'],
                'id_bucket_inspection_fk': recordBucketInspection.first['id_bucket_inspection'],
                'id_security_fk': recordSecurity.first['id_security'],
                'id_extra_fk': recordExtra.first['id_extra'],
                'id_equipment_fk': recordEquipment.first['id_equipment'],
                'issues': controlForm.issues,
                'date_added': controlForm.dateAdded.toIso8601String(),
              },
            ).select<PostgrestList>('id_control_form');
            //Registrar control Form
            if (recordControlForm.isNotEmpty) {
              //Se recupera el idDBR de Supabase de Measure
              controlForm.measures.target!.idDBR = recordMeasure.first['id_measure'].toString();
              dataBase.measuresFormBox.put(controlForm.measures.target!);
              //Se recupera el idDBR de Supabase de Lights
              controlForm.lights.target!.idDBR = recordLights.first['id_lights'].toString();
              dataBase.lightsFormBox.put(controlForm.lights.target!);
              //Se recupera el idDBR de Supabase de Car Bodywork
              controlForm.carBodywork.target!.idDBR = recordCarBodywork.first['id_car_bodywork'].toString();
              dataBase.carBodyworkFormBox.put(controlForm.carBodywork.target!);
              //Se recupera el idDBR de Supabase de Fluids Check
              controlForm.fluidsCheck.target!.idDBR = recordFluidsCheck.first['id_fluids_check'].toString();
              dataBase.fluidsCheckFormBox.put(controlForm.fluidsCheck.target!);
              //Se recupera el idDBR de Supabase de Bucket Inspection
              controlForm.bucketInspection.target!.idDBR = recordBucketInspection.first['id_bucket_inspection'].toString();
              dataBase.bucketInspectionFormBox.put(controlForm.bucketInspection.target!);
              //Se recupera el idDBR de Supabase de Security
              controlForm.security.target!.idDBR = recordSecurity.first['id_security'].toString();
              dataBase.securityFormBox.put(controlForm.security.target!);
              //Se recupera el idDBR de Supabase de Extra
              controlForm.extra.target!.idDBR = recordExtra.first['id_extra'].toString();
              dataBase.extraFormBox.put(controlForm.extra.target!);
              //Se recupera el idDBR de Supabase de Equipment
              controlForm.equipment.target!.idDBR = recordEquipment.first['id_equipment'].toString();
              dataBase.equipmentFormBox.put(controlForm.equipment.target!);
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
