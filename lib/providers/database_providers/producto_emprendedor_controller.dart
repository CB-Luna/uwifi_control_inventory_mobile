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
      idEmprendimiento: idEmprendimiento,
      );
      //Se agrega las imagen al producto emprendedor
      if (imagen != null) {
        final nuevaImagenProductoEmp = Imagenes(
          imagenes: imagen!.path,
          nombre: imagen!.nombre,
          path: imagen!.path,
          base64: imagen!.base64, 
          idEmprendimiento: idEmprendimiento,
          ); //Se crea el objeto imagenes para la ProductoEmp
        nuevaImagenProductoEmp.productosEmp.target = nuevoProductoEmp;
        nuevoProductoEmp.imagen.target = nuevaImagenProductoEmp;
      }
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final unidadMedidad = dataBase.unidadesMedidaBox.get(idUnidadMedida);
      if (emprendimiento != null && unidadMedidad != null) {
        final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProductoEmp.emprendimientos.target = emprendimiento;
        nuevoProductoEmp.unidadMedida.target = unidadMedidad;
        nuevoProductoEmp.bitacora.add(nuevaInstruccion);
        emprendimiento.productosEmp.add(nuevoProductoEmp);
        dataBase.emprendimientosBox.put(emprendimiento);
        // dataBase.emprendedoresBox.put(nuevoEmprendedor);
        productosEmp.add(nuevoProductoEmp);
        //print('Producto Emprendedor agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void update(int id, String newNombre, String newDescripcion, String newImagen,
    String newCosto, int newIdUnidadMedida, int idEmprendimiento) {
    var updateProdEmprendedor = dataBase.productosEmpBox.get(id);
    final updateUnidadMedida = dataBase.unidadesMedidaBox.get(newIdUnidadMedida);
    if (updateProdEmprendedor !=  null && updateUnidadMedida != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProductoEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateProdEmprendedor.nombre = newNombre;
      updateProdEmprendedor.descripcion = newDescripcion;
      // updateProdEmprendedor.imagen =  newImagen;
      updateProdEmprendedor.costo = double.parse(newCosto);
      updateProdEmprendedor.unidadMedida.target = updateUnidadMedida;
      updateProdEmprendedor.bitacora.add(nuevaInstruccion);
      dataBase.productosEmpBox.put(updateProdEmprendedor);
    }
    //print('Producto Emprendedor actualizado exitosamente');
    notifyListeners();
}

void updateImagenProductoEmp(int idImagenProductoEmp, String newNombreImagen, String newPath, String newBase64, int idEmprendimiento) {
    var updateImagenProductoEmp = dataBase.imagenesBox.get(idImagenProductoEmp);
    final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateImagenProductoEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    if (updateImagenProductoEmp != null) {
      updateImagenProductoEmp.imagenes = newPath; //Se actualiza la imagen del producto emprendedor
      updateImagenProductoEmp.nombre = newNombreImagen;
      updateImagenProductoEmp.base64 = newBase64;
      updateImagenProductoEmp.path = newPath;
      updateImagenProductoEmp.bitacora.add(nuevaInstruccion);
      dataBase.imagenesBox.put(updateImagenProductoEmp);
      //print('Imagen Prod Emprendedor actualizada exitosamente');
    }
    notifyListeners();
  }

void addImagenProductoEmp(ProductosEmp productoEmp, String newNombreImagen, String newPath, String newBase64, int idEmprendimiento) {
    final nuevaInstruccionImagen = Bitacora(instruccion: 'syncAddImagenProductoEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
    final nuevaInstruccionProductoEmp = Bitacora(instruccion: 'syncUpdateProductoEmprendedor', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      final nuevaImagenProductoEmp = Imagenes(
        imagenes: newPath,
        nombre: newNombreImagen,
        base64: newBase64,
        path: newPath, 
        idEmprendimiento: idEmprendimiento,
      );
      nuevaImagenProductoEmp.productosEmp.target = productoEmp;
      productoEmp.imagen.target = nuevaImagenProductoEmp;
      productoEmp.bitacora.add(nuevaInstruccionProductoEmp);
      nuevaImagenProductoEmp.bitacora.add(nuevaInstruccionImagen);
      dataBase.imagenesBox.put(nuevaImagenProductoEmp);
      dataBase.productosEmpBox.put(productoEmp);
      //print('Imagen Prod Emprendedor agregada exitosamente');
    notifyListeners();
  }
  
}