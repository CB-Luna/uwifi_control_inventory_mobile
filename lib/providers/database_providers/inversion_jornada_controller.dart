import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/database/entitys.dart';

class InversionJornadaController extends ChangeNotifier {

  Inversiones? inversion;

  GlobalKey<FormState> inversionesFormKey = GlobalKey<FormState>();
 
  //Inversiones
  DateTime? fechaCompra;
  String porcentajePago = "";
  double montoPagar = 0.0;
  double saldo = 0.0;
  double totalInversion = 0.0;
  bool inversionRecibida = false;

  TextEditingController textControllerImagen = TextEditingController();
  TextEditingController textControllerNombre = TextEditingController();
  TextEditingController textControllerDescripcion = TextEditingController();

  bool validateForm(GlobalKey<FormState> inversionesKey) {
    return inversionesKey.currentState!.validate() ? true : false;
  }


  void clearInformation()
  {
    fechaCompra = null;
    porcentajePago = "";
    montoPagar = 0.0;
    saldo = 0.0;
    totalInversion = 0.0;
    inversionRecibida = false;
    inversion = null;
    notifyListeners();
  }

  void addTemporal(int idEmprendimiento) {
    final inversionTemporal = Inversiones(
      porcentajePago: int.parse(porcentajePago),
      montoPagar: montoPagar,
      saldo: saldo,
      totalInversion: totalInversion,
      inversionRecibida: inversionRecibida,
      jornada3: true,
      );
      final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
      if (emprendimiento != null) {
        // final nuevoSync = StatusSync(); //Se crea el objeto estatus por dedault //M__
        // final nuevaInstruccion = Bitacora(instrucciones: 'syncAddCotizacion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
        // nuevoProductoEmp.statusSync.target = nuevoSync;
        // nuevoProductoEmp.emprendimientos.target = emprendimiento;
        // nuevoProductoEmp.familiaInversion.target = familia;
        // nuevoProductoEmp.bitacora.add(nuevaInstruccion);
        // emprendimiento.productosEmp.add(nuevoProductoEmp);
        // dataBase.emprendimientosBox.put(emprendimiento);
        inversion = inversionTemporal;
        print('Registro agregado exitosamente');
        notifyListeners();
      }
  }

  int add(int idEmprendimiento) {
    int idInversion = -1;
    final emprendimiento = dataBase.emprendimientosBox.get(idEmprendimiento);
    final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.estado.equals("Solicitada")).build().findFirst();
    if (emprendimiento != null && inversion != null && estadoInversion != null) {
      final nuevaInversionXprodCotizados = InversionesXProdCotizados(); //Se crea la inversion x prod Cotizados
      final nuevoSyncInversion = StatusSync(); //Se crea el objeto estatus por dedault //M__
      final nuevoSyncInversionXprodCotizados = StatusSync(); //Se crea el objeto estatus por dedault //M__
      nuevaInversionXprodCotizados.statusSync.target = nuevoSyncInversionXprodCotizados;
      nuevaInversionXprodCotizados.inversion.target = inversion;
      // final nuevaInstruccion = Bitacora(instrucciones: 'syncAddInversion', usuario: prefs.getString("userId")!); //Se crea la nueva instruccion a realizar en bitacora
      inversion!.inversionXprodCotizados.add(nuevaInversionXprodCotizados); //Se agrega la nueva inversion x prod Cotizados
      inversion!.statusSync.target = nuevoSyncInversion;
      inversion!.estadoInversion.target = estadoInversion;
      inversion!.emprendimiento.target = emprendimiento;
      // inversion!.bitacora.add(nuevaInstruccion);
      idInversion = dataBase.inversionesBox.put(inversion!);
      emprendimiento.inversiones.add(inversion!);
      emprendimiento.idInversionJornada = idInversion;
      dataBase.emprendimientosBox.put(emprendimiento);
      print('Inversion agregada exitosamente');
      clearInformation();
      notifyListeners();
    }
    return idInversion;
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