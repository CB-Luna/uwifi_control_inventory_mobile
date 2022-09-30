import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
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

  void add(
      String nombre,
      String apellidoP,
      String apellidoM,
      DateTime nacimiento,
      String telefono,
      String celular,
      String correo,
      String password,
      String avatar,
      String idDBR,
      String rolIdDBR,
      ) {
    final nuevoUsuario = Usuarios(
        nombre: nombre,
        apellidoP: apellidoP,
        apellidoM: apellidoM,
        nacimiento: nacimiento,
        telefono: telefono,
        celular: celular,
        correo: correo,
        password: password,
        imagen: avatar,
        idDBR: idDBR,
        );
    final nuevoSyncUsuario = StatusSync(); //Se crea el objeto estatus por dedault //M__ para Usuario
    final nuevaImagenUsuario = Imagenes(imagenes: avatar); //Se crea el objeto imagenes para el Usuario
    final nuevoRol = dataBase.rolesBox.query(Roles_.idDBR.equals(rolIdDBR)).build().findUnique(); //Se recupera el rol del Usuario
    if (nuevoRol != null) {
      nuevoUsuario.statusSync.target = nuevoSyncUsuario;
      nuevoUsuario.image.target = nuevaImagenUsuario;
      nuevoUsuario.rol.target = nuevoRol;
      //TODO: Verifcar si se ocupa esta tabla
      final nuevaVariablesUsuario = VariablesUsuario();
      nuevoUsuario.variablesUsuario.target = nuevaVariablesUsuario;

      dataBase.usuariosBox.put(nuevoUsuario);
      usuarios.add(nuevoUsuario);
      final lastUsuario = dataBase.usuariosBox.query(Usuarios_.correo.equals(correo)).build().findUnique();
      if (lastUsuario != null) {
        print("NOMBRE USUARIO: ${lastUsuario.nombre}");
        print("ID DE VARIABLES USUARIO: ${lastUsuario.variablesUsuario.target?.id ?? 'none'}");
        print("Emprendedores: ${lastUsuario.variablesUsuario.target?.emprendedores ?? 'none'}");
        print("Tamaño VariablesUser: ${dataBase.variablesUsuarioBox.getAll().length}");
      }
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
      final updateImagenUsuario = dataBase.imagenesBox.query(Imagenes_.id.equals(updateUsuario.image.target?.id ?? -1)).build().findUnique();
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

  // void addEmprendimiento(Emprendimientos nuevoEmprendimiento, int idCurrentUser) {

  //   usuarioCurrent!.emprendimientos.add(nuevoEmprendimiento);

  // }

  void addEmprendimiento(Emprendimientos emprendimiento) {
    usuarioCurrent!.emprendimientos.add(emprendimiento);
    dataBase.usuariosBox.put(usuarioCurrent!);
    print('Emprendimiento modificado exitosamente');
    notifyListeners();
  }

  void removeEmprendimiento(Emprendimientos emprendimiento) {
    usuarioCurrent!.emprendimientos.remove(emprendimiento);
    dataBase.usuariosBox.put(usuarioCurrent!);
    print('Emprendimiento actualizado exitosamente');
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
