import 'dart:convert';
import 'dart:io';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/get_imagen_usuario.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';

class UsuarioController extends ChangeNotifier {
  List<Usuarios> usuarios = [];

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
      String curp,
      String correo,
      String password,
      GetImagenUsuario? imagen,
      List<String> rolesIdDBR,
      String idDBR,
      String idEmiWeb,
      DateTime fechaNacimiento,
      ) async {
    late Imagenes nuevaImagenUsuario;
    final nuevoUsuario = Usuarios(
        nombre: nombre,
        apellidoP: apellidoP,
        apellidoM: apellidoM,
        telefono: telefono,
        celular: celular,
        correo: correo,
        password: password,
        idDBR: idDBR, 
        idEmiWeb: idEmiWeb, 
        fechaNacimiento: fechaNacimiento, 
        curp: curp,
        );
    if (imagen != null) {
      final uInt8ListImagen = base64Decode(imagen.base64);
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/${imagen.nombre}').create();
      file.writeAsBytesSync(uInt8ListImagen);
      nuevaImagenUsuario = Imagenes(
      imagenes: file.path,
      nombre: imagen.nombre,
      path: file.path,
      base64: imagen.base64,
      idEmiWeb: imagen.idEmiWeb,
      idDBR: imagen.id,
      idEmprendimiento: 0,
      );   
      //print("Se guarda exitosamente la imagen de perfil");
    } else{
      //print("No hay imagen de perfil");
      nuevaImagenUsuario = Imagenes(
      imagenes: "",
      idEmprendimiento: 0,
      );
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
      nuevoUsuario.imagen.target = nuevaImagenUsuario;
      nuevaImagenUsuario.usuario.target = nuevoUsuario;
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
      String newPassword,
      GetImagenUsuario? newImagen,
      List<String> newRolesIdDBR,
      ) async {
    // Se recupera el usuario por id
    final updateUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(correo)).build().findUnique();
    if (updateUsuario != null) {
      updateUsuario.nombre = newNombre;
      updateUsuario.apellidoP = newApellidoP;
      updateUsuario.apellidoM = newApellidoM;
      updateUsuario.telefono = newTelefono;
      updateUsuario.celular = newCelular;
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
      if (newImagen != null) {
        if (updateUsuario.imagen.target!.idDBR == null) {
          // Se agrega nueva imagen
          final uInt8ListImagen = base64Decode(newImagen.base64);
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/${newImagen.nombre}').create();
          file.writeAsBytesSync(uInt8ListImagen);
          final nuevaImagenUsuario = Imagenes(
            imagenes: file.path,
            nombre: newImagen.nombre,
            path: file.path,
            base64: newImagen.base64,
            idEmiWeb: newImagen.idEmiWeb,
            idDBR: newImagen.id,
            idEmprendimiento: 0,
          ); 
          nuevaImagenUsuario.usuario.target = updateUsuario;
          dataBase.imagenesBox.put(nuevaImagenUsuario);
          updateUsuario.imagen.target = nuevaImagenUsuario;
        } else {
          //print("Se actualiza imagen USUARIO");
          // Se actualiza imagen
          //print("ID IMAGEN: ${newImagen.idEmiWeb}");
          final uInt8ListImagen = base64Decode(newImagen.base64);
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/${newImagen.nombre}').create();
          file.writeAsBytesSync(uInt8ListImagen);
          updateUsuario.imagen.target!.imagenes = file.path;
          updateUsuario.imagen.target!.nombre = newImagen.nombre;
          updateUsuario.imagen.target!.path = file.path;
          updateUsuario.imagen.target!.base64 = newImagen.base64;
          dataBase.imagenesBox.put(updateUsuario.imagen.target!);
        }
      } else {
        if (updateUsuario.imagen.target!.idDBR != null) {
          // Se eliminan los datos de la imagen actual del usuario
          updateUsuario.imagen.target!.imagenes = "";
          updateUsuario.imagen.target!.nombre = null;
          updateUsuario.imagen.target!.path = null;
          updateUsuario.imagen.target!.base64 = null;
          updateUsuario.imagen.target!.idDBR = null;
          updateUsuario.imagen.target!.idEmiWeb = null;
          updateUsuario.imagen.target!.fechaRegistro = DateTime.now();
          dataBase.imagenesBox.put(updateUsuario.imagen.target!);
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
    var updateUsuario = dataBase.usuariosBox.get(id);
    if (updateUsuario != null) {
      //El id Emprendimiento es 0 porque la instrucción no se relaciona con ningún emprendimiento
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateUsuario', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instruccion a realizar en bitacora
      updateUsuario.nombre = newNombre;
      updateUsuario.apellidoP = newApellidoP;
      updateUsuario.apellidoM = newApellidoM;
      updateUsuario.telefono = newTelefono;
      updateUsuario.bitacora.add(nuevaInstruccion);
      dataBase.usuariosBox.put(updateUsuario);
      //print('Usuario actualizado exitosamente');
    }
    notifyListeners();
  }

void updateImagenUsuario(int idImagenUsuario, String newNombreImagen, String newPath, String newBase64) {
    var updateImagenUsuario = dataBase.imagenesBox.get(idImagenUsuario);
    //El id Emprendimiento es 0 porque la instrucción no se relaciona con ningún emprendimiento
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenUsuario', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instruccion a realizar en bitacora
    if (updateImagenUsuario != null) {
      updateImagenUsuario.imagenes = newPath; //Se actualiza la imagen del usuario
      updateImagenUsuario.nombre = newNombreImagen;
      updateImagenUsuario.base64 = newBase64;
      updateImagenUsuario.path = newPath;
      updateImagenUsuario.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(updateImagenUsuario);
      //print("ID IMAGEN CONFIRMAR: ${updateImagenUsuario.idEmiWeb}");
      //print('Imagen Usuario actualizado exitosamente');
    }
    notifyListeners();
  }

void addImagenUsuario(int idImagenUsuario, String newNombreImagen, String newPath, String newBase64) {
    var newImagenUsuario = dataBase.imagenesBox.get(idImagenUsuario);
    //El id Emprendimiento es 0 porque la instrucción no se relaciona con ningún emprendimiento
    final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenUsuario', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instruccion a realizar en bitacora
    if (newImagenUsuario != null) {
      newImagenUsuario.imagenes = newPath; //Se actualiza la imagen del usuario
      newImagenUsuario.nombre = newNombreImagen;
      newImagenUsuario.base64 = newBase64;
      newImagenUsuario.path = newPath;
      newImagenUsuario.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(newImagenUsuario);
      //print('Imagen Usuario agregada exitosamente');
    }
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

  void addEmprendimiento(Emprendimientos emprendimiento) {
    usuarioCurrent!.emprendimientos.add(emprendimiento);
    dataBase.usuariosBox.put(usuarioCurrent!);
    //print('Emprendimiento modificado exitosamente');
    notifyListeners();
  }

  List<Emprendimientos> getEmprendimientos() {
    final List<Emprendimientos> emprendimientos = [];
    final usuarioActual = dataBase.usuariosBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
        for (var element in usuarioActual.emprendimientos) {
        emprendimientos.add(element);
      }
    }
    return emprendimientos;
  }

}
