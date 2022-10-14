import 'dart:convert';

import 'package:bizpro_app/modelsEmiWeb/get_token_emi_web.dart';
import 'package:bizpro_app/modelsEmiWeb/post_registro_exitoso_emi_web.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';

class SyncProviderEmiWeb extends ChangeNotifier {

  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  List<bool> banderasExistoSync = [];
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

//Función inicial para recuperar el Token para la sincronización/posteo de datos
  Future<bool> getTokenOAuth() async {
    try {
      var url = Uri.parse("$baseUrlEmiWebSecurity/oauth/token");
      final headers = ({
          "Authorization": "Basic Yml6cHJvOmFkbWlu",
        });
      final bodyMsg = ({
          "grant_type": "password",
          "scope": "webclient",
          "username": "alozanop@encuentroconmexico.org",
          "password": "3FFV4lkuqqC9IuP05+K3dQ=="
        });
      
      var response = await post(
        url, 
        headers: headers,
        body: bodyMsg
      );

      print(response.body);

      switch (response.statusCode) {
          case 200:
            final responseTokenEmiWeb = getTokenEmiWebFromMap(
            response.body);
            tokenGlobal = responseTokenEmiWeb.accessToken;
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


  Future<bool> executeInstrucciones(List<Bitacora> instruccionesBitacora) async {
    if (await getTokenOAuth()) {
      for (var i = 0; i < instruccionesBitacora.length; i++) {
        print("Tamaño instrucciones Emi Web: ${instruccionesBitacora.length}");
        print("Instrucción a realizar en Emi Web: ${instruccionesBitacora[i].instrucciones}");
        switch (instruccionesBitacora[i].instrucciones) {
          case "syncAddEmprendedor":
            print("Entro al caso de syncAddEmprendedor Emi Web");
            final emprendedorToSync = getFirstEmprendedor(dataBase.emprendedoresBox.getAll(), instruccionesBitacora[i].id);
            if(emprendedorToSync != null){
              banderasExistoSync.add(await syncAddEmprendedor(emprendedorToSync, instruccionesBitacora[i].id));         
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddEmprendimiento":
            print("Entro al caso de syncAddEmprendimiento Emi Web");
            banderasExistoSync.add(syncAddEmprendimiento(instruccionesBitacora[i].id));
            continue;
          case "syncAddJornada1":
            print("Entro al caso de syncAddJornada1 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              banderasExistoSync.add(await syncAddJornada12y4(jornadaToSync, instruccionesBitacora[i].id));         
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddJornada2":
            print("Entro al caso de syncAddJornada2 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              banderasExistoSync.add(await syncAddJornada12y4(jornadaToSync, instruccionesBitacora[i].id));         
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncAddJornada3":
            print("Entro al caso de syncAddJornada3 Emi Web");
            final jornadaToSync = getFirstJornada(dataBase.jornadasBox.getAll(), instruccionesBitacora[i].id);
            if(jornadaToSync != null){
              banderasExistoSync.add(await syncAddJornada3(jornadaToSync, instruccionesBitacora[i].id));         
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
            }
          case "syncUpdateFaseEmprendimiento":
            print("Entro al caso de syncUpdateFaseEmprendimiento Emi Web");
            final emprendimientoToSync = getFirstEmprendimiento(dataBase.emprendimientosBox.getAll(), instruccionesBitacora[i].id);
            if(emprendimientoToSync != null){
              banderasExistoSync.add(await syncUpdateFaseEmprendimiento(emprendimientoToSync, instruccionesBitacora[i]));         
            continue;
            } else {
              //Salimos del bucle
              banderasExistoSync.add(false);
              i = instruccionesBitacora.length;
              break;
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
        print("Porceso de sync Emi Web exitoso");
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = true;
        dataBase.bitacoraBox.removeAll(); //TOD0: Quitar instrucción cuando se hayan colocado todos los casos de instrucciones.
        notifyListeners();
        return exitoso;
      } else {
        print("Porceso de sync Emi Web fallido");
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        notifyListeners();
        return exitoso;
      }
    } else {
      print("Porceso de sync Emi Web fallido por Token");
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      notifyListeners();
      return false;
    }

  }

  Usuarios? getFirstUsuario(List<Usuarios> usuarios, int idInstruccionesBitacora)
  {
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

  Emprendedores? getFirstEmprendedor(List<Emprendedores> emprendedores, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendedores.length; i++) {
      if (emprendedores[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendedores[i].bitacora.length; j++) {
          if (emprendedores[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendedores[i];
          } 
        }
      }
    }
    return null;
  }
  Emprendimientos? getFirstEmprendimiento(List<Emprendimientos> emprendimientos, int idInstruccionesBitacora)
  {
    for (var i = 0; i < emprendimientos.length; i++) {
      if (emprendimientos[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < emprendimientos[i].bitacora.length; j++) {
          if (emprendimientos[i].bitacora[j].id == idInstruccionesBitacora) {
            return emprendimientos[i];
          } 
        }
      }
    }
    return null;
  }
  Jornadas? getFirstJornada(List<Jornadas> jornadas, int idInstruccionesBitacora)
  {
    for (var i = 0; i < jornadas.length; i++) {
      if (jornadas[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < jornadas[i].bitacora.length; j++) {
          if (jornadas[i].bitacora[j].id == idInstruccionesBitacora) {
            return jornadas[i];
          } 
        }
      }
    }
    return null;
  }
  Inversiones? getFirstInversion(List<Inversiones> inversiones, int idInstruccionesBitacora)
  {
    for (var i = 0; i < inversiones.length; i++) {
      if (inversiones[i].bitacora.isEmpty) {
        
      } else {
        for (var j = 0; j < inversiones[i].bitacora.length; j++) {
          if (inversiones[i].bitacora[j].id == idInstruccionesBitacora) {
            return inversiones[i];
          } 
        }
      }
    }
    return null;
  }
  Consultorias? getFirstConsultoria(List<Consultorias> consultorias, int idInstruccionesBitacora)
  {
    for (var i = 0; i < consultorias.length; i++) {
      if (consultorias[i].bitacora.isEmpty) {

      } else {
        for (var j = 0; j < consultorias[i].bitacora.length; j++) {
          if (consultorias[i].bitacora[j].id == idInstruccionesBitacora) {
            return consultorias[i];
          } 
        }
      }
    }
    return null;
  }
  ProductosEmp? getFirstProductoEmprendedor(List<ProductosEmp> productosEmp, int idInstruccionesBitacora)
    {
      for (var i = 0; i < productosEmp.length; i++) {
        if (productosEmp[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < productosEmp[i].bitacora.length; j++) {
            if (productosEmp[i].bitacora[j].id == idInstruccionesBitacora) {
              return productosEmp[i];
            } 
          }
        }
      }
      return null;
    }
  Ventas? getFirstVenta(List<Ventas> ventas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < ventas.length; i++) {
        if (ventas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < ventas[i].bitacora.length; j++) {
            if (ventas[i].bitacora[j].id == idInstruccionesBitacora) {
              return ventas[i];
            } 
          }
        }
      }
      return null;
    }
  ProdVendidos? getFirstProductoVendido(List<ProdVendidos> prodVendidos, int idInstruccionesBitacora)
    {
      for (var i = 0; i < prodVendidos.length; i++) {
        if (prodVendidos[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < prodVendidos[i].bitacora.length; j++) {
            if (prodVendidos[i].bitacora[j].id == idInstruccionesBitacora) {
              return prodVendidos[i];
            } 
          }
        }
      }
      return null;
    }
  Tareas? getFirstTarea(List<Tareas> tareas, int idInstruccionesBitacora)
    {
      for (var i = 0; i < tareas.length; i++) {
        if (tareas[i].bitacora.isEmpty) {

        } else {
          for (var j = 0; j < tareas[i].bitacora.length; j++) {
            if (tareas[i].bitacora[j].id == idInstruccionesBitacora) {
              return tareas[i];
            } 
          }
        }
      }
      return null;
    }


  Future<bool> syncAddEmprendedor(Emprendedores emprendedor, int idInstruccionBitacora) async {
    print("Estoy en El syncAddEmprendedor de Emi Web");
    try {
      final emprendimientoToSync = dataBase.emprendimientosBox.get(emprendedor.emprendimiento.target!.id);
      if (emprendimientoToSync != null) {
        //Verificamos que no se haya posteado anteriormente el emprendedor y emprendimiento
        if (emprendedor.idEmiWeb == null && emprendimientoToSync.idEmiWeb == null) {
          // Primero creamos el emprendedor asociado al emprendimiento
          final crearEmprendedorUri =
            Uri.parse('$baseUrlEmiWebServices/emprendedores/registro/crear');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Nombre: ${emprendedor.nombre}");
          print("Fecha: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(emprendedor.fechaRegistro)}");
          final responsePostEmprendedor = await post(crearEmprendedorUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": 1, //TODO: Cambiar a usuario correcto
            "nombreUsuario": "${emprendedor.emprendimiento
            .target!.usuario.target!.nombre} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoP} ${emprendedor.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "nombre": emprendedor.nombre,
            "apellidos": emprendedor.apellidos,
            "curp": emprendedor.curp,
            "integrantesFamilia": emprendedor.integrantesFamilia,
            "comunidad": emprendedor.comunidad.target!.idEmiWeb,
            "estado": emprendedor.comunidad.target!.municipios.target!.estados.target!.idEmiWeb,
            "municipio": emprendedor.comunidad.target!.municipios.target!.idEmiWeb,
            "emprendimiento": emprendedor.emprendimiento.target!.nombre,
            "telefono": emprendedor.telefono,
            "comentarios": emprendedor.comentarios,
            "fechaRegistro": (DateFormat("yyyy-MM-ddTHH:mm:ss").format(emprendedor.fechaRegistro)).toString(),
            "archivado": false
          }));
          print(responsePostEmprendedor.statusCode);
          print(responsePostEmprendedor.body);
          print("Respuesta Post Emprendedor");
          switch (responsePostEmprendedor.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Emprendedor");
            //Se recupera el id Emi Web del Emprendedor que será el mismo id para el Emprendimiento
            final responsePostEmprendedorParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostEmprendedor.bodyBytes));
            emprendedor.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendedoresBox.put(emprendedor);
            //Segundo creamos el emprendimiento
            //Se recupera el id Emi Web del Emprendimiento
            emprendimientoToSync.idEmiWeb = responsePostEmprendedorParse.payload!.id.toString();
            dataBase.emprendimientosBox.put(emprendimientoToSync);
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear emprendedor Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe un emprendimiento asociado al emprendedor de forma local
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      return false;
    }
}

  bool syncAddEmprendimiento(int idInstruccionBitacora) {
    print("Estoy en El syncAddEmprendimiento de Emi Web");
    try {
      //Se elimina la instrucción de la bitacora
      print("Elimino Instrucción de bitacora");
      dataBase.bitacoraBox.remove(idInstruccionBitacora);
      return true;
    } catch (e) {
      print('ERROR - function syncAddEmprendimiento(): $e');
      return false;
    }
  }

  Future<bool> syncAddJornada12y4(Jornadas jornada, int idInstruccionBitacora) async {
    print("Estoy en El syncAddJornada12y4 de Emi Web");
    try {
      final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (tareaToSync != null) {
        //Verificamos que no se haya posteado anteriormente el emprendedor y emprendimiento
        if (jornada.idEmiWeb == null && tareaToSync.idEmiWeb == null) {
          // Primero creamos la jornada asociada a la tarea
          final crearJornadaUri =
            Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Número de Jornada: ${jornada.numJornada}");
          print("Fecha Registro: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro)}");
          print("Fecha Revisión: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision)}");
          final responsePostJornada = await post(crearJornadaUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": 1, //TODO: Cambiar a usuario correcto
            "nombreUsuario": "${jornada.emprendimiento
            .target!.usuario.target!.nombre} ${jornada.emprendimiento
            .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
            "registrarTarea": jornada.tarea.target!.tarea,
            "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
            "comentarios": jornada.tarea.target!.comentarios,
            "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
            "descripcion": jornada.tarea.target!.descripcion,
            "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
            "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
          }));
          print(responsePostJornada.statusCode);
          print(responsePostJornada.body);
          print("Respuesta Post Jornada");
          switch (responsePostJornada.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Jornada");
            //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
            final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostJornada.bodyBytes));
            jornada.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
            dataBase.jornadasBox.put(jornada);
            //Segundo creamos la Tarea
            //Se recupera el id Emi Web de la Tarea
            tareaToSync.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
            dataBase.tareasBox.put(tareaToSync);
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      return false;
    }
}

  Future<bool> syncAddJornada3(Jornadas jornada, int idInstruccionBitacora) async {
    print("Estoy en El syncAddJornada3 de Emi Web");
    try {
      final tareaToSync = dataBase.tareasBox.get(jornada.tarea.target!.id);
      if (tareaToSync != null) {
        //Verificamos que no se haya posteado anteriormente el emprendedor y emprendimiento
        if (jornada.idEmiWeb == null && tareaToSync.idEmiWeb == null) {
          // Primero creamos la jornada asociada a la tarea
          final crearJornadaUri =
            Uri.parse('$baseUrlEmiWebServices/jornadas?jornada=${jornada.numJornada}');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Número de Jornada: ${jornada.numJornada}");
          print("Fecha Registro: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro)}");
          print("Fecha Revisión: ${DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision)}");
          final responsePostJornada = await post(crearJornadaUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuario": 1, //TODO: Cambiar a usuario correcto
            "nombreUsuario": "${jornada.emprendimiento
            .target!.usuario.target!.nombre} ${jornada.emprendimiento
            .target!.usuario.target!.apellidoP} ${jornada.emprendimiento
            .target!.usuario.target!.apellidoM}",
            "fechaRegistro": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRegistro),
            "registrarTarea": jornada.tarea.target!.tarea,
            "fechaRevision": DateFormat("yyyy-MM-ddTHH:mm:ss").format(jornada.fechaRevision),
            "comentarios": jornada.tarea.target!.comentarios,
            "tareaCompletada": false, //Es falso por que apenas la estamos dando de alta
            "descripcion": jornada.tarea.target!.descripcion,
            "idProyecto": jornada.emprendimiento.target!.idEmiWeb,
            "nombreEmprendimiento": jornada.emprendimiento.target!.nombre,
          }));
          print(responsePostJornada.statusCode);
          print(responsePostJornada.body);
          print("Respuesta Post Jornada");
          switch (responsePostJornada.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Jornada");
            //Se recupera el id Emi Web de la Jornada que será el mismo id para la Tarea
            final responsePostJornadaParse = postRegistroExitosoEmiWebFromMap(
            const Utf8Decoder().convert(responsePostJornada.bodyBytes));
            jornada.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
            dataBase.jornadasBox.put(jornada);
            //Segundo creamos la Tarea
            //Se recupera el id Emi Web de la Tarea
            tareaToSync.idEmiWeb = responsePostJornadaParse.payload!.id.toString();
            dataBase.tareasBox.put(tareaToSync);
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(idInstruccionBitacora);
            return true;
            default: //No se realizo con éxito el post
              print("Error en postear jornada Emi Web");
              return false;
          }       
        } else {
          //Ya se ha posteado anteriormente
          //Se elimina la instrucción de la bitacora
          dataBase.bitacoraBox.remove(idInstruccionBitacora);
          return true;
        }
      } else {
        //No existe una tarea asociada a la jornada de forma local
        return false;
      }
    } catch (e) { //Fallo en el momento se sincronizar
      return false;
    }
}

