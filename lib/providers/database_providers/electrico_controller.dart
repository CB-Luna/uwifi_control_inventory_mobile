import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';

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
