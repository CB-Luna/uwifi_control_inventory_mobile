import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';

class FluidosController extends ChangeNotifier {

  GlobalKey<FormState> fluidosFormKey = GlobalKey<FormState>();

  //Datos del formulario Fluidos
  String atf = "";
  String observacionesATF = "";
  String power = "";
  String observacionesPower = "";
  String frenos = "";
  String observacionesFrenos = "";
  String anticongelante = "";
  String observacionesAnticongelante = "";
  String wipers = "";
  String observacionesWipers = "";


  String tecnicoMecanicoCelularCorreoSeleccionado = "No seleccionado";
  Usuarios? tecnicoMecanicoInterno;
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController tecnicoMecanicoCelularCorreoController = TextEditingController(); 
  String tecnicoMecanicoCelularCorreoIngresado = "";

  bool validateForm(GlobalKey<FormState> fluidosFormKey) {
    return fluidosFormKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    atf = "";
    observacionesATF = "";
    power = "";
    observacionesPower = "";
    frenos = "";
    observacionesFrenos = "";
    anticongelante = "";
    observacionesAnticongelante = "";
    wipers = "";
    
    tecnicoMecanicoCelularCorreoSeleccionado = "No seleccionado";
    tecnicoMecanicoInterno = null;
    tecnicoMecanicoCelularCorreoController.clear();
    tecnicoMecanicoCelularCorreoIngresado = "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarATFBueno ()
  {
   if (atf == "Bueno") {
     atf = "";
   } else {
      atf = "Bueno";
   }
    notifyListeners();
  }
  void actualizarATFRecomendado ()
  {
   if (atf == "Recomendado") {
     atf = "";
   } else {
      atf = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarATFUrgente ()
  {
   if (atf == "Urgente") {
     atf = "";
   } else {
      atf = "Urgente";
   }
    notifyListeners();
  }
  void actualizarPowerBueno ()
  {
   if (power == "Bueno") {
     power = "";
   } else {
      power = "Bueno";
   }
    notifyListeners();
  }
  void actualizarPowerRecomendado ()
  {
   if (power == "Recomendado") {
     power = "";
   } else {
      power = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarPowerUrgente ()
  {
   if (power == "Urgente") {
     power = "";
   } else {
      power = "Urgente";
   }
    notifyListeners();
  }


   void actualizarFrenosBueno ()
  {
   if (frenos == "Bueno") {
     frenos = "";
   } else {
      frenos = "Bueno";
   }
    notifyListeners();
  }
  void actualizarFrenosRecomendado ()
  {
   if (frenos == "Recomendado") {
     frenos = "";
   } else {
      frenos = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarFrenosUrgente ()
  {
   if (frenos == "Urgente") {
     frenos = "";
   } else {
      frenos = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (atf != "" 
    && power != ""
    && frenos != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarAnticongelanteBueno ()
  {
   if (anticongelante == "Bueno") {
     anticongelante = "";
   } else {
      anticongelante = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAnticongelanteRecomendado ()
  {
   if (anticongelante == "Recomendado") {
     anticongelante = "";
   } else {
      anticongelante = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAnticongelanteUrgente ()
  {
   if (anticongelante == "Urgente") {
     anticongelante = "";
   } else {
      anticongelante = "Urgente";
   }
    notifyListeners();
  }
  void actualizarWipersBueno ()
  {
   if (wipers == "Bueno") {
     wipers = "";
   } else {
      wipers = "Bueno";
   }
    notifyListeners();
  }
  void actualizarWipersRecomendado ()
  {
   if (wipers == "Recomendado") {
     wipers = "";
   } else {
      wipers = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarWipersUrgente ()
  {
   if (wipers == "Urgente") {
     wipers = "";
   } else {
      wipers = "Urgente";
   }
    notifyListeners();
  }

    bool validarSeccionDosFormulario ()
  {
    if (anticongelante != "" 
    && wipers != "") {
      return true;
    } else {
      return false;
    }
  }

  bool agregarFluidos(OrdenTrabajo ordenTrabajo, Fluidos fluidos) {
    try {
      //Se válida que la revisión exista en la orden de trabajo
      fluidos.atf = atf;
      fluidos.atfObservaciones = observacionesATF;
      fluidos.power = power;
      fluidos.powerObservaciones = observacionesPower;
      fluidos.frenos = frenos;
      fluidos.frenosObservaciones = observacionesFrenos;
      fluidos.anticongelante = anticongelante;
      fluidos.anticongelanteObservaciones = observacionesAnticongelante;
      fluidos.wipers = wipers;
      fluidos.wipersObservaciones = observacionesWipers;
      fluidos.completado = true;
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
    
    final nuevaInstruccionFluidos = Bitacora(
      instruccion: 'syncAgregarFluidos',
      usuarioPropietario: prefs.getString("userId")!,
      idOrdenTrabajo: ordenTrabajo.id,
    ); //Se crea la nueva instruccion a realizar en bitacora
    nuevaInstruccionFluidos.fluidos.target = fluidos;
    dataBase.fluidosBox.put(fluidos);
    dataBase.bitacoraBox.put(nuevaInstruccionFluidos);
    notifyListeners();
    return true;
    } catch (e) {
      return false;
    }
  }

  bool asignarTecnicoMecanicoInterno(OrdenTrabajo ordenTrabajo) {
    if (tecnicoMecanicoInterno != null) {
      final fechaRegistro =  DateTime.now();
      final nuevoFluidos = Fluidos(
        atf: "",
        atfObservaciones: "",
        power: "",
        powerObservaciones: "",
        frenos: "",
        frenosObservaciones: "",
        anticongelante: "",
        anticongelanteObservaciones: "",
        wipers: "",
        wipersObservaciones: "",
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
        nuevoFluidos.tecnicoMecanico.target = tecnicoMecanicoInterno;
        tecnicoMecanicoInterno!.fluidos.add(nuevoFluidos);
        dataBase.usuariosBox.put(tecnicoMecanicoInterno!);

        nuevaRevision.fluidos.target = nuevoFluidos;
        nuevoFluidos.revision.target = nuevaRevision;
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
        final nuevaInstruccionFluidos = Bitacora(
          instruccion: 'syncAsignarFluidos',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionFluidos.fluidos.target = nuevoFluidos;
        dataBase.fluidosBox.put(nuevoFluidos);
        dataBase.bitacoraBox.put(nuevaInstruccionFluidos);
        notifyListeners();
        return true;
      } else {
        nuevoFluidos.tecnicoMecanico.target = tecnicoMecanicoInterno;
        tecnicoMecanicoInterno!.fluidos.add(nuevoFluidos);
        dataBase.usuariosBox.put(tecnicoMecanicoInterno!);

        nuevoFluidos.revision.target = ordenTrabajo.revision.target;
        ordenTrabajo.revision.target!.fluidos.target = nuevoFluidos;

        dataBase.revisionBox.put(ordenTrabajo.revision.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionFluidos = Bitacora(
          instruccion: 'syncAsignarFluidos',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionFluidos.fluidos.target = nuevoFluidos;
        dataBase.fluidosBox.put(nuevoFluidos);
        dataBase.bitacoraBox.put(nuevaInstruccionFluidos);
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
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {

    notifyListeners();
  }
}
