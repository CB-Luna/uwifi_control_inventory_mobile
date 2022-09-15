import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';

class InversionController extends ChangeNotifier {

  List<Inversiones> inversiones= [];

  GlobalKey<FormState> productoEmpFormKey = GlobalKey<FormState>();
 
  //ProductoEmp
  String imagen = '';
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
    imagen = '';
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
        final nuevoSyncInversion = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevoSyncInversionXprodCotizados = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInversionXprodCotizados.statusSync.target = nuevoSyncInversionXprodCotizados;
        nuevaInversion.inversionXprodCotizados.add(nuevaInversionXprodCotizados); //Se agrega la nueva instancia de inversion x prod Cotizados
        nuevaInversion.statusSync.target = nuevoSyncInversion;
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
  String? newProveedorSugerido, int newIdTipoEmpaques, int newCantidad, double? newCostoTotalEstimado, String newImagen) {
    final updateProdSolicitado = dataBase.productosSolicitadosBox.get(idProdSolicitado);
    final updateInversion = dataBase.inversionesBox.get(idInversion);
    final newFamiliaProd = dataBase.familiaProductosBox.get(newIdFamiliaProd);
    final newTipoEmpaques =  dataBase.tipoEmpaquesBox.get(newIdTipoEmpaques);
    if (updateProdSolicitado != null && updateInversion != null && newFamiliaProd != null && newTipoEmpaques != null) {
      // final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      //Restamos actual costoTotal
      updateInversion.totalInversion -= (updateProdSolicitado.costoEstimado == null ? 0.0 : (updateProdSolicitado.costoEstimado! * updateProdSolicitado.cantidad));
      if (newImagen != '') {
        if (updateProdSolicitado.imagen.target != null) {
          final updateImagen  = dataBase.imagenesBox.get(updateProdSolicitado.imagen.target!.id);
          if (updateImagen != null) {
            updateImagen.imagenes = newImagen;
          }
        } else {
          final nuevaImagenProdSolicitado = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para el Prod Solicitado
          updateProdSolicitado.imagen.target = nuevaImagenProdSolicitado;
        }
      }
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
      if (imagen != '') {
        final nuevaImagenProdSolicitado = Imagenes(imagenes: imagen); //Se crea el objeto imagenes para el Prod Solicitado
        nuevoProdSolicitado.imagen.target = nuevaImagenProdSolicitado;
      }
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      final inversion = dataBase.inversionesBox.get(idInversion);
      final familiaProd = dataBase.familiaProductosBox.get(idFamiliaProd);
      final tipoEmpaques = dataBase.tipoEmpaquesBox.get(idTipoEmpaques);
      if (emprendimiento != null && inversion != null && familiaProd != null && tipoEmpaques != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdSolicitado.statusSync.target = nuevoSync;
        nuevoProdSolicitado.familiaProducto.target = familiaProd;
        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
        nuevoProdSolicitado.inversion.target = inversion;
        nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
        inversion.prodSolicitados.add(nuevoProdSolicitado);
        inversion.totalInversion += costo != '' ? (double.parse(costo) * double.parse(cantidad)) : 0.0;
        dataBase.inversionesBox.put(inversion);
        print('ProdSolicitado agregado exitosamente');
        clearInformation();
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