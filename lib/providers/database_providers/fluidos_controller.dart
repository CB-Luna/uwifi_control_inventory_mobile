import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsLocales/estatus/estatus_data.dart';

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

  
  bool agregarFluidos(OrdenTrabajo ordenTrabajo) {
    try {
      //Se válida que la inspección exista en la orden de trabajo
      final fechaRegistro =  DateTime.now();
      final nuevoFluidos = Fluidos(
          atf: atf,
          atfObservaciones: observacionesATF,
          power: power,
          powerObservaciones: observacionesPower,
          frenos: frenos,
          frenosObservaciones: observacionesFrenos,
          anticongelante: anticongelante,
          anticongelanteObservaciones: observacionesAnticongelante,
          wipers: wipers,
          wipersObservaciones: observacionesWipers,
          completado: true,
          fechaRegistro: fechaRegistro,
        );
      //Inspección
      if (ordenTrabajo.estatus.target!.estatus == "Observación")  {
        final estatus = listaEstatusData.elementAt(2);
        dataBase.estatusBox.put(estatus);
        ordenTrabajo.estatus.target = estatus;
      } else{
        // ordenTrabajo.estatus.target!.avance += 0.05; 
      }
      if (ordenTrabajo.inspeccion.target == null) {
        final nuevaInspeccion = Inspeccion(
          completado: false,
          fechaRegistro: fechaRegistro,
        );
        nuevaInspeccion.fluidos.target = nuevoFluidos;
        nuevoFluidos.inspeccion.target = nuevaInspeccion;
        dataBase.fluidosBox.put(nuevoFluidos);
        dataBase.inspeccionBox.put(nuevaInspeccion);
        ordenTrabajo.inspeccion.target = nuevaInspeccion;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionInspeccion = Bitacora(
          instruccion: 'syncAgregarInspeccion',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionInspeccion);
        final nuevaInstruccionFluidos = Bitacora(
          instruccion: 'syncAgregarFluidos',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionFluidos);
        notifyListeners();
        return true;

      } else {
        nuevoFluidos.inspeccion.target = ordenTrabajo.inspeccion.target;
        ordenTrabajo.inspeccion.target!.fluidos.target = nuevoFluidos;
        dataBase.fluidosBox.put(nuevoFluidos);
        dataBase.inspeccionBox.put(ordenTrabajo.inspeccion.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionFluidos = Bitacora(
          instruccion: 'syncAgregarFluidos',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionFluidos);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    final updateEmprendedor = dataBase.emprendedoresBox.get(id);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendedor != null) {
      updateEmprendedor.nombre = newNombre;
      updateEmprendedor.apellidos = newApellidos;
      updateEmprendedor.curp = newCurp;
      updateEmprendedor.integrantesFamilia = newIntegrantesFamilia;
      updateEmprendedor.telefono =  newTelefono;
      updateEmprendedor.comentarios =  newComentarios;
      updateEmprendedor.comunidad.target = dataBase.comunidadesBox.get(idComunidad);
      updateEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.emprendedoresBox.put(updateEmprendedor);

    }
    notifyListeners();
  }
}
