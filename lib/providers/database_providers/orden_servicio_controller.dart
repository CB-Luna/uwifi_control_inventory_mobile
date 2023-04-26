import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
class OrdenServicioController extends ChangeNotifier {

  GlobalKey<FormState> ordenServicioFormKey = GlobalKey<FormState>();

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

  bool validateForm(GlobalKey<FormState> ordenServicioKey) {
    return ordenServicioKey.currentState!.validate() ? true : false;
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


  bool addOrdenServicio(OrdenTrabajo ordenTrabajo) {
    try {
      double costoTotalOrdenServicio = tipoServicio!.costo;
      final nuevoServicio = Servicio(
          servicio: tipoServicio!.tipoServicio, 
          costoServicio: tipoServicio!.costo, 
          autorizado: true, 
          imagen: tipoServicio!.imagen,
          path: tipoServicio!.path,
          fechaEntrega: fechaEntrega!,
        );
      
      for (var element in productosTemp) {
        nuevoServicio.productos.add(element);
        element.servicio.target = nuevoServicio;
        dataBase.productoBox.put(element);
        costoTotalOrdenServicio += element.costo;
      }

      final nuevoOrdenServicio = OrdenServicio(
        fechaEntrega: fechaEntrega!,
        costoTotal: costoTotalOrdenServicio,
      );
      //Diagnóstico
      final estatus = dataBase.estatusBox
        .query(Estatus_.estatus.equals("Diagnóstico"))
        .build()
        .findFirst();
      ordenTrabajo.estatus.target = estatus;
      final nuevaInstruccionEstatusOrdenTrabajo = Bitacora(
        instruccion: 'syncActualizarEstatusOrdenTrabajo',
        usuarioPropietario: prefs.getString("userId")!,
        idOrdenTrabajo: ordenTrabajo.id,
        instruccionAdicional: estatus?.estatus,
      ); //Se crea la nueva instruccion a realizar en bitacora
      nuevaInstruccionEstatusOrdenTrabajo.ordenTrabajo.target = ordenTrabajo;
      dataBase.bitacoraBox.put(nuevaInstruccionEstatusOrdenTrabajo);

      nuevoServicio.ordenServicio.target = nuevoOrdenServicio;
      nuevoOrdenServicio.servicios.add(nuevoServicio);
      ordenTrabajo.ordenServicio.target = nuevoOrdenServicio;
      dataBase.servicioBox.put(nuevoServicio);
      dataBase.ordenServicioBox.put(nuevoOrdenServicio);
      dataBase.ordenTrabajoBox.put(ordenTrabajo);
      final nuevaInstruccionServicio = Bitacora(instruccion: 'syncAgregarServicio', usuarioPropietario: prefs.getString("userId")!, idOrdenTrabajo: ordenTrabajo.id); //Se crea la nueva instrucción a realizar en bitacora
      nuevaInstruccionServicio.servicio.target = nuevoServicio;
      dataBase.bitacoraBox.put(nuevaInstruccionServicio);
      final nuevaInstruccionOrdenServicio = Bitacora(instruccion: 'syncAgregarOrdenServicio', usuarioPropietario: prefs.getString("userId")!, idOrdenTrabajo: ordenTrabajo.id); //Se crea la nueva instrucción a realizar en bitacora
      nuevaInstruccionOrdenServicio.ordenServicio.target = nuevoOrdenServicio;
      dataBase.bitacoraBox.put(nuevaInstruccionOrdenServicio);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool addServicio(OrdenServicio ordenServicio) {
    try {
      double costoTotalOrdenServicio = tipoServicio!.costo;
      final nuevoServicio = Servicio(
          servicio: tipoServicio!.tipoServicio, 
          costoServicio: tipoServicio!.costo, 
          autorizado: true, 
          imagen: tipoServicio!.imagen,
          path: tipoServicio!.path,
          fechaEntrega: fechaEntrega!,
        );
      
      for (var element in productosTemp) {
        nuevoServicio.productos.add(element);
        element.servicio.target = nuevoServicio;
        dataBase.productoBox.put(element);
        costoTotalOrdenServicio += element.costo;
      }

      ordenServicio.costoTotal = ordenServicio.costoTotal + costoTotalOrdenServicio;
      ordenServicio.servicios.add(nuevoServicio);
      dataBase.servicioBox.put(nuevoServicio);
      dataBase.ordenServicioBox.put(ordenServicio);
      final nuevaInstruccionServicio = Bitacora(instruccion: 'syncAgregarServicio', usuarioPropietario: prefs.getString("userId")!, idOrdenTrabajo: ordenServicio.ordenTrabajo.target!.id); //Se crea la nueva instrucción a realizar en bitacora
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
    for (var element in dataBase.tipoServicioBox.getAll().toList()) {
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
    for (var element in dataBase.tipoProductoBox.getAll().toList()) {
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