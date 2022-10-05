import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class ProductoEmprendedorController extends ChangeNotifier {

  List<ProductosEmp> productosEmp= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  String imagen = '';
  String nombre = '';
  String descripcion = '';
  String costo = '';
  String cantidad = '';
  String proveedor = '';

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
    costo = '';
    cantidad = '';
    proveedor = '';
    notifyListeners();
  }

  void add(int idEmprendimiento, int idUnidadMedida) {
    final nuevoProductoEmp = ProductosEmp(
      nombre: nombre,
      descripcion: descripcion,
      imagen: imagen,
      costo: double.parse(costo),
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final unidadMedidad = dataBase.unidadesMedidaBox.get(idUnidadMedida);
      if (emprendimiento != null && unidadMedidad != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoEmp.statusSync.target = nuevoSync;
        nuevoProductoEmp.emprendimientos.target = emprendimiento;
        nuevoProductoEmp.unidadMedida.target = unidadMedidad;
        nuevoProductoEmp.bitacora.add(nuevaInstruccion);
        emprendimiento.productosEmp.add(nuevoProductoEmp);
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        productosEmp.add(nuevoProductoEmp);
        print('Producto Emprendedor agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void update(int id, String newNombre, String newDescripcion, String newImagen,
    String newCosto, int newIdUnidadMedida) {
    var updateProdEmprendedor = dataBase.productosEmpBox.get(id);
    final updateUnidadMedida = dataBase.unidadesMedidaBox.get(newIdUnidadMedida);
    if (updateProdEmprendedor !=  null && updateUnidadMedida != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateProdEmprendedor.nombre = newNombre;
      updateProdEmprendedor.descripcion = newDescripcion;
      updateProdEmprendedor.imagen =  newImagen;
      updateProdEmprendedor.costo = double.parse(newCosto);
      updateProdEmprendedor.unidadMedida.target = updateUnidadMedida;
      final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdEmprendedor.statusSync.target!.id)).build().findUnique();
      if (statusSyncJornada != null) {
        statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Solicitado
        dataBase.statusSyncBox.put(statusSyncJornada);
      }
      updateProdEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.productosEmpBox.put(updateProdEmprendedor);
    }
    print('Producto Emprendedor actualizado exitosamente');
    notifyListeners();
}
  //TODO Eliminar producto del backend, agregando un campo idbr en la bitacora

  // void remove(ProductosEmp productosEmp) {
  //   print("Tamaño productos antes de remover: ${dataBase.productosEmpBox.getAll().length}");
  //   final nuevaInstruccion = Bitacora(instrucciones: 'syncDeleteProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
  //   dataBase.productosEmpBox.remove(productosEmp.id); //Se elimina de bitacora la instruccion creada anteriormente
  //   print("Tamaño productos después de remover: ${dataBase.productosEmpBox.getAll().length}");
  //   notifyListeners(); 
  // }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}