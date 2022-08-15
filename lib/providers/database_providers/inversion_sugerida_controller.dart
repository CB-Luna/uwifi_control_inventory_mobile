import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class InversionSugeridaController extends ChangeNotifier {

  List<ProductosEmp> productosEmp= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  String imagen = '';
  String nombre = '';
  String descripcion = '';
  int costo = 0;
  int precioVenta = 0;
  int cantidad = 0;

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> productoEmpKey) {
    return productoEmpKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    imagen = '';
    nombre = '';
    descripcion = '';
    costo = 0;
    precioVenta = 0;
    cantidad = 0;
    notifyListeners();
  }

  void add(int idEmprendimiento, int idFamilia) {
    final nuevoProductoEmp = ProductosEmp(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagen,
      costo: costo,
      precioVenta: precioVenta,
      cantidad: cantidad,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final familia = dataBase.familiaInversionBox.get(idFamilia);
      if (emprendimiento != null && familia != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddInversionSugerida', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoEmp.statusSync.target = nuevoSync;
        nuevoProductoEmp.emprendimientos.target = emprendimiento;
        nuevoProductoEmp.familiaInversion.target = familia;
        nuevoProductoEmp.bitacora.add(nuevaInstruccion);
        emprendimiento.productosEmp.add(nuevoProductoEmp);
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        productosEmp.add(nuevoProductoEmp);
        print('ProductoEmp agregado exitosamente');
        notifyListeners();
      }
  }

  void remove(ProductosEmp productosEmp) {
    dataBase.productosEmpBox.remove(productosEmp.id); //Se elimina de bitacora la instruccion creada anteriormente
    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}