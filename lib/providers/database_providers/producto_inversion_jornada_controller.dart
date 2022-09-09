import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/models/temporals/productos_solicitados_temporal.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:uuid/uuid.dart';

class ProductoInversionJornadaController extends ChangeNotifier {

  List<ProductosSolicitadosTemporal> productosSolicitados = [];

  GlobalKey<FormState> productoSolFormKey = GlobalKey<FormState>();
 
  //ProductoSol
  String producto = '';
  String marcaSugerida= '';
  String descripcion = '';
  String proveedorSugerido = '';
  String costoEstimado = '';
  String cantidad = '';
  String imagen = '';

  var uuid = Uuid();

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> registroJornadaKey) {
    return registroJornadaKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    producto = '';
    marcaSugerida = '';
    descripcion = '';
    costoEstimado = '';
    cantidad = '';
    imagen = '';
    productosSolicitados.clear();
    notifyListeners();
  }

  void addTemporal(int idFamiliaProd, String familiaProd, int idTipoEmpaques, String tipoEmpaques) {
    //Se crea un Id temporal
    final id = uuid.v4();
    final nuevoProductoSolicitado = ProductosSolicitadosTemporal(
      id: id,
      producto: producto,
      marcaSugerida: marcaSugerida,
      descripcion: descripcion,
      proveedorSugerido: proveedorSugerido,
      costoEstimado: costoEstimado != '' ? double.parse(costoEstimado) : 0.0,
      cantidad: int.parse(cantidad),
      idFamiliaProd: idFamiliaProd,
      familiaProd: familiaProd,
      idTipoEmpaques: idTipoEmpaques,
      tipoEmpaques: tipoEmpaques,
      imagen: imagen,
      fechaRegistro: DateTime.now(),
    );
    productosSolicitados.add(nuevoProductoSolicitado);
    print('Registro agregado exitosamente');
    notifyListeners();
  }

  void updateTemporal(String idProdSolicitadoTemp, String newProducto, String? newMarcaSugerida, 
    String newDescripcion, String? newProveedor, String? newCostoEstimado, String newCantidad,
    int newIdFamiliaProd, String newFamiliaProd, int newIdTipoEmpaques, String newTipoEmpaques, 
    String? newImagen, DateTime fechaRegistro) {
    final updateProductoSolicitado = ProductosSolicitadosTemporal(
        id: idProdSolicitadoTemp,
        producto: newProducto,
        marcaSugerida: newMarcaSugerida,
        descripcion: newDescripcion,
        proveedorSugerido: newProveedor,
        costoEstimado: newCostoEstimado == null ? null : double.parse(newCostoEstimado),
        cantidad: int.parse(newCantidad),
        idFamiliaProd: newIdFamiliaProd,
        familiaProd: newFamiliaProd,
        idTipoEmpaques: newIdTipoEmpaques,
        tipoEmpaques: newTipoEmpaques,
        imagen: newImagen,
        fechaRegistro: fechaRegistro,
      );
      //Se actualiza el registro
    for (var i = 0; i < productosSolicitados.length; i++) {
      if (productosSolicitados[i].id == idProdSolicitadoTemp) {
        print("Desde actualizar");
        productosSolicitados[i] = updateProductoSolicitado;
      }
    }
    print('Registro actualizado exitosamente');
    notifyListeners();
  
  }

void update(int id, String newProducto, String? newMarcaSugerida, String newDescripcion, 
    String? newProveedor, String? newCostoEstimado, String newCantidad, int newIdFamiliaProd, 
    int newIdTipoEmpaques) {
    var updateProdSolicitado = dataBase.productosSolicitadosBox.get(id);
    final updateFamiliaProd = dataBase.familiaProductosBox.get(newIdFamiliaProd);
    final updateTipoEmpaques = dataBase.tipoEmpaquesBox.get(newIdTipoEmpaques);
    if (updateProdSolicitado !=  null && updateFamiliaProd != null && updateTipoEmpaques != null) {
      final nuevaInstruccion = Bitacora(instrucciones: 'syncUpdateProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      updateProdSolicitado.producto = newProducto;
      updateProdSolicitado.marcaSugerida = newMarcaSugerida;
      updateProdSolicitado.proveedorSugerido =  newProveedor;
      updateProdSolicitado.costoEstimado = newCostoEstimado == null ? null : double.parse(newCostoEstimado);
      updateProdSolicitado.cantidad = int.parse(newCantidad);
      updateProdSolicitado.familiaProducto.target = updateFamiliaProd;
      updateProdSolicitado.tipoEmpaques.target = updateTipoEmpaques;
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

void add(int idEmprendimiento, int idInversion) {
  final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
  final inversion = dataBase.inversionesBox.get(idInversion);
  if (emprendimiento != null && inversion != null) {
    for (var i = 0; i < productosSolicitados.length; i++) {
      final nuevoProdSolicitado = ProdSolicitado(
        idInversion: idInversion,
        producto: productosSolicitados[i].producto,
        marcaSugerida: productosSolicitados[i].marcaSugerida,
        descripcion: productosSolicitados[i].descripcion,
        proveedorSugerido: productosSolicitados[i].proveedorSugerido,
        costoEstimado: productosSolicitados[i].costoEstimado,
        cantidad: productosSolicitados[i].cantidad,
        fechaRegistro: productosSolicitados[i].fechaRegistro,
      );
      //Se recupera la familia y tipoEmpaques
      final familiaProd = dataBase.familiaProductosBox.get(productosSolicitados[i].idFamiliaProd);
      final tipoEmpaques = dataBase.tipoEmpaquesBox.get(productosSolicitados[i].idTipoEmpaques);
      if (familiaProd != null && tipoEmpaques != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdSolicitado.familiaProducto.target = familiaProd;
        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
        nuevoProdSolicitado.statusSync.target = nuevoSync;
        nuevoProdSolicitado.inversion.target = inversion;
        nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
        inversion.prodSolicitados.add(nuevoProdSolicitado);
        inversion.totalInversion += productosSolicitados[i].costoEstimado != null ? (productosSolicitados[i].cantidad * productosSolicitados[i].costoEstimado!) : 0.0;
        dataBase.inversionesBox.put(inversion);
      }
    }
    print('Registro agregado exitosamente');
    clearInformation();
    notifyListeners();
  }
  }

void addSingle(int idInversion, int idFamiliaProd, int idTipoEmpaques) {
  final inversion = dataBase.inversionesBox.get(idInversion);
  if (inversion != null) {
      final nuevoProdSolicitado = ProdSolicitado(
        idInversion: idInversion,
        producto: producto,
        marcaSugerida: marcaSugerida,
        descripcion: descripcion,
        proveedorSugerido: proveedorSugerido,
        costoEstimado: double.parse(costoEstimado),
        cantidad: int.parse(cantidad),
      );
      //Se recupera la familia y tipo de empaques
      final familiaProd = dataBase.familiaProductosBox.get(idFamiliaProd);
      final tipoEmpaques = dataBase.tipoEmpaquesBox.get(idTipoEmpaques);
      if (familiaProd != null && tipoEmpaques != null) {
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        //TODO: Agregar instrucción correcta
        // final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdSolicitado.familiaProducto.target = familiaProd;
        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
        nuevoProdSolicitado.statusSync.target = nuevoSync;
        nuevoProdSolicitado.inversion.target = inversion;
        // nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
        inversion.prodSolicitados.add(nuevoProdSolicitado);
        dataBase.inversionesBox.put(inversion);
        print('Registro agregado exitosamente');
        clearInformation();
        notifyListeners();
      }
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