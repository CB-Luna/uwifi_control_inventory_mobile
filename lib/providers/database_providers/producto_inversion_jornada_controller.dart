import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/productos_solicitados_temporal.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_instruccion_producto_inversion_j3_temporal.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:uuid/uuid.dart';

class ProductoInversionJornadaController extends ChangeNotifier {
  List<ProductosSolicitadosTemporal> productosSolicitados = [];

  GlobalKey<FormState> productoSolFormKey = GlobalKey<FormState>();

  //ProductoSol
  String producto = '';
  String marcaSugerida = '';
  String descripcion = '';
  String proveedorSugerido = '';
  String costoEstimado = '';
  String cantidad = '';
  String imagen = '';
  List<SaveInstruccionProductoInversionJ3Temporal>
      instruccionesProdInversionJ3Temp = [];
  List<ProdSolicitado> listProdSolicitadosActual = [];

  var uuid = Uuid();

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> registroJornadaKey) {
    return registroJornadaKey.currentState!.validate() ? true : false;
  }

  void clearInformation() {
    producto = '';
    marcaSugerida = '';
    descripcion = '';
    costoEstimado = '';
    cantidad = '';
    imagen = '';
    productosSolicitados.clear();
    listProdSolicitadosActual.clear();
    instruccionesProdInversionJ3Temp.clear();
    notifyListeners();
  }

  void addTemporal(int idTipoEmpaque, String tipoEmpaque, int idFamiliaInversion, String familiaInversion) {
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
      idTipoEmpaques: idTipoEmpaque,
      tipoEmpaques: tipoEmpaque,
      imagen: imagen,
      idFamiliaInversion: idFamiliaInversion,
      familiaInversion: familiaInversion,
      fechaRegistro: DateTime.now(),
    );
    productosSolicitados.add(nuevoProductoSolicitado);
    //print('Registro agregado exitosamente');
    notifyListeners();
  }

  void updateTemporal(
      String idProdSolicitadoTemp,
      String newProducto,
      String? newMarcaSugerida,
      String newDescripcion,
      String? newProveedor,
      String? newCostoEstimado,
      String newCantidad,
      int newIdTipoEmpaque,
      String newTipoEmpaque,
      String? newImagen,
      int newIdFamiliaInversion,
      String newFamiliaInversion,
      DateTime fechaRegistro) {
    final updateProductoSolicitado = ProductosSolicitadosTemporal(
      id: idProdSolicitadoTemp,
      producto: newProducto,
      marcaSugerida: newMarcaSugerida,
      descripcion: newDescripcion,
      proveedorSugerido: newProveedor,
      costoEstimado:
          newCostoEstimado == null ? null : double.parse(newCostoEstimado),
      cantidad: int.parse(newCantidad),
      idTipoEmpaques: newIdTipoEmpaque,
      tipoEmpaques: newTipoEmpaque,
      idFamiliaInversion: newIdFamiliaInversion,
      familiaInversion: newFamiliaInversion,
      imagen: newImagen,
      fechaRegistro: fechaRegistro,
    );
    //Se actualiza el registro
    for (var i = 0; i < productosSolicitados.length; i++) {
      if (productosSolicitados[i].id == idProdSolicitadoTemp) {
        //print("Desde actualizar");
        productosSolicitados[i] = updateProductoSolicitado;
      }
    }
    //print('Registro actualizado exitosamente');
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
          idEmprendimiento: idEmprendimiento,
        );
        if (productosSolicitados[i].imagen != '' &&
            productosSolicitados[i].imagen != null) {
          //print(
             // "A ver contenido del producto $i: ${productosSolicitados[i].imagen}");
          final nuevaImagenProdSolicitado = Imagenes(
              imagenes: productosSolicitados[i].imagen!,
              idEmprendimiento:
                  idEmprendimiento); //Se crea el objeto imagenes para el Prod Solicitado
          nuevoProdSolicitado.imagen.target = nuevaImagenProdSolicitado;
        }
        //Se recupera la familia y tipoEmpaque
        final familiaInversion = dataBase.familiaInversionBox
            .get(productosSolicitados[i].idFamiliaInversion!);
        final tipoEmpaque = dataBase.tipoEmpaquesBox
            .get(productosSolicitados[i].idTipoEmpaques!);
        if (familiaInversion != null && tipoEmpaque != null) {
          // final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProductoSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
          nuevoProdSolicitado.familiaInversion.target = familiaInversion;
          nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaque;
          nuevoProdSolicitado.inversion.target = inversion;
          // nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
          inversion.prodSolicitados.add(nuevoProdSolicitado);
          inversion.totalInversion +=
              productosSolicitados[i].costoEstimado != null
                  ? (productosSolicitados[i].cantidad *
                      productosSolicitados[i].costoEstimado!)
                  : 0.0;
          dataBase.inversionesBox.put(inversion);
        }
      }
      //print('Registro agregado exitosamente');
      clearInformation();
      notifyListeners();
    }
  }

  void updateProductosInversionJ3(Inversiones inversion, int idEmprendimiento) {
    for (var i = 0; i < instruccionesProdInversionJ3Temp.length; i++) {
      switch (instruccionesProdInversionJ3Temp[i].instruccion) {
        case "syncAddProductoInversionJ3":
          final nuevaInstruccion = Bitacora(
              instruccion: 'syncAddProductoInversionJ3',
              usuario: prefs.getString("userId")!,
              idEmprendimiento:
                  idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          instruccionesProdInversionJ3Temp[i]
              .prodSolicitado
              .bitacora
              .add(nuevaInstruccion);
          int idNuevoProductoInversionJ3 = dataBase.productosSolicitadosBox
              .put(instruccionesProdInversionJ3Temp[i].prodSolicitado);
          inversion.prodSolicitados.add(dataBase.productosSolicitadosBox
              .get(idNuevoProductoInversionJ3)!);
          inversion.totalInversion += instruccionesProdInversionJ3Temp[i]
                      .prodSolicitado
                      .costoEstimado !=
                  null
              ? (instruccionesProdInversionJ3Temp[i].prodSolicitado.cantidad *
                  instruccionesProdInversionJ3Temp[i]
                      .prodSolicitado
                      .costoEstimado!)
              : 0.0;
          dataBase.inversionesBox.put(inversion);
          continue;
        case "syncUpdateProductoInversionJ3":
          final nuevaInstruccion = Bitacora(
              instruccion: 'syncUpdateProductoInversionJ3',
              usuario: prefs.getString("userId")!,
              idEmprendimiento:
                  idEmprendimiento); //Se crea la nueva instruccion a realizar en bitacora
          final updateProductoInversionJ3 = dataBase.productosSolicitadosBox
              .get(instruccionesProdInversionJ3Temp[i].prodSolicitado.id);
          if (updateProductoInversionJ3 != null) {
            inversion.totalInversion -=
                updateProductoInversionJ3.costoEstimado != null
                    ? (updateProductoInversionJ3.cantidad *
                        updateProductoInversionJ3.costoEstimado!)
                    : 0.0;
            updateProductoInversionJ3.marcaSugerida =
                instruccionesProdInversionJ3Temp[i]
                    .prodSolicitado
                    .marcaSugerida;
            updateProductoInversionJ3.proveedorSugerido =
                instruccionesProdInversionJ3Temp[i]
                    .prodSolicitado
                    .proveedorSugerido;
            updateProductoInversionJ3.cantidad =
                instruccionesProdInversionJ3Temp[i].prodSolicitado.cantidad;
            updateProductoInversionJ3.costoEstimado =
                instruccionesProdInversionJ3Temp[i]
                    .prodSolicitado
                    .costoEstimado;
            updateProductoInversionJ3.tipoEmpaques.target =
                instruccionesProdInversionJ3Temp[i]
                    .prodSolicitado
                    .tipoEmpaques
                    .target;
            updateProductoInversionJ3.familiaInversion.target =
                instruccionesProdInversionJ3Temp[i]
                    .prodSolicitado
                    .familiaInversion
                    .target;
            inversion.totalInversion +=
                updateProductoInversionJ3.costoEstimado != null
                    ? (updateProductoInversionJ3.cantidad *
                        updateProductoInversionJ3.costoEstimado!)
                    : 0.0;
            dataBase.inversionesBox.put(inversion);
            updateProductoInversionJ3.bitacora.add(nuevaInstruccion);
            dataBase.productosSolicitadosBox.put(updateProductoInversionJ3);
            continue;
          } else {
            continue;
          }
        case "syncDeleteProductoInversionJ3":
          final deleteProductoInversionJ3 = dataBase.productosSolicitadosBox
              .get(instruccionesProdInversionJ3Temp[i].prodSolicitado.id);
          if (deleteProductoInversionJ3 != null) {
            final nuevaInstruccion = Bitacora(
              instruccion: 'syncDeleteProductoInversionJ3',
              usuario: prefs.getString("userId")!,
              idDBR: deleteProductoInversionJ3.idDBR,
              idEmiWeb: deleteProductoInversionJ3.idEmiWeb,
              emprendimiento: inversion.emprendimiento.target!.nombre,
              idEmprendimiento: idEmprendimiento,
            ); //Se crea la nueva instruccion a realizar en bitacora
            deleteProductoInversionJ3.bitacora.add(nuevaInstruccion);
            // Se elimina prodSolicitado de ObjectBox
            inversion.totalInversion -= instruccionesProdInversionJ3Temp[i]
                        .prodSolicitado
                        .costoEstimado !=
                    null
                ? (instruccionesProdInversionJ3Temp[i].prodSolicitado.cantidad *
                    instruccionesProdInversionJ3Temp[i]
                        .prodSolicitado
                        .costoEstimado!)
                : 0.0;
            dataBase.inversionesBox.put(inversion);
            dataBase.productosSolicitadosBox
                .remove(deleteProductoInversionJ3.id);
            continue;
          } else {
            continue;
          }
        default:
          continue;
      }
    }
    clearInformation();
  }

  void updateImagenProductoSol(
      ProdSolicitado updateProdSol,
      int idImagenProductoSol,
      String newNombreImagen,
      String newPath,
      String newBase64) {
    var updateImagenProductoSol = dataBase.imagenesBox.get(idImagenProductoSol);
    if (updateImagenProductoSol != null) {
      updateImagenProductoSol.imagenes =
          newPath; //Se actualiza la imagen del producto solicitado
      updateImagenProductoSol.nombre = newNombreImagen;
      updateImagenProductoSol.base64 = newBase64;
      updateImagenProductoSol.path = newPath;
      dataBase.imagenesBox.put(updateImagenProductoSol);
      updateProdSol.imagen.target = updateImagenProductoSol;
      dataBase.productosSolicitadosBox.put(updateProdSol);
      //print('Imagen Prod Solicitado actualizada exitosamente');
    }
    notifyListeners();
  }

  void addImagenProductoSol(ProdSolicitado productoSol, String newNombreImagen,
      String newPath, String newBase64, int idEmprendimiento) {
    final nuevaImagenProductoSol = Imagenes(
      imagenes: newPath,
      nombre: newNombreImagen,
      base64: newBase64,
      path: newPath,
      idEmprendimiento: idEmprendimiento,
    );
    productoSol.imagen.target = nuevaImagenProductoSol;
    dataBase.imagenesBox.put(nuevaImagenProductoSol);
    dataBase.productosSolicitadosBox.put(productoSol);
    //print('Imagen Prod Solicitado agregada exitosamente');
    notifyListeners();
  }
}
