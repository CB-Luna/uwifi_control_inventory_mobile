import 'package:diacritic/diacritic.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/vehiculo_temporal.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
class VehiculoController extends ChangeNotifier {
  VehiculoTemporal? vehiculo; 

  GlobalKey<FormState> vehiculoFormKey = GlobalKey<FormState>();

  //Vehículo
  // TextEditingController integrantesFamilia = TextEditingController();
  List<String> listaMarcas = [];
  List<String> listaModelos = [];
  List<String> listaAnios = [];

  String imagenVehiculo = "";
  String? path;
  String marcaSeleccionada = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController marcaController = TextEditingController(); 
  String modeloSeleccionado = "";
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController modeloController = TextEditingController(); 
  String anioSeleccionado = "";
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
    listaMarcas.clear();
    listaModelos.clear();
    listaAnios.clear();

    vehiculo = null;
    imagenVehiculo = "";
    path = null; 
    marcaSeleccionada = "";
    marcaController.clear();
    modeloSeleccionado = "";
    modeloController.clear();
    anioSeleccionado = "";
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
      marca: marcaSeleccionada, 
      modelo: modeloSeleccionado,
      anio: anioSeleccionado, 
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

  void enCambioMarca(String marca) {
    if (marcaController.text == marcaSeleccionada) {
      Marca? objetoMarca = dataBase.marcaBox.query(Marca_.marca.equals(marca)).build().findFirst();
      if (objetoMarca != null) {
        listaModelos.clear();
        listaAnios.clear();
        for (var element in objetoMarca.modelos) {
          listaModelos.add(element.modelo);
        }
        listaModelos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      } else{
        listaModelos.clear();
        listaAnios.clear();
        modeloController.text = "";
        anioController.text = "";
        modeloSeleccionado = "";
        anioSeleccionado = "";
      }
    } else {
      listaModelos.clear();
      listaAnios.clear();
      modeloController.text = "";
      anioController.text = "";
      modeloSeleccionado = "";
      anioSeleccionado = "";
    }
    notifyListeners();
  }

  void seleccionarMarca(String marca) {
    marcaSeleccionada = marca; 
    marcaController.text = marca;
    Marca? objetoMarca = dataBase.marcaBox.query(Marca_.marca.equals(marca)).build().findFirst();
      if (objetoMarca != null) {
        listaModelos.clear();
        for (var element in objetoMarca.modelos) {
          listaModelos.add(element.modelo);
        }
        listaModelos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      } else{
        listaModelos.clear();
        modeloController.text = "";
        anioController.text = "";
        modeloSeleccionado = "";
        anioSeleccionado = "";
      }
    notifyListeners();
  }

  void enCambioModelo(String modelo) {
    if (modeloController.text == modeloSeleccionado) {
      Modelo? objetoModelo = dataBase.modeloBox.query(Modelo_.modelo.equals(modelo)).build().findFirst();
      listaAnios.clear();
      if (objetoModelo != null) {
        for (var element in objetoModelo.anios) {
          listaAnios.add(element.anio);
        }
        listaAnios.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      } else{
        listaAnios.clear();
        anioController.text = "";
        anioSeleccionado = "";
      }
    } else {
      listaAnios.clear();
      anioController.text = "";
      anioSeleccionado = "";
    }
    notifyListeners();
  }

  void seleccionarModelo(String modelo) {
    modeloSeleccionado = modelo; 
    modeloController.text = modelo;
    Modelo? objetoModelo = dataBase.modeloBox.query(Modelo_.modelo.equals(modelo)).build().findFirst();
      if (objetoModelo != null) {
        listaAnios.clear();
        for (var element in objetoModelo.anios) {
          listaAnios.add(element.anio);
        }
        listaAnios.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      } else{
        listaAnios.clear();
        anioController.text = "";
        anioSeleccionado = "";
      }
    notifyListeners();
  }

  void enCambioAnio(String anio) {
    if (anioController.text == anioSeleccionado) {
      notifyListeners();
    }
  }

  void seleccionarAnio(String anio) {
    anioSeleccionado = anio; 
    anioController.text = anio;
    notifyListeners();
  }

}