import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';

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
