
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';


class MotorController extends ChangeNotifier {

  GlobalKey<FormState> motorFormKey = GlobalKey<FormState>();

  //Datos del formulario Motor
  String aceite = "";
  String observacionesAceite = "";
  String filtroDeAire = "";
  String observacionesFiltroDeAire = "";
  String cpoDeAceleracion = "";
  String observacionesCpoDeAceleracion = "";
  String bujias = "";
  String observacionesBujias = "";
  String bandaCadenaTiempo = "";
  String observacionesBandaCadenaTiempo = "";
  String soportes = "";
  String observacionesSoportes = "";
  String bandas = "";
  String observacionesBandas = "";
  String mangueras = "";
  String observacionesMangueras = "";


  bool validateForm(GlobalKey<FormState> motorFormKey) {
    return motorFormKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    aceite = "";
    observacionesAceite = "";
    filtroDeAire = "";
    observacionesFiltroDeAire = "";
    cpoDeAceleracion = "";
    observacionesCpoDeAceleracion = "";
    bujias = "";
    observacionesBujias = "";
    bandaCadenaTiempo = "";
    observacionesBandaCadenaTiempo = "";
    soportes = "";
    observacionesSoportes = "";
    bandas = "";
    observacionesBandas = "";
    mangueras = "";
    observacionesMangueras = "";
    notifyListeners();
  }

  //*********Formulario Uno
  void actualizarAceiteBueno ()
  {
   if (aceite == "Bueno") {
     aceite = "";
   } else {
      aceite = "Bueno";
   }
    notifyListeners();
  }
  void actualizarAceiteRecomendado ()
  {
   if (aceite == "Recomendado") {
     aceite = "";
   } else {
      aceite = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarAceiteUrgente ()
  {
   if (aceite == "Urgente") {
     aceite = "";
   } else {
      aceite = "Urgente";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireBueno ()
  {
   if (filtroDeAire == "Bueno") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Bueno";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireRecomendado ()
  {
   if (filtroDeAire == "Recomendado") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarFiltroDeAireUrgente ()
  {
   if (filtroDeAire == "Urgente") {
     filtroDeAire = "";
   } else {
      filtroDeAire = "Urgente";
   }
    notifyListeners();
  }


   void actualizarCpoDeAceleracionBueno ()
  {
   if (cpoDeAceleracion == "Bueno") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Bueno";
   }
    notifyListeners();
  }
  void actualizarCpoDeAceleracionRecomendado ()
  {
   if (cpoDeAceleracion == "Recomendado") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarCpoDeAceleracionUrgente ()
  {
   if (cpoDeAceleracion == "Urgente") {
     cpoDeAceleracion = "";
   } else {
      cpoDeAceleracion = "Urgente";
   }
    notifyListeners();
  }
  void actualizarBujiasBueno ()
  {
   if (bujias == "Bueno") {
     bujias = "";
   } else {
      bujias = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBujiasRecomendado ()
  {
   if (bujias == "Recomendado") {
     bujias = "";
   } else {
      bujias = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBujiasUrgente ()
  {
   if (bujias == "Urgente") {
     bujias = "";
   } else {
      bujias = "Urgente";
   }
    notifyListeners();
  }

  bool validarSeccionUnoFormulario ()
  {
    if (aceite != "" 
    && filtroDeAire != ""
    && cpoDeAceleracion != ""
    && bujias != "") {
      return true;
    } else {
      return false;
    }
  }


  //*********Formulario Dos
  void actualizarBandaCadenaTiempoBueno ()
  {
   if (bandaCadenaTiempo == "Bueno") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBandaCadenaTiempoRecomendado ()
  {
   if (bandaCadenaTiempo == "Recomendado") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBandaCadenaTiempoUrgente ()
  {
   if (bandaCadenaTiempo == "Urgente") {
     bandaCadenaTiempo = "";
   } else {
      bandaCadenaTiempo = "Urgente";
   }
    notifyListeners();
  }
  void actualizarSoportesBueno ()
  {
   if (soportes == "Bueno") {
     soportes = "";
   } else {
      soportes = "Bueno";
   }
    notifyListeners();
  }
  void actualizarSoportesRecomendado ()
  {
   if (soportes == "Recomendado") {
     soportes = "";
   } else {
      soportes = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarSoportesUrgente ()
  {
   if (soportes == "Urgente") {
     soportes = "";
   } else {
      soportes = "Urgente";
   }
    notifyListeners();
  }

  void actualizarBandasBueno ()
  {
   if (bandas == "Bueno") {
     bandas = "";
   } else {
      bandas = "Bueno";
   }
    notifyListeners();
  }
  void actualizarBandasRecomendado ()
  {
   if (bandas == "Recomendado") {
     bandas = "";
   } else {
      bandas = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarBandasUrgente ()
  {
   if (bandas == "Urgente") {
     bandas = "";
   } else {
      bandas = "Urgente";
   }
    notifyListeners();
  }
  void actualizarManguerasBueno ()
  {
   if (mangueras == "Bueno") {
     mangueras = "";
   } else {
      mangueras = "Bueno";
   }
    notifyListeners();
  }
  void actualizarManguerasRecomendado ()
  {
   if (mangueras == "Recomendado") {
     mangueras = "";
   } else {
      mangueras = "Recomendado";
   }
    notifyListeners();
  }
  void actualizarManguerasUrgente ()
  {
   if (mangueras == "Urgente") {
     mangueras = "";
   } else {
      mangueras = "Urgente";
   }
    notifyListeners();
  }
    bool validarSeccionDosFormulario ()
  {
    if (bandaCadenaTiempo != "" 
    && soportes != ""
    && bandas != ""
    && mangueras != "") {
      return true;
    } else {
      return false;
    }
  }

  
    bool add(Usuarios usuario, String medida) {
    return true;
    // final nuevaOrdenTrabajo = OrdenTrabajo(
    //   fechaOrden: fechaOrden!,
    //   gasolina: gasolina,
    //   kilometrajeMillaje: "$kilometrajeMillaje $medida",
    //   descripcionFalla: descripcionFalla,  
    // );

    // final nuevaInstruccion = Bitacora(
    //   instruccion: 'syncAgregarOrdenTrabajo',
    //   usuario: prefs.getString("userId")!,
    //   idEmprendimiento: 0,
    // ); //Se crea la nueva instruccion a realizar en bitacora
    
    // final cliente = vehiculo?.cliente.target;
    // // final formaPago = dataBase.formaPagoBox.get(idFormaPago!);
    // if (cliente != null && vehiculo != null) {
    //   nuevaOrdenTrabajo.cliente.target = cliente;
    //   nuevaOrdenTrabajo.vehiculo.target = vehiculo;
    //   // nuevaOrdenTrabajo.formaPago.target = formaPago;
    //   nuevaOrdenTrabajo.usuario.target = usuario;
    //   nuevaInstruccion.ordenTrabajo.target = nuevaOrdenTrabajo; //Se asigna la orden de trabajo a la nueva instrucción
    //   nuevaOrdenTrabajo.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
    //   dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
    //   dataBase.ordenTrabajoBox.put(nuevaOrdenTrabajo); //Agregamos la orden de trabajo en objectBox
    //   usuario.ordenesTrabajo.add(nuevaOrdenTrabajo);
    //   dataBase.usuariosBox.put(usuario);
    //   notifyListeners();
    //   return true;
    // } else {
    //   notifyListeners();
    //   return false;
    // }
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
