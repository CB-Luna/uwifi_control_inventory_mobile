import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
class OrdenTrabajoController extends ChangeNotifier {

  GlobalKey<FormState> ordenTrabajoFormKey = GlobalKey<FormState>();

  //Datos de la Orden de Trabajo
  int porcentajeGasolina = 0;
  // int idCliente = -1;
  // int idVehiculo = -1;
  // int idFormaPago = -1;
  String gasolina = "";
  String kilometrajeMillaje = "";
  String vinSeleccionado = "No seleccionado";
  Vehiculo? vehiculo;
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController vinController = TextEditingController(); 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController gasolinaController = TextEditingController(); 
  DateTime? fechaOrden; //Es null para inicializar sin porcentajeGasolina el campo en el formulario 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController fechaOrdenController = TextEditingController(); 
  
  String descripcionFalla = "";
  String vinIngresado = "";
  List<String> opcionesVehiculos = [];

  bool validateForm(GlobalKey<FormState> ordenTrabajoKey) {
    return ordenTrabajoKey.currentState!.validate() ? true : false;
  }


  void limpiarInformacion()
  {
    porcentajeGasolina = 0;
    // idCliente = -1;
    // idVehiculo = -1; 
    // idFormaPago = -1;
    gasolina = "";
    kilometrajeMillaje = "";
    vinSeleccionado = "No seleccionado";
    vehiculo = null;
    vinController.clear();
    gasolinaController.clear();
    fechaOrden =  null;
    fechaOrdenController.clear();
    descripcionFalla = "";
    vinIngresado = "";
    opcionesVehiculos.clear();
    notifyListeners();
  }

  void actualizarPorcentajeGasolina(int valor) {
    porcentajeGasolina = valor;
    notifyListeners();
  }
  
  bool add(Usuarios usuario, String medida) {
    final nuevaOrdenTrabajo = OrdenTrabajo(
      fechaOrden: fechaOrden!,
      gasolina: "$porcentajeGasolina %",
      kilometrajeMillaje: "$kilometrajeMillaje $medida",
      descripcionFalla: descripcionFalla,  
      completado: false,
    );
    
    final cliente = vehiculo?.cliente.target;
    // final formaPago = dataBase.formaPagoBox.get(idFormaPago!);
    if (cliente != null && vehiculo != null) {
      //Recepción
      final estatus = dataBase.estatusBox
          .query(Estatus_.estatus.equals("Recepción"))
          .build()
          .findFirst();
      nuevaOrdenTrabajo.estatus.target = estatus;

      nuevaOrdenTrabajo.cliente.target = cliente;
      nuevaOrdenTrabajo.vehiculo.target = vehiculo;
      // nuevaOrdenTrabajo.formaPago.target = formaPago;
      nuevaOrdenTrabajo.asesor.target = usuario;
      final idOrdenTrabajo = dataBase.ordenTrabajoBox.put(nuevaOrdenTrabajo); //Agregamos la orden de trabajo en objectBox
      usuario.ordenesTrabajo.add(nuevaOrdenTrabajo);
      dataBase.usuariosBox.put(usuario);

      final nuevaInstruccion = Bitacora(
        instruccion: 'syncAgregarOrdenTrabajo',
        usuarioPropietario: prefs.getString("userId")!,
        idOrdenTrabajo: idOrdenTrabajo,
      ); //Se crea la nueva instruccion a realizar en bitacora

      nuevaInstruccion.ordenTrabajo.target = nuevaOrdenTrabajo; //Se asigna la orden de trabajo a la nueva instrucción
      nuevaOrdenTrabajo.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox

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

  void enCambioVIN(String vin, List<String> opcionesVehiculosActual) {
    vinIngresado = vin;
    print("Tamaño: ${opcionesVehiculosActual.length}");
    print("VIN ingresado: $vinIngresado");
    if (vinIngresado.length >= 3) {
      opcionesVehiculos.removeWhere((element) {
        final vinUpperCase = element.toUpperCase();
        final tempBusqueda = vinController.text.toUpperCase();
        if (vinUpperCase.contains(tempBusqueda)) {
          return false;
        } else{
          return true;
        }
      });
    } else {
      //Se recuperan los vehiculos
      rellenarOpcionesVehiculos(opcionesVehiculosActual);
    }
    notifyListeners();
  }

  void rellenarOpcionesVehiculos(List<String> opcionesVehiculosActual) {
    opcionesVehiculos = opcionesVehiculosActual;
    notifyListeners();
  }

  void seleccionarVIN(String vin) {
    vinSeleccionado = vin;
    vinController.text = vin;
    vehiculo = dataBase.vehiculoBox.query(Vehiculo_.vin.equals(vin)).build().findUnique();
    opcionesVehiculos.clear();
    notifyListeners();
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
  
}