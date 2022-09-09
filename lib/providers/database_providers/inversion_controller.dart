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
        final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevaInversion.statusSync.target = nuevoSync;
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
        final nuevaInstruccion = Bitacora(instrucciones: 'syncAddProdSolicitado', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        nuevoProdSolicitado.statusSync.target = nuevoSync;
        nuevoProdSolicitado.familiaProducto.target = familiaProd;
        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
        nuevoProdSolicitado.inversion.target = inversion;
        nuevoProdSolicitado.bitacora.add(nuevaInstruccion);
        inversion.prodSolicitados.add(nuevoProdSolicitado);
        inversion.totalInversion += costo != '' ? (int.parse(cantidad) * double.parse(costo)) : 0.0;
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