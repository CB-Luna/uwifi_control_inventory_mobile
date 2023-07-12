import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_company_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_roles_supabase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_usuario_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_vehicle_supabase.dart';
import 'package:uuid/uuid.dart';
import '../objectbox.g.dart';
import '../screens/clientes/flutter_flow_util_local.dart';

class RolesSupabaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String message = "";
  List<dynamic>? recordsMonthCurrentR;
  List<dynamic>? recordsMonthSecondR;
  List<dynamic>? recordsMonthThirdR;
  List<dynamic>? recordsMonthCurrentD;
  List<dynamic>? recordsMonthSecondD;
  List<dynamic>? recordsMonthThirdD;
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

  Future<String> getRolesSupabase(GetUsuarioSupabase usuario) async {
    recordsMonthCurrentR = null;
    recordsMonthSecondR = null;
    recordsMonthThirdR = null;
    recordsMonthCurrentD = null;
    recordsMonthSecondD = null;
    recordsMonthThirdD = null;
    message = await getRoles(usuario);
    //Verificamos que no haya habido errores al sincronizar
    if (message == "Okay") {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = true;
      notifyListeners();
      return message;
    } else {
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return message;
    }
  }

//Función para recuperar el catálogo de roles desde Supabase
  Future<String> getRoles(GetUsuarioSupabase usuario) async {
    List<dynamic>? recordsVehicle;
    String queryGetRoles = """
      query Query {
        roleCollection {
          edges {
            node {
              role_id
              name
              created_at
            }
          }
        }
      }
      """;
      
//Función para recuperar el catálogo de company desde Supabase
    String queryGetCompany = """
      query Query {
        companyCollection {
          edges {
            node {
              id_company
              company
              created_at
            }
          }
        }
      }
      """;
    try {
      //Se recupera toda la colección de roles en Supabase
      final recordsRoles = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetRoles),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
      //Función para recuperar el catálogo de status desde Supabase
      final recordsStatus = await supabaseCtrlV
          .from('status')
          .select();
      //Se recupera toda la colección de company en Supabase
      final recordsCompany = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetCompany),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
      //Se recupera la colección de vehicle especifica en Supabase
      if (usuario.idVehicleFk != null) {
        recordsVehicle = await supabaseCtrlV
          .from('vehicle')
          .select()
          .eq('id_vehicle', usuario.idVehicleFk);
      } else {
        final recordAvailable = await supabaseCtrlV
          .from('status')
          .select()
          .eq('status', 'Available')
          .select<PostgrestList>("id_status");
        if (recordAvailable.isNotEmpty) {
          recordsVehicle = await supabaseCtrlV
          .from('vehicle')
          .select()
          .eq('id_company_fk', usuario.company.companyId)
          .eq('id_status_fk', recordAvailable.first['id_status']);
        }
      }
      //Se recupera toda la colección de services en Supabase
      final recordsServices = await supabaseCtrlV
          .from('services')
          .select();
      // Se recuperan los formularios del mes anterior
      // Obtener la fecha del mes actual y previos
      DateTime currentDate = DateTime.now();
      DateTime currentMonth = DateTime(currentDate.year, currentDate.month);
      DateTime firstPreviousMonth = DateTime(currentDate.year, currentDate.month - 1);
      DateTime secondPreviousMonth = DateTime(currentDate.year, currentDate.month - 2);

      DateTime startOfMonthCurrent = DateTime(currentMonth.year, currentMonth.month, 1);
      DateTime endOfMonthCurrent = DateTime(currentMonth.year, currentMonth.month + 1, 0, 23, 59, 59);

      DateTime startOfMonthSecond = DateTime(firstPreviousMonth.year, firstPreviousMonth.month, 1);
      DateTime endOfMonthSecond = DateTime(firstPreviousMonth.year, firstPreviousMonth.month + 1, 0, 23, 59, 59);

      DateTime startOfMonthThird = DateTime(secondPreviousMonth.year, secondPreviousMonth.month, 1);
      DateTime endOfMonthThird = DateTime(secondPreviousMonth.year, secondPreviousMonth.month + 1, 0, 23, 59, 59);

      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

      String formattedStartOfMonthCurrent = format.format(startOfMonthCurrent);
      String formattedEndOfMonthCurrent = format.format(endOfMonthCurrent);

      String formattedStartOfMonthSecond = format.format(startOfMonthSecond);
      String formattedEndOfMonthSecond = format.format(endOfMonthSecond);

      String formattedStartOfMonthThird = format.format(startOfMonthThird);
      String formattedEndOfMonthThird = format.format(endOfMonthThird);

      final responseCurrentR = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_r', formattedStartOfMonthCurrent).lt('date_added_r', formattedEndOfMonthCurrent)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      final responseCurrentD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthCurrent).lt('date_added_d', formattedEndOfMonthCurrent)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      final responseSecondR = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_r', formattedStartOfMonthSecond).lt('date_added_r', formattedEndOfMonthSecond)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      final responseSecondD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthSecond).lt('date_added_d', formattedEndOfMonthSecond)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      final responseThirdR = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_r', formattedStartOfMonthThird).lt('date_added_r', formattedEndOfMonthThird)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      final responseThirdD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthThird).lt('date_added_d', formattedEndOfMonthThird)
      .eq('id_user_fk', usuario.idPerfilUsuario);

      if (recordsVehicle != null) {
        if (recordsRoles.data != null && recordsStatus != null && recordsCompany.data != null && recordsServices != null &&
        responseCurrentR != null && responseSecondR != null && responseThirdR != null &&
        responseCurrentD != null && responseSecondD != null && responseThirdD != null) {
          //Existen datos de roles en Supabase
          print("****Roles: ${jsonEncode(recordsRoles.data.toString())}");
          print("****Company: ${jsonEncode(recordsCompany.data.toString())}");
          final responseListRoles = getRolesSupabaseFromMap(jsonEncode(recordsRoles.data).toString());
          final responseListStatus = recordsStatus as List<dynamic>;
          final responseListCompany = getCompanySupabaseFromMap(jsonEncode(recordsCompany.data).toString());
          final responseListVehicle = recordsVehicle;
          final responseListServices = recordsServices as List<dynamic>;
          recordsMonthCurrentR = responseCurrentR as List<dynamic>;
          recordsMonthSecondR = responseSecondR as List<dynamic>;
          recordsMonthThirdR = responseThirdR as List<dynamic>;
          recordsMonthCurrentD = responseCurrentD as List<dynamic>;
          recordsMonthSecondD = responseSecondD as List<dynamic>;
          recordsMonthThirdD = responseThirdD as List<dynamic>;
          for (var element in responseListRoles.rolesCollection.edges) {
            //Se valida que el nuevo rol aún no existe en Objectbox
            final rolExistente = dataBase.roleBox.query(Role_.idDBR.equals(element.node.id)).build().findUnique();
            if (rolExistente == null) {
              final newRole = Role(
              role: element.node.name,
              idDBR: element.node.id, 
              );
              dataBase.roleBox.put(newRole);
              //print('Rol Nuevo agregado exitosamente');
            } else {
                //Se actualiza el registro en Objectbox
                rolExistente.role = element.node.name;
                dataBase.roleBox.put(rolExistente);
            }
          }
          for (var element in responseListStatus) {
            //Se valida que el nuevo status aún no existe en Objectbox
            final statusExistente = dataBase.statusBox.query(Status_.idDBR.equals(element['id_status'].toString())).build().findUnique();
            if (statusExistente == null) {
              final newStatus = Status(
              status: element['status'],
              idDBR: element['id_status'].toString(), 
              );
              dataBase.statusBox.put(newStatus);
              //print('Status Nuevo agregado exitosamente');
            } else {
                //Se actualiza el registro en Objectbox
                statusExistente.status = element['status'];
                dataBase.statusBox.put(statusExistente);
            }
          }
          for (var element in responseListCompany.companyCollection.edges) {
            //Se valida que el nuevo company aún no existe en Objectbox
            final companyExistente = dataBase.companyBox.query(Company_.idDBR.equals(element.node.id)).build().findUnique();
            if (companyExistente == null) {
              final newCompany = Company(
              company: element.node.company,
              idDBR: element.node.id, 
              );
              dataBase.companyBox.put(newCompany);
              //print('company Nuevo agregado exitosamente');
            } else {
                //Se actualiza el registro en Objectbox
                companyExistente.company = element.node.company;
                dataBase.companyBox.put(companyExistente);
            }
          }
          for (var element in responseListServices) {
            //Se valida que el nuevo Service aún no existe en Objectbox
            final serviceExistente = dataBase.serviceBox.query(Service_.idDBR.equals(element['id_service'].toString())).build().findUnique();
            if (serviceExistente == null) {
              final newService = Service(
              service: element['service'],
              description: element['description'],
              idDBR: element['id_service'].toString(), 
              );
              dataBase.serviceBox.put(newService);
              //print('service Nuevo agregado exitosamente');
            } else {
                //Se actualiza el registro en Objectbox
                serviceExistente.service = element['service'];
                dataBase.serviceBox.put(serviceExistente);
            }
          }
          for (var element in responseListVehicle) {
            //Se valida que el nuevo vehicle aún no existe en Objectbox
            final vehicleExistente = dataBase.vehicleBox.query(Vehicle_.idDBR.equals(element['id_vehicle'].toString())).build().findUnique();
            if (vehicleExistente == null) {
              final uInt8ListImagen = await supabase.storage.from('assets/Vehicles').download(
                element['image'].toString().replaceAll("https://supa43.rtatel.com/storage/v1/object/public/assets/Vehicles/", ""));
              final base64Image = const Base64Encoder().convert(uInt8ListImagen);
              final tempDir = await getTemporaryDirectory();
              File file = await File(
                '${tempDir.path}/${uuid.v1()}.png')
              .create();
              file.writeAsBytesSync(uInt8ListImagen);

              final newVehicle = Vehicle(
                make: element['make'],
                model: element['model'],
                year: element['year'],
                vin: element['vin'],
                licensePlates: element['license_plates'],
                motor: element['motor'],
                color: element['color'],
                mileage: element['mileage'],
                path: file.path,
                image: base64Image,
                oilChangeDue: element['oil_change_due'] == null ? null : DateTime.parse(element['oil_change_due']),
                lastTransmissionFluidChange: element['last_transmission_fluid_change'] == null ? null : DateTime.parse(element['last_transmission_fluid_change']),
                lastRadiatorFluidChange: element['last_radiator_fluid_change'] == null ? null : DateTime.parse(element['last_radiator_fluid_change']),
                dateAdded: DateTime.parse(element['date_added']),
                idDBR: element['id_vehicle'].toString(), 
                carWash: element['car_wash'],
              );

              //Se recuperan las reglas
              final ruleOilChange = RuleChange.fromMap(element['rule_oil_change']);
              final ruleTransmissionFluidChange = RuleChange.fromMap(element['rule_transmission_fluid_change']);
              final ruleRadiatorFluidChange = RuleChange.fromMap(element['rule_radiator_fluid_change']);

              //Se crea la regla para Oil Change
              final newRuleOilChange = Rule(
                value: ruleOilChange.value, 
                registered: ruleOilChange.registered, 
                lastMileageService: ruleOilChange.lastMileageService,
              );
              newVehicle.ruleOilChange.target = newRuleOilChange;
              newRuleOilChange.vehicle.target = newVehicle;
              dataBase.ruleBox.put(newRuleOilChange);
              //Se crea la regla para Transmission Change
              final newRuleTransmissionFluidChange = Rule(
                value: ruleTransmissionFluidChange.value, 
                registered: ruleTransmissionFluidChange.registered, 
                lastMileageService: ruleTransmissionFluidChange.lastMileageService,
              );
              newVehicle.ruleTransmissionFluidChange.target = newRuleTransmissionFluidChange;
              newRuleTransmissionFluidChange.vehicle.target = newVehicle;
              dataBase.ruleBox.put(newRuleTransmissionFluidChange);
              //Se crea la regla para Radiator Change
              final newRuleRadiatorFluidChange = Rule(
                value: ruleRadiatorFluidChange.value, 
                registered: ruleRadiatorFluidChange.registered, 
                lastMileageService: ruleRadiatorFluidChange.lastMileageService,
              );
              newVehicle.ruleRadiatorFluidChange.target = newRuleRadiatorFluidChange;
              newRuleRadiatorFluidChange.vehicle.target = newVehicle;
              dataBase.ruleBox.put(newRuleRadiatorFluidChange);

              final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element['id_status_fk'].toString())).build().findUnique(); //Status recovered
              final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element['id_company_fk'].toString())).build().findUnique(); //Company recovered
              if (newStatus == null && newCompany == null) {
                return "Not-Status-Company";
              }

              //Se recuperan los servicios del vehiculo de Supabase
              final recordsVehicleServices = await supabaseCtrlV
                  .from('vehicle_services')
                  .select()
                  .eq('id_vehicle_fk', element['id_vehicle']);
              if (recordsVehicleServices != null) {
                final responseListVehicleServices = recordsVehicleServices as List<dynamic>;
                for (var vehicleServices in responseListVehicleServices) {
                    final newVehicleServices = VehicleServices(
                      completed: vehicleServices['completed'],
                      serviceDate: vehicleServices['service_date'] == null ? null : DateTime.parse(vehicleServices['service_date']),
                      dateAdded: DateTime.parse(vehicleServices['created_at']),
                      idDBR: vehicleServices['id_vehicle_services'].toString(), 
                      mileageRemaining: vehicleServices['mileage_remaining'],
                    );
                    //Se recupera el servicio al que esta relacionado
                    final serviceExistenteTarjet = dataBase.serviceBox.query(Service_.idDBR.equals(vehicleServices['id_service_fk'].toString())).build().findUnique();
                    if (serviceExistenteTarjet != null) {
                      newVehicleServices.service.target = serviceExistenteTarjet;
                      newVehicleServices.vehicle.target = newVehicle;
                      newVehicle.vehicleServices.add(newVehicleServices);
                      dataBase.vehicleServicesBox.put(newVehicleServices);
                    }
                }
              }
              newVehicle.status.target = newStatus;
              newVehicle.company.target = newCompany;
              //Se verifica que sea Jueves
                final today = DateTime.now();
                if (today.weekday == DateTime.thursday) {
                  if (!element['car_wash']) {
                    final service = dataBase.serviceBox.query(Service_.service.equals("Car Wash")).build().findUnique();
                    final serviceVehicle = dataBase.vehicleServicesBox.query(VehicleServices_.vehicle.equals(newVehicle.id).and(VehicleServices_.service.equals(service?.id ?? 0)).and(VehicleServices_.completed.equals(false)).and(VehicleServices_.serviceDate.between(today.weekday, today.add(const Duration(days: 2)).weekday))).build().findFirst();
                    if (serviceVehicle == null) {
                      final serviceVehicle = VehicleServices(
                        completed: false,
                        serviceDate: today.add(const Duration(days: 1)),
                      );
                      serviceVehicle.service.target = service;
                      serviceVehicle.vehicle.target = newVehicle;
                      newVehicle.vehicleServices.add(serviceVehicle);
                      dataBase.vehicleServicesBox.put(serviceVehicle);

                      final nuevaInstruccion = Bitacora(
                        instruccion: 'syncAddCarWashService',
                        usuarioPropietario: prefs.getString("userId")!,
                        idControlForm: 0,
                      ); //Se crea la nueva instruccion a realizar en bitacora

                      nuevaInstruccion.vehicleService.target = serviceVehicle; //Se asigna el verhicle service a la nueva instrucción
                      serviceVehicle.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el verhicle service
                      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox

                      newVehicle.carWash = true;
                    }
                  }
                }
              dataBase.vehicleBox.put(newVehicle);
            } else {
                //Se actualiza el registro en Objectbox
                final uInt8ListImagen = await supabase.storage.from('assets/Vehicles').download(
                element['image'].toString().replaceAll("https://supa43.rtatel.com/storage/v1/object/public/assets/Vehicles/", ""));
                final base64Image = const Base64Encoder().convert(uInt8ListImagen);
                final tempDir = await getTemporaryDirectory();
                File file = await File(
                  '${tempDir.path}/${uuid.v1()}.png')
                .create();
                file.writeAsBytesSync(uInt8ListImagen);

                vehicleExistente.make = element['make'];
                vehicleExistente.model = element['model'];
                vehicleExistente.year = element['year'];
                vehicleExistente.vin = element['vin'];
                vehicleExistente.licensePlates = element['license_plates'];
                vehicleExistente.motor = element['motor'];
                vehicleExistente.color = element['color'];
                vehicleExistente.mileage = element['mileage'];
                vehicleExistente.path = file.path;
                vehicleExistente.image = base64Image;
                vehicleExistente.oilChangeDue = element['oil_change_due'] == null ? null : DateTime.parse(element['oil_change_due']);
                vehicleExistente.lastTransmissionFluidChange = element['last_transmission_fluid_change'] == null ? null : DateTime.parse(element['last_transmission_fluid_change']);
                vehicleExistente.lastRadiatorFluidChange = element['last_radiator_fluid_change'] == null ? null : DateTime.parse(element['last_radiator_fluid_change']);
                vehicleExistente.dateAdded = DateTime.parse(element['date_added']);
                vehicleExistente.carWash = element['car_wash'];

                //Se recuperan las reglas
                final ruleOilChange = RuleChange.fromMap(element['rule_oil_change']);
                final ruleTransmissionFluidChange = RuleChange.fromMap(element['rule_transmission_fluid_change']);
                final ruleRadiatorFluidChange = RuleChange.fromMap(element['rule_radiator_fluid_change']);

                //Se actualizan las reglas

                vehicleExistente.ruleOilChange.target!.value = ruleOilChange.value; 
                vehicleExistente.ruleOilChange.target!.registered = ruleOilChange.registered; 
                vehicleExistente.ruleOilChange.target!.lastMileageService = ruleOilChange.lastMileageService;

                dataBase.ruleBox.put(vehicleExistente.ruleOilChange.target!);

                vehicleExistente.ruleTransmissionFluidChange.target!.value = ruleTransmissionFluidChange.value; 
                vehicleExistente.ruleTransmissionFluidChange.target!.registered = ruleTransmissionFluidChange.registered; 
                vehicleExistente.ruleTransmissionFluidChange.target!.lastMileageService = ruleTransmissionFluidChange.lastMileageService;

                dataBase.ruleBox.put(vehicleExistente.ruleTransmissionFluidChange.target!);
                
                vehicleExistente.ruleRadiatorFluidChange.target!.value = ruleRadiatorFluidChange.value; 
                vehicleExistente.ruleRadiatorFluidChange.target!.registered = ruleRadiatorFluidChange.registered; 
                vehicleExistente.ruleRadiatorFluidChange.target!.lastMileageService = ruleRadiatorFluidChange.lastMileageService;

                dataBase.ruleBox.put(vehicleExistente.ruleRadiatorFluidChange.target!);

                final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element['id_status_fk'].toString())).build().findUnique(); //Status recovered
                final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element['id_company_fk'].toString())).build().findUnique(); //Company recovered
                if (newStatus == null && newCompany == null) {
                  return "Not-Status-Company";
                }

                //Se recuperan los servicios del vehiculo de Supabase
              final recordsVehicleServices = await supabaseCtrlV
                  .from('vehicle_services')
                  .select()
                  .eq('id_vehicle_fk', element['id_vehicle']);
              if (recordsVehicleServices != null) {
                final responseListVehicleServices = recordsVehicleServices as List<dynamic>;
                for (var vehicleServices in responseListVehicleServices) {
                  //Se recupera el service Vehicle
                  final serviceVehicleExistente = dataBase.vehicleServicesBox.query(VehicleServices_.idDBR.equals(vehicleServices['id_vehicle_services'].toString())).build().findUnique();
                    if (serviceVehicleExistente != null) {
                      //El service vehicle sí existe, entonces se actualiza
                      serviceVehicleExistente.completed = vehicleServices['completed'];
                      serviceVehicleExistente.serviceDate = vehicleServices['service_date'] == null ? null : DateTime.parse(vehicleServices['service_date']);
                      serviceVehicleExistente.mileageRemaining = vehicleServices['mileage_remaining'];
                      //Se recupera el servicio al que esta relacionado
                      final serviceExistenteTarjet = dataBase.serviceBox.query(Service_.idDBR.equals(vehicleServices['id_service_fk'].toString())).build().findUnique();
                      if (serviceExistenteTarjet != null) {
                        serviceVehicleExistente.service.target = serviceExistenteTarjet;
                        dataBase.vehicleServicesBox.put(serviceVehicleExistente);
                      }
                    } else {
                      //El service vehicle no existe, entonces se crea
                      final newVehicleServices = VehicleServices(
                        completed: vehicleServices['completed'],
                        serviceDate: vehicleServices['service_date'] == null ? null : DateTime.parse(vehicleServices['service_date']),
                        mileageRemaining: vehicleServices['mileage_remaining'],
                        dateAdded: DateTime.parse(vehicleServices['created_at']),
                        idDBR: vehicleServices['id_vehicle_services'].toString(), 
                      );
                      //Se recupera el servicio al que esta relacionado
                      final serviceExistenteTarjet = dataBase.serviceBox.query(Service_.idDBR.equals(vehicleServices['id_service_fk'].toString())).build().findUnique();
                      if (serviceExistenteTarjet != null) {
                        newVehicleServices.service.target = serviceExistenteTarjet;
                        newVehicleServices.vehicle.target = vehicleExistente;
                        vehicleExistente.vehicleServices.add(newVehicleServices);
                        dataBase.vehicleServicesBox.put(newVehicleServices);
                      }
                    }
                }
              }

                vehicleExistente.status.target = newStatus;
                vehicleExistente.company.target = newCompany;

                //Se verifica que sea Jueves
                final today = DateTime.now();
                if (today.weekday == DateTime.thursday) {
                  if (!element['car_wash']) {
                    final service = dataBase.serviceBox.query(Service_.service.equals("Car Wash")).build().findUnique();
                    final serviceVehicle = dataBase.vehicleServicesBox.query(VehicleServices_.vehicle.equals(vehicleExistente.id).and(VehicleServices_.service.equals(service?.id ?? 0)).and(VehicleServices_.completed.equals(false)).and(VehicleServices_.serviceDate.between(today.weekday, today.add(const Duration(days: 2)).weekday))).build().findFirst();
                    if (serviceVehicle == null) {
                      final serviceVehicle = VehicleServices(
                        completed: false,
                        serviceDate: today.add(const Duration(days: 1)),
                      );
                      serviceVehicle.service.target = service;
                      serviceVehicle.vehicle.target = vehicleExistente;
                      vehicleExistente.vehicleServices.add(serviceVehicle);
                      dataBase.vehicleServicesBox.put(serviceVehicle);

                      final nuevaInstruccion = Bitacora(
                        instruccion: 'syncAddCarWashService',
                        usuarioPropietario: prefs.getString("userId")!,
                        idControlForm: 0,
                      ); //Se crea la nueva instruccion a realizar en bitacora

                      nuevaInstruccion.vehicleService.target = serviceVehicle; //Se asigna el verhicle service a la nueva instrucción
                      serviceVehicle.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el verhicle service
                      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox

                      vehicleExistente.carWash = true;
                    }
                  }
                }

                dataBase.vehicleBox.put(vehicleExistente);
            }
          }
          return "Okay";
        } else {
          //No existen datos de estados en Pocketbase
          return "Not-Data";
        }
      } else {
        //No hay vehiculos disponibles en la companía de este Usuario
        return "Not-Vehicles";
      }
    } catch (e) {
      print("Error getRoleSupabase: $e");
      return "$e";
    }
  }
}
