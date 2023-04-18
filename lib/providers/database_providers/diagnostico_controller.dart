import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/modelsLocales/estatus/estatus_data.dart';
import 'package:taller_alex_app_asesor/modelsLocales/productos/productos_data.dart';
import 'package:taller_alex_app_asesor/modelsLocales/servicios/servicios_data.dart';
class DiagnosticoController extends ChangeNotifier {

  GlobalKey<FormState> diagnosticoFormKey = GlobalKey<FormState>();

  //Diagnóstico
  String productoSeleccionado = "";
  String servicioSeleccionado = "";
  String productoIngresado = "";
  String servicioIngresado = "";
  TipoServicio? tipoServicio;
  TipoProducto? tipoProducto;
  int cantidad = 1;
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController servicioController = TextEditingController(); 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController productoController = TextEditingController(); 
  //Se asigna un controller para que se pueda visualizar lo que se selecciona del Widget que abre el campo
  TextEditingController fechaEntregaController = TextEditingController(); 
  DateTime? fechaEntrega; 
  String comentarios = "";
  List<String> opcionesServicios = [];
  List<String> opcionesProductos = [];
  List<Producto> productosTemp = [];

  bool validateForm(GlobalKey<FormState> diagnosticoKey) {
    return diagnosticoKey.currentState!.validate() ? true : false;
  }

  void limpiarInformacion()
  {
    tipoServicio = null;
    tipoProducto = null;
    productoSeleccionado = "";
    servicioSeleccionado = "";
    productoIngresado = "";
    servicioIngresado = "";
    comentarios = "";
    fechaEntrega = null;
    fechaEntregaController.clear();
    servicioController.clear();
    productoController.clear();
    opcionesServicios.clear();
    opcionesProductos.clear();
    productosTemp.clear();
    cantidad = 1;
    // gasolinaController.clear();
    notifyListeners();
  }

   void limpiarInformacionProductos()
  {
    tipoProducto = null;
    productoSeleccionado = "";
    productoIngresado = "";
    productoController.clear();
    opcionesProductos.clear();
    cantidad = 1;
    notifyListeners();
  }


