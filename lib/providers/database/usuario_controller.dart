import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:uwifi_control_inventory_mobile/models/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/get_user_supabase.dart';
import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart' as DOB;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UsuarioController extends ChangeNotifier {
  List<DOB.Users> usuarios = [];
  Uuid uuid = Uuid();

  DOB.ControlForm? controlFormCheckOut;
  DOB.BucketInspection? controlForrmCheckIn;

  List<DOB.ControlForm> firstFormCheckOut = [];
  List<DOB.ControlForm> secondFormCheckOut = [];
  List<DOB.ControlForm> thirdFormCheckOut = [];

  List<DOB.ControlForm> firstForrmCheckIn = [];
  List<DOB.ControlForm> secondForrmCheckIn = [];
  List<DOB.ControlForm> thirdForrmCheckIn = [];

  

  DOB.Users? usuarioCurrent;
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

  // CV
  bool get isTechSupervisor => usuarioCurrent?.role.target?.role == 'Tech Supervisor';
  bool get isManager => usuarioCurrent?.role.target?.role == 'Manager';
  bool get isInventory => usuarioCurrent?.role.target?.role == 'Inventory Warehouse';

  UsuarioController({String? email}) {
    //print("El email es: $email");
    //print("Currentuser: $currentUser");
    if (email != null) {
      final query =
          dataBase.usersBox.query(Users_.email.equals(email)).build();
      currentUser = currentUser;
      usuarioCurrent = query.findFirst();
      //print(usuarioCurrent?.nombre ?? "SIN NOMBRE");
    }
  }

  GlobalKey<FormState> usuarioFormKey = GlobalKey<FormState>();

  bool validateForm(GlobalKey<FormState> usuarioKey) {
    return usuarioKey.currentState!.validate() ? true : false;
  }


  // void clearInformation() {
  //   // setStream(false);
  //   notifyListeners();
  // }

  Future<void> add(
      String fisrtName,
      String lastName,
      String email,
      String password,
      String? nameImage,
      List<RoleSupabase> rolesIdDBR,
      String idDBR,
      String idRoleFk,
      int sequentialId
      ) async {
    final newUser = DOB.Users(
        firstName: fisrtName,
        lastName: lastName,
        email: email,
        password: password,
        idDBR: idDBR, 
        sequentialId: sequentialId,
        );
    if (nameImage != null) {
      final urlImage = supabase.storage.from('assets/user_profile').getPublicUrl(nameImage);
      final uInt8ListImagen = await supabase.storage.from('assets/user_profile').download(nameImage);
      final base64Image = const Base64Encoder().convert(uInt8ListImagen);
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/$nameImage').create();
      file.writeAsBytesSync(uInt8ListImagen);
      final newImage = DOB.Image(
        url: urlImage, 
        path: file.path,
        base64: base64Image
      );
      //Relación entre elementos
      newUser.image.target = newImage;
      newImage.user.target = newUser;
      //Se registra imagen
      dataBase.imageBox.put(newImage);
    } 
    //Se crea el objeto imagenes para el Usuario
    //Se agregan los roles
    for (var i = 0; i < rolesIdDBR.length; i++) {
      final newRole = dataBase.roleBox.query(Role_.idDBR.equals(rolesIdDBR[i].id.toString())).build().findUnique(); //Se recupera el rol del Usuario
      if (newRole != null) {
        newUser.roles.add(newRole);
      }
    }
    //Se asiga el rol actual que ocupará
    final currentRole = dataBase.roleBox.query(Role_.idDBR.equals(idRoleFk)).build().findUnique(); //Se recupera el rol actual del Usuario
    if (currentRole != null) {
      newUser.role.target = currentRole;
      dataBase.usersBox.put(newUser);
      usuarios.add(newUser);
      //print('Usuario agregado exitosamente');
      notifyListeners();
    }
  }

  Future<bool> update(
      String email,
      String newFirstName,
      String newLastName,
      String newPassword,
      String? newImage,
      List<RoleSupabase> newRolesIdDBR,
      String idRoleFk,
      int newSequentialId
      ) async {
    // Se recupera el usuario por id
    final updateUser = dataBase.usersBox.query(Users_.email.equals(email)).build().findUnique();
    if (updateUser != null) {
      updateUser.firstName = newFirstName;
      updateUser.lastName = newLastName;
      updateUser.password = newPassword;
      updateUser.sequentialId = newSequentialId;
      //Se agregan los roles actualizados
      updateUser.roles.clear();
      for (var i = 0; i < newRolesIdDBR.length; i++) {
        final newRole = dataBase.roleBox.query(Role_.idDBR.equals(newRolesIdDBR[i].id.toString())).build().findUnique(); //Se recupera el rol del Usuario
        if (newRole != null) {
          updateUser.roles.add(newRole);
        }
      } 
      //Se asiga el role actual que ocupará
      final currentRole = dataBase.roleBox.query(Role_.idDBR.equals(idRoleFk)).build().findUnique(); //Se recupera el rol actual del Usuario
      if (currentRole != null) {
        updateUser.role.target = currentRole;
      }
      if (newImage != null) {
          final urlImage = supabase.storage.from('assets/user_profile').getPublicUrl(newImage);
          final uInt8ListImagen = await supabase.storage.from('assets/user_profile').download(newImage);
          final base64Image = const Base64Encoder().convert(uInt8ListImagen);
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/$newImage').create();
          file.writeAsBytesSync(uInt8ListImagen);
          if (updateUser.image.target != null) {
            // Se actualizan los datos de la imagen actual del usuario
            updateUser.image.target!.url = urlImage;
            updateUser.image.target!.path = file.path;
            updateUser.image.target!.base64 = base64Image;
            dataBase.imageBox.put(updateUser.image.target!);
          } else {
            final newImage = DOB.Image(
              url: urlImage, 
              path: file.path,
              base64: base64Image
            );
            //Relación entre elementos
            updateUser.image.target = newImage;
            newImage.user.target = updateUser;
            //Se registra imagen
            dataBase.imageBox.put(newImage);
          }
      } else {
        if (updateUser.image.target != null) {
          // Se eliminan los datos de la imagen actual del usuario
          dataBase.imageBox.remove(updateUser.image.target!.id);
          updateUser.image.target = null;
        }
      }
      // Se actualiza el usuario con éxito
      dataBase.usersBox.put(updateUser); 
      return true;
    } else {
      // No se encontró el usuario a actualizar en ObjectBox
      //print("No se encontro usuario en ObjectBox");
      return false;
    }
  }

