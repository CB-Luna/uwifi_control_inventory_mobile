import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class InversionController extends ChangeNotifier {

  List<Inversiones> inversiones= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  SaveImagenesLocal? imagen;
  String nombre = '';
  String descripcion = '';
  String costo = '';
  String cantidad = '';
  String proveedor = '';
  String marcaSugerida = '';

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
    marcaSugerida = '';
    notifyListeners();
  }

  int addInversion(int idEmprendimiento, String porcentaje) {
    int idInversion = -1;
    final nuevaInversion = Inversiones(
      porcentajePago: int.parse(porcentaje),
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
      if (emprendimiento != null && estadoInversion != null) {
        final nuevaInversionXprodCotizados = InversionesXProdCotizados(); //Se crea la instancia inversion x prod Cotizados
        nuevaInversionXprodCotizados.inversion.target = nuevaInversion;
        final nuevaInstruccion = Bitacora(instruccion: 'syncAddInversion', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInversion.inversionXprodCotizados.add(nuevaInversionXprodCotizados); //Se agrega la nueva instancia de inversion x prod Cotizados
        nuevaInversion.estadoInversion.target = estadoInversion;
        nuevaInversion.emprendimiento.target = emprendimiento;
        nuevaInversion.bitacora.add(nuevaInstruccion);
        idInversion = dataBase.inversionesBox.put(nuevaInversion);
        emprendimiento.inversiones.add(nuevaInversion);
        dataBase.emprendimientosBox.put(emprendimiento);
        print('Inversion agregada exitosamente');
        notifyListeners();
      }
    return idInversion;
  }

  void updateProductoSolicitado(int idProdSolicitado, int idInversion, int newIdFamiliaProd, String? newMarcaSugerida,
  String? newProveedorSugerido, int newIdTipoEmpaques, int newCantidad, double? newCostoTotalEstimado) {
    final updateProdSolicitado = dataBase.productosSolicitadosBox.get(idProdSolicitado);
    final updateInversion = dataBase.inversionesBox.get(idInversion);
    final newFamiliaProd = dataBase.familiaProductosBox.get(newIdFamiliaProd);
    final newTipoEmpaques =  dataBase.tipoEmpaquesBox.get(newIdTipoEmpaques);
    if (updateProdSolicitado != null && updateInversion != null && newFamiliaProd != null && newTipoEmpaques != null) {
      // final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Restamos actual costoTotal
      updateInversion.totalInversion -= (updateProdSolicitado.costoEstimado == null ? 0.0 : (updateProdSolicitado.costoEstimado! * updateProdSolicitado.cantidad));
      updateProdSolicitado.familiaProducto.target = newFamiliaProd;
      updateProdSolicitado.marcaSugerida = newMarcaSugerida;
      updateProdSolicitado.proveedorSugerido =  newProveedorSugerido;
      updateProdSolicitado.tipoEmpaques.target = newTipoEmpaques;
      updateProdSolicitado.cantidad = newCantidad;
      updateProdSolicitado.costoEstimado = newCostoTotalEstimado;
      dataBase.productosSolicitadosBox.put(updateProdSolicitado);
      //Sumamos actual costoTotal
      updateInversion.totalInversion += newCostoTotalEstimado == null ? 0.0 : (newCostoTotalEstimado * newCantidad);
      dataBase.inversionesBox.put(updateInversion);
      print('Prod Solicitado actualizado exitosamente');
      clearInformation();
      notifyListeners();
    }
  }

  void updateImagenProductoSolicitado(ProdSolicitado updateProdSol, int idImagenProductoSol, String newNombreImagen, String newPath, String newBase64) {
    var updateImagenProductoSol = dataBase.imagenesBox.get(idImagenProductoSol);
    if (updateImagenProductoSol != null) {
      updateImagenProductoSol.imagenes = newPath; //Se actualiza la imagen del producto solicitado
      updateImagenProductoSol.nombre = newNombreImagen;
      updateImagenProductoSol.base64 = newBase64;
      updateImagenProductoSol.path = newPath;
      dataBase.imagenesBox.put(updateImagenProductoSol);
      updateProdSol.imagen.target = updateImagenProductoSol;
      dataBase.productosSolicitadosBox.put(updateProdSol);
      print('Imagen Prod Solicitado actualizada exitosamente');
    }
    notifyListeners();
  }

void addImagenProductoSolicitado(ProdSolicitado productoSol, String newNombreImagen, String newPath, String newBase64) {
      final nuevaImagenProductoSol = Imagenes(
        imagenes: newPath,
        nombre: newNombreImagen,
        base64: newBase64,
        path: newPath,
      );
      productoSol.imagen.target = nuevaImagenProductoSol;
      dataBase.imagenesBox.put(nuevaImagenProductoSol);
      dataBase.productosSolicitadosBox.put(productoSol);
      print('Imagen Prod Solicitado agregada exitosamente');
    notifyListeners();
  }

  void addProductoSolicitado(int idEmprendimiento, int idInversion, int idFamiliaProd, int idTipoEmpaques) {
    print("Nombre: $cantidad");
    print("descrip: $descripcion");
    print("Cantidad: $cantidad");
    final nuevoProdSolicitado = ProdSolicitado(
      idInversion: idInversion,
      producto: nombre,
      marcaSugerida: marcaSugerida,
      descripcion: descripcion,
      proveedorSugerido: proveedor,
      cantidad: int.parse(cantidad),
      costoEstimado: costo != '' ? double.parse(costo) : 0.0,
      );
      if (imagen != null) {
        final nuevaImagenProdSolicitado = Imagenes(
          imagenes: imagen!.path,
          nombre: imagen!.nombre,
          path: imagen!.path,
          base64: imagen!.base64,
          ); //Se crea el objeto imagenes para el Prod Solicitado
        nuevoProdSolicitado.imagen.target = nuevaImagenProdSolicitado;
      }
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final inversion = dataBase.inversionesBox.get(idInversion);
      final familiaProd = dataBase.familiaProductosBox.get(idFamiliaProd);
      final tipoEmpaques = dataBase.tipoEmpaquesBox.get(idTipoEmpaques);
      if (emprendimiento != null && inversion != null && familiaProd != null && tipoEmpaques != null) {
        // final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdSolicitado.familiaProducto.target = familiaProd;
        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
        nuevoProdSolicitado.inversion.target = inversion;
        // nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
        inversion.prodSolicitados.add(nuevoProdSolicitado);
        inversion.totalInversion += costo != '' ? (double.parse(costo) * double.parse(cantidad)) : 0.0;
        dataBase.inversionesBox.put(inversion);
        print('ProdSolicitado agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
  }

  void remove(ProdSolicitado productoSolicitado) {
    final inversion = dataBase.inversionesBox.get(productoSolicitado.idInversion);
    if (inversion != null) {
      print("Tamaño productos solicitados antes de remover: ${dataBase.productosSolicitadosBox.getAll().length}");
      // final nuevaInstruccion = Bitacora(instruccion: 'syncDeleteProductoSolicitado', usuario: prefs.getString("userId")!, idDBR: productoSolicitado.idDBR); //Se crea la nueva instruccion a realizar en bitacora
      //Se resta de la inversión el costo del Prod Solicitado
      inversion.totalInversion -= productoSolicitado.costoEstimado != null ? (productoSolicitado.cantidad * productoSolicitado.costoEstimado!) : 0.0;
      dataBase.inversionesBox.put(inversion);
      // productoSolicitado.bitacora.add(nuevaInstruccion);
      dataBase.productosSolicitadosBox.remove(productoSolicitado.id); //Se elimina de bitacora la instruccion creada anteriormente?
      print("Tamaño productos solicitados después de remover: ${dataBase.productosSolicitadosBox.getAll().length}");
      notifyListeners(); 
    }
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }
  
}