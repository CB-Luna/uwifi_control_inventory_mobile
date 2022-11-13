import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/productos_vendidos_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:uuid/uuid.dart';

class ProductoVentaController extends ChangeNotifier {

  List<ProductosVendidosTemporal> productosVendidos = [];

  GlobalKey<FormState> productoVendidoFormKey = GlobalKey<FormState>();
 
  //ProductoSol
  String cantidad = '';
  String precioVenta = '';
  DateTime fechaRegistro = DateTime.now();
  var uuid = Uuid();

  bool validateForm(GlobalKey<FormState> productoVendidoKey) {
    return productoVendidoKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    cantidad = '';
    fechaRegistro = DateTime.now();
    productosVendidos.clear();
    notifyListeners();
  }

  void addTemporal(int idProductoEmp, String producto, int idUnidadMedida, String unidadMedida, double costoUnitario, String subTotal) {
    //Se crea un Id temporal
    final id = uuid.v4();
    final nuevoProductoVendido = ProductosVendidosTemporal(
      id: id,
      idProductoEmp: idProductoEmp,
      producto: producto,
      idUnidadMedida: idUnidadMedida,
      unidadMedida: unidadMedida,
      cantidad: int.parse(cantidad),
      costoUnitario: costoUnitario,
      precioVenta: double.parse(precioVenta),
      subTotal: double.parse(subTotal),
      fechaRegistro: DateTime.now(),
    );
    productosVendidos.add(nuevoProductoVendido);
    print('Producto Vendido agregado exitosamente');
    notifyListeners();
  }

  void updateTemporal(String idProdVendidoTemp, int newIdProductoEmp, String newProducto, int newIdUnidadMedida, String newUnidadMedida, 
    String newCantidad, String newCostoUnitario, String newPrecioVenta, String newSubTotal, DateTime fechaRegistro
    ) {
    final updateProductoVendido = ProductosVendidosTemporal(
        id: idProdVendidoTemp,
        idProductoEmp: newIdProductoEmp,
        producto: newProducto,
        idUnidadMedida: newIdUnidadMedida,
        unidadMedida: newUnidadMedida,
        cantidad: int.parse(newCantidad),
        costoUnitario: double.parse(newCostoUnitario),
        precioVenta: double.parse(newPrecioVenta),
        subTotal: double.parse(newSubTotal),
        fechaRegistro: fechaRegistro,
      );
      //Se actualiza el registro
    for (var i = 0; i < productosVendidos.length; i++) {
      if (productosVendidos[i].id == idProdVendidoTemp) {
        productosVendidos[i] = updateProductoVendido;
      }
    }
    print('Producto Vendido actualizado exitosamente');
    notifyListeners();
  
  }

void add(int idEmprendimiento, int idVenta) {
  final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  final venta = dataBase.ventasBox.get(idVenta);
  if (emprendimiento != null && venta != null) {
    for (var i = 0; i < productosVendidos.length; i++) {
      final productoEmp = dataBase.productosEmpBox.get(productosVendidos[i].idProductoEmp);
      if (productoEmp !=  null) {
        final nuevoProdVendido = ProdVendidos(
          nombreProd: productoEmp.nombre,
          descripcion: productoEmp.descripcion,
          costo: productoEmp.costo, 
          cantVendida: productosVendidos[i].cantidad,
          subtotal: productosVendidos[i].subTotal,
          precioVenta: productosVendidos[i].precioVenta, 
        );
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoVendido', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdVendido.productoEmp.target = productoEmp;
        nuevoProdVendido.statusSync.target = nuevoSync;
        nuevoProdVendido.venta.target = venta;
        nuevoProdVendido.unidadMedida.target = productoEmp.unidadMedida.target;
        nuevoProdVendido.bitacora.add(nuevaInstruccion);
        venta.prodVendidos.add(nuevoProdVendido);
        dataBase.ventasBox.put(venta);
      }
    }
    print('Productos Vendidos agregados exitosamente');
    clearInformation();
    notifyListeners();
  }
}

void addSingle(int idVenta, int idProductoEmp, String subTotal, ) {
  final venta = dataBase.ventasBox.get(idVenta);
  final productoEmp = dataBase.productosEmpBox.get(idProductoEmp);
  if (venta != null && productoEmp != null) {
      final nuevoProdVendido = ProdVendidos(
        nombreProd: productoEmp.nombre,
        descripcion: productoEmp.descripcion,
        costo: productoEmp.costo, 
        cantVendida: int.parse(cantidad),
        subtotal: double.parse(subTotal),
        precioVenta: double.parse(precioVenta),
      );
      final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoVendido', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevoProdVendido.productoEmp.target = productoEmp;
      nuevoProdVendido.statusSync.target = nuevoSync;
      nuevoProdVendido.venta.target = venta;
      nuevoProdVendido.unidadMedida.target = productoEmp.unidadMedida.target;
      nuevoProdVendido.bitacora.add(nuevaInstruccion);
      venta.prodVendidos.add(nuevoProdVendido);
      dataBase.ventasBox.put(venta);
      print('Producto Vendido agregado exitosamente');
      clearInformation();
      notifyListeners();
  }
  }

void update(int id, int idProductoEmp, double newPrecioVenta, int newCantidad, double newSubTotal) {
    var updateProdVendido = dataBase.productosVendidosBox.get(id);
    final updateProductoEmp = dataBase.productosEmpBox.get(idProductoEmp);
    if (updateProdVendido != null && updateProductoEmp != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProductoVendido', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateProdVendido.productoEmp.target = updateProductoEmp;
      updateProdVendido.cantVendida = newCantidad;
      updateProdVendido.precioVenta =  newPrecioVenta;
      updateProdVendido.subtotal = newSubTotal;
      final statusSyncProdVendido = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdVendido.statusSync.target!.id)).build().findUnique();
      if (statusSyncProdVendido != null) {
        statusSyncProdVendido.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Solicitado
        dataBase.statusSyncBox.put(statusSyncProdVendido);
      }
      updateProdVendido.bitacora.add(nuevaInstruccion);
      dataBase.productosVendidosBox.put(updateProdVendido);
    }
    print('Producto Vendido actualizado exitosamente');
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
  void remove(ProdVendidos productoVendido) {
    print("Tamaño productos vendidos antes de remover: ${dataBase.productosVendidosBox.getAll().length}");
    final nuevaInstruccion = Bitacora(instruccion: 'syncDeleteProductoVendido', usuario: prefs.getString("userId")!, idDBR: productoVendido.idDBR); //Se crea la nueva instruccion a realizar en bitacora
    productoVendido.bitacora.add(nuevaInstruccion);
    dataBase.productosVendidosBox.remove(productoVendido.id); //Se elimina de bitacora la instruccion creada anteriormente?
    print("Tamaño productos después de remover: ${dataBase.productosVendidosBox.getAll().length}");
    notifyListeners(); 
  }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }

}