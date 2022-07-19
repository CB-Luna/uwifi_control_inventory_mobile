import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
class UsuarioController extends ChangeNotifier {

  List<Usuarios> usuarios = [];

  GlobalKey<FormState> usuarioFormKey = GlobalKey<FormState>();
 
  //Jornada
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
      print('Usuario recuperado exitosamente');
      notifyListeners();
  }

  void remove(Usuarios usuario) {
    dataBase.usuariosBox.remove(usuario.id);
    usuarios.remove(usuario);

    notifyListeners(); 
  }

  getAll() {
    usuarios = dataBase.usuariosBox.getAll();
    notifyListeners();
  }

  bool validateUser(String correo) {
    usuarios = dataBase.usuariosBox.getAll();
    for(int i = 0; i < usuarios.length ; i++) {
      if (usuarios[i].correo == correo) {
        return true;
      }
    }
    return false;
  }

  int? getUserID(String correo) {
    final id;
    usuarios = dataBase.usuariosBox.getAll();
    for(int i = 0; i < usuarios.length ; i++) {
      if (usuarios[i].correo == correo) {
        return usuarios[i].id;
      }
    }
  }
  
}