import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';

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