void updateRol(int id, int newIdRol) {
    var updateUsuario = dataBase.usersBox.get(id);
    if (updateUsuario != null) {
      final updateRol = dataBase.roleBox.get(newIdRol);
      if (updateRol != null) {
        updateUsuario.role.target = updateRol; //Se actualiza el rol del Usuario
      }
      dataBase.usersBox.put(updateUsuario);
      //print('Usuario actualizado exitosamente');
    }
    notifyListeners();
  }

bool updateData(
    DOB.Users user, 
    String newName, 
    String newLastName, 
    String? newMiddleName, 
    String? newHomePhone,
    String? newMobilePhone,
    String newAddress,
    ImageEvidence? image,
    String? imageTemp,
  ) {
    try {
      // //Se válida que se haya cambiado la imagen
      // if (imageTemp != user.path) {
      //   if (user.path == null) {
      //     //Se agrega una imagen
      //     user.image = base64.encode(image!.uint8List);
      //     user.nameImage = "${uuid.v4()}${image.name}";
      //     user.path = image.path;

      //     final nuevaInstruccion = Bitacora(
      //       instruccion: 'syncAddUserImage',
      //       instruccionAdicional: "${user.nameImage}||${user.image}",
      //       usuarioPropietario: prefs.getString("userId")!,
      //       idControlForm: 0,
      //     ); //Se crea la nueva instruccion a realizar en bitacora

      //     nuevaInstruccion.user.target = user; //Se asigna el user a la nueva instrucción
      //     user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al user
      //     dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      //     dataBase.usersBox.put(user);
      //   } else {
      //     // Se elimina la imagen
      //     if (imageTemp == null) {
      //       final nuevaInstruccion = Bitacora(
      //         instruccion: 'syncDeleteUserImage',
      //         instruccionAdicional: user.nameImage,
      //         usuarioPropietario: prefs.getString("userId")!,
      //         idControlForm: 0,
      //       ); //Se crea la nueva instruccion a realizar en bitacora

      //       nuevaInstruccion.user.target = user; //Se asigna el user a la nueva instrucción
      //       user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el user
      //       dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      //       dataBase.usersBox.put(user);

      //       user.image = null;
      //       user.nameImage = null;
      //       user.path = null;
      //     } else {
      //       //Se actualiza imagen
      //       final newNameImage = "${uuid.v4()}${image?.name}";
      //       final nuevaInstruccion = Bitacora(
      //         instruccion: 'syncUpdateUserImage',
      //         instruccionAdicional: "${user.nameImage}||$newNameImage||${base64.encode(image!.uint8List)}", //imagen a actualizar
      //         usuarioPropietario: prefs.getString("userId")!,
      //         idControlForm: 0,
      //       ); //Se crea la nueva instruccion a realizar en bitacora

      //       user.image = base64.encode(image.uint8List);
      //       user.nameImage = newNameImage;
      //       user.path = image.path;

      //       nuevaInstruccion.user.target = user; //Se asigna la orden de trabajo a la nueva instrucción
      //       user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      //       dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      //       dataBase.usersBox.put(user);
      //     }
      //   }
      // }
      // user.name = newName;
      // user.lastName = newLastName;
      // user.middleName = newMiddleName;
      // user.homePhone = newHomePhone;
      // user.mobilePhone = newMobilePhone;
      // user.address = newAddress;

      // final nuevaInstruccion = Bitacora(
      //   instruccion: 'syncUpdateUser',
      //   usuarioPropietario: prefs.getString("userId")!,
      //   idControlForm: 0,
      // ); //Se crea la nueva instruccion a realizar en bitacora

      // nuevaInstruccion.user.target = user; //Se asigna la orden de trabajo a la nueva instrucción
      // user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      // dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      // dataBase.usersBox.put(user);
      return true;
    } catch (e) {
      print("Error in update User Data: $e");
      return false;
    }
  }

  getAll() {
    usuarios = dataBase.usersBox.getAll();
    notifyListeners();
  }

  //Usuario existente o no en la base de Datos
  bool validateUsuario(String email) {
    final usuarios = dataBase.usersBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email) {
        return true;
      }
    }
    return false;
  }

  DOB.Users? validateUserOffline(String email, String password) {
    final usuarios = dataBase.usersBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email && usuarios[i].password == password) {
        return usuarios[i];
      }
    }
    return null;
  }

  //Se recupera ID del Usuario ya existente
  void getUserID(String email) {
    final usuarios = dataBase.usersBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == email) {
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
        dataBase.usersBox.query(Users_.email.equals(email)).build();
    currentUser = email;
    usuarioCurrent = query.findFirst();
  }

  //Se actualiza password del usuarioCurrent
  void updatePasswordLocal(String password) {
    if (usuarioCurrent != null) {
      usuarioCurrent!.password = password;
      dataBase.usersBox.put(usuarioCurrent!);
    }
  }


  bool addCliente(int idCliente) {
    final cliente = dataBase.usersBox.get(idCliente);
    if (cliente != null) {
      dataBase.usersBox.put(usuarioCurrent!);
      //print('Emprendimiento modificado exitosamente');
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }



  List<DOB.Users> obtenerClientes() {
    final List<DOB.Users> clientes = [];
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? 1);
    if (usuarioActual != null) {
    }
    return clientes;
  }

  



  bool validatePassword(String actualPassword) {
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
      if (usuarioActual.password == actualPassword) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool updatePassword(String actualPassword, String newPassword) {
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
      usuarioActual.password = newPassword;
      final nuevaInstruccion = DOB.Bitacora(
        instruccion: 'syncUpdatePassword',
        instruccionAdicional: actualPassword,
        usuarioPropietario: prefs.getString("userId")!,
        idControlForm: 0,
      ); //Se crea la nueva instruccion a realizar en bitacora

      nuevaInstruccion.user.target = usuarioActual; //Se asigna el usuario a la nueva instrucción
      usuarioActual.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el usuario
      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      dataBase.usersBox.put(usuarioActual);

      return true;
    } else {
      return false;
    }
  }

}
