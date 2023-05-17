import 'dart:convert';
import 'dart:io';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UsuarioController extends ChangeNotifier {
  List<Usuarios> usuarios = [];
  var uuid = Uuid();

  Usuarios? usuarioCurrent;
  //Usuario
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  DateTime nacimiento = DateTime.now();
  String telefono = '';
  String curp = '';
  String celular = '';
  String correo = '';
  String password = '';

  String? currentUser;
  int? currentUserId;

  UsuarioController({String? email}) {
    //print("El email es: $email");
    //print("Currentuser: $currentUser");
    if (email != null) {
      final query =
          dataBase.usuariosBox.query(Usuarios_.correo.equals(email)).build();
      currentUser = currentUser;
      usuarioCurrent = query.findFirst();
      //print(usuarioCurrent?.nombre ?? "SIN NOMBRE");
    }
  }

  GlobalKey<FormState> usuarioFormKey = GlobalKey<FormState>();

  bool validateForm(GlobalKey<FormState> usuarioKey) {
    return usuarioKey.currentState!.validate() ? true : false;
  }

  void clearInformation() {
    notifyListeners();
  }

  Future<void> add(
      String nombre,
      String apellidoP,
      String? apellidoM,
      String? telefono,
      String celular,
      String rfc,
      String? domicilio,
      String correo,
      String password,
      String? imagenBase64,
      List<String> rolesIdDBR,
      String idDBR,
      ) async {
    final nuevoUsuario = Usuarios(
        nombre: nombre,
        apellidoP: apellidoP,
        apellidoM: apellidoM,
        telefono: telefono,
        celular: celular,
        correo: correo,
        password: password,
        idDBR: idDBR, 
        rfc: rfc,
        domicilio: domicilio,
        imagen: imagenBase64,
        );
    if (imagenBase64 != null) {
      final uInt8ListImagen = base64Decode(imagenBase64);
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
      file.writeAsBytesSync(uInt8ListImagen);
      nuevoUsuario.path = file.path;
    } 
    //Se crea el objeto imagenes para el Usuario
    //Se agregan los roles
    for (var i = 0; i < rolesIdDBR.length; i++) {
      final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
      if (nuevoRol != null) {
        nuevoUsuario.roles.add(nuevoRol);
      }
    }
    //Se asiga el rol actual que ocupará
    final rolActual = dataBase.rolesBox.query(Roles_.idDBR.equals(rolesIdDBR[0])).build().findUnique(); //Se recupera el rol actual del Usuario
    if (rolActual != null) {
      nuevoUsuario.rol.target = rolActual;
      dataBase.usuariosBox.put(nuevoUsuario);
      usuarios.add(nuevoUsuario);
      //print('Usuario agregado exitosamente');
      notifyListeners();
    }
  }

  Future<bool> update(
      String correo,
      String newNombre,
      String newApellidoP,
      String? newApellidoM,
      String? newTelefono,
      String newCelular,
      String newRFC,
      String? newDomicilio,
      String newPassword,
      String? newImagenBase64,
      List<String> newRolesIdDBR,
      ) async {
    // Se recupera el usuario por id
    final updateUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(correo)).build().findUnique();
    if (updateUsuario != null) {
      updateUsuario.nombre = newNombre;
      updateUsuario.apellidoP = newApellidoP;
      updateUsuario.apellidoM = newApellidoM;
      updateUsuario.nombre = newNombre;
      updateUsuario.telefono = newTelefono;
      updateUsuario.celular = newCelular;
      updateUsuario.rfc = newRFC;
      updateUsuario.domicilio = newDomicilio;
      updateUsuario.password = newPassword;
      //Se agregan los roles actualizados
      updateUsuario.roles.clear();
      for (var i = 0; i < newRolesIdDBR.length; i++) {
        final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(newRolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
        if (nuevoRol != null) {
          updateUsuario.roles.add(nuevoRol);
        }
      } 
      //Se asiga el rol actual que ocupará
      final rolActual = dataBase.rolesBox.query(Roles_.idDBR.equals(newRolesIdDBR[0])).build().findUnique(); //Se recupera el rol actual del Usuario
      if (rolActual != null) {
        updateUsuario.rol.target = rolActual;
      }
      if (newImagenBase64 != null) {
          //print("Se actualiza imagen USUARIO");
          // Se actualiza imagen
          //print("ID IMAGEN: ${newImagen.idEmiWeb}");
          final uInt8ListImagen = base64Decode(newImagenBase64);
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/${uuid.v1()}.jpg').create();
          file.writeAsBytesSync(uInt8ListImagen);
          updateUsuario.imagen = newImagenBase64;
          updateUsuario.path = file.path;
      } else {
        if (updateUsuario.imagen != null) {
          // Se eliminan los datos de la imagen actual del usuario
          updateUsuario.imagen = null;
          updateUsuario.path = null;
        }
      }
      // Se actualiza el usuario con éxito
      dataBase.usuariosBox.put(updateUsuario); 
      return true;
    } else {
      // No se encontró el usuario a actualizar en ObjectBox
      //print("No se encontro usuario en ObjectBox");
      return false;
    }
  }

void updateRol(int id, int newIdRol) {
    var updateUsuario = dataBase.usuariosBox.get(id);
    if (updateUsuario != null) {
      final updateRol = dataBase.rolesBox.get(newIdRol);
      if (updateRol != null) {
        updateUsuario.rol.target = updateRol; //Se actualiza el rol del Usuario
      }
      dataBase.usuariosBox.put(updateUsuario);
      //print('Usuario actualizado exitosamente');
    }
    notifyListeners();
  }

void updateDatos(int id, String newNombre, String newApellidoP, String newApellidoM, String newTelefono) {

    notifyListeners();
  }

void updateImagenUsuario(int idImagenUsuario, String newNombreImagen, String newPath, String newBase64) {

    notifyListeners();
  }

void addImagenUsuario(int idImagenUsuario, String newNombreImagen, String newPath, String newBase64) {

    notifyListeners();
  }
  getAll() {
    usuarios = dataBase.usuariosBox.getAll();
    notifyListeners();
  }

  //Usuario existente o no en la base de Datos
  bool validateUsuario(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email) {
        return true;
      }
    }
    return false;
  }

  Usuarios? validateUserOffline(String email, String password) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email && usuarios[i].password == password) {
        return usuarios[i];
      }
    }
    return null;
  }

  //Se recupera ID del Usuario ya existente
  void getUserID(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email) {
        currentUserId = usuarios[i].id;
        currentUser = email;
        //print('ID Usuario recuperado exitosamente');
      }
    }
    getUser(email);
  }

  //Se recupera informacion del Usuario ya existente
  void getUser(String email) {
    final query =
        dataBase.usuariosBox.query(Usuarios_.correo.equals(email)).build();
    currentUser = email;
    usuarioCurrent = query.findFirst();
  }

  //Se actualiza password del usuarioCurrent
  void updatePasswordLocal(String password) {
    if (usuarioCurrent != null) {
      usuarioCurrent!.password = password;
      dataBase.usuariosBox.put(usuarioCurrent!);
    }
  }


  bool addCliente(int idCliente) {
    final cliente = dataBase.usuariosBox.get(idCliente);
    if (cliente != null) {
      usuarioCurrent!.clientes.add(cliente);
      dataBase.usuariosBox.put(usuarioCurrent!);
      //print('Emprendimiento modificado exitosamente');
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }


  List<OrdenTrabajo> obtenerOrdenesTrabajo() {
    final List<OrdenTrabajo> ordenesTrabajo = [];
    final usuarioActual = dataBase.usuariosBox.get(usuarioCurrent?.id ?? 1);
    if (usuarioActual != null) {
        for (var element in usuarioActual.ordenesTrabajo) {
        ordenesTrabajo.add(element);
      }
    }
    return ordenesTrabajo;
  }

  List<Usuarios> obtenerClientes() {
    final List<Usuarios> clientes = [];
    final usuarioActual = dataBase.usuariosBox.get(usuarioCurrent?.id ?? 1);
    if (usuarioActual != null) {
        for (var element in usuarioActual.clientes) {
        clientes.add(element);
      }
    }
    return clientes;
  }

  List<String> obtenerOpcionesVehiculos() {
    final List<String> opcionesVehiculos = [];
    final usuarioActual = dataBase.usuariosBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
        for (var cliente in usuarioActual.clientes) {
        for (var vehiculo in cliente.vehiculos) {
          opcionesVehiculos.add("${cliente.nombre} ${cliente.apellidoP} ${cliente.apellidoM} ${vehiculo.placas} ${vehiculo.vin}");
        }
      }
    }
    return opcionesVehiculos;
  }

  List<String> obtenerTecnicosMecanicosInternos() {
    List<Usuarios> tecnicosMecanicosInternos = [];
    List<String> opcionesTecnicosMecanicos = [];
    tecnicosMecanicosInternos = dataBase.usuariosBox.query(
            Usuarios_.rol.equals(dataBase.rolesBox.query(
                Roles_.rol.equals("Técnico-Mecánico"))
                .build().findFirst()?.id ?? 0).and(Usuarios_.interno.equals(true))).build().find();
    for (var tecnicoMecanico in tecnicosMecanicosInternos) {
      opcionesTecnicosMecanicos.add("${tecnicoMecanico.nombre} ${tecnicoMecanico.apellidoP} ${tecnicoMecanico.apellidoM} ${tecnicoMecanico.celular} ${tecnicoMecanico.correo}");
    }
    return opcionesTecnicosMecanicos;
  }

}
