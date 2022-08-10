import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/objectbox.g.dart';
// import 'package:bizpro_app/objectbox.g.dart';

class ObjectBoxDatabase {
 late final Store store;

  late final Box<Usuarios> usuariosBox;
  late final Box<Emprendimientos> emprendimientosBox;
  late final Box<Emprendedores> emprendedoresBox;
  late final Box<Jornadas> jornadasBox;
  late final Box<Consultorias> consultoriasBox;
  late final Box<Bitacora> bitacoraBox;
  late final Box<StatusSync> statusSyncBox;
  late final Box<VariablesUsuario> variablesUsuarioBox;
  late final Box<Estados> estadosBox;
  late final Box<Municipios> municipiosBox;
  late final Box<Comunidades> comunidadesBox;

  ObjectBoxDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    usuariosBox = Box<Usuarios>(store);
    emprendimientosBox = Box<Emprendimientos>(store);
    emprendedoresBox = Box<Emprendedores>(store);
    jornadasBox = Box<Jornadas>(store);
    consultoriasBox = Box<Consultorias>(store);
    bitacoraBox = Box<Bitacora>(store);
    statusSyncBox = Box<StatusSync>(store);
    variablesUsuarioBox = Box<VariablesUsuario>(store);
    estadosBox = Box<Estados>(store);
    municipiosBox = Box<Municipios>(store);
    comunidadesBox = Box<Comunidades>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxDatabase._create(store);
  }
  
}