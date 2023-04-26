import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';

class ElectricoController extends ChangeNotifier {

  GlobalKey<FormState> electricoFormKey = GlobalKey<FormState>();

  //Datos del formulario Electrico
  String terminalesDeBateria = "";
  String observacionesTerminalesDeBateria = "";
  String lucesFrenos = "";
  String observacionesLucesFrenos = "";
  String lucesDireccionales = "";
  String observacionesLucesDireccionales = "";
  String lucesCuartos= "";
  String observacionesLucesCuartos= "";
  String checkEngine= "";
  String observacionesCheckEngine= "";


  bool validateForm(GlobalKey<FormState> electricoFormKey) {
    return electricoFormKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    terminalesDeBateria = "";
    observacionesTerminalesDeBateria = "";
    lucesFrenos = "";
    observacionesLucesFrenos = "";
    lucesDireccionales = "";
    observacionesLucesDireccionales = "";
    lucesCuartos= "";
    observacionesLucesCuartos= "";
    checkEngine= "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarTerminalesDeBateriaBueno ()
  {
   if (terminalesDeBateria == "Bueno") {
     terminalesDeBateria = "";
   } else {
      terminalesDeBateria = "Bueno";
   }
    notifyListeners();
  }
  void actualizarTerminalesDeBateriaRecomendado ()
  {
   if (terminalesDeBateria == "Recomendado") {
     terminalesDeBateria = "";
   } else {
      terminalesDeBateria = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarTerminalesDeBateriaUrgente ()
  {
   if (terminalesDeBateria == "Urgente") {
     terminalesDeBateria = "";
   } else {
      terminalesDeBateria = "Urgente";
   }
    notifyListeners();
  }
  void actualizarLucesFrenosBueno ()
  {
   if (lucesFrenos == "Bueno") {
     lucesFrenos = "";
   } else {
      lucesFrenos = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLucesFrenosRecomendado ()
  {
   if (lucesFrenos == "Recomendado") {
     lucesFrenos = "";
   } else {
      lucesFrenos = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLucesFrenosUrgente ()
  {
   if (lucesFrenos == "Urgente") {
     lucesFrenos = "";
   } else {
      lucesFrenos = "Urgente";
   }
    notifyListeners();
  }


   void actualizarLucesDireccionalesBueno ()
  {
   if (lucesDireccionales == "Bueno") {
     lucesDireccionales = "";
   } else {
      lucesDireccionales = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLucesDireccionalesRecomendado ()
  {
   if (lucesDireccionales == "Recomendado") {
     lucesDireccionales = "";
   } else {
      lucesDireccionales = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLucesDireccionalesUrgente ()
  {
   if (lucesDireccionales == "Urgente") {
     lucesDireccionales = "";
   } else {
      lucesDireccionales = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (terminalesDeBateria != "" 
    && lucesFrenos != ""
    && lucesDireccionales != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarLucesCuartosBueno ()
  {
   if (lucesCuartos == "Bueno") {
     lucesCuartos = "";
   } else {
      lucesCuartos = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLucesCuartosRecomendado ()
  {
   if (lucesCuartos == "Recomendado") {
     lucesCuartos = "";
   } else {
      lucesCuartos = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLucesCuartosUrgente ()
  {
   if (lucesCuartos == "Urgente") {
     lucesCuartos = "";
   } else {
      lucesCuartos = "Urgente";
   }
    notifyListeners();
  }
  void actualizarCheckEngineBueno ()
  {
   if (checkEngine == "Bueno") {
     checkEngine = "";
   } else {
      checkEngine = "Bueno";
   }
    notifyListeners();
  }
  void actualizarCheckEngineRecomendado ()
  {
   if (checkEngine == "Recomendado") {
     checkEngine = "";
   } else {
      checkEngine = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarCheckEngineUrgente ()
  {
   if (checkEngine == "Urgente") {
     checkEngine = "";
   } else {
      checkEngine = "Urgente";
   }
    notifyListeners();
  }

    bool validarSeccionDosFormulario ()
  {
    if (lucesCuartos != "" 
    && checkEngine != "") {
      return true;
    } else {
      return false;
    }
  }

  
  bool agregarSistemaElectrico(OrdenTrabajo ordenTrabajo) {
    try {
      //Se válida que la inspección exista en la orden de trabajo
      final fechaRegistro =  DateTime.now();
      final nuevoElectrico = Electrico(
          terminalesDeBaterias: terminalesDeBateria,
          terminalesDeBateriasObservaciones: observacionesTerminalesDeBateria,
          lucesFrenos: lucesFrenos,
          lucesFrenosObservaciones: observacionesLucesFrenos,
          lucesDireccionales: lucesDireccionales,
          lucesDireccionalesObservaciones: observacionesLucesDireccionales,
          lucesCuartos: lucesCuartos,
          lucesCuartosObservaciones: observacionesLucesCuartos,
          checkEngine: checkEngine,
          checkEngineObservaciones: observacionesCheckEngine,
          completado: true,
          fechaRegistro: fechaRegistro,
        );
      //Inspección
      if (ordenTrabajo.estatus.target!.estatus == "Observación") {
        final estatus = dataBase.estatusBox
          .query(Estatus_.estatus.equals("Inspección"))
          .build()
          .findFirst();
        ordenTrabajo.estatus.target = estatus;
        final nuevaInstruccionEstatusOrdenTrabajo = Bitacora(
          instruccion: 'syncActualizarEstatusOrdenTrabajo',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
          instruccionAdicional: estatus?.estatus,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionEstatusOrdenTrabajo.ordenTrabajo.target = ordenTrabajo;
        dataBase.bitacoraBox.put(nuevaInstruccionEstatusOrdenTrabajo);
      } 
      if (ordenTrabajo.inspeccion.target == null) {
        final nuevaInspeccion = Inspeccion(
          completado: false,
          fechaRegistro: fechaRegistro,
        );
        nuevaInspeccion.electrico.target = nuevoElectrico;
        nuevoElectrico.inspeccion.target = nuevaInspeccion;
        nuevaInspeccion.ordenTrabajo.target = ordenTrabajo;
        ordenTrabajo.inspeccion.target = nuevaInspeccion;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionInspeccion = Bitacora(
          instruccion: 'syncAgregarInspeccion',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionInspeccion.inspeccion.target = nuevaInspeccion;
        dataBase.bitacoraBox.put(nuevaInstruccionInspeccion);
        dataBase.inspeccionBox.put(nuevaInspeccion);
        final nuevaInstruccionElectrico = Bitacora(
          instruccion: 'syncAgregarElectrico',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionElectrico.electrico.target = nuevoElectrico;
        dataBase.bitacoraBox.put(nuevaInstruccionElectrico);
        dataBase.electricoBox.put(nuevoElectrico);
        notifyListeners();
        return true;
      } else {
        nuevoElectrico.inspeccion.target = ordenTrabajo.inspeccion.target;
        ordenTrabajo.inspeccion.target!.electrico.target = nuevoElectrico;
        dataBase.electricoBox.put(nuevoElectrico);
        if (ordenTrabajo.inspeccion.target?.suspensionDireccion.target != null 
          && ordenTrabajo.inspeccion.target?.frenos.target != null
          && ordenTrabajo.inspeccion.target?.fluidos.target != null
          && ordenTrabajo.inspeccion.target?.electrico.target != null
          && ordenTrabajo.inspeccion.target?.motor.target != null) {      
          ordenTrabajo.inspeccion.target!.completado = true;
          final nuevaInstruccionInspeccion = Bitacora(
            instruccion: 'syncActualizarInspeccion',
            usuarioPropietario: prefs.getString("userId")!,
            idOrdenTrabajo: ordenTrabajo.id,
          ); //Se crea la nueva instruccion a realizar en bitacora
          nuevaInstruccionInspeccion.inspeccion.target = ordenTrabajo.inspeccion.target;
          dataBase.bitacoraBox.put(nuevaInstruccionInspeccion);
        }
        dataBase.inspeccionBox.put(ordenTrabajo.inspeccion.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionElectrico = Bitacora(
          instruccion: 'syncAgregarElectrico',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionElectrico.electrico.target = nuevoElectrico;
        dataBase.bitacoraBox.put(nuevaInstruccionElectrico);
        dataBase.electricoBox.put(nuevoElectrico);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idOrdenTrabajo) {
    notifyListeners();
  }
}
