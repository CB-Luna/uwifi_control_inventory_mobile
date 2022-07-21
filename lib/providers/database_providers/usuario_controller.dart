import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:objectbox/objectbox.dart';

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
  int? rol;

  String? currentUser;
  int? currentUserId;

  UsuarioController({String? email}) {
    print("El email es: $email");
    print("Currentuser: $currentUser");
    if (email != null) {
      final query = dataBase.usuariosBox.query(
        Usuarios_.correo.equals(email)).build();
        currentUser = currentUser;
        usuarioCurrent = query.findUnique();
        print(usuarioCurrent?.nombre ?? "SIN NOMBRE");
    }

  }


  GlobalKey<FormState> usuarioFormKey = GlobalKey<FormState>();
 
  

  bool validateForm() {
    return usuarioFormKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    notifyListeners();
  }

  void add(String nombre, String apellidoP, String apellidoM, 
  DateTime nacimiento, String telefono, String celular, String correo, 
  String password, String imagen, int rol) {
    final nuevoUsuario = Usuarios(
      nombre: nombre, 
      apellidoP: apellidoP, 
      apellidoM: apellidoM, 
      nacimiento: nacimiento, 
      telefono: telefono, 
      celular: celular, 
      correo: correo, 
      password: password, 
      imagen: imagen, 
      rol: rol    
      );
      
      dataBase.usuariosBox.put(nuevoUsuario);
      usuarios.add(nuevoUsuario);
      getUserID(correo);
      print('Usuario agregado exitosamente');
      notifyListeners();
  }

  // void remove(Usuarios usuario) {
  //   dataBase.usuariosBox.remove(usuario.id);
  //   usuarios.remove(usuario);

  //   notifyListeners(); 
  // }

  getAll() {
    usuarios = dataBase.usuariosBox.getAll();
    notifyListeners();
  }

  //Usuario existente o no en la base de Datos
  bool validateUser(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for(int i = 0; i < usuarios.length ; i++) {
      if (usuarios[i].correo == email) {
        return true;
      }
    }
    return false;
  }

  //Se recupera ID del Usuario ya existente 
  void getUserID(String email) {
    final usuarios = dataBase.usuariosBox.getAll();
    for(int i = 0; i < usuarios.length ; i++) {
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
    final query = dataBase.usuariosBox.query(
        Usuarios_.correo.equals(email)).build();
        currentUser = email;
        usuarioCurrent = query.findUnique();
  }

  // void addEmprendimiento(Emprendimientos nuevoEmprendimiento, int idCurrentUser) {

  //   usuarioCurrent!.emprendimientos.add(nuevoEmprendimiento);

  // }

  void addEmprendimiento(Emprendimientos emprendimiento) {
      usuarioCurrent!.emprendimientos.add(emprendimiento);
      usuarioCurrent!.emprendimientos.applyToDb();
      print('Emprendimiento modificado exitosamente');
      notifyListeners();
  }
  
  void removeEmprendimiento(Emprendimientos emprendimiento) {
    usuarioCurrent!.emprendimientos.remove(emprendimiento);
    usuarioCurrent!.emprendimientos.applyToDb();
    print('Emprendimiento actualizado exitosamente');
    notifyListeners();

  }

  List<String> getEmprendedores(Emprendimientos emprendimiento)
  {
    final List<String> emprendedores = [];
    emprendimiento.emprendedores.forEach((element) {
      emprendedores.add(element.nombre);
    });

    return emprendedores;
  }

  
}