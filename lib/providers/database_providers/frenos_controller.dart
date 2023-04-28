import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';

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
      //Se válida que la revisión exista en la orden de trabajo
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
        nuevaRevision.frenos.target = nuevoFrenos;
        nuevoFrenos.revision.target = nuevaRevision;
        nuevaRevision.ordenTrabajo.target = ordenTrabajo;
        ordenTrabajo.revision.target = nuevaRevision;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionRevision = Bitacora(
          instruccion: 'syncAgregarRevision',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionRevision.revision.target = nuevaRevision;
        dataBase.bitacoraBox.put(nuevaInstruccionRevision);
        dataBase.revisionBox.put(nuevaRevision);
        final nuevaInstruccionFrenos = Bitacora(
          instruccion: 'syncAgregarFrenos',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionFrenos.frenos.target = nuevoFrenos;
        dataBase.bitacoraBox.put(nuevaInstruccionFrenos);
        dataBase.frenosBox.put(nuevoFrenos);
        notifyListeners();
        return true;
      } else {
        nuevoFrenos.revision.target = ordenTrabajo.revision.target;
        ordenTrabajo.revision.target!.frenos.target = nuevoFrenos;
        if (ordenTrabajo.revision.target?.suspensionDireccion.target != null 
          && ordenTrabajo.revision.target?.frenos.target != null
          && ordenTrabajo.revision.target?.fluidos.target != null
          && ordenTrabajo.revision.target?.electrico.target != null
          && ordenTrabajo.revision.target?.motor.target != null) {      
          ordenTrabajo.revision.target!.completado = true;
          final nuevaInstruccionRevision = Bitacora(
            instruccion: 'syncActualizarRevision',
            usuarioPropietario: prefs.getString("userId")!,
            idOrdenTrabajo: ordenTrabajo.id,
          ); //Se crea la nueva instruccion a realizar en bitacora
          nuevaInstruccionRevision.revision.target = ordenTrabajo.revision.target;
          dataBase.bitacoraBox.put(nuevaInstruccionRevision);
        }
        dataBase.revisionBox.put(ordenTrabajo.revision.target!);
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionFrenos = Bitacora(
          instruccion: 'syncAgregarFrenos',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionFrenos.frenos.target = nuevoFrenos;
        dataBase.bitacoraBox.put(nuevaInstruccionFrenos);
        dataBase.frenosBox.put(nuevoFrenos);
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
    notifyListeners();
  }
}
