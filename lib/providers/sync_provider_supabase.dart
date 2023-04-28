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
              dataBase.vehiculoBox.getAll(), instruccionesBitacora[i].id);
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
        case "syncAgregarOrdenTrabajo":
          final ordenTrabajoToSync = getFirstOrdenTrabajo(
              dataBase.ordenTrabajoBox.getAll(), instruccionesBitacora[i].id);
          if (ordenTrabajoToSync != null) {
            final responseSyncAddOrdenTrabajo = await syncAddOrdenTrabajo(
                ordenTrabajoToSync, instruccionesBitacora[i]);
            if (responseSyncAddOrdenTrabajo.exitoso) {
              banderasExistoSync.add(responseSyncAddOrdenTrabajo.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddOrdenTrabajo.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddOrdenTrabajo.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una orden de trabajo no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarObservacion":
          final observacionToSync = getFirstObservacion(
              dataBase.observacionesBox.getAll(), instruccionesBitacora[i].id);
          if (observacionToSync != null) {
            final responseSyncAddObservacion = await syncAddObservacion(
                observacionToSync, instruccionesBitacora[i]);
            if (responseSyncAddObservacion.exitoso) {
              banderasExistoSync.add(responseSyncAddObservacion.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddObservacion.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddObservacion.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una observación no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarRevision":
          final revisionToSync = getFirstRevision(
              dataBase.revisionBox.getAll(), instruccionesBitacora[i].id);
          if (revisionToSync != null) {
            final responseSyncAddRevision = await syncAddRevision(
                revisionToSync, instruccionesBitacora[i]);
            if (responseSyncAddRevision.exitoso) {
              banderasExistoSync.add(responseSyncAddRevision.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddRevision.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddRevision.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una observación no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
          case "syncAgregarSuspensionDireccion":
          final suspensionDireccionToSync = getFirstSuspensionDireccion(
              dataBase.suspensionDireccionBox.getAll(), instruccionesBitacora[i].id);
          if (suspensionDireccionToSync != null) {
            final responseSyncAddSuspensionDireccion = await syncAddSuspensionDireccion(
                suspensionDireccionToSync, instruccionesBitacora[i]);
            if (responseSyncAddSuspensionDireccion.exitoso) {
              banderasExistoSync.add(responseSyncAddSuspensionDireccion.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddSuspensionDireccion.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddSuspensionDireccion.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una Revisión de la suspensión y dirección no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarElectrico":
          final electricoToSync = getFirstElectrico(
              dataBase.electricoBox.getAll(), instruccionesBitacora[i].id);
          if (electricoToSync != null) {
            final responseSyncAddElectrico = await syncAddElectrico(
                electricoToSync, instruccionesBitacora[i]);
            if (responseSyncAddElectrico.exitoso) {
              banderasExistoSync.add(responseSyncAddElectrico.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddElectrico.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddElectrico.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una Revisión del sistema eléctrico no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarFluidos":
          final fluidosToSync = getFirstFluido(
              dataBase.fluidosBox.getAll(), instruccionesBitacora[i].id);
          if (fluidosToSync != null) {
            final responseSyncAddFluido = await syncAddFluido(
                fluidosToSync, instruccionesBitacora[i]);
            if (responseSyncAddFluido.exitoso) {
              banderasExistoSync.add(responseSyncAddFluido.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddFluido.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddFluido.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una Revisión de los fluidos no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarFrenos":
          final frenosToSync = getFirstFreno(
              dataBase.frenosBox.getAll(), instruccionesBitacora[i].id);
          if (frenosToSync != null) {
            final responseSyncAddFreno = await syncAddFreno(
                frenosToSync, instruccionesBitacora[i]);
            if (responseSyncAddFreno.exitoso) {
              banderasExistoSync.add(responseSyncAddFreno.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddFreno.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddFreno.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una Revisión de los frenos no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncAgregarMotor":
          final motorToSync = getFirstMotor(
              dataBase.motorBox.getAll(), instruccionesBitacora[i].id);
          if (motorToSync != null) {
            final responseSyncAddMotor = await syncAddMotor(
                motorToSync, instruccionesBitacora[i]);
            if (responseSyncAddMotor.exitoso) {
              banderasExistoSync.add(responseSyncAddMotor.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncAddMotor.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncAddMotor.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local una Revisión del motor no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncActualizarEstatusOrdenTrabajo":
          final ordenTrabajoToSync = getFirstOrdenTrabajo(
              dataBase.ordenTrabajoBox.getAll(), instruccionesBitacora[i].id);
          if (ordenTrabajoToSync != null) {
            final responseSyncUpdateEstatusOrdenTrabajo = await syncUpdateEstatusOrdenTrabajo(
                ordenTrabajoToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateEstatusOrdenTrabajo.exitoso) {
              banderasExistoSync.add(responseSyncUpdateEstatusOrdenTrabajo.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateEstatusOrdenTrabajo.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncUpdateEstatusOrdenTrabajo.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local el estatus de una orden de trabajo no recuperada.",
                fecha: instruccionesBitacora[i].fechaRegistro);
            instruccionesFallidas.add(instruccionNoSincronizada);
            continue;
          }
        case "syncActualizarRevision":
          final revisionToSync = getFirstRevision(
              dataBase.revisionBox.getAll(), instruccionesBitacora[i].id);
          if (revisionToSync != null) {
            final responseSyncUpdateRevision = await syncUpdateRevision(
                revisionToSync, instruccionesBitacora[i]);
            if (responseSyncUpdateRevision.exitoso) {
              banderasExistoSync.add(responseSyncUpdateRevision.exitoso);
              continue;
            } else {
              //Recuperamos la instrucción que no se ejecutó
              banderasExistoSync.add(responseSyncUpdateRevision.exitoso);
              final instruccionNoSincronizada = InstruccionNoSincronizada(
                  instruccion: responseSyncUpdateRevision.descripcion,
                  fecha: instruccionesBitacora[i].fechaRegistro);
              instruccionesFallidas.add(instruccionNoSincronizada);
              continue;
            }
          } else {
            //Recuperamos la instrucción que no se ejecutó
            banderasExistoSync.add(false);
            final instruccionNoSincronizada = InstruccionNoSincronizada(
                instruccion:
                    "Problemas en sincronizar al Servidor Local la actualización de la Revisión no recuperada.",
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

  Vehiculo? getFirstVehiculo(
      List<Vehiculo> vehiculos, int idInstruccionesBitacora) {
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

  OrdenTrabajo? getFirstOrdenTrabajo(
      List<OrdenTrabajo> ordenesTrabajo, int idInstruccionesBitacora) {
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

  Observaciones? getFirstObservacion(
      List<Observaciones> observaciones, int idInstruccionesBitacora) {
    for (var i = 0; i < observaciones.length; i++) {
      if (observaciones[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < observaciones[i].bitacora.length; j++) {
          if (observaciones[i].bitacora[j].id == idInstruccionesBitacora) {
            return observaciones[i];
          }
        }
      }
    }
    return null;
  }

  Revision? getFirstRevision(
      List<Revision> revision, int idInstruccionesBitacora) {
    for (var i = 0; i < revision.length; i++) {
      if (revision[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < revision[i].bitacora.length; j++) {
          if (revision[i].bitacora[j].id == idInstruccionesBitacora) {
            return revision[i];
          }
        }
      }
    }
    return null;
  }

  SuspensionDireccion? getFirstSuspensionDireccion(
      List<SuspensionDireccion> suspensionDireccion, int idInstruccionesBitacora) {
    for (var i = 0; i < suspensionDireccion.length; i++) {
      if (suspensionDireccion[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < suspensionDireccion[i].bitacora.length; j++) {
          if (suspensionDireccion[i].bitacora[j].id == idInstruccionesBitacora) {
            return suspensionDireccion[i];
          }
        }
      }
    }
    return null;
  }

  Electrico? getFirstElectrico(
      List<Electrico> electrico, int idInstruccionesBitacora) {
    for (var i = 0; i < electrico.length; i++) {
      if (electrico[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < electrico[i].bitacora.length; j++) {
          if (electrico[i].bitacora[j].id == idInstruccionesBitacora) {
            return electrico[i];
          }
        }
      }
    }
    return null;
  }

  Fluidos? getFirstFluido(
      List<Fluidos> fluidos, int idInstruccionesBitacora) {
    for (var i = 0; i < fluidos.length; i++) {
      if (fluidos[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < fluidos[i].bitacora.length; j++) {
          if (fluidos[i].bitacora[j].id == idInstruccionesBitacora) {
            return fluidos[i];
          }
        }
      }
    }
    return null;
  }

  Frenos? getFirstFreno(
      List<Frenos> frenos, int idInstruccionesBitacora) {
    for (var i = 0; i < frenos.length; i++) {
      if (frenos[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < frenos[i].bitacora.length; j++) {
          if (frenos[i].bitacora[j].id == idInstruccionesBitacora) {
            return frenos[i];
          }
        }
      }
    }
    return null;
  }

  Motor? getFirstMotor(
      List<Motor> motor, int idInstruccionesBitacora) {
    for (var i = 0; i < motor.length; i++) {
      if (motor[i].bitacora.isEmpty) {
      } else {
        for (var j = 0; j < motor[i].bitacora.length; j++) {
          if (motor[i].bitacora[j].id == idInstruccionesBitacora) {
            return motor[i];
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
                    'perfil_usuario_id': clienteId,
                    'nombre': usuario.nombre,
                    'apellido_p': usuario.apellidoP,
                    'apellido_m': usuario.apellidoM,
                    'imagen': usuario.imagen,
                    'rol_fk': usuario.rol.target!.idDBR,
                    'asesor_fk': usuario.asesor.target!.idDBR,
                    'rfc': usuario.rfc,
                    'telefono': usuario.telefono,
                    'celular': usuario.celular,
                    'domicilio': usuario.domicilio,
                  },
                ).select<PostgrestList>('perfil_usuario_id');
                if (recordCliente.isNotEmpty) {
                  //Se recupera el idDBR de Supabase del Usuario
                  usuario.idDBR = recordCliente.first['perfil_usuario_id'].toString();
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
                  'perfil_usuario_id': clienteId,
                  'nombre': usuario.nombre,
                  'apellido_p': usuario.apellidoP,
                  'apellido_m': usuario.apellidoM,
                  'imagen': usuario.imagen,
                  'rol_fk': usuario.rol.target!.idDBR,
                  'asesor_fk': usuario.asesor.target!.idDBR,
                  'rfc': usuario.rfc,
                  'telefono': usuario.telefono,
                  'celular': usuario.celular,
                  'domicilio': usuario.domicilio,
                },
              ).select<PostgrestList>('perfil_usuario_id');
              if (recordCliente.isNotEmpty) {
                //Se recupera el idDBR de Supabase del Usuario
                usuario.idDBR = recordCliente.first['perfil_usuario_id'].toString();
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
      Vehiculo vehiculo, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (vehiculo.idDBR == null) {
          //Registrar el vehiculo
          final recordVehiculo = await supabaseClient.from('vehiculo').insert(
            {
              'marca': vehiculo.marca,
              'modelo': vehiculo.modelo,
              'anio': vehiculo.anio,
              'imagen': vehiculo.imagen,
              'vin': vehiculo.vin,
              'placas': vehiculo.placas,
              'color': vehiculo.color,
              'motor': vehiculo.motor,
              'id_cliente_fk': vehiculo.cliente.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordVehiculo.isNotEmpty) {
            //Se recupera el idDBR de Supabase del Vehiculo
            vehiculo.idDBR = recordVehiculo.first['id'].toString();
            dataBase.vehiculoBox.put(vehiculo);
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

  Future<SyncInstruction> syncAddOrdenTrabajo(
      OrdenTrabajo ordenTrabajo, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (ordenTrabajo.idDBR == null) {
          //Registrar el orden Trabajo
          final recordOrdenTrabajo = await supabaseClient.from('orden_trabajo').insert(
            {
              'id_estatus_fk': ordenTrabajo.estatus.target!.idDBR,
              'kilometraje': ordenTrabajo.kilometrajeMillaje,
              'gasolina': ordenTrabajo.gasolina,
              'id_asesor_fk': ordenTrabajo.asesor.target!.idDBR,
              'id_vehiculo_fk': ordenTrabajo.vehiculo.target!.idDBR,
              'fecha_orden': ordenTrabajo.fechaOrden.toIso8601String(),
              'descripcion_falla': ordenTrabajo.descripcionFalla,
              'id_cliente_fk': ordenTrabajo.cliente.target!.idDBR,
              'completado': ordenTrabajo.completado,
            },
          ).select<PostgrestList>('id');
          if (recordOrdenTrabajo.isNotEmpty) {
            //Se recupera el idDBR de Supabase del Vehiculo
            ordenTrabajo.idDBR = recordOrdenTrabajo.first['id'].toString();
            dataBase.ordenTrabajoBox.put(ordenTrabajo);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Orden Trabajo en el Servidor Local: Problema al postear los datos de la orden de Trabajo del vehiculo con VIN '${ordenTrabajo.vehiculo.target?.vin}'.");
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
              "Falló en proceso de sincronizar alta de de Orden de Trabajo del Vehiculo con VIN '${ordenTrabajo.vehiculo.target?.vin}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddObservacion(
      Observaciones observacion, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (observacion.idDBR == null) {
          //Registrar el orden Trabajo
          final recordObservacion = await supabaseClient.from('observaciones').insert(
            {
              'fecha_observacion': observacion.fechaObservacion.toIso8601String(),
              'nombre_asesor': observacion.nombreAsesor,
              'p1_observacion': observacion.respuestaP1,
              'p2_observacion': observacion.respuestaP2,
              'p3_observacion': observacion.respuestaP3,
              'p4_observacion': observacion.respuestaP4,
              'p5_observacion': observacion.respuestaP5,
              'p6_observacion': observacion.respuestaP6,
              'p7_observacion': observacion.respuestaP7,
              'p8_observacion': observacion.respuestaP8,
              'p9_observacion': observacion.respuestaP9,
              'p10_observacion': observacion.respuestaP10,
              'id_orden_trabajo_fk': observacion.ordenTrabajo.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordObservacion.isNotEmpty) {
            //Se recupera el idDBR de Supabase de la Observación
            observacion.idDBR = recordObservacion.first['id'].toString();
            dataBase.observacionesBox.put(observacion);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Observación en el Servidor Local: Problema al postear los datos de la observación de la Orden de Trabajo con id Local '${observacion.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Observación de la orden de trabajo con id Local '${observacion.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddRevision(
      Revision revision, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (revision.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('revision').insert(
            {
              'created_at': revision.fechaRegistro.toIso8601String(),
              'completado': false,
              'id_orden_trabajo_fk': revision.ordenTrabajo.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase de la Observación
            revision.idDBR = recordRevision.first['id'].toString();
            dataBase.revisionBox.put(revision);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión en el Servidor Local: Problema al postear los datos de la Revisión de la Orden de Trabajo con id Local '${revision.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión de la orden de trabajo con id Local '${revision.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddSuspensionDireccion(
      SuspensionDireccion suspensionDireccion, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (suspensionDireccion.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('suspension_direccion').insert(
            {
              'created_at': suspensionDireccion.fechaRegistro.toIso8601String(),
              'amortiguador_trasero_der': suspensionDireccion.amortiguadorTraseroDer,
              'rotula_superior_izq': suspensionDireccion.rotulaSuperiorIzq,
              'buje_barra_estabilizadora_izq': suspensionDireccion.bujeBarraEstabilizadoraIzq,
              'rotula_superior_der': suspensionDireccion.rotulaSuperiorDer,
              'buje_barra_estabilizadora_der': suspensionDireccion.bujeBarraEstabilizadoraDer,
              'rotula_inferior_izq': suspensionDireccion.rotulaInferiorIzq,
              'link_kit_delantero_izq': suspensionDireccion.linkKitDelanteroIzq,
              'rotula_inferior_der': suspensionDireccion.rotulaInferiorDer,
              'link_kit_delantero_der': suspensionDireccion.linkKitDelanteroDer,
              'buje_horquilla_superior_izq': suspensionDireccion.bujeHorquillaSuperiorIzq,
              'link_kit_trasero_izq': suspensionDireccion.linkKitDelanteroIzq,
              'buje_horquilla_superior_der': suspensionDireccion.bujeHorquillaSuperiorDer,
              'link_kit_trasero_der': suspensionDireccion.linkKitTraseroDer,
              'buje_horquilla_inferior_izq': suspensionDireccion.bujeHorquillaInferiorIzq,
              'amortiguador_trasero_der_o': suspensionDireccion.amortiguadorTraseroDerObservaciones,
              'terminal_interior_izq': suspensionDireccion.terminalInteriorIzq,
              'buje_horquilla_inferior_der': suspensionDireccion.bujeHorquillaInferiorDer,
              'terminal_interior_der': suspensionDireccion.terminalInteriorDer,
              'amortiguador_delantero_izq': suspensionDireccion.amortiguadorDelanteroIzq,
              'terminal_exterior_izq': suspensionDireccion.terminalExteriorIzq,
              'amortiguador_delantero_der': suspensionDireccion.amortiguadorDelanteroDer,
              'terminal_exterior_der': suspensionDireccion.terminalExteriorDer,
              'amortiguador_trasero_izq': suspensionDireccion.amortiguadorTraseroIzq,
              'amortiguador_trasero_izq_o': suspensionDireccion.amortiguadorTraseroIzqObservaciones,
              'rotula_superior_izq_o': suspensionDireccion.rotulaSuperiorIzqObservaciones,
              'buje_barra_estabilizadora_izq_o': suspensionDireccion.bujeBarraEstabilizadoraIzqObservaciones,
              'rotula_superior_der_o': suspensionDireccion.rotulaSuperiorDerObservaciones,
              'buje_barra_estabilizadora_der_o': suspensionDireccion.bujeBarraEstabilizadoraDerObservaciones,
              'rotula_inferior_izq_o': suspensionDireccion.rotulaInferiorIzqObservaciones,
              'link_kit_delantero_izq_o': suspensionDireccion.linkKitDelanteroIzqObservaciones,
              'rotula_inferior_der_o': suspensionDireccion.rotulaInferiorDerObservaciones,
              'link_kit_delantero_der_o': suspensionDireccion.linkKitDelanteroDerObservaciones,
              'buje_horquilla_superior_izq_o': suspensionDireccion.bujeHorquillaSuperiorIzqObservaciones,
              'link_kit_trasero_izq_o': suspensionDireccion.linkKitTraseroIzqObservaciones,
              'buje_horquilla_superior_der_o': suspensionDireccion.bujeHorquillaSuperiorDerObservaciones,
              'link_kit_trasero_der_o': suspensionDireccion.linkKitTraseroDerObservaciones,
              'buje_horquilla_inferior_izq_o': suspensionDireccion.bujeHorquillaInferiorIzqObservaciones,
              'terminal_interior_izq_o': suspensionDireccion.terminalInteriorIzqObservaciones,
              'buje_horquilla_inferior_der_o': suspensionDireccion.bujeHorquillaInferiorDerObservaciones,
              'terminal_interior_der_o': suspensionDireccion.terminalInteriorDerObservaciones,
              'amortiguador_delantero_izq_o': suspensionDireccion.amortiguadorDelanteroIzqObservaciones,
              'terminal_exterior_izq_o': suspensionDireccion.terminalExteriorIzqObservaciones,
              'amortiguador_delantero_der_o': suspensionDireccion.amortiguadorDelanteroDerObservaciones,
              'terminal_exterior_der_o': suspensionDireccion.terminalExteriorDerObservaciones,
              'id_revision_fk': suspensionDireccion.revision.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase de la Suspensión Dirección
            suspensionDireccion.idDBR = recordRevision.first['id'].toString();
            dataBase.suspensionDireccionBox.put(suspensionDireccion);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión de la Suspensión y Dirección del vehiculo en el Servidor Local: Problema al postear los datos de la Revisión de la suspensión y dirección de la Orden de Trabajo con id Local '${suspensionDireccion.revision.target!.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión de la Suspensión y Dirección del vehiculo de la orden de trabajo con id Local '${suspensionDireccion.revision.target!.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }


  Future<SyncInstruction> syncAddElectrico(
      Electrico electrico, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (electrico.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('electrico').insert(
            {
              'created_at': electrico.fechaRegistro.toIso8601String(),
              'luces_direccionales': electrico.lucesDireccionales,
              'terminales_baterias': electrico.terminalesDeBaterias,
              'luces_cuartos': electrico.lucesCuartos,
              'luces_frenos': electrico.lucesFrenos,
              'check_engine': electrico.checkEngine,
              'luces_direccionales_o': electrico.lucesDireccionalesObservaciones,
              'terminales_baterias_o': electrico.terminalesDeBateriasObservaciones,
              'luces_cuartos_o': electrico.lucesCuartosObservaciones,
              'luces_frenos_o': electrico.lucesFrenosObservaciones,
              'check_engine_o': electrico.checkEngineObservaciones,
              'id_revision_fk': electrico.revision.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase del Eléctrico
            electrico.idDBR = recordRevision.first['id'].toString();
            dataBase.electricoBox.put(electrico);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión de la Sistema Eléctrico del vehiculo en el Servidor Local: Problema al postear los datos de la Revisión del sistema eléctrico de la Orden de Trabajo con id Local '${electrico.revision.target!.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión de la Sistema Eléctrico del vehiculo de la orden de trabajo con id Local '${electrico.revision.target!.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddFluido(
      Fluidos fluido, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (fluido.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('fluidos').insert(
            {
              'created_at': fluido.fechaRegistro.toIso8601String(),
              'atf': fluido.atf,
              'power': fluido.power,
              'frenos': fluido.frenos,
              'anticongelante': fluido.anticongelante,
              'wipers': fluido.wipers,
              'atf_o': fluido.atfObservaciones,
              'power_o': fluido.powerObservaciones,
              'frenos_o': fluido.frenosObservaciones,
              'anticongelante_o': fluido.anticongelanteObservaciones,
              'wipers_o': fluido.wipersObservaciones,
              'id_revision_fk': fluido.revision.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase de Fluidos
            fluido.idDBR = recordRevision.first['id'].toString();
            dataBase.fluidosBox.put(fluido);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión de Fluidos del vehiculo en el Servidor Local: Problema al postear los datos de la Revisión de los fluidos de la Orden de Trabajo con id Local '${fluido.revision.target!.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión de Fluidos del vehiculo de la orden de trabajo con id Local '${fluido.revision.target!.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddFreno(
      Frenos frenos, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (frenos.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('frenos').insert(
            {
              'created_at': frenos.fechaRegistro.toIso8601String(),
              'balatas_delanteras': frenos.balatasDelanteras,
              'balatas_traseras_disco_tambor': frenos.balatasTraserasDiscoTambor,
              'mangueras_lineas': frenos.manguerasLineas,
              'cilindro_maestro': frenos.cilindroMaestro,
              'birlos_tuercas': frenos.birlosYTuercas,
              'balatas_delanteras_o': frenos.balatasDelanterasObservaciones,
              'balatas_traseras_disco_tambor_o': frenos.balatasTraserasDiscoTamborObservaciones,
              'mangueras_lineas_o': frenos.manguerasLineasObservaciones,
              'cilindro_maestro_o': frenos.cilindroMaestroObservaciones,
              'birlos_tuercas_o': frenos.birlosYTuercasObservaciones,
              'id_revision_fk': frenos.revision.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase de Frenos
            frenos.idDBR = recordRevision.first['id'].toString();
            dataBase.frenosBox.put(frenos);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión de Frenos del vehiculo en el Servidor Local: Problema al postear los datos de la Revisión de los frenos de la Orden de Trabajo con id Local '${frenos.revision.target!.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión de Frenos del vehiculo de la orden de trabajo con id Local '${frenos.revision.target!.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncAddMotor(
      Motor motor, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        if (motor.idDBR == null) {
          //Registrar el orden Trabajo
          final recordRevision = await supabaseClient.from('motor').insert(
            {
              'created_at': motor.fechaRegistro.toIso8601String(),
              'aceite': motor.aceite,
              'filtro_aire': motor.filtroDeAire,
              'cpo_aceleracion': motor.cpoDeAceleracion,
              'bujias': motor.bujias,
              'banda_cadena_tiempo': motor.bandaCadenaDeTiempo,
              'soportes': motor.soportes,
              'bandas': motor.bandas,
              'mangueras': motor.mangueras,
              'aceite_o': motor.aceiteObservaciones,
              'filtro_aire_o': motor.filtroDeAireObservaciones,
              'cpo_aceleracion_o': motor.cpoDeAceleracionObservaciones,
              'bujias_o': motor.bujiasObservaciones,
              'banda_cadena_tiempo_o': motor.bandaCadenaDeTiempoObservaciones,
              'soportes_o': motor.soportesObservaciones,
              'bandas_o': motor.bandasObservaciones,
              'mangueras_o': motor.manguerasObservaciones,
              'id_revision_fk': motor.revision.target!.idDBR,
            },
          ).select<PostgrestList>('id');
          if (recordRevision.isNotEmpty) {
            //Se recupera el idDBR de Supabase de Frenos
            motor.idDBR = recordRevision.first['id'].toString();
            dataBase.motorBox.put(motor);
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar alta de Revisión de Motor del vehiculo en el Servidor Local: Problema al postear los datos de la Revisión del motor de la Orden de Trabajo con id Local '${motor.revision.target!.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar alta de de Revisión del Motor del vehiculo de la orden de trabajo con id Local '${motor.revision.target!.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

  Future<SyncInstruction> syncUpdateEstatusOrdenTrabajo(
    OrdenTrabajo ordenTrabajo, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        final estatusActual = dataBase.estatusBox
          .query(Estatus_.estatus.equals(bitacora.instruccionAdicional!))
          .build()
          .findUnique();
        if (estatusActual != null) {
          //Actualizar orden de Trabajo
          final recordObservacion = await supabaseClient.from('orden_trabajo').update(
            {
              'id_estatus_fk': estatusActual.idDBR,
            },
          )
          .eq('id', ordenTrabajo.idDBR)
          .select();
          if (recordObservacion.isNotEmpty) {
            //Se marca como ejecutada la instrucción en Bitacora
            bitacora.executeSupabase = true;
            dataBase.bitacoraBox.put(bitacora);
            dataBase.bitacoraBox.remove(bitacora.id);
            return SyncInstruction(exitoso: true, descripcion: "");
          } else {
            return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar actualización de Estatus de Orden de trabajo en el Servidor Local: Problema al actualizar estatus de la Orden de Trabajo con id Local '${ordenTrabajo.id}' en '${estatusActual.estatus}'.");
          }
        } else {
          return SyncInstruction(
            exitoso: false,
            descripcion:
                "Falló en proceso de sincronizar actualización de Estatus de Orden de trabajo en el Servidor Local: Problema al recuperar los datos del estatus de la Orden de Trabajo con id Local '${ordenTrabajo.id}' en '${bitacora.instruccionAdicional}'.");
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
              "Falló en proceso de sincronizar actualización de Estatus de Orden de trabajo en el Servidor Local, detalles: '$e'");
    }
  }

    Future<SyncInstruction> syncUpdateRevision(
      Revision revision, Bitacora bitacora) async {
    try {
      if (bitacora.executeSupabase == false) {
        //Registrar el orden Trabajo
        final recordRevision = await supabaseClient.from('revision').update(
          {
            'completado': revision.completado,
          },
        )
        .eq('id', revision.idDBR)
        .select();
        if (recordRevision.isNotEmpty) {
          //Se marca como ejecutada la instrucción en Bitacora
          bitacora.executeSupabase = true;
          dataBase.bitacoraBox.put(bitacora);
          dataBase.bitacoraBox.remove(bitacora.id);
          return SyncInstruction(exitoso: true, descripcion: "");
        } else {
          return SyncInstruction(
          exitoso: false,
          descripcion:
              "Falló en proceso de sincronizar actualización de Revisión en el Servidor Local: Problema al actualizar los datos de la Revisión de la Orden de Trabajo con id Local '${revision.ordenTrabajo.target!.id}'.");
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
              "Falló en proceso de sincronizar actualización de de Revisión de la orden de trabajo con id Local '${revision.ordenTrabajo.target!.id}' en el Servidor Local, detalles: '$e'");
    }
  }

}
