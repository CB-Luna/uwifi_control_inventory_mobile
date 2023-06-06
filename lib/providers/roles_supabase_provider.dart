import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_company_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_roles_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_status_supabase.dart';
import 'package:taller_alex_app_asesor/modelsSupabase/get_vehicle_supabase.dart';
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
//Función para recuperar el catálogo de status desde Supabase
    String queryGetStatus = """
      query Query {
        statusCollection {
          edges {
            node {
              id_status
              status
              date_added
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
              date_added
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
      //Se recupera toda la colección de status en Supabase
      final recordsStatus = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetStatus),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
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
      final recordsVehicle = await sbGQL.query(
        QueryOptions(
          document: gql(queryGetVehicle),
          fetchPolicy: FetchPolicy.noCache,
          onError: (error) {
            return null;
        },),
      );
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

      final responseCurrentR = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthCurrent).lt('date_added', formattedEndOfMonthCurrent)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', true);

      final responseCurrentD = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthCurrent).lt('date_added', formattedEndOfMonthCurrent)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', false);

      final responseSecondR = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthSecond).lt('date_added', formattedEndOfMonthSecond)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', true);

      final responseSecondD = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthSecond).lt('date_added', formattedEndOfMonthSecond)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', false);

      final responseThirdR = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthThird).lt('date_added', formattedEndOfMonthThird)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', true);

      final responseThirdD = await supabaseClient
      .from('control_form')
      .select()
      .gt('date_added', formattedStartOfMonthThird).lt('date_added', formattedEndOfMonthThird)
      .eq('id_user_fk', idUserFk)
      .eq('type_form', false);

      if (recordsRoles.data != null && recordsStatus.data != null && recordsCompany.data != null && recordsVehicle.data != null &&
      responseCurrentR != null && responseSecondR != null && responseThirdR != null &&
      responseCurrentD != null && responseSecondD != null && responseThirdD != null) {
        //Existen datos de roles en Supabase
        print("****Roles: ${jsonEncode(recordsRoles.data.toString())}");
        print("****Status: ${jsonEncode(recordsStatus.data.toString())}");
        print("****Company: ${jsonEncode(recordsCompany.data.toString())}");
        print("****Vehicle: ${jsonEncode(recordsVehicle.data.toString())}");
        final responseListRoles = getRolesSupabaseFromMap(jsonEncode(recordsRoles.data).toString());
        final responseListStatus = getStatusSupabaseFromMap(jsonEncode(recordsStatus.data).toString());
        final responseListCompany = getCompanySupabaseFromMap(jsonEncode(recordsCompany.data).toString());
        final responseListVehicle = getVehicleSupabaseFromMap(jsonEncode(recordsVehicle.data).toString());
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
        for (var element in responseListStatus.statusCollection.edges) {
          //Se valida que el nuevo status aún no existe en Objectbox
          final statusExistente = dataBase.statusBox.query(Status_.idDBR.equals(element.node.id)).build().findUnique();
          if (statusExistente == null) {
            final newStatus = Status(
            status: element.node.status,
            idDBR: element.node.id, 
            );
            dataBase.statusBox.put(newStatus);
            //print('Status Nuevo agregado exitosamente');
          } else {
              //Se actualiza el registro en Objectbox
              statusExistente.status = element.node.status;
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
        for (var element in responseListVehicle.vehicleCollection.edges) {
          //Se valida que el nuevo vehicle aún no existe en Objectbox
          final vehicleExistente = dataBase.vehicleBox.query(Vehicle_.idDBR.equals(element.node.id)).build().findUnique();
          if (vehicleExistente == null) {
            final uInt8ListImagen = base64Decode(
                element.node.image.replaceAll("data:image/png;base64,", ""));
            final tempDir = await getTemporaryDirectory();
            File file = await File(
              '${tempDir.path}/${uuid.v1()}.png')
            .create();
            file.writeAsBytesSync(uInt8ListImagen);

            final newVehicle = Vehicle(
              make: element.node.make,
              model: element.node.model,
              year: element.node.year,
              vin: element.node.vin,
              licensePlates: element.node.licensePlates,
              motor: element.node.motor,
              color: element.node.color,
              path: file.path,
              image: element.node.image,
              oilChangeDue: element.node.oilChangeDue,
              registrationDue: element.node.registrationDue,
              insuranceRenewalDue: element.node.insuranceRenewalDue,
              dateAdded: element.node.dateAdded,
              idDBR: element.node.id, 
            );

            final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element.node.idStatusFk)).build().findUnique(); //Status recovered
            final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element.node.idCompanyFk)).build().findUnique(); //Company recovered
            if (newStatus == null && newCompany == null) {
              return false;
            }

            newVehicle.status.target = newStatus;
            newVehicle.company.target = newCompany;
            dataBase.vehicleBox.put(newVehicle);
          } else {
              //Se actualiza el registro en Objectbox
              final uInt8ListImagen = base64Decode(
                element.node.image.replaceAll("data:image/png;base64,", ""));
              final tempDir = await getTemporaryDirectory();
              File file = await File(
                '${tempDir.path}/${uuid.v1()}.png')
              .create();
              file.writeAsBytesSync(uInt8ListImagen);

              vehicleExistente.make = element.node.make;
              vehicleExistente.model = element.node.model;
              vehicleExistente.year = element.node.year;
              vehicleExistente.vin = element.node.vin;
              vehicleExistente.licensePlates = element.node.licensePlates;
              vehicleExistente.motor = element.node.motor;
              vehicleExistente.color = element.node.color;
              vehicleExistente.path = file.path;
              vehicleExistente.image = element.node.image;
              vehicleExistente.oilChangeDue = element.node.oilChangeDue;
              vehicleExistente.registrationDue = element.node.registrationDue;
              vehicleExistente.insuranceRenewalDue = element.node.insuranceRenewalDue;
              vehicleExistente.dateAdded = element.node.dateAdded;

              final newStatus = dataBase.statusBox.query(Status_.idDBR.equals(element.node.idStatusFk)).build().findUnique(); //Status recovered
              final newCompany = dataBase.companyBox.query(Company_.idDBR.equals(element.node.idCompanyFk)).build().findUnique(); //Company recovered
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
