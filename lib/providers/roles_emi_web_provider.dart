import 'dart:convert';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsEmiWeb/get_roles_emi_web.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsPocketbase/get_roles.dart';

import 'package:http/http.dart' as http;

class RolesEmiWebProvider extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  bool banderaExistoSync = false;
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

  Future<bool> getRolesEmiWeb(String email, String password) async {
      banderaExistoSync = await getRoles(email, password);
      //Aplicamos una operación and para validar que no haya habido un catálogo con False
      exitoso = exitoso && banderaExistoSync;
      //Verificamos que no haya habido errores al sincronizar con las banderas
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

//Función inicial para recuperar el Token para el llamado de catálogos
  Future<bool> getTokenOAuth(String email, String password) async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": email,
          "password": password
        });
      
      var response = await http.post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      print(response.body);

      switch (response.statusCode) {
          case 200:
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
            response.body);
            storage.write(key: "tokenEmiWeb", value: responseTokenEmiWeb.accessToken);
            return true;
          case 401:
            return false;
          case 404:
            return false;
          default:
            return false;
        }
    } catch (e) {
      return false;
    }
  }

//Función para recuperar el catálogo de roles desde Emi Web
  Future<bool> getRoles(String email, String password) async {
    try {
      var url = Uri.parse("$baseUrlEmiWebServices/catalogos/roles");
      var tokenActual = await storage.read(key: "tokenEmiWeb");
      final headers = ({
          "Content-Type": "application/json",
          'Authorization': 'Bearer $tokenActual',
        });
      var response = await http.get(
        url,
        headers: headers
      );

      switch (response.statusCode) {
        case 200: //Caso éxitoso
          print("Caso exitoso 200 en get Roles Emi Web");
          final responseListRoles = getRolesEmiWebFromMap(
          const Utf8Decoder().convert(response.bodyBytes));
          for (var i = 0; i < responseListRoles.payload!.length; i++) {
            //Verificamos que el nuevo rol no exista en Pocketbase
            final recordRol = await client.records.getFullList(
              'roles', 
              batch: 200, 
              filter: "id_emi_web='${responseListRoles.payload![i].idCatRoles}'");
            if (recordRol.isEmpty) {
              //Se agrega el rol como nuevo en la colección de Pocketbase
              final newRecordEstado = await client.records.create('roles', body: {
              "rol": responseListRoles.payload![i].rol,
              "id_status_sync_fk": "xx5X7zjT7DhRA8a",
              "id_emi_web": responseListRoles.payload![i].idCatRoles.toString(),
              });
              if (newRecordEstado.id.isNotEmpty) {
                print('Rol Emi Web agregado éxitosamente en Pocketbase');
              } else {
                return false;
              }
            } else {
              //Se actualiza el rol en la colección de Pocketbase
              final recordRolParse = getRolesFromMap(recordRol.first.toString());
              //Verificamos que los campos de este registro sean diferentes para actualizarlo
              if (recordRolParse.rol != responseListRoles.payload![i].rol) {
                  final updateRecordRol = await client.records.update('roles', recordRolParse.id, 
                  body: {
                    "rol": responseListRoles.payload![i].rol,
                  });
                  if (updateRecordRol.id.isNotEmpty) {
                    print('Rol Emi Web actualizado éxitosamente en Pocketbase');
                  } else {
                    return false;
                  }
              }
            }
          }
          return true;
        case 401: //Error de Token incorrecto
          print("Caso 401 en Emi web");
          if(await getTokenOAuth(email, password)) {
            getRoles(email, password);
            return true;
          } else{
            return false;
          }
        case 404: //Error de ruta incorrecta
          print("Caso 404 en Emi web");
          return false;
        default:
          return false;
      }  
    } catch (e) {
      return false;
    }
  }
}
