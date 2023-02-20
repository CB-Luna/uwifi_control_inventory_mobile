import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/vehiculo_temporal.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class VehiculoController extends ChangeNotifier {
  VehiculoTemporal? vehiculo; 

  GlobalKey<FormState> vehiculoFormKey = GlobalKey<FormState>();

  //Vehículo
  // TextEditingController integrantesFamilia = TextEditingController();
  Imagenes? imagenVehiculo;
  String marca = "";
  String modelo = "";
  String anio = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController anioController = TextEditingController(); 
  String vin = "";
  String placas = "";
  String kilometraje = "";
  String gasolina = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController gasolinaController = TextEditingController();
  bool clienteAsociado =  false;

  bool validateForm(GlobalKey<FormState> vehiculoKey) {
    return vehiculoKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    vehiculo = null;
    imagenVehiculo = null;
    marca = "";
    modelo = "";
    anio = "";
    anioController.clear();
    vin = "";
    placas = "";
    kilometraje = "";
    gasolina = "";
    clienteAsociado = false;
    gasolinaController.clear();
    notifyListeners();
  }

  void addTemporal() {
    vehiculo = VehiculoTemporal(
      marca: marca, 
      modelo: modelo,
      anio: anio, 
      vin: vin, 
      placas: placas, 
      kilometraje: kilometraje, 
      gasolina: gasolina, 
      imagen: imagenVehiculo!,  
    );
    clienteAsociado = true;
    notifyListeners();
  }

  void add(int idCliente) {
    if (vehiculo != null) {
      final nuevoVehiculo = Vehiculo(
        marca: vehiculo!.marca, 
        modelo: vehiculo!.modelo,
        anio: vehiculo!.anio, 
        vin: vehiculo!.vin, 
        placas: vehiculo!.placas, 
        kilometraje: vehiculo!.kilometraje, 
        gasolina: vehiculo!.gasolina,  
      );
      final cliente = dataBase.clienteBox.get(idCliente);
      if (cliente != null) {
        final nuevaInstruccion = Bitacora(instruccion: 'syncAgregarVehiculo', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instrucción a realizar en bitacora
        nuevoVehiculo.bitacora.add(nuevaInstruccion);
        nuevoVehiculo.cliente.target = cliente;
        cliente.vehiculo.add(nuevoVehiculo);
        dataBase.imagenesBox.put(imagenVehiculo!);
        nuevoVehiculo.imagen.target = imagenVehiculo!;
        dataBase.clienteBox.put(cliente);
        dataBase.vehiculoBox.put(nuevoVehiculo);
        notifyListeners();
      }
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
      //print('Emprendedor actualizado exitosamente');

    }
    notifyListeners();
  }

  void addImagen(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      imagenVehiculo!.bitacora.add(nuevaInstruccion);
      emprendimiento.emprendedor.target!.imagen.target = imagenVehiculo;
      dataBase.imagenesBox.put(imagenVehiculo!);
      dataBase.emprendedoresBox.put(emprendimiento.emprendedor.target!);
      //print('Imagen Emprendedor agregada exitosamente');
      notifyListeners();
    } 
  }

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


  List<Emprendedores> getEmprendedoresActualUser(List<Emprendimientos> emprendimientos) {
    List<Emprendedores> emprendedoresActualUser = [];
    for (var element in emprendimientos) {
      if (element.emprendedor.target != null) {
        emprendedoresActualUser.add(element.emprendedor.target!);
      }
    }
    return emprendedoresActualUser;
  }
  
}