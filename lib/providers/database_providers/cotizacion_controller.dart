import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class CotizacionController extends ChangeNotifier {

  List<ProductosCot> productosCot= [];

  GlobalKey<FormState> productoCotFormKey = GlobalKey<FormState>();
 
  //ProductoCot
  String imagen = '';
  String nombre = '';
  String descripcion = '';
  String costo = '';
  int precioVenta = 0;
  String cantidad = '';
  String proveedor = '';

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> productoCotKey) {
    return productoCotKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    descripcion = '';
    costo = '';
    precioVenta = 0;
    cantidad = '';
    proveedor = '';
    notifyListeners();
  }

  void add(int idEmprendimiento, int idFamilia) {
    final nuevoProductoCot = ProductosCot(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagen,
      costo: double.parse(costo),
      precioVenta: precioVenta,
      cantidad: int.parse(cantidad),
      proveedor: proveedor,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final familia = dataBase.familiaInversionBox.get(idFamilia);
      if (emprendimiento != null && familia != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoCot.statusSync.target = nuevoSync;
        nuevoProductoCot.emprendimientos.target = emprendimiento;
        nuevoProductoCot.familiaInversion.target = familia;
        nuevoProductoCot.bitacora.add(nuevaInstruccion);
        emprendimiento.productosCot.add(nuevoProductoCot);
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        productosCot.add(nuevoProductoCot);
        print('ProductoCot agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void remove(ProductosCot productosCot) {
    dataBase.productosCotBox.remove(productosCot.id); //Se elimina de bitacora la instruccion creada anteriormente
    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}