 import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
class SuspensionDireccionController extends ChangeNotifier {

  GlobalKey<FormState> suspensionDireccionFormKey = GlobalKey<FormState>();

  //Datos del formulario Suspensión/Dirección
  String rotulaSuperiorIzq = "";
  String observacionesRotulaSuperiorIzq = "";
  String rotulaSuperiorDer = "";
  String observacionesRotulaSuperiorDer = "";
  String rotulaInferiorIzq = "";
  String observacionesRotulaInferiorIzq = "";
  String rotulaInferiorDer = "";
  String observacionesRotulaInferiorDer = "";
  String bujeHorquillaSuperiorIzq = "";
  String observacionesBujeHorquillaSuperiorIzq = "";
  String bujeHorquillaSuperiorDer = "";
  String observacionesBujeHorquillaSuperiorDer = "";
  String bujeHorquillaInferiorIzq = "";
  String observacionesBujeHorquillaInferiorIzq = "";
  String bujeHorquillaInferiorDer = "";
  String observacionesBujeHorquillaInferiorDer = "";
  String amortiguadorDelanteroIzq = "";
  String observacionesAmortiguadorDelanteroIzq = "";
  String amortiguadorDelanteroDer = "";
  String observacionesAmortiguadorDelanteroDer = "";
  String amortiguadorTraseroIzq = "";
  String observacionesAmortiguadorTraseroIzq = "";
  String amortiguadorTraseroDer = "";
  String observacionesAmortiguadorTraseroDer = "";
  String bujeBarraEstabilizadoraIzq = "";
  String observacionesBujeBarraEstabilizadoraIzq = "";
  String bujeBarraEstabilizadoraDer = "";
  String observacionesBujeBarraEstabilizadoraDer = "";
  String linkKitDelanteroIzq = "";
  String observacionesLinkKitDelanteroIzq = "";
  String linkKitDelanteroDer = "";
  String observacionesLinkKitDelanteroDer = "";
  String linkKitTraseroIzq = "";
  String observacionesLinkKitTraseroIzq = "";
  String linkKitTraseroDer = "";
  String observacionesLinkKitTraseroDer = "";
  String terminalInteriorIzq = "";
  String observacionesTerminalInteriorIzq = "";
  String terminalInteriorDer = "";
  String observacionesTerminalInteriorDer = "";
  String terminalExteriorIzq = "";
  String observacionesTerminalExteriorIzq = "";
  String terminalExteriorDer = "";
  String observacionesTerminalExteriorDer = "";


