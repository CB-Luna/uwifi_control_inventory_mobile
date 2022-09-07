import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/models/temporals/productos_vendidos_temporal.dart';
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
        cantVendida: productosVendidos[i].cantidad,
        subtotal: productosVendidos[i].subTotal,
        precioVenta: productosVendidos[i].precioVenta
        );
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoVenta', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdVendido.statusSync.target = nuevoSync;
        nuevoProdVendido.venta.target = venta;
        nuevoProdVendido.bitacora.add(nuevaInstruccion);
        venta.prodVendidos.add(nuevoProdVendido);
        dataBase.ventasBox.put(venta);
      }
    }
    print('Registro agregado exitosamente');
    clearInformation();
    notifyListeners();
  }
}

void update(int id, String newProducto, String? newMarcaSugerida, String newDescripcion, 
    String? newProveedor, String? newCostoEstimado, String newCantidad, int newIdFamiliaProd, 
    int newIdUnidadMedida) {
    var updateProdSolicitado = dataBase.productosSolicitadosBox.get(id);
    final updateFamiliaProd = dataBase.familiaProductosBox.get(newIdFamiliaProd);
    final updateUnidadMedida = dataBase.unidadesMedidaBox.get(newIdUnidadMedida);
    if (updateProdSolicitado !=  null && updateFamiliaProd != null && updateUnidadMedida != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateProdSolicitado.producto = newProducto;
      updateProdSolicitado.marcaSugerida = newMarcaSugerida;
      updateProdSolicitado.proveedorSugerido =  newProveedor;
      updateProdSolicitado.costoEstimado = newCostoEstimado == null ? null : double.parse(newCostoEstimado);
      updateProdSolicitado.cantidad = int.parse(newCantidad);
      updateProdSolicitado.familiaProducto.target = updateFamiliaProd;
      updateProdSolicitado.unidadMedida.target = updateUnidadMedida;
      final statusSyncJornada = dataBase.statusSyncBox.query(StatusSync_.id.equals(updateProdSolicitado.statusSync.target!.id)).build().findUnique();
      if (statusSyncJornada != null) {
        statusSyncJornada.status = "0E3hoVIByUxMUMZ"; //Se actualiza el estado del prod Solicitado
        dataBase.statusSyncBox.put(statusSyncJornada);
      }
      updateProdSolicitado.bitacora.add(nuevaInstruccion);
      dataBase.productosSolicitadosBox.put(updateProdSolicitado);
    }
    print('Registro actualizado exitosamente');
    notifyListeners();
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