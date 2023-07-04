import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_company_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_roles_supabase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../objectbox.g.dart';
import '../screens/clientes/flutter_flow_util_local.dart';

class RolesSupabaseProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  bool exitoso = true;
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

  Future<bool> getRolesSupabase(String idUserFk) async {
    recordsMonthCurrentR = null;
    recordsMonthSecondR = null;
    recordsMonthThirdR = null;
    recordsMonthCurrentD = null;
    recordsMonthSecondD = null;
    recordsMonthThirdD = null;
    exitoso = await getRoles(idUserFk);
    //Verificamos que no haya habido errores al sincronizar
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

//Función para recuperar el catálogo de roles desde Supabase
  Future<bool> getRoles(String idUserFk) async {
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
//Función para recuperar el catálogo de vehicles desde Supabase
    String queryGetVehicle = """
      query Query {
        vehicleCollection {
          edges {
            node {
              id_vehicle
              make
              model
              year
              vin
              license_plates
              motor
              color
              image
              id_status_fk
              id_company_fk
              date_added
              oil_change_due
              registration_due
              insurance_renewal_due
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
      //Se recupera toda la colección de vehicle en Supabase
      final recordsVehicle = await supabaseCtrlV
          .from('vehicle')
          .select();
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
      .eq('id_user_fk', idUserFk);

      final responseCurrentD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthCurrent).lt('date_added_d', formattedEndOfMonthCurrent)
      .eq('id_user_fk', idUserFk);

      final responseSecondR = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_r', formattedStartOfMonthSecond).lt('date_added_r', formattedEndOfMonthSecond)
      .eq('id_user_fk', idUserFk);

      final responseSecondD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthSecond).lt('date_added_d', formattedEndOfMonthSecond)
      .eq('id_user_fk', idUserFk);

      final responseThirdR = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_r', formattedStartOfMonthThird).lt('date_added_r', formattedEndOfMonthThird)
      .eq('id_user_fk', idUserFk);

      final responseThirdD = await supabaseCtrlV
      .from('control_form')
      .select()
      .gt('date_added_d', formattedStartOfMonthThird).lt('date_added_d', formattedEndOfMonthThird)
      .eq('id_user_fk', idUserFk);

      if (recordsRoles.data != null && recordsStatus != null && recordsCompany.data != null && recordsVehicle != null && recordsServices != null &&
      responseCurrentR != null && responseSecondR != null && responseThirdR != null &&
      responseCurrentD != null && responseSecondD != null && responseThirdD != null) {
        //Existen datos de roles en Supabase
        print("****Roles: ${jsonEncode(recordsRoles.data.toString())}");
        print("****Company: ${jsonEncode(recordsCompany.data.toString())}");
        final responseListRoles = getRolesSupabaseFromMap(jsonEncode(recordsRoles.data).toString());
        final responseListStatus = recordsStatus as List<dynamic>;
        final responseListCompany = getCompanySupabaseFromMap(jsonEncode(recordsCompany.data).toString());
        final responseListVehicle = recordsVehicle as List<dynamic>;
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
            final uInt8ListImagen = base64Decode(
                element['image'].replaceAll("data:image/png;base64,", ""));
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
              path: file.path,
              image: element['image'],
              oilChangeDue: DateTime.parse(element['oil_change_due']),
              lastTransmissionFluidChange: DateTime.parse(element['last_transmission_fluid_change']),
              lastRadiatorFluidChange: DateTime.parse(element['last_radiator_fluid_change']),
              dateAdded: DateTime.parse(element['date_added']),
              idDBR: element['id_vehicle'].toString(), 
            );

            final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element['id_status_fk'].toString())).build().findUnique(); //Status recovered
            final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element['id_company_fk'].toString())).build().findUnique(); //Company recovered
            if (newStatus == null && newCompany == null) {
              return false;
            }

            //Se recuperan los servicios del vehiculo de Supabase
            final recordsVehicleServices = await supabaseCtrlV
                .from('vehicle_services')
                .select()
                .eq('id_vehicle_fk', element['id_vehicle']);
            if (recordsVehicleServices != null) {
              final responseListVehicleServices = recordsVehicleServices as List<dynamic>;
              for (var vehicleServices in responseListVehicleServices) {
                //Se valida que el nuevo vehicle services aún no existe en Objectbox
                final vehicleServicesExistente = dataBase.vehicleServicesBox.query(VehicleServices_.idDBR.equals(vehicleServices['id_vehicle_services'].toString())).build().findUnique();
                if (vehicleServicesExistente == null) {
                  final newVehicleServices = VehicleServices(
                    completed: vehicleServices['completed'],
                    serviceDate: DateTime.parse(vehicleServices['service_date']),
                    dateAdded: DateTime.parse(vehicleServices['created_at']),
                    idDBR: vehicleServices['id_vehicle_services'].toString(), 
                  );
                  //Se recupera el servicio al que esta relacionado
                  final serviceExistenteTarjet = dataBase.serviceBox.query(Service_.idDBR.equals(vehicleServices['id_service_fk'].toString())).build().findUnique();
                  if (serviceExistenteTarjet != null) {
                    newVehicleServices.service.target = serviceExistenteTarjet;
                    newVehicleServices.vehicle.target = newVehicle;
                    newVehicle.vehicleServices.add(newVehicleServices);
                    dataBase.vehicleServicesBox.put(newVehicleServices);
                  }
                  //print('Rol Nuevo agregado exitosamente');
                } else {
                    //Se actualiza el registro en Objectbox
                    vehicleServicesExistente.completed = vehicleServices['completed'];
                    vehicleServicesExistente.serviceDate = DateTime.parse(vehicleServices['service_date']);
                    dataBase.vehicleServicesBox.put(vehicleServicesExistente);
                }
              }
            }


            newVehicle.status.target = newStatus;
            newVehicle.company.target = newCompany;
            dataBase.vehicleBox.put(newVehicle);
          } else {
              //Se actualiza el registro en Objectbox
              final uInt8ListImagen = base64Decode(
                element['image'].replaceAll("data:image/png;base64,", ""));
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
              vehicleExistente.path = file.path;
              vehicleExistente.image = element['image'];
              vehicleExistente.oilChangeDue = DateTime.parse(element['oil_change_due']);
              vehicleExistente.lastTransmissionFluidChange = DateTime.parse(element['last_transmission_fluid_change']);
              vehicleExistente.lastRadiatorFluidChange = DateTime.parse(element['last_radiator_fluid_change']);
              vehicleExistente.dateAdded = DateTime.parse(element['date_added']);

              final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element['id_status_fk'].toString())).build().findUnique(); //Status recovered
              final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element['id_company_fk'].toString())).build().findUnique(); //Company recovered
              if (newStatus == null && newCompany == null) {
                return false;
              }

              vehicleExistente.status.target = newStatus;
              vehicleExistente.company.target = newCompany;

              dataBase.vehicleBox.put(vehicleExistente);
          }
        }
        return true;
      } else {
        //No existen datos de estados en Pocketbase
        return false;
      }
    } catch (e) {
      print("Error getRoleSupabase: $e");
      return false;
    }
  }
}
