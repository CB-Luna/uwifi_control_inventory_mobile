import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/modelsLocales/estatus/estatus_data.dart';

class FrenosController extends ChangeNotifier {

  GlobalKey<FormState> frenosFormKey = GlobalKey<FormState>();

  //Datos del formulario Frenos
  String balatasDelanteras = "";
  String observacionesBalatasDelanteras = "";
  String balatasTraserasDiscoTambor = "";
  String observacionesBalatasTraserasDiscoTambor = "";
  String manguerasLineas = "";
  String observacionesManguerasLineas = "";
  String cilindroMaestro = "";
  String observacionesCilindroMaestro = "";
  String birlosYTuercas = "";
  String observacionesBirlosYTuercas = "";


  bool validateForm(GlobalKey<FormState> frenosFormKey) {
    return frenosFormKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    balatasDelanteras = "";
    observacionesBalatasDelanteras = "";
    balatasTraserasDiscoTambor = "";
    observacionesBalatasTraserasDiscoTambor = "";
    manguerasLineas = "";
    observacionesManguerasLineas = "";
    cilindroMaestro = "";
    observacionesCilindroMaestro = "";
    birlosYTuercas = "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarBalatasDelanterasBueno ()
  {
   if (balatasDelanteras == "Bueno") {
     balatasDelanteras = "";
   } else {
      balatasDelanteras = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBalatasDelanterasRecomendado ()
  {
   if (balatasDelanteras == "Recomendado") {
     balatasDelanteras = "";
   } else {
      balatasDelanteras = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBalatasDelanterasUrgente ()
  {
   if (balatasDelanteras == "Urgente") {
     balatasDelanteras = "";
   } else {
      balatasDelanteras = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBalatasTraserasDiscoTamborBueno ()
  {
   if (balatasTraserasDiscoTambor == "Bueno") {
     balatasTraserasDiscoTambor = "";
   } else {
      balatasTraserasDiscoTambor = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBalatasTraserasDiscoTamborRecomendado ()
  {
   if (balatasTraserasDiscoTambor == "Recomendado") {
     balatasTraserasDiscoTambor = "";
   } else {
      balatasTraserasDiscoTambor = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBalatasTraserasDiscoTamborUrgente ()
  {
   if (balatasTraserasDiscoTambor == "Urgente") {
     balatasTraserasDiscoTambor = "";
   } else {
      balatasTraserasDiscoTambor = "Urgente";
   }
    notifyListeners();
  }


   void actualizarManguerasLineasBueno ()
  {
   if (manguerasLineas == "Bueno") {
     manguerasLineas = "";
   } else {
      manguerasLineas = "Bueno";
   }
    notifyListeners();
  }
  void actualizarManguerasLineasRecomendado ()
  {
   if (manguerasLineas == "Recomendado") {
     manguerasLineas = "";
   } else {
      manguerasLineas = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarManguerasLineasUrgente ()
  {
   if (manguerasLineas == "Urgente") {
     manguerasLineas = "";
   } else {
      manguerasLineas = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (balatasDelanteras != "" 
    && balatasTraserasDiscoTambor != ""
    && manguerasLineas != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarCilindroMaestroBueno ()
  {
   if (cilindroMaestro == "Bueno") {
     cilindroMaestro = "";
   } else {
      cilindroMaestro = "Bueno";
   }
    notifyListeners();
  }
  void actualizarCilindroMaestroRecomendado ()
  {
   if (cilindroMaestro == "Recomendado") {
     cilindroMaestro = "";
   } else {
      cilindroMaestro = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarCilindroMaestroUrgente ()
  {
   if (cilindroMaestro == "Urgente") {
     cilindroMaestro = "";
   } else {
      cilindroMaestro = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBirlosYTuercasBueno ()
  {
   if (birlosYTuercas == "Bueno") {
     birlosYTuercas = "";
   } else {
      birlosYTuercas = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBirlosYTuercasRecomendado ()
  {
   if (birlosYTuercas == "Recomendado") {
     birlosYTuercas = "";
   } else {
      birlosYTuercas = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBirlosYTuercasUrgente ()
  {
   if (birlosYTuercas == "Urgente") {
     birlosYTuercas = "";
   } else {
      birlosYTuercas = "Urgente";
   }
    notifyListeners();
  }

    bool validarSeccionDosFormulario ()
  {
    if (cilindroMaestro != "" 
    && birlosYTuercas != "") {
      return true;
    } else {
      return false;
    }
  }

  
  bool agregarFrenos(OrdenTrabajo ordenTrabajo) {
    try {
      //Se válida que la inspección exista en la orden de trabajo
      final fechaRegistro =  DateTime.now();
      final nuevoFrenos = Frenos(
          balatasDelanteras: balatasDelanteras,
          balatasDelanterasObservaciones: observacionesBalatasDelanteras,
          balatasTraserasDiscoTambor: balatasTraserasDiscoTambor,
          balatasTraserasDiscoTamborObservaciones: observacionesBalatasTraserasDiscoTambor,
          manguerasLineas: manguerasLineas,
          manguerasLineasObservaciones: observacionesManguerasLineas,
          cilindroMaestro: cilindroMaestro,
          cilindroMaestroObservaciones: observacionesCilindroMaestro,
          birlosYTuercas: birlosYTuercas,
          birlosYTuercasObservaciones: observacionesBirlosYTuercas,
          completado: true,
          fechaRegistro: fechaRegistro,
        );
      //Inspección
      if (ordenTrabajo.estatus.target!.estatus == "Observación")  {
        final estatus = listaEstatusData.elementAt(2);
        dataBase.estatusBox.put(estatus);
        ordenTrabajo.estatus.target = estatus;
      } else{
        // ordenTrabajo.estatus.target!.avance = 0.05; 
      }
      if (ordenTrabajo.inspeccion.target == null) {
        final nuevaInspeccion = Inspeccion(
          completado: false,
          fechaRegistro: fechaRegistro,
        );
        nuevaInspeccion.frenos.target = nuevoFrenos;
        nuevoFrenos.inspeccion.target = nuevaInspeccion;
        dataBase.frenosBox.put(nuevoFrenos);
        dataBase.inspeccionBox.put(nuevaInspeccion);
        ordenTrabajo.inspeccion.target = nuevaInspeccion;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionInspeccion = Bitacora(
          instruccion: 'syncAgregarInspeccion',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionInspeccion);
        final nuevaInstruccionFrenos = Bitacora(
          instruccion: 'syncAgregarFrenos',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionFrenos);
        notifyListeners();
        return true;

      } else {
        nuevoFrenos.inspeccion.target = ordenTrabajo.inspeccion.target;
        ordenTrabajo.inspeccion.target!.frenos.target = nuevoFrenos;
        dataBase.frenosBox.put(nuevoFrenos);
        dataBase.inspeccionBox.put(ordenTrabajo.inspeccion.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionFrenos = Bitacora(
          instruccion: 'syncAgregarFrenos',
          usuario: prefs.getString("userId")!,
          idEmprendimiento: 0,
        ); //Se crea la nueva instruccion a realizar en bitacora
        dataBase.bitacoraBox.put(nuevaInstruccionFrenos);
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