  Future<bool> syncUpdateFaseEmprendimiento(Emprendimientos emprendimiento, Bitacora bitacora) async {
    print("Estoy en El syncUpdateFaseEmprendimiento en Emi Web");
    try {
      final faseActual = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(bitacora.instruccionAdicional!)).build().findUnique();
      if (faseActual != null) {
        // Primero creamos el API para realizar la actualización
          final actualizarFaseEmprendimientoUri =
            Uri.parse('$baseUrlEmiWebServices/proyectos/fase');
          final headers = ({
            "Content-Type": "application/json",
            'Authorization': 'Bearer $tokenGlobal',
          });
          print("Fase Actual: ${faseActual.fase}");
          print("Id Emprendimiento: ${emprendimiento.idEmiWeb}");
          final responsePostUpdateFaseEmprendimiento = await put(actualizarFaseEmprendimientoUri, 
          headers: headers,
          body: jsonEncode({
            "idUsuarioRegistra": 1,
            "usuarioRegistra": "Álvaro Lozano Platonoff",
            "id": emprendimiento.idEmiWeb,
            "idCatFase": faseActual.idEmiWeb,
          }));
          print(responsePostUpdateFaseEmprendimiento.statusCode);
          print(responsePostUpdateFaseEmprendimiento.body);
          print("Respuesta Post Update Fase Emprendimiento");
          switch (responsePostUpdateFaseEmprendimiento.statusCode) {
            case 200:
            print("Caso 200 en Emi Web Update Fase Emprendimiento");
            //Se elimina la instrucción de la bitacora
            dataBase.bitacoraBox.remove(bitacora.id);
            return true;
            default: //No se realizo con éxito el post
              print("Error en actualizar fase emprendimiento Emi Web");
              return false;
          }  
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function syncUpdateFaseEmprendimiento(): $e');
      return false;
    }
  }

}
