import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class OrdenTrabajoController extends ChangeNotifier {

  GlobalKey<FormState> ordenTrabajoFormKey = GlobalKey<FormState>();

  //Datos de la Orden de Trabajo
  int idCliente = -1;
  int idVehiculo = -1;
  int idFormaPago = -1;
  DateTime? fechaOrden; //Es null para inicializar sin valor el campo en el formulario 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController fechaOrdenController = TextEditingController(); 
  String descripcion = "";

  bool validateForm(GlobalKey<FormState> ordenTrabajoKey) {
    return ordenTrabajoKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    idCliente = -1;
    idVehiculo = -1; 
    idFormaPago = -1;
    fechaOrden =  null;
    fechaOrdenController.clear();
    descripcion = "";
    notifyListeners();
  }


  bool add(Usuarios usuario) {
    final nuevaOrdenTrabajo = OrdenTrabajo(
      fechaOrden: fechaOrden!,
      descripcion: descripcion,  
    );

    final nuevaInstruccion = Bitacora(
      instruccion: 'syncAgregarOrdenTrabajo',
      usuario: prefs.getString("userId")!,
      idEmprendimiento: 0,
    ); //Se crea la nueva instruccion a realizar en bitacora

    final cliente = dataBase.clienteBox.get(idCliente);
    final vehiculo = dataBase.vehiculoBox.get(idVehiculo);
    // final formaPago = dataBase.formaPagoBox.get(idFormaPago!);
    if (cliente != null && vehiculo != null) {
      nuevaOrdenTrabajo.cliente.target = cliente;
      nuevaOrdenTrabajo.vehiculo.target = vehiculo;
      // nuevaOrdenTrabajo.formaPago.target = formaPago;
      nuevaOrdenTrabajo.usuario.target = usuario;
      nuevaInstruccion.ordenTrabajo.target = nuevaOrdenTrabajo; //Se asigna la orden de trabajo a la nueva instrucción
      nuevaOrdenTrabajo.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
      dataBase.ordenTrabajoBox.put(nuevaOrdenTrabajo); //Agregamos la orden de trabajo en objectBox
      usuario.ordenesTrabajo.add(nuevaOrdenTrabajo);
      dataBase.usuariosBox.put(usuario);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    final updateEmprendedor = dataBase.emprendedoresBox.get(id);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    if (updateEmprendedor != null) {
      updateEmprendedor.nombre = newNombre;
      updateEmprendedor.apellidos = newApellidos;
      updateEmprendedor.curp = newCurp;
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