  bool validateForm(GlobalKey<FormState> suspensionDireccionKey) {
    return suspensionDireccionKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    rotulaSuperiorIzq = "";
    observacionesRotulaSuperiorIzq = "";
    rotulaSuperiorDer = "";
    observacionesRotulaSuperiorDer = "";
    rotulaInferiorIzq = "";
    observacionesRotulaInferiorIzq = "";
    rotulaInferiorDer = "";
    observacionesRotulaInferiorDer = "";
    bujeHorquillaSuperiorIzq = "";
    observacionesBujeHorquillaSuperiorIzq = "";
    bujeHorquillaSuperiorDer = "";
    observacionesBujeHorquillaSuperiorDer = "";
    bujeHorquillaInferiorIzq = "";
    observacionesBujeHorquillaInferiorIzq = "";
    bujeHorquillaInferiorDer = "";
    observacionesBujeHorquillaInferiorDer = "";
    amortiguadorDelanteroIzq = "";
    observacionesAmortiguadorDelanteroIzq = "";
    amortiguadorDelanteroDer = "";
    observacionesAmortiguadorDelanteroDer = "";
    amortiguadorTraseroIzq = "";
    observacionesAmortiguadorTraseroIzq = "";
    amortiguadorTraseroDer = "";
    observacionesAmortiguadorTraseroDer = "";
    bujeBarraEstabilizadoraIzq = "";
    observacionesBujeBarraEstabilizadoraIzq = "";
    bujeBarraEstabilizadoraDer = "";
    observacionesBujeBarraEstabilizadoraDer = "";
    linkKitDelanteroIzq = "";
    observacionesLinkKitDelanteroIzq = "";
    linkKitDelanteroDer = "";
    observacionesLinkKitDelanteroDer = "";
    linkKitTraseroIzq = "";
    observacionesLinkKitTraseroIzq = "";
    linkKitTraseroDer = "";
    observacionesLinkKitTraseroDer = "";
    terminalInteriorIzq = "";
    observacionesTerminalInteriorIzq = "";
    terminalInteriorDer = "";
    observacionesTerminalInteriorDer = "";
    terminalExteriorIzq = "";
    observacionesTerminalExteriorIzq = "";
    terminalExteriorDer = "";
    observacionesTerminalExteriorDer = "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarRotulaSuperiorIzqBueno ()
  {
   if (rotulaSuperiorIzq == "Bueno") {
     rotulaSuperiorIzq = "";
   } else {
      rotulaSuperiorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarRotulaSuperiorIzqRecomendado ()
  {
   if (rotulaSuperiorIzq == "Recomendado") {
     rotulaSuperiorIzq = "";
   } else {
      rotulaSuperiorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarRotulaSuperiorIzqUrgente ()
  {
   if (rotulaSuperiorIzq == "Urgente") {
     rotulaSuperiorIzq = "";
   } else {
      rotulaSuperiorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarRotulaSuperiorDerBueno ()
  {
   if (rotulaSuperiorDer == "Bueno") {
     rotulaSuperiorDer = "";
   } else {
      rotulaSuperiorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarRotulaSuperiorDerRecomendado ()
  {
   if (rotulaSuperiorDer == "Recomendado") {
     rotulaSuperiorDer = "";
   } else {
      rotulaSuperiorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarRotulaSuperiorDerUrgente ()
  {
   if (rotulaSuperiorDer == "Urgente") {
     rotulaSuperiorDer = "";
   } else {
      rotulaSuperiorDer = "Urgente";
   }
    notifyListeners();
  }


   void actualizarRotulaInferiorIzqBueno ()
  {
   if (rotulaInferiorIzq == "Bueno") {
     rotulaInferiorIzq = "";
   } else {
      rotulaInferiorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarRotulaInferiorIzqRecomendado ()
  {
   if (rotulaInferiorIzq == "Recomendado") {
     rotulaInferiorIzq = "";
   } else {
      rotulaInferiorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarRotulaInferiorIzqUrgente ()
  {
   if (rotulaInferiorIzq == "Urgente") {
     rotulaInferiorIzq = "";
   } else {
      rotulaInferiorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarRotulaInferiorDerBueno ()
  {
   if (rotulaInferiorDer == "Bueno") {
     rotulaInferiorDer = "";
   } else {
      rotulaInferiorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarRotulaInferiorDerRecomendado ()
  {
   if (rotulaInferiorDer == "Recomendado") {
     rotulaInferiorDer = "";
   } else {
      rotulaInferiorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarRotulaInferiorDerUrgente ()
  {
   if (rotulaInferiorDer == "Urgente") {
     rotulaInferiorDer = "";
   } else {
      rotulaInferiorDer = "Urgente";
   }
    notifyListeners();
  }


   void actualizarBujeHorquillaSuperiorIzqBueno ()
  {
   if (bujeHorquillaSuperiorIzq == "Bueno") {
     bujeHorquillaSuperiorIzq = "";
   } else {
      bujeHorquillaSuperiorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaSuperiorIzqRecomendado ()
  {
   if (bujeHorquillaSuperiorIzq == "Recomendado") {
     bujeHorquillaSuperiorIzq = "";
   } else {
      bujeHorquillaSuperiorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaSuperiorIzqUrgente ()
  {
   if (bujeHorquillaSuperiorIzq == "Urgente") {
     bujeHorquillaSuperiorIzq = "";
   } else {
      bujeHorquillaSuperiorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaSuperiorDerBueno ()
  {
   if (bujeHorquillaSuperiorDer == "Bueno") {
     bujeHorquillaSuperiorDer = "";
   } else {
      bujeHorquillaSuperiorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaSuperiorDerRecomendado ()
  {
   if (bujeHorquillaSuperiorDer == "Recomendado") {
     bujeHorquillaSuperiorDer = "";
   } else {
      bujeHorquillaSuperiorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaSuperiorDerUrgente ()
  {
   if (bujeHorquillaSuperiorDer == "Urgente") {
     bujeHorquillaSuperiorDer = "";
   } else {
      bujeHorquillaSuperiorDer = "Urgente";
   }
    notifyListeners();
  }

  void actualizarBujeHorquillaInferiorIzqBueno ()
  {
   if (bujeHorquillaInferiorIzq == "Bueno") {
     bujeHorquillaInferiorIzq = "";
   } else {
      bujeHorquillaInferiorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaInferiorIzqRecomendado ()
  {
   if (bujeHorquillaInferiorIzq == "Recomendado") {
     bujeHorquillaInferiorIzq = "";
   } else {
      bujeHorquillaInferiorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaInferiorIzqUrgente ()
  {
   if (bujeHorquillaInferiorIzq == "Urgente") {
     bujeHorquillaInferiorIzq = "";
   } else {
      bujeHorquillaInferiorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaInferiorDerBueno ()
  {
   if (bujeHorquillaInferiorDer == "Bueno") {
     bujeHorquillaInferiorDer = "";
   } else {
      bujeHorquillaInferiorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaInferiorDerRecomendado ()
  {
   if (bujeHorquillaInferiorDer == "Recomendado") {
     bujeHorquillaInferiorDer = "";
   } else {
      bujeHorquillaInferiorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeHorquillaInferiorDerUrgente ()
  {
   if (bujeHorquillaInferiorDer == "Urgente") {
     bujeHorquillaInferiorDer = "";
   } else {
      bujeHorquillaInferiorDer = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (rotulaSuperiorIzq != "" 
    && rotulaSuperiorDer != ""
    && rotulaInferiorIzq != ""
    && rotulaInferiorDer != ""
    && bujeHorquillaSuperiorIzq != ""
    && bujeHorquillaSuperiorDer != ""
    && bujeHorquillaInferiorIzq != ""
    && bujeHorquillaInferiorDer != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarAmortiguadorDelanteroIzqBueno ()
  {
   if (amortiguadorDelanteroIzq == "Bueno") {
     amortiguadorDelanteroIzq = "";
   } else {
      amortiguadorDelanteroIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorDelanteroIzqRecomendado ()
  {
   if (amortiguadorDelanteroIzq == "Recomendado") {
     amortiguadorDelanteroIzq = "";
   } else {
      amortiguadorDelanteroIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorDelanteroIzqUrgente ()
  {
   if (amortiguadorDelanteroIzq == "Urgente") {
     amortiguadorDelanteroIzq = "";
   } else {
      amortiguadorDelanteroIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorDelanteroDerBueno ()
  {
   if (amortiguadorDelanteroDer == "Bueno") {
     amortiguadorDelanteroDer = "";
   } else {
      amortiguadorDelanteroDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorDelanteroDerRecomendado ()
  {
   if (amortiguadorDelanteroDer == "Recomendado") {
     amortiguadorDelanteroDer = "";
   } else {
      amortiguadorDelanteroDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorDelanteroDerUrgente ()
  {
   if (amortiguadorDelanteroDer == "Urgente") {
     amortiguadorDelanteroDer = "";
   } else {
      amortiguadorDelanteroDer = "Urgente";
   }
    notifyListeners();
  }

  void actualizarAmortiguadorTraseroIzqBueno ()
  {
   if (amortiguadorTraseroIzq == "Bueno") {
     amortiguadorTraseroIzq = "";
   } else {
      amortiguadorTraseroIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorTraseroIzqRecomendado ()
  {
   if (amortiguadorTraseroIzq == "Recomendado") {
     amortiguadorTraseroIzq = "";
   } else {
      amortiguadorTraseroIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorTraseroIzqUrgente ()
  {
   if (amortiguadorTraseroIzq == "Urgente") {
     amortiguadorTraseroIzq = "";
   } else {
      amortiguadorTraseroIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorTraseroDerBueno ()
  {
   if (amortiguadorTraseroDer == "Bueno") {
     amortiguadorTraseroDer = "";
   } else {
      amortiguadorTraseroDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorTraseroDerRecomendado ()
  {
   if (amortiguadorTraseroDer == "Recomendado") {
     amortiguadorTraseroDer = "";
   } else {
      amortiguadorTraseroDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAmortiguadorTraseroDerUrgente ()
  {
   if (amortiguadorTraseroDer == "Urgente") {
     amortiguadorTraseroDer = "";
   } else {
      amortiguadorTraseroDer = "Urgente";
   }
    notifyListeners();
  }


  void actualizarBujeBarraEstabilizadoraIzqBueno ()
  {
   if (bujeBarraEstabilizadoraIzq == "Bueno") {
     bujeBarraEstabilizadoraIzq = "";
   } else {
      bujeBarraEstabilizadoraIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeBarraEstabilizadoraIzqRecomendado ()
  {
   if (bujeBarraEstabilizadoraIzq == "Recomendado") {
     bujeBarraEstabilizadoraIzq = "";
   } else {
      bujeBarraEstabilizadoraIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeBarraEstabilizadoraIzqUrgente ()
  {
   if (bujeBarraEstabilizadoraIzq == "Urgente") {
     bujeBarraEstabilizadoraIzq = "";
   } else {
      bujeBarraEstabilizadoraIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBujeBarraEstabilizadoraDerBueno ()
  {
   if (bujeBarraEstabilizadoraDer == "Bueno") {
     bujeBarraEstabilizadoraDer = "";
   } else {
      bujeBarraEstabilizadoraDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujeBarraEstabilizadoraDerRecomendado ()
  {
   if (bujeBarraEstabilizadoraDer == "Recomendado") {
     bujeBarraEstabilizadoraDer = "";
   } else {
      bujeBarraEstabilizadoraDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujeBarraEstabilizadoraDerUrgente ()
  {
   if (bujeBarraEstabilizadoraDer == "Urgente") {
     bujeBarraEstabilizadoraDer = "";
   } else {
      bujeBarraEstabilizadoraDer = "Urgente";
   }
    notifyListeners();
  }

    bool validarSeccionDosFormulario ()
  {
    if (amortiguadorDelanteroIzq != "" 
    && amortiguadorDelanteroDer != ""
    && amortiguadorTraseroIzq != ""
    && amortiguadorTraseroDer != ""
    && bujeBarraEstabilizadoraIzq != ""
    && bujeBarraEstabilizadoraDer != "") {
      return true;
    } else {
      return false;
    }
  }

  //*********Formulario Tres
  void actualizarLinkKitDelanteroIzqBueno ()
  {
   if (linkKitDelanteroIzq == "Bueno") {
     linkKitDelanteroIzq = "";
   } else {
      linkKitDelanteroIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLinkKitDelanteroIzqRecomendado ()
  {
   if (linkKitDelanteroIzq == "Recomendado") {
     linkKitDelanteroIzq = "";
   } else {
      linkKitDelanteroIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLinkKitDelanteroIzqUrgente ()
  {
   if (linkKitDelanteroIzq == "Urgente") {
     linkKitDelanteroIzq = "";
   } else {
      linkKitDelanteroIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarLinkKitDelanteroDerBueno ()
  {
   if (linkKitDelanteroDer == "Bueno") {
     linkKitDelanteroDer = "";
   } else {
      linkKitDelanteroDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLinkKitDelanteroDerRecomendado ()
  {
   if (linkKitDelanteroDer == "Recomendado") {
     linkKitDelanteroDer = "";
   } else {
      linkKitDelanteroDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLinkKitDelanteroDerUrgente ()
  {
   if (linkKitDelanteroDer == "Urgente") {
     linkKitDelanteroDer = "";
   } else {
      linkKitDelanteroDer = "Urgente";
   }
    notifyListeners();
  }

  void actualizarLinkKitTraseroIzqBueno ()
  {
   if (linkKitTraseroIzq == "Bueno") {
     linkKitTraseroIzq = "";
   } else {
      linkKitTraseroIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLinkKitTraseroIzqRecomendado ()
  {
   if (linkKitTraseroIzq == "Recomendado") {
     linkKitTraseroIzq = "";
   } else {
      linkKitTraseroIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLinkKitTraseroIzqUrgente ()
  {
   if (linkKitTraseroIzq == "Urgente") {
     linkKitTraseroIzq = "";
   } else {
      linkKitTraseroIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarLinkKitTraseroDerBueno ()
  {
   if (linkKitTraseroDer == "Bueno") {
     linkKitTraseroDer = "";
   } else {
      linkKitTraseroDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarLinkKitTraseroDerRecomendado ()
  {
   if (linkKitTraseroDer == "Recomendado") {
     linkKitTraseroDer = "";
   } else {
      linkKitTraseroDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarLinkKitTraseroDerUrgente ()
  {
   if (linkKitTraseroDer == "Urgente") {
     linkKitTraseroDer = "";
   } else {
      linkKitTraseroDer = "Urgente";
   }
    notifyListeners();
  }

  void actualizarTerminalInteriorIzqBueno ()
  {
   if (terminalInteriorIzq == "Bueno") {
     terminalInteriorIzq = "";
   } else {
      terminalInteriorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarTerminalInteriorIzqRecomendado ()
  {
   if (terminalInteriorIzq == "Recomendado") {
     terminalInteriorIzq = "";
   } else {
      terminalInteriorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarTerminalInteriorIzqUrgente ()
  {
   if (terminalInteriorIzq == "Urgente") {
     terminalInteriorIzq = "";
   } else {
      terminalInteriorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarTerminalInteriorDerBueno ()
  {
   if (terminalInteriorDer == "Bueno") {
     terminalInteriorDer = "";
   } else {
      terminalInteriorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarTerminalInteriorDerRecomendado ()
  {
   if (terminalInteriorDer == "Recomendado") {
     terminalInteriorDer = "";
   } else {
      terminalInteriorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarTerminalInteriorDerUrgente ()
  {
   if (terminalInteriorDer == "Urgente") {
     terminalInteriorDer = "";
   } else {
      terminalInteriorDer = "Urgente";
   }
    notifyListeners();
  }

    void actualizarTerminalExteriorIzqBueno ()
  {
   if (terminalExteriorIzq == "Bueno") {
     terminalExteriorIzq = "";
   } else {
      terminalExteriorIzq = "Bueno";
   }
    notifyListeners();
  }
  void actualizarTerminalExteriorIzqRecomendado ()
  {
   if (terminalExteriorIzq == "Recomendado") {
     terminalExteriorIzq = "";
   } else {
      terminalExteriorIzq = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarTerminalExteriorIzqUrgente ()
  {
   if (terminalExteriorIzq == "Urgente") {
     terminalExteriorIzq = "";
   } else {
      terminalExteriorIzq = "Urgente";
   }
    notifyListeners();
  }
  void actualizarTerminalExteriorDerBueno ()
  {
   if (terminalExteriorDer == "Bueno") {
     terminalExteriorDer = "";
   } else {
      terminalExteriorDer = "Bueno";
   }
    notifyListeners();
  }
  void actualizarTerminalExteriorDerRecomendado ()
  {
   if (terminalExteriorDer == "Recomendado") {
     terminalExteriorDer = "";
   } else {
      terminalExteriorDer = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarTerminalExteriorDerUrgente ()
  {
   if (terminalExteriorDer == "Urgente") {
     terminalExteriorDer = "";
   } else {
      terminalExteriorDer = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionTresFormulario ()
  {
    if (linkKitDelanteroIzq != "" 
    && linkKitDelanteroDer != ""
    && linkKitTraseroIzq != ""
    && linkKitTraseroDer != ""
    && terminalInteriorIzq != ""
    && terminalInteriorDer != ""
    && terminalExteriorIzq != ""
    && terminalExteriorDer != "") {
      return true;
    } else {
      return false;
    }
  }
  
  bool agregarSuspensionDireccion(OrdenTrabajo ordenTrabajo) {
    try {
      //Se válida que la inspección exista en la orden de trabajo
      final fechaRegistro =  DateTime.now();
      final nuevaSuspensionDireccion = SuspensionDireccion(
          rotulaSuperiorIzq: rotulaSuperiorIzq, 
          rotulaSuperiorIzqObservaciones: observacionesRotulaSuperiorIzq,
          rotulaSuperiorDer: rotulaSuperiorDer, 
          rotulaSuperiorDerObservaciones: observacionesRotulaSuperiorDer,
          rotulaInferiorIzq: rotulaInferiorIzq, 
          rotulaInferiorIzqObservaciones: observacionesRotulaInferiorIzq,
          rotulaInferiorDer: rotulaInferiorDer, 
          rotulaInferiorDerObservaciones: observacionesRotulaInferiorDer,
          bujeHorquillaSuperiorIzq: bujeHorquillaSuperiorIzq, 
          bujeHorquillaSuperiorIzqObservaciones: observacionesBujeHorquillaSuperiorIzq,
          bujeHorquillaSuperiorDer: bujeHorquillaSuperiorDer, 
          bujeHorquillaSuperiorDerObservaciones: observacionesBujeHorquillaSuperiorDer,
          bujeHorquillaInferiorIzq: bujeHorquillaInferiorIzq, 
          bujeHorquillaInferiorIzqObservaciones: observacionesBujeHorquillaInferiorIzq,
          bujeHorquillaInferiorDer: bujeHorquillaInferiorDer, 
          bujeHorquillaInferiorDerObservaciones: observacionesBujeHorquillaInferiorDer,
          amortiguadorDelanteroIzq: amortiguadorDelanteroIzq, 
          amortiguadorDelanteroIzqObservaciones: observacionesAmortiguadorDelanteroIzq,
          amortiguadorDelanteroDer: amortiguadorDelanteroDer, 
          amortiguadorDelanteroDerObservaciones: observacionesAmortiguadorDelanteroDer,
          amortiguadorTraseroIzq: amortiguadorTraseroIzq, 
          amortiguadorTraseroIzqObservaciones: observacionesAmortiguadorTraseroIzq,
          amortiguadorTraseroDer: amortiguadorTraseroDer, 
          amortiguadorTraseroDerObservaciones: observacionesAmortiguadorTraseroDer,
          bujeBarraEstabilizadoraIzq: bujeBarraEstabilizadoraIzq, 
          bujeBarraEstabilizadoraIzqObservaciones: observacionesBujeBarraEstabilizadoraIzq,
          bujeBarraEstabilizadoraDer: bujeBarraEstabilizadoraDer, 
          bujeBarraEstabilizadoraDerObservaciones: observacionesBujeBarraEstabilizadoraDer,
          linkKitDelanteroIzq: linkKitDelanteroIzq, 
          linkKitDelanteroIzqObservaciones: observacionesLinkKitDelanteroIzq,
          linkKitDelanteroDer: linkKitDelanteroDer, 
          linkKitDelanteroDerObservaciones: observacionesLinkKitDelanteroDer,
          linkKitTraseroIzq: linkKitTraseroIzq, 
          linkKitTraseroIzqObservaciones: observacionesLinkKitTraseroIzq,
          linkKitTraseroDer: linkKitTraseroDer, 
          linkKitTraseroDerObservaciones: observacionesLinkKitTraseroDer,
          terminalInteriorIzq: terminalInteriorIzq, 
          terminalInteriorIzqObservaciones: observacionesTerminalInteriorIzq,
          terminalInteriorDer: terminalInteriorDer, 
          terminalInteriorDerObservaciones: observacionesTerminalInteriorDer,
          terminalExteriorIzq: terminalExteriorIzq, 
          terminalExteriorIzqObservaciones: observacionesTerminalExteriorIzq,
          terminalExteriorDer: terminalExteriorDer, 
          terminalExteriorDerObservaciones: observacionesTerminalExteriorDer,
          completado: true,
          fechaRegistro: fechaRegistro,
        );
      //Inspección
      if (ordenTrabajo.estatus.target!.estatus == "Observación")  {
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
        nuevaInspeccion.suspensionDireccion.target = nuevaSuspensionDireccion;
        nuevaSuspensionDireccion.inspeccion.target = nuevaInspeccion;
        nuevaInspeccion.ordenTrabajo.target = ordenTrabajo;
        ordenTrabajo.inspeccion.target = nuevaInspeccion;
        dataBase.ordenTrabajoBox.put(ordenTrabajo);
        final nuevaInstruccionInspeccion = Bitacora(
          instruccion: 'syncAgregarInspeccion',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionInspeccion.inspeccion.target = nuevaInspeccion;
        dataBase.inspeccionBox.put(nuevaInspeccion);
        dataBase.bitacoraBox.put(nuevaInstruccionInspeccion);
        final nuevaInstruccionSuspensionDireccion = Bitacora(
          instruccion: 'syncAgregarSuspensionDireccion',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionSuspensionDireccion.suspensionDireccion.target = nuevaSuspensionDireccion;
        dataBase.suspensionDireccionBox.put(nuevaSuspensionDireccion);
        dataBase.bitacoraBox.put(nuevaInstruccionSuspensionDireccion);
        notifyListeners();
        return true;

      } else {
        nuevaSuspensionDireccion.inspeccion.target = ordenTrabajo.inspeccion.target;
        ordenTrabajo.inspeccion.target!.suspensionDireccion.target = nuevaSuspensionDireccion;
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
        final nuevaInstruccionSuspensionDireccion = Bitacora(
          instruccion: 'syncAgregarSuspensionDireccion',
          usuarioPropietario: prefs.getString("userId")!,
          idOrdenTrabajo: ordenTrabajo.id,
        ); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInstruccionSuspensionDireccion.suspensionDireccion.target = nuevaSuspensionDireccion;
        dataBase.suspensionDireccionBox.put(nuevaSuspensionDireccion);
        dataBase.bitacoraBox.put(nuevaInstruccionSuspensionDireccion);
        notifyListeners();
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    notifyListeners();
  }
}
