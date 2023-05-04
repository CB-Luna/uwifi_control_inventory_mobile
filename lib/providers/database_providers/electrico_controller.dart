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

  String tecnicoMecanicoCelularCorreoSeleccionado = "No seleccionado";
  Usuarios? tecnicoMecanicoInterno;
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController tecnicoMecanicoCelularCorreoController = TextEditingController(); 
  String tecnicoMecanicoCelularCorreoIngresado = "";


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

    tecnicoMecanicoCelularCorreoSeleccionado = "No seleccionado";
    tecnicoMecanicoInterno = null;
    tecnicoMecanicoCelularCorreoController.clear();
    tecnicoMecanicoCelularCorreoIngresado = "";
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

  
  bool agregarSistemaElectrico(OrdenTrabajo ordenTrabajo, Electrico electrico) {
    try {
      //Se válida que la revisión exista en la orden de trabajo
      electrico.terminalesDeBaterias = terminalesDeBateria;
      electrico.terminalesDeBateriasObservaciones = observacionesTerminalesDeBateria;
      electrico.lucesFrenos = lucesFrenos;
      electrico.lucesFrenosObservaciones = observacionesLucesFrenos;
      electrico.lucesDireccionales = lucesDireccionales;
      electrico.lucesDireccionalesObservaciones = observacionesLucesDireccionales;
      electrico.lucesCuartos = lucesCuartos;
      electrico.lucesCuartosObservaciones = observacionesLucesCuartos;
      electrico.checkEngine = checkEngine;
      electrico.checkEngineObservaciones = observacionesCheckEngine;
      electrico.completado = true;
      if (ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == true 
        && ordenTrabajo.revision.target?.frenos.target?.completado == true
        && ordenTrabajo.revision.target?.fluidos.target?.completado == true
        && ordenTrabajo.revision.target?.electrico.target?.completado == true
        && ordenTrabajo.revision.target?.motor.target?.completado == true) {      
        ordenTrabajo.revision.target!.completado = true;
        final nuevaInstruccionRevision = Bitacora(
          instruccion: 'syncActualizarRevision',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.revisionBox.put(ordenTrabajo.revision.target!);
        nuevaInstruccionRevision.revision.target = ordenTrabajo.revision.target;
        dataBase.bitacoraBox.put(nuevaInstruccionRevision);
      }
    
    final nuevaInstruccionElectrico = Bitacora(
      instruccion: 'syncAgregarElectrico',
      usuarioPropietario: prefs.getString("userId")!,
      idOrdenTrabajo: ordenTrabajo.id,
    ); //Se crea la nueva instruccion a realizar en bitacora
    nuevaInstruccionElectrico.electrico.target = electrico;
    dataBase.electricoBox.put(electrico);
    dataBase.bitacoraBox.put(nuevaInstruccionElectrico);
    notifyListeners();
    return true;
    } catch (e) {
      return false;
    }
  }

  bool asignarTecnicoMecanicoInterno(OrdenTrabajo ordenTrabajo) {
    if (tecnicoMecanicoInterno != null) {
      final fechaRegistro =  DateTime.now();
      final nuevoElectrico = Electrico(
        terminalesDeBaterias: "",
        terminalesDeBateriasObservaciones: "",
        lucesFrenos: "",
        lucesFrenosObservaciones: "",
        lucesDireccionales: "",
        lucesDireccionalesObservaciones: "",
        lucesCuartos: "",
        lucesCuartosObservaciones: "",
        checkEngine: "",
        checkEngineObservaciones: "",
        completado: false,
        fechaRegistro: fechaRegistro,
      );
      //Revisión
      if (ordenTrabajo.estatus.target!.estatus == "Observación")  {
        final estatus = dataBase.estatusBox
          .query(Estatus_.estatus.equals("Revisión"))
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
      if (ordenTrabajo.revision.target == null) {
        final nuevaRevision = Revision(
          completado: false,
          fechaRegistro: fechaRegistro,
        );
        nuevoElectrico.tecnicoMecanico.target = tecnicoMecanicoInterno;
        tecnicoMecanicoInterno!.electricos.add(nuevoElectrico);
        dataBase.usuariosBox.put(tecnicoMecanicoInterno!);

        nuevaRevision.electrico.target = nuevoElectrico;
        nuevoElectrico.revision.target = nuevaRevision;
        nuevaRevision.ordenTrabajo.target = ordenTrabajo;
        ordenTrabajo.revision.target = nuevaRevision;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionRevision = Bitacora(
          instruccion: 'syncAgregarRevision',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionRevision.revision.target = nuevaRevision;
        dataBase.revisionBox.put(nuevaRevision);
        dataBase.bitacoraBox.put(nuevaInstruccionRevision);
        final nuevaInstruccionElectrico = Bitacora(
          instruccion: 'syncAsignarElectrico',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionElectrico.electrico.target = nuevoElectrico;
        dataBase.electricoBox.put(nuevoElectrico);
        dataBase.bitacoraBox.put(nuevaInstruccionElectrico);
        notifyListeners();
        return true;
      } else {
        nuevoElectrico.tecnicoMecanico.target = tecnicoMecanicoInterno;
        tecnicoMecanicoInterno!.electricos.add(nuevoElectrico);
        dataBase.usuariosBox.put(tecnicoMecanicoInterno!);

        nuevoElectrico.revision.target = ordenTrabajo.revision.target;
        ordenTrabajo.revision.target!.electrico.target = nuevoElectrico;

        dataBase.revisionBox.put(ordenTrabajo.revision.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionElectrico = Bitacora(
          instruccion: 'syncAsignarElectrico',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionElectrico.electrico.target = nuevoElectrico;
        dataBase.electricoBox.put(nuevoElectrico);
        dataBase.bitacoraBox.put(nuevaInstruccionElectrico);
        notifyListeners();
        return true;
      }
    } else {
      notifyListeners();
      return false;
    }
  }

  void enCambioTecnicoMecanicoCelularCorreo(String tecnicoMecanicoCelularCorreo) {
    tecnicoMecanicoCelularCorreoIngresado = tecnicoMecanicoCelularCorreo;
    notifyListeners();
  }


  void seleccionarTecnicoMecanicoCelularCorreo(String tecnicoMecanicoCelularCorreo) {
    String correo = tecnicoMecanicoCelularCorreo.split(" ").last; //Se recupera el VIN del Vehiculo
    tecnicoMecanicoCelularCorreoSeleccionado = tecnicoMecanicoCelularCorreo; 
    tecnicoMecanicoCelularCorreoIngresado = tecnicoMecanicoCelularCorreo;
    tecnicoMecanicoCelularCorreoController.text = tecnicoMecanicoCelularCorreo;
    tecnicoMecanicoInterno = dataBase.usuariosBox.query(Usuarios_.correo.equals(correo)).build().findUnique();
    notifyListeners();
  }


  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idOrdenTrabajo) {
    notifyListeners();
  }
}
