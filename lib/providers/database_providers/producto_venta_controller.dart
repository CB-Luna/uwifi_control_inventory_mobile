import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/productos_vendidos_temporal.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_instruccion_producto_vendido.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:uuid/uuid.dart';

class ProductoVentaController extends ChangeNotifier {

  List<ProductosVendidosTemporal> productosVendidos = [];

  GlobalKey<FormState> productoVendidoFormKey = GlobalKey<FormState>();
 
  //ProductoSol
  String cantidad = '';
  String precioVenta = '';
  DateTime fechaRegistro = DateTime.now();
  List<SaveInstruccionProductoVendido> instruccionesProdVendido = [];
  List<ProdVendidos> listProdVendidosActual = [];
  var uuid = Uuid();

  bool validateForm(GlobalKey<FormState> productoVendidoKey) {
    return productoVendidoKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    cantidad = '';
    precioVenta = '';
    fechaRegistro = DateTime.now();
    productosVendidos.clear();
    instruccionesProdVendido.clear();
    listProdVendidosActual.clear();
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
    //print('Producto Vendido agregado exitosamente');
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
    //print('Producto Vendido actualizado exitosamente');
    notifyListeners();
  
  }

void add(int idEmprendimiento, int idVenta) {
  final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  final venta = dataBase.ventasBox.get(idVenta);
  var total = 0.0;
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
          idEmprendimiento: idEmprendimiento, 
        );
        total += productosVendidos[i].subTotal;
        final nuevaInstruccion = Bitacora(instruccion: 'syncAddProductoVendido', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdVendido.productoEmp.target = productoEmp;
        nuevoProdVendido.venta.target = venta;
        nuevoProdVendido.unidadMedida.target = productoEmp.unidadMedida.target;
        nuevoProdVendido.bitacora.add(nuevaInstruccion);
        venta.total = total;
        venta.prodVendidos.add(nuevoProdVendido);
        dataBase.ventasBox.put(venta);
      }
    }
    //print('Productos Vendidos agregados exitosamente');
    clearInformation();
    notifyListeners();
  }
}


  void updateProductosVendidos(Ventas venta, int idEmprendimiento) {
    for (var i = 0; i < instruccionesProdVendido.length; i++) {
      switch (instruccionesProdVendido[i].instruccion) {
        case "syncAddSingleProductoVendido":
          venta.total += (instruccionesProdVendido[i].prodVendido.cantVendida * instruccionesProdVendido[i].prodVendido.precioVenta);
          final nuevaInstruccion = Bitacora(instruccion: 'syncAddSingleProductoVendido', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          instruccionesProdVendido[i].prodVendido.bitacora.add(nuevaInstruccion);
          instruccionesProdVendido[i].prodVendido.venta.target = venta;
          dataBase.productosVendidosBox.put(instruccionesProdVendido[i].prodVendido);
          int idNuevoProductoVendido = dataBase.productosVendidosBox.put(instruccionesProdVendido[i].prodVendido);
          venta.prodVendidos.add(dataBase.productosVendidosBox.get(idNuevoProductoVendido)!);
          dataBase.ventasBox.put(venta);
          continue;
        case "syncUpdateProductoVendido":
          final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProductoVendido', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final updateProductoVendido = dataBase.productosVendidosBox.get(instruccionesProdVendido[i].prodVendido.id);
          if(updateProductoVendido != null) {
            venta.total -= (updateProductoVendido.cantVendida * updateProductoVendido.precioVenta);
            updateProductoVendido.precioVenta = instruccionesProdVendido[i].prodVendido.precioVenta;
            updateProductoVendido.cantVendida = instruccionesProdVendido[i].prodVendido.cantVendida;
            venta.total += (updateProductoVendido.cantVendida * updateProductoVendido.precioVenta);
            dataBase.ventasBox.put(venta);
            updateProductoVendido.bitacora.add(nuevaInstruccion);
            dataBase.productosVendidosBox.put(updateProductoVendido);
            continue;
          } else {
            continue;
          }
        case "syncDeleteProductoVendido":
          final deleteProductoVendido = dataBase.productosVendidosBox.get(instruccionesProdVendido[i].prodVendido.id);
          if(deleteProductoVendido != null) {
            //print("Se elimina producto Vendido");
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncDeleteProductoVendido', 
              instruccionAdicional: deleteProductoVendido.nombreProd,
              usuario: prefs.getString("userId")!,
              idDBR: deleteProductoVendido.idDBR,
              idEmiWeb: deleteProductoVendido.idEmiWeb,
              emprendimiento: venta.emprendimiento.target!.nombre, idEmprendimiento: idEmprendimiento,
            ); //Se crea la nueva instruccion a realizar en bitacora
            deleteProductoVendido.bitacora.add(nuevaInstruccion);
            dataBase.productosVendidosBox.put(deleteProductoVendido);
            // Se elimina prodVendido de ObjectBox
            venta.total -= (instruccionesProdVendido[i].prodVendido.cantVendida * instruccionesProdVendido[i].prodVendido.precioVenta);
            dataBase.ventasBox.put(venta);
            dataBase.productosVendidosBox.remove(deleteProductoVendido.id);
            continue;
          } else {
            //print("No se elimina producto Vendido");
            continue;
          }
        default:
          continue;
      }
    }
    clearInformation();
  }


void update(int id, int idProductoEmp, double newPrecioVenta, int newCantidad, double newSubTotal, int idEmprendimiento) {
    var updateProdVendido = dataBase.productosVendidosBox.get(id);
    final updateProductoEmp = dataBase.productosEmpBox.get(idProductoEmp);
    if (updateProdVendido != null && updateProductoEmp != null) {
      final nuevaInstruccion = Bitacora(instruccion: 'syncUpdateProductoVendido', usuario: prefs.getString("userId")!, idEmprendimiento: idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
      updateProdVendido.productoEmp.target = updateProductoEmp;
      updateProdVendido.cantVendida = newCantidad;
      updateProdVendido.precioVenta =  newPrecioVenta;
      updateProdVendido.subtotal = newSubTotal;
      updateProdVendido.bitacora.add(nuevaInstruccion);
      dataBase.productosVendidosBox.put(updateProdVendido);
    }
    //print('Producto Vendido actualizado exitosamente');
    notifyListeners();
}
  //TODO Eliminar producto del backend, agregando un campo idbr en la bitacora

  // void remove(ProductosEmp productosEmp) {
  //   //print("Tamaño productos antes de remover: ${dataBase.productosEmpBox.getAll().length}");
  //   final nuevaInstruccion = Bitacora(instrucciones: 'syncDeleteProductoEmprendedor', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
  //   dataBase.productosEmpBox.remove(productosEmp.id); //Se elimina de bitacora la instruccion creada anteriormente
  //   //print("Tamaño productos después de remover: ${dataBase.productosEmpBox.getAll().length}");
  //   notifyListeners(); 
  // }

  // getAll() {
  //   emprendimientos = dataBase.emprendimientosBox.getAll();
  //   notifyListeners();
  // }

}