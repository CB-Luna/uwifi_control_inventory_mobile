import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fleet_management_tool_rta/helpers/constants.dart';
import 'package:intl/intl.dart';
import 'package:fleet_management_tool_rta/database/image_evidence.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:fleet_management_tool_rta/main.dart';
import 'package:fleet_management_tool_rta/database/entitys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class UsuarioController extends ChangeNotifier {
  List<Users> usuarios = [];
  Uuid uuid = Uuid();

  ControlForm? controlFormCheckOut;
  ControlForm? controlForrmCheckIn;

  List<ControlForm> firstFormCheckOut = [];
  List<ControlForm> secondFormCheckOut = [];
  List<ControlForm> thirdFormCheckOut = [];

  List<ControlForm> firstForrmCheckIn = [];
  List<ControlForm> secondForrmCheckIn = [];
  List<ControlForm> thirdForrmCheckIn = [];

  

  Users? usuarioCurrent;
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
  bool get isEmployee => usuarioCurrent?.role.target?.role == 'Employee';

  UsuarioController({String? email}) {
    //print("El email es: $email");
    //print("Currentuser: $currentUser");
    if (email != null) {
      final query =
          dataBase.usersBox.query(Users_.correo.equals(email)).build();
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
      String nombre,
      String apellidoP,
      String? apellidoM,
      String? telefono,
      String? celular,
      String domicilio,
      String correo,
      String password,
      String? imagenUrl,
      List<String> rolesIdDBR,
      String idDBR,
      DateTime? birthDate,
      String idCompanyFk,
      String? idVehicleFk,
      int formsCurrentMonthR,
      int formsSecondMonthR,
      int formsThirdMonthR,
      int formsCurrentMonthD,
      int formsSecondMonthD,
      int formsThirdMonthD,
      ) async {
    final nuevoUsuario = Users(
        name: nombre,
        lastName: apellidoP,
        middleName: apellidoM,
        homePhone: telefono,
        mobilePhone: celular,
        correo: correo,
        password: password,
        idDBR: idDBR, 
        address: domicilio,
        birthDate: birthDate,
        recordsMonthCurrentR: formsCurrentMonthR,
        recordsMonthSecondR: formsSecondMonthR,
        recordsMonthThirdR: formsThirdMonthR,
        recordsMonthCurrentD: formsCurrentMonthD,
        recordsMonthSecondD: formsSecondMonthD,
        recordsMonthThirdD: formsThirdMonthD,
        );
    if (imagenUrl != null) {
      final name = imagenUrl.toString().replaceAll("$supabaseUrl/storage/v1/object/public/assets/user_profile/", "");
      final uInt8ListImagen = await supabase.storage.from('assets/user_profile').download(name);
      final base64Image = const Base64Encoder().convert(uInt8ListImagen);
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/$name').create();
      file.writeAsBytesSync(uInt8ListImagen);
      nuevoUsuario.image = base64Image;
      nuevoUsuario.name = name;
      nuevoUsuario.path = file.path;
    } 
    //Se crea el objeto imagenes para el Usuario
    //Se agregan los roles
    for (var i = 0; i < rolesIdDBR.length; i++) {
      final nuevoRol = dataBase.roleBox.query(Role_.idDBR.equals(rolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
      if (nuevoRol != null) {
        nuevoUsuario.roles.add(nuevoRol);
      }
    }
    //Se asiga el rol actual que ocupará
    final rolActual = dataBase.roleBox.query(Role_.idDBR.equals(rolesIdDBR[0])).build().findUnique(); //Se recupera el rol actual del Usuario
    final companyActual = dataBase.companyBox.query(Company_.idDBR.equals(idCompanyFk)).build().findUnique(); //Se recupera el rol actual del Usuario
    final vehicleActual = dataBase.vehicleBox.query(Vehicle_.idDBR.equals(idVehicleFk ?? "")).build().findFirst(); //Se recupera el rol actual del Usuario
    if (vehicleActual != null) {
      nuevoUsuario.vehicle.target = vehicleActual;
    }
    if (rolActual != null && companyActual != null) {
      nuevoUsuario.role.target = rolActual;
      nuevoUsuario.company.target = companyActual;
      dataBase.usersBox.put(nuevoUsuario);
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
      String? newCelular,
      String newDomicilio,
      String newPassword,
      String? newImagenUrl,
      List<String> newRolesIdDBR,
      DateTime? newBirthDate,
      String newIdCompanyFk,
      String? newIdVehicleFk,
      int formsCurrentMonthR,
      int formsSecondMonthR,
      int formsThirdMonthR,
      int formsCurrentMonthD,
      int formsSecondMonthD,
      int formsThirdMonthD,
      ) async {
    // Se recupera el usuario por id
    final updateUsuario = dataBase.usersBox.query(Users_.correo.equals(correo)).build().findUnique();
    if (updateUsuario != null) {
      updateUsuario.name = newNombre;
      updateUsuario.lastName = newApellidoP;
      updateUsuario.middleName= newApellidoM;
      updateUsuario.name = newNombre;
      updateUsuario.homePhone = newTelefono;
      updateUsuario.mobilePhone = newCelular;
      updateUsuario.address = newDomicilio;
      updateUsuario.password = newPassword;
      updateUsuario.birthDate = newBirthDate;
      updateUsuario.recordsMonthCurrentR = formsCurrentMonthR;
      updateUsuario.recordsMonthSecondR = formsSecondMonthR;
      updateUsuario.recordsMonthThirdR = formsThirdMonthR;
      updateUsuario.recordsMonthCurrentD = formsCurrentMonthD;
      updateUsuario.recordsMonthSecondD = formsSecondMonthD;
      updateUsuario.recordsMonthThirdD = formsThirdMonthD;
      //Se agregan los roles actualizados
      updateUsuario.roles.clear();
      for (var i = 0; i < newRolesIdDBR.length; i++) {
        final nuevoRol = dataBase.roleBox.query(Role_.idDBR.equals(newRolesIdDBR[i])).build().findUnique(); //Se recupera el rol del Usuario
        if (nuevoRol != null) {
          updateUsuario.roles.add(nuevoRol);
        }
      } 
      //Se asiga el rol actual que ocupará
      final rolActual = dataBase.roleBox.query(Role_.idDBR.equals(newRolesIdDBR[0])).build().findUnique(); //Se recupera el rol actual del Usuario
      final companyActual = dataBase.companyBox.query(Company_.idDBR.equals(newIdCompanyFk)).build().findUnique(); //Se recupera el rol actual del Usuario
      final vehicleActual = dataBase.vehicleBox.query(Vehicle_.idDBR.equals(newIdVehicleFk ?? "")).build().findFirst(); //Se recupera el rol actual del Usuario
      if (rolActual != null && companyActual != null) {
        updateUsuario.role.target = rolActual;
        updateUsuario.company.target = companyActual;
      }
      if (vehicleActual != null) {
        updateUsuario.vehicle.target = vehicleActual;
      } else {
        updateUsuario.vehicle.target = null;
      }
      if (newImagenUrl != null) {
          final name = newImagenUrl.toString().replaceAll("$supabaseUrl/storage/v1/object/public/assets/user_profile/", "");
          final uInt8ListImagen = await supabase.storage.from('assets/user_profile').download(name);
          final base64Image = const Base64Encoder().convert(uInt8ListImagen);
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/$name').create();
          file.writeAsBytesSync(uInt8ListImagen);
          updateUsuario.image = base64Image;
          updateUsuario.nameImage = name;
          updateUsuario.path = file.path;
      } else {
        if (updateUsuario.image != null) {
          // Se eliminan los datos de la imagen actual del usuario
          updateUsuario.image = null;
          updateUsuario.nameImage = null;
          updateUsuario.path = null;
        }
      }
      // Se actualiza el usuario con éxito
      dataBase.usersBox.put(updateUsuario); 
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
    Users user, 
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
      //Se válida que se haya cambiado la imagen
      if (imageTemp != user.path) {
        if (user.path == null) {
          //Se agrega una imagen
          user.image = base64.encode(image!.uint8List);
          user.nameImage = "${uuid.v4()}${image.name}";
          user.path = image.path;

          final nuevaInstruccion = Bitacora(
            instruccion: 'syncAddUserImage',
            instruccionAdicional: "${user.nameImage}||${user.image}",
            usuarioPropietario: prefs.getString("userId")!,
            idControlForm: 0,
          ); //Se crea la nueva instruccion a realizar en bitacora

          nuevaInstruccion.user.target = user; //Se asigna el user a la nueva instrucción
          user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al user
          dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
          dataBase.usersBox.put(user);
        } else {
          // Se elimina la imagen
          if (imageTemp == null) {
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncDeleteUserImage',
              instruccionAdicional: user.nameImage,
              usuarioPropietario: prefs.getString("userId")!,
              idControlForm: 0,
            ); //Se crea la nueva instruccion a realizar en bitacora

            nuevaInstruccion.user.target = user; //Se asigna el user a la nueva instrucción
            user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el user
            dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
            dataBase.usersBox.put(user);

            user.image = null;
            user.nameImage = null;
            user.path = null;
          } else {
            //Se actualiza imagen
            final newNameImage = "${uuid.v4()}${image?.name}";
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncUpdateUserImage',
              instruccionAdicional: "${user.nameImage}||$newNameImage||${base64.encode(image!.uint8List)}", //imagen a actualizar
              usuarioPropietario: prefs.getString("userId")!,
              idControlForm: 0,
            ); //Se crea la nueva instruccion a realizar en bitacora

            user.image = base64.encode(image.uint8List);
            user.nameImage = newNameImage;
            user.path = image.path;

            nuevaInstruccion.user.target = user; //Se asigna la orden de trabajo a la nueva instrucción
            user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
            dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
            dataBase.usersBox.put(user);
          }
        }
      }
      user.name = newName;
      user.lastName = newLastName;
      user.middleName = newMiddleName;
      user.homePhone = newHomePhone;
      user.mobilePhone = newMobilePhone;
      user.address = newAddress;

      final nuevaInstruccion = Bitacora(
        instruccion: 'syncUpdateUser',
        usuarioPropietario: prefs.getString("userId")!,
        idControlForm: 0,
      ); //Se crea la nueva instruccion a realizar en bitacora

      nuevaInstruccion.user.target = user; //Se asigna la orden de trabajo a la nueva instrucción
      user.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      dataBase.usersBox.put(user);
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
      if (usuarios[i].correo == email) {
        return true;
      }
    }
    return false;
  }

  Users? validateUserOffline(String email, String password) {
    final usuarios = dataBase.usersBox.getAll();
    for (int i = 0; i < usuarios.length; i++) {
      if (usuarios[i].correo == email && usuarios[i].password == password) {
        return usuarios[i];
      }
    }
    return null;
  }

  //Se recupera ID del Usuario ya existente
  void getUserID(String email) {
    final usuarios = dataBase.usersBox.getAll();
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
        dataBase.usersBox.query(Users_.correo.equals(email)).build();
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


  List<ControlForm> obtenerOrdenesTrabajo() {
    final List<ControlForm> ordenesTrabajo = [];
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? 1);
    if (usuarioActual != null) {
      //   for (var element in usuarioActual.ordenesTrabajo) {
      //   ordenesTrabajo.add(element);
      // }
    }
    return ordenesTrabajo;
  }

  List<Users> obtenerClientes() {
    final List<Users> clientes = [];
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? 1);
    if (usuarioActual != null) {
    }
    return clientes;
  }

  List<Vehicle> getVehiclesAvailables() {
    final List<Vehicle> opcionesVehiculos = [];
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
        if (usuarioActual.vehicle.target != null) {
          opcionesVehiculos.add(usuarioActual.vehicle.target!);
        } else {
          for (var vehicle in dataBase.vehicleBox.getAll().toList()) {
            if (vehicle.status.target?.status == "Available") {
              if (vehicle.company.target?.company == usuarioActual.company.target?.company) {
                opcionesVehiculos.add(vehicle);
              }
            }
          }
        }
    }
    return opcionesVehiculos;
  }

    List<Vehicle> getAllVehicles() {
    final List<Vehicle> opcionesVehiculos = [];
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
        if (usuarioActual.vehicle.target != null) {
          opcionesVehiculos.add(usuarioActual.vehicle.target!);
        } else {
          for (var vehicle in dataBase.vehicleBox.getAll().toList()) {
              if (vehicle.company.target?.company == usuarioActual.company.target?.company) {
                opcionesVehiculos.add(vehicle);
              }
          }
        }
    }
    return opcionesVehiculos;
  }

  Vehicle getVehicleAsigned() {
    Vehicle? vehicleAssigned;
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual != null) {
        if (usuarioActual.vehicle.target != null) {
          vehicleAssigned = usuarioActual.vehicle.target!;
        } 
    }
    return vehicleAssigned!;
  }
  

  ControlForm? getControlFormCheckOutToday(DateTime today) {
    ControlForm? controlFormToday;
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual?.actualControlForm.target != null) {
      if ((DateFormat('dd-MM-yyyy')
          .format(usuarioActual!.actualControlForm.target!.dateAddedR).toString() == 
          DateFormat('dd-MM-yyyy')
          .format(today).toString())) {
        controlFormToday = usuarioActual.actualControlForm.target;
      }
    }
    return controlFormToday;
  }

  ControlForm? getControlFormCheckInToday(DateTime today) {
    ControlForm? controlFormToday;
    final usuarioActual = dataBase.usersBox.get(usuarioCurrent?.id ?? -1);
    if (usuarioActual?.actualControlForm.target?.dateAddedD != null) {
        if ((DateFormat('dd-MM-yyyy')
          .format(usuarioActual!.actualControlForm.target!.dateAddedD!).toString() == 
          DateFormat('dd-MM-yyyy')
          .format(today).toString())) {
        controlFormToday = usuarioActual.actualControlForm.target;
      }
    }
    return controlFormToday;
  }


  void recoverPreviousControlForms(DateTime today) {

    firstFormCheckOut.clear();
    secondFormCheckOut.clear();
    thirdFormCheckOut.clear();

    firstForrmCheckIn.clear();
    secondForrmCheckIn.clear();
    thirdForrmCheckIn.clear();

    if (usuarioCurrent != null) {
      for (var element in usuarioCurrent!.controlForms) {
        if (element.dateAddedR.month == (today.month)) {
            firstFormCheckOut.add(element);
          if (element.dateAddedD != null) {
            if (element.dateAddedD!.month == (today.month)) {
              firstForrmCheckIn.add(element);
            }
          }
        }
        if (element.dateAddedR.month == (today.month - 1)) {
            secondFormCheckOut.add(element);
          if (element.dateAddedD != null) {
            if (element.dateAddedD!.month == (today.month - 1)) {
              secondForrmCheckIn.add(element);
            }
          }
        }
        if (element.dateAddedR.month == (today.month - 2)) {
            thirdFormCheckOut.add(element);
          if (element.dateAddedD != null) {
            if (element.dateAddedD!.month == (today.month - 2)) {
              thirdForrmCheckIn.add(element);
            }
          }
        }
      }
    }
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
      final nuevaInstruccion = Bitacora(
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
