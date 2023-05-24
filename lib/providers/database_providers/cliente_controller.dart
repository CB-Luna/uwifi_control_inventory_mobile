import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:uuid/uuid.dart';
class ClienteController extends ChangeNotifier {

  GlobalKey<FormState> clienteFormKey = GlobalKey<FormState>();

  //Datos del Cliente
  String? imagenCliente;
  String? path;
  String nombre = "";
  String apellidoP = "";
  String apellidoM = "";
  String rfc = "";
  String domicilio = "";
  String telefono = "";
  String celular = "";
  String correo = ""; 
  var uuid = Uuid();

  bool validateForm(GlobalKey<FormState> clienteKey) {
    return clienteKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    imagenCliente = null;
    path = null;
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


  int add(Usuarios? asesor) {

    final nuevoCliente = Usuarios(
      nombre: nombre, 
      apellidoP: apellidoP,
      apellidoM: apellidoM, 
      domicilio: domicilio,
      telefono: telefono, 
      celular: celular, 
      correo: correo,
      password: "default",
      idDBR: "sinIdDBR-${uuid.v1()}",
      imagen: imagenCliente,
      path: path,
    );

    final nuevaInstruccion = Bitacora(
      instruccion: 'syncAgregarCliente',
      usuarioPropietario: prefs.getString("userId")!,
      idControlForm: 0,
    ); //Se crea la nueva instruccion a realizar en bitacora
    final rol = dataBase.rolesBox
          .query(Roles_.rol.equals("Cliente"))
          .build()
          .findFirst();
    nuevoCliente.rol.target = rol;
    nuevoCliente.asesor.target = asesor;
    nuevaInstruccion.usuario.target = nuevoCliente; //Se asigna el cliente a la nueva instrucción
    nuevoCliente.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al cliente
    dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
    final idCliente = dataBase.usuariosBox.put(nuevoCliente); //Agregamos el cliente en objectBox
    notifyListeners();
    return idCliente;
  }

  void update(int id, String newNombre, String newApellidos, String newRfc, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {

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


  
}