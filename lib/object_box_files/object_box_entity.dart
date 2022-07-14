import 'package:bizpro_app/object_box_files/entitys.dart';
// import 'package:bizpro_app/objectbox.g.dart';

// class ObjectBox {
//   /// The Store of this app.
//   late final Store store;

//   /// A Box of emprendimientos.
//   late final Box<Emprendimiento> emprendimientoBox;

//   /// A Box of jornadas.
//   late final Box<Jornada> jornadaBox;

//   /// A Box of usuarios
//   late final Box<Usuario> usuarioBox;

//   /// A stream of all emprendimientos ordered by id.
//   late final Stream<Query<Emprendimiento>> queryEmprendimiento;

//   /// A stream of all jornadas ordered by id.
//   late final Stream<Query<Jornada>> queryJornada;

//   /// A stream of all jornadas ordered by id.
//   late final Stream<Query<Usuario>> queryUsuario;
  
  

//   ObjectBox._create(this.store) {
//     // Add any additional setup code, e.g. build queries.
//     emprendimientoBox = Box<Emprendimiento>(store);

//     jornadaBox = Box<Jornada>(store);

//     usuarioBox = Box<Usuario>(store);

//     final qBuilderEmprendimiento = emprendimientoBox.query()
//       ..order(Emprendimiento_.id, flags: Order.descending);
//     queryEmprendimiento = qBuilderEmprendimiento.watch(triggerImmediately: true);

//     final qBuilderJornada = jornadaBox.query()
//       ..order(Jornada_.id, flags: Order.descending);
//     queryJornada = qBuilderJornada.watch(triggerImmediately: true);

//     final qBuilderUsuario = usuarioBox.query()
//       ..order(Usuario_.id, flags: Order.descending);
//     queryUsuario = qBuilderUsuario.watch(triggerImmediately: true);

//     // Add some demo data if the box is empty.
//     if (emprendimientoBox.isEmpty()) {
//       _putEmprendimientoData();
//     }

//     if (jornadaBox.isEmpty()) {
//       _putJornadaData();
//     }
//   }

//   /// Create an instance of ObjectBox to use throughout the app.
//   static Future<ObjectBox> create() async {
//     // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
//     final store = await openStore();
//     return ObjectBox._create(store);
//   }

//   void _putEmprendimientoData() {
//     final demoEmprendimientos = [
//       Emprendimiento(imagen: 'Arbol.png', nombre: 'Plantar Arboles', descripcion: 'Plantar 100 arboles frutales'),
//       Emprendimiento(imagen: 'Canal.png', nombre: 'Limpiar Canales',  descripcion: 'Limpiar canales de Xochimilco'),
//       Emprendimiento(imagen: 'Alebrige.png', nombre: 'Construir Alebriges', descripcion: 'Fabricar 100 alebrijes'),
//     ];
//     store.runInTransactionAsync(TxMode.write, _putEmprendimientosInTx, demoEmprendimientos);
//   }

//   void _putJornadaData() {
//     final demoJornadas = [
//       Jornada(numeroJornada: 4, fechaRevision: DateTime.now(), circuloEmpresa: 'NONE', analisisFinanciero: 'NONE', convenio: 'NONE', agregarRegistro: 'NONE'),
//       Jornada(numeroJornada: 3, fechaRevision: DateTime.now(),  circuloEmpresa: 'NONE', analisisFinanciero: 'NONE', convenio: 'NONE', agregarRegistro: 'NONE', ),
//       Jornada(numeroJornada: 2, fechaRevision: DateTime.now(), circuloEmpresa: 'NONE', analisisFinanciero: 'NONE', convenio: 'NONE', agregarRegistro: 'NONE'),
//     ];
//     store.runInTransactionAsync(TxMode.write, _putJornadasInTx, demoJornadas);
//   }

//   static void _putJornadasInTx(Store store, List<Jornada> jornadas) =>
//       store.box<Jornada>().putMany(jornadas);

//   static void _putEmprendimientosInTx(Store store, List<Emprendimiento> emprendimientos) =>
//       store.box<Emprendimiento>().putMany(emprendimientos);

// Future<void> addEmprendimiento(Emprendimiento emprendimiento) =>
//       store.runInTransactionAsync(TxMode.write, _addEmprendimientoInTx, emprendimiento);

//   static void _addEmprendimientoInTx(Store store, Emprendimiento emprendimiento) {
//     store.box<Emprendimiento>().put(emprendimiento);
//   }

//   Future<void> addJornada(Jornada jornada) =>
//       store.runInTransactionAsync(TxMode.write, _addJornadaInTx, jornada);

//   static void _addJornadaInTx(Store store, Jornada jornada) {
//     store.box<Jornada>().put(jornada);
//   }

//   Future<void> addUsuario(Usuario usuario) =>
//       store.runInTransactionAsync(TxMode.write, _addUsuarioInTx, usuario);

//   static void _addUsuarioInTx(Store store, Usuario usuario) {
//     store.box<Usuario>().put(usuario);
//   }
  
// }