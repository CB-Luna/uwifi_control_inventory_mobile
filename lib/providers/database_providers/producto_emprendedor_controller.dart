import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class ProductoEmprendedorController extends ChangeNotifier {

  List<ProductosEmp> productosEmp= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  SaveImagenesLocal? imagen;
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
    imagen = null;
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
      costo: double.parse(costo),
      );
      //Se agrega las imagen al producto emprendedor
      if (imagen != null) {
        final nuevaImagenProductoEmp = Imagenes(
          imagenes: imagen!.path,
          nombre: imagen!.nombre,
          path: imagen!.path,
          base64: imagen!.base64,
          ); //Se crea el objeto imagenes para la ProductoEmp
        nuevaImagenProductoEmp.productosEmp.target = nuevoProductoEmp;
        nuevoProductoEmp.imagen.target = nuevaImagenProductoEmp;
      }
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final unidadMedidad = dataBase.unidadesMedidaBox.get(idUnidadMedida);
      if (emprendimiento != null && unidadMedidad != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
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
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateProdEmprendedor.nombre = newNombre;
      updateProdEmprendedor.descripcion = newDescripcion;
      // updateProdEmprendedor.imagen =  newImagen;
      updateProdEmprendedor.costo = double.parse(newCosto);
      updateProdEmprendedor.unidadMedida.target = updateUnidadMedida;
      updateProdEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.productosEmpBox.put(updateProdEmprendedor);
    }
    print('Producto Emprendedor actualizado exitosamente');
    notifyListeners();
}

void updateImagenUsuario(int idImagenUsuario, String newNombreImagen, String newPath, String newBase64) {
    var updateImagenUsuario = dataBase.imagenesBox.get(idImagenUsuario);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
    if (updateImagenUsuario != null) {
      updateImagenUsuario.imagenes = newPath; //Se actualiza la imagen del usuario
      updateImagenUsuario.nombre = newNombreImagen;
      updateImagenUsuario.base64 = newBase64;
      updateImagenUsuario.path = newPath;
      updateImagenUsuario.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(updateImagenUsuario);
      print('Imagen Prod Emprendedor actualizada exitosamente');
    }
    notifyListeners();
  }

void addImagenUsuario(String newNombreImagen, String newPath, String newBase64) {
    final nuevaInstruccion = Bitacora(instruccion: 'syncAddImagenProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      final newImagenUsuario = Imagenes(
        imagenes: newPath,
        nombre: newNombreImagen,
        base64: newBase64,
        path: newPath,
      );
      newImagenUsuario.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(newImagenUsuario);
      print('Imagen Prod Emprendedor agregada exitosamente');
    notifyListeners();
  }
  
}