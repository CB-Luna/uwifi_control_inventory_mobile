import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsPocketbase/get_imagen_usuario.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bizpro_app/database/entitys.dart';

class UsuarioController extends ChangeNotifier {
  List<Usuarios> usuarios = [];

  Usuarios? usuarioCurrent;
  //Usuario
  String nombre = '';
  String apellidoP = '';
  String apellidoM = '';
  DateTime? nacimiento;
  String telefono = '';
  String celular = '';
  String correo = '';
  String password = '';
  String imagen = '';

  String? currentUser;
  int? currentUserId;

  UsuarioController({String? email}) {
    print("El email es: $email");
    print("Currentuser: $currentUser");
    if (email != null) {
      final query =
          dataBase.usuariosBox.query(Usuarios_.correo.equals(email)).build();
      currentUser = currentUser;
      usuarioCurrent = query.findFirst();
      print(usuarioCurrent?.nombre ?? "SIN NOMBRE");
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
      String telefono,
      String? celular,
      String correo,
      String password,
      GetImagenUsuario? imagen,
      String? idDBR,
      List<String> rolesIdDBR,
      String idEmiWeb,
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
        );
    final nuevoSyncUsuario = StatusSync(); //Se crea el objeto estatus por dedault //M__ para Usuario
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
      );   
      print("Se guarda exitosamente la imagen de perfil");
    } else{
      print("No hay imagen de perfil");
      nuevaImagenUsuario = Imagenes(
      imagenes: "",
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
      nuevoUsuario.statusSync.target = nuevoSyncUsuario;
      nuevoUsuario.imagen.target = nuevaImagenUsuario;

      dataBase.usuariosBox.put(nuevoUsuario);
      usuarios.add(nuevoUsuario);
      print('Usuario agregado exitosamente');
      notifyListeners();
    }
  }

void update(int id, int newIdRol, String newfotoPerfil, String newNombre, String newApellidoP, String newApellidoM, String newTelefono) {
    var updateUsuario = dataBase.usuariosBox.get(id);
    if (updateUsuario != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateUsuario', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateUsuario.nombre = newNombre;
      updateUsuario.apellidoP = newApellidoP;
      updateUsuario.apellidoM = newApellidoM;
      updateUsuario.telefono = newTelefono;
      final updateRol = dataBase.rolesBox.get(newIdRol);
      if (updateRol != null) {
        updateUsuario.rol.target = updateRol; //Se actualiza el rol del Usuario
      }
      final updateImagenUsuario = dataBase.imagenesBox.query(Imagenes_.id.equals(updateUsuario.imagen.target?.id ?? -1)).build().findUnique();
      if (updateImagenUsuario != null) {
        updateImagenUsuario.imagenes = newfotoPerfil; //Se actualiza la imagen del usuario
        dataBase.imagenesBox.put(updateImagenUsuario);
      }
      final statusSyncUsuario = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateUsuario.statusSync.target?.id ?? -1)).build().findUnique();
      if (statusSyncUsuario != null) {
        statusSyncUsuario.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del usuario
        dataBase.statusSyncBox.put(statusSyncUsuario);
      } 
      updateUsuario.bitacora.add(nuevaInstruccion);
      dataBase.usuariosBox.put(updateUsuario);
      print('Usuario actualizado exitosamente');
    }
    notifyListeners();
  }

  getAll() {
    usuarios = dataBase.usuariosBox.getAll();
    notifyListeners();
  }

  //Usuario existente o no en la base de Datos
  bool validateUser(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email) {
        return true;
      }
    }
    return false;
  }

  bool validateUserOffline(String email, String password) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email && usuarios[i].password == password) {
        return true;
      }
    }
    return false;
  }

  //Se recupera ID del Usuario ya existente
  void getUserID(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email) {
        currentUserId = usuarios[i].id;
        currentUser = email;
        print('ID Usuario recuperado exitosamente');
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
    print('Emprendimiento modificado exitosamente');
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
