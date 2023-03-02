import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class ClienteController extends ChangeNotifier {

  GlobalKey<FormState> clienteFormKey = GlobalKey<FormState>();

  //Datos del Cliente
  Imagenes? imagenCliente;
  String nombre = "";
  String apellidoP = "";
  String apellidoM = "";
  String rfc = "";
  String domicilio = "";
  String telefono = "";
  String celular = "";
  String correo = ""; 

  bool validateForm(GlobalKey<FormState> clienteKey) {
    return clienteKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    imagenCliente = null;
    nombre = "";
    apellidoP = "";
    apellidoM = "";
    rfc = "";
    domicilio = "";
    telefono = "";
    celular = "";
    correo = "";
    notifyListeners();
  }


  int add() {
    final nuevoCliente = Cliente(
      nombre: nombre, 
      apellidoP: apellidoP,
      apellidoM: apellidoM, 
      rfc: rfc,
      domicilio: domicilio,
      telefono: telefono, 
      celular: celular, 
      correo: correo,  
    );

    nuevoCliente.imagen.target = imagenCliente;
    final nuevaInstruccion = Bitacora(
      instruccion: 'syncAgregarCliente',
      usuario: prefs.getString("userId")!,
      idEmprendimiento: 0,
    ); //Se crea la nueva instruccion a realizar en bitacora
    nuevaInstruccion.cliente.target = nuevoCliente; //Se asigna el cliente a la nueva instrucción
    nuevoCliente.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al cliente
    dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
    final idCliente = dataBase.clienteBox.put(nuevoCliente); //Agregamos el cliente en objectBox
    notifyListeners();
    return idCliente;
  }

  void update(int id, String newNombre, String newApellidos, String newRfc, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    final updateEmprendedor = dataBase.emprendedoresBox.get(id);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendedor != null) {
      updateEmprendedor.nombre = newNombre;
      updateEmprendedor.apellidos = newApellidos;
      updateEmprendedor.integrantesFamilia = newIntegrantesFamilia;
      updateEmprendedor.telefono =  newTelefono;
      updateEmprendedor.comentarios =  newComentarios;
      updateEmprendedor.comunidad.target = dataBase.comunidadesBox.get(idComunidad);
      updateEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.emprendedoresBox.put(updateEmprendedor);

    }
    notifyListeners();
  }

  // void addImagen(int idEmprendimiento) {
  //   final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  //   if (emprendimiento != null) {
  //     final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
  //     imagenLocal!.bitacora.add(nuevaInstruccion);
  //     emprendimiento.emprendedor.target!.imagen.target = imagenLocal;
  //     dataBase.imagenesBox.put(imagenLocal!);
  //     dataBase.emprendedoresBox.put(emprendimiento.emprendedor.target!);
  //     //print('Imagen Emprendedor agregada exitosamente');
  //     notifyListeners();
  //   } 
  // }

  void updateImagen(int id, Imagenes newImagen, int idEmprendimiento) {
    final updateImagen = dataBase.imagenesBox.get(id);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    if (updateImagen != null) {
      updateImagen.nombre = newImagen.nombre;
      updateImagen.path = newImagen.path;
      updateImagen.base64 = newImagen.base64;
      updateImagen.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(updateImagen);
      //print('Imagen de Emprendedor actualizada exitosamente');
    }
    notifyListeners();
  }

  void remove(Emprendedores emprendedor) {
    dataBase.emprendedoresBox.remove(emprendedor.id);  //Se elimina de bitacora la instruccion creada anteriormente
    // emprendedores.remove(emprendedor);
    notifyListeners(); 
  }
  
}