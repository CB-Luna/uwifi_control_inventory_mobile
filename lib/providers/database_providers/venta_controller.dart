import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';

class VentaController extends ChangeNotifier {

  List<Ventas> venta = [];

  GlobalKey<FormState> ventasFormKey = GlobalKey<FormState>();
 
  //ProductoSol
  DateTime? fechaInicio;
  DateTime? fechaTermino;
  String total = "";

  bool validateForm(GlobalKey<FormState> ventasKey) {
    return ventasKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    fechaInicio = null;
    fechaTermino = null;
    total = "";
    notifyListeners();
  }

  int add(int idEmprendimiento) {
    print(total);
    int idVenta = -1;
      final nuevaVenta = Ventas(
      fechaInicio: fechaInicio ?? DateTime.now(),
      fechaTermino: fechaTermino!,
      total: double.parse(total),
    );
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    if (emprendimiento != null) {
      final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final nuevaInstruccion = Bitacora(instrucciones: 'syncAddVenta', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      nuevaVenta.statusSync.target = nuevoSync;
      nuevaVenta.emprendimiento.target = emprendimiento;
      nuevaVenta.bitacora.add(nuevaInstruccion);
      idVenta = dataBase.ventasBox.put(nuevaVenta);
      emprendimiento.ventas.add(nuevaVenta);
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Venta agregada exitosamente');
      clearInformation();
      notifyListeners();
    }
    return idVenta;
  }

  // void add(int idEmprendimiento) {
  //   if (fechaInicio != null && fechaTermino != null) {
  //     final nuevaVenta = Ventas(
  //     fechaInicio: fechaInicio!,
  //     fechaTermino: fechaTermino!,
  //     total: double.parse(total),
  //   );
  //   final nuevoSyncVenta = StatusSync(); //Se crea el objeto estatus por dedault //M__ para la Venta
  //   final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  //   if (emprendimiento != null) {
  //     final nuevaInstruccion = Bitacora(instrucciones: 'syncAddVenta', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
  //     nuevaVenta.statusSync.target = nuevoSyncVenta;
  //     nuevaVenta.emprendimiento.target = emprendimiento;
  //     nuevaVenta.bitacora.add(nuevaInstruccion);
  //     //Indispensable para que se muestre en la lista de jornadas
  //     emprendimiento.ventas.add(nuevaVenta);
  //     dataBase.emprendimientosBox.put(emprendimiento);
  //     print('Venta agregada exitosamente');
  //     clearInformation(); //Se limpia información para usar el mismo controller en otro registro
  //     notifyListeners();
  //   }      
  //   }
  // }


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

}