import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/vehiculo_temporal.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class VehiculoController extends ChangeNotifier {
  VehiculoTemporal? vehiculo; 

  GlobalKey<FormState> vehiculoFormKey = GlobalKey<FormState>();

  //Vehículo
  // TextEditingController integrantesFamilia = TextEditingController();
  String imagenVehiculo = "";
  String? path;
  String marca = "";
  String modelo = "";
  String anio = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController anioController = TextEditingController(); 
  String vin = "";
  String placas = "";
  String motor = "";
  String color = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  // TextEditingController gasolinaController = TextEditingController();
  bool clienteAsociado =  false;

  bool validateForm(GlobalKey<FormState> vehiculoKey) {
    return vehiculoKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    vehiculo = null;
    imagenVehiculo = "";
    path = null; 
    marca = "";
    modelo = "";
    anio = "";
    anioController.clear();
    vin = "";
    placas = "";
    motor = "";
    color = "";
    clienteAsociado = false;
    // gasolinaController.clear();
    notifyListeners();
  }


  void addTemporal() {
    vehiculo = VehiculoTemporal(
      marca: marca, 
      modelo: modelo,
      anio: anio, 
      vin: vin, 
      placas: placas, 
      motor: motor, 
      color: color, 
      imagen: imagenVehiculo, 
      path: path!, 
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
        motor: vehiculo!.motor, 
        color: vehiculo!.color,  
        imagen: vehiculo!.imagen,
        path: vehiculo!.path,
      );
      final cliente = dataBase.usuariosBox.get(idCliente);
      if (cliente != null) {
        final nuevaInstruccion = Bitacora(instruccion: 'syncAgregarVehiculo', usuarioPropietario: prefs.getString("userId")!, idOrdenTrabajo: 0); //Se crea la nueva instrucción a realizar en bitacora
        nuevoVehiculo.bitacora.add(nuevaInstruccion);
        nuevoVehiculo.cliente.target = cliente;
        cliente.vehiculos.add(nuevoVehiculo);
        dataBase.usuariosBox.put(cliente);
        dataBase.vehiculoBox.put(nuevoVehiculo);
        notifyListeners();
      }
    } 
  }

  void update(int id, String newNombre, String newApellidos, String newCurp, 
  String newIntegrantesFamilia, String newTelefono, String newComentarios, int idComunidad, int idEmprendimiento) {
    final updateEmprendedor = dataBase.emprendedoresBox.get(id);

    notifyListeners();
  }

  void addImagen(int idEmprendimiento) {
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      notifyListeners();
    } 
  }

  void updateImagen(int id, Imagenes newImagen, int idEmprendimiento) {
    final updateImagen = dataBase.imagenesBox.get(id);
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