  bool addDiagnostico(OrdenTrabajo ordenTrabajo) {
    try {
      double costoTotalDiagnostico = tipoServicio!.costo;
      final nuevoServicio = Servicio(
          servicio: tipoServicio!.tipoServicio, 
          costoServicio: tipoServicio!.costo, 
          autorizado: true, 
          imagen: tipoServicio!.imagen,
          fechaEntrega: fechaEntrega!,
        );
      
      for (var element in productosTemp) {
        nuevoServicio.productos.add(element);
        element.servicio.target = nuevoServicio;
        dataBase.productoBox.put(element);
        costoTotalDiagnostico += element.costo;
      }

      final nuevoDiagnostico = Diagnostico(
        fechaEntrega: fechaEntrega!,
        costoTotal: costoTotalDiagnostico,
      );
      //Diagnóstico
      final estatus = listaEstatusData.elementAt(3);
      dataBase.estatusBox.put(estatus);
      ordenTrabajo.estatus.target = estatus;

      nuevoServicio.diagnostico.target = nuevoDiagnostico;
      nuevoDiagnostico.servicios.add(nuevoServicio);
      ordenTrabajo.diagnostico.target = nuevoDiagnostico;
      dataBase.servicioBox.put(nuevoServicio);
      dataBase.diagnosticoBox.put(nuevoDiagnostico);
      dataBase.ordenTrabajoBox.put(ordenTrabajo);
      final nuevaInstruccionServicio = Bitacora(instruccion: 'syncAgregarServicio', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instrucción a realizar en bitacora
      nuevaInstruccionServicio.servicio.target = nuevoServicio;
      dataBase.bitacoraBox.put(nuevaInstruccionServicio);
      final nuevaInstruccionDiagnostico = Bitacora(instruccion: 'syncAgregarDiagnostico', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instrucción a realizar en bitacora
      nuevaInstruccionDiagnostico.diagnostico.target = nuevoDiagnostico;
      dataBase.bitacoraBox.put(nuevaInstruccionDiagnostico);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool addServicio(Diagnostico diagnostico) {
    try {
      double costoTotalDiagnostico = tipoServicio!.costo;
      final nuevoServicio = Servicio(
          servicio: tipoServicio!.tipoServicio, 
          costoServicio: tipoServicio!.costo, 
          autorizado: true, 
          imagen: tipoServicio!.imagen,
          fechaEntrega: fechaEntrega!,
        );
      
      for (var element in productosTemp) {
        nuevoServicio.productos.add(element);
        element.servicio.target = nuevoServicio;
        dataBase.productoBox.put(element);
        costoTotalDiagnostico += element.costo;
      }

      diagnostico.costoTotal = diagnostico.costoTotal + costoTotalDiagnostico;
      diagnostico.servicios.add(nuevoServicio);
      dataBase.servicioBox.put(nuevoServicio);
      dataBase.diagnosticoBox.put(diagnostico);
      final nuevaInstruccionServicio = Bitacora(instruccion: 'syncAgregarServicio', usuario: prefs.getString("userId")!, idEmprendimiento: 0); //Se crea la nueva instrucción a realizar en bitacora
      nuevaInstruccionServicio.servicio.target = nuevoServicio;
      dataBase.bitacoraBox.put(nuevaInstruccionServicio);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }


  void enCambioServicio(String servicio, List<String> opcionesServiciosActual) {
    servicioIngresado = servicio;
    print("Tamaño: ${opcionesServiciosActual.length}");
    print("Servicio ingresado: $servicioIngresado");
    if (servicioIngresado.length >= 3) {
      opcionesServicios.removeWhere((element) {
        final servicioUpperCase = element.toUpperCase();
        final tempBusqueda = servicioController.text.toUpperCase();
        if (servicioUpperCase.contains(tempBusqueda)) {
          return false;
        } else{
          return true;
        }
      });
    } else {
      //Se recuperan los servicios
      servicioSeleccionado = "";
      rellenarOpcionesServicios(opcionesServiciosActual);
    }
    notifyListeners();
  }

  void rellenarOpcionesServicios(List<String> opcionesServiciosActual) {
    opcionesServicios = opcionesServiciosActual;
    notifyListeners();
  }

  void enCambioProducto(String producto, List<String> opcionesProductosActual) {
    productoIngresado = producto;
    print("Tamaño: ${opcionesProductosActual.length}");
    print("producto ingresado: $productoIngresado");
    if (productoIngresado.length >= 3) {
      opcionesProductos.removeWhere((element) {
        final productoUpperCase = element.toUpperCase();
        final tempBusqueda = productoController.text.toUpperCase();
        if (productoUpperCase.contains(tempBusqueda)) {
          return false;
        } else{
          return true;
        }
      });
    } else {
      //Se recuperan los productos
      productoSeleccionado = "";
      rellenarOpcionesProductos(opcionesProductosActual);
    }
    notifyListeners();
  }

  void enCambioCantidadProducto(int nuevaCantidad) {
    cantidad = nuevaCantidad;
    notifyListeners();
  }


  void rellenarOpcionesProductos(List<String> opcionesProductosActual) {
    opcionesProductos = opcionesProductosActual;
    notifyListeners();
  }

  void seleccionarServicio(String servicio) {
    servicioSeleccionado = servicio;
    servicioController.text = servicio;
    for (var element in listaServiciosData) {
      if (element.tipoServicio == servicio) {
        tipoServicio = element;
      }
    }
    opcionesServicios.clear();
    notifyListeners();
  }

  void seleccionarProducto(String producto) {
    productoSeleccionado = producto;
    productoController.text = producto;
    for (var element in listaProductosData) {
      if (element.tipoProducto == producto) {
        tipoProducto = element;
      }
    }
    opcionesProductos.clear();
    notifyListeners();
  }

  void agregarProductoTemporal() {
    Producto productoNuevo = Producto(
      producto: tipoProducto!.tipoProducto, 
      cantidad: cantidad, 
      costo: cantidad * tipoProducto!.costo);
    productosTemp.add(productoNuevo);
    opcionesProductos.clear();
    notifyListeners();
  }
  
}