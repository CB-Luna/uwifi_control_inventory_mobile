import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
// import 'package:taller_alex_app_asesor/objectbox.g.dart';

class ObjectBoxDatabase {
  late final Store store;

  late final Box<Usuarios> usuariosBox;
  late final Box<Vehiculo> vehiculoBox;
  late final Box<OrdenTrabajo> ordenTrabajoBox;
  late final Box<FormaPago> formaPagoBox;
  late final Box<Observaciones> observacionesBox;
  late final Box<Revision> revisionBox;
  late final Box<SuspensionDireccion> suspensionDireccionBox;
  late final Box<Motor> motorBox;
  late final Box<Frenos> frenosBox;
  late final Box<Fluidos> fluidosBox;
  late final Box<Electrico> electricoBox;
  late final Box<Servicio> servicioBox;
  late final Box<TipoServicio> tipoServicioBox;
  late final Box<Producto> productoBox;
  late final Box<TipoProducto> tipoProductoBox;
  late final Box<OrdenServicio> ordenServicioBox;
  late final Box<Estatus> estatusBox;
  late final Box<Bitacora> bitacoraBox;
  late final Box<Marca> marcaBox;
  late final Box<Modelo> modeloBox;
  late final Box<Anio> anioBox;
  late final Box<TipoProyecto> tipoProyectoBox;
  late final Box<CatalogoProyecto> catalogoProyectoBox;
  late final Box<Roles> rolesBox;
  late final Box<Inversiones> inversionesBox;
  late final Box<ProdSolicitado> productosSolicitadosBox;
  late final Box<ProdProyecto> productosProyectoBox;
  late final Box<EstadoInversion> estadoInversionBox;
  late final Box<Pagos> pagosBox;
  late final Box<TipoProveedor> tipoProveedorBox;
  late final Box<CondicionesPago> condicionesPagoBox;
  late final Box<Bancos> bancosBox;
  late final Box<Proveedores> proveedoresBox;
  late final Box<FamiliaInversion> familiaInversionBox;
  late final Box<ProductosProv> productosProvBox;
  late final Box<InversionesXProdCotizados> inversionesXprodCotizadosBox;

  ObjectBoxDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    usuariosBox = Box<Usuarios>(store);
    vehiculoBox = Box<Vehiculo>(store);
    ordenTrabajoBox = Box<OrdenTrabajo>(store);
    formaPagoBox = Box<FormaPago>(store);
    observacionesBox = Box<Observaciones>(store);
    revisionBox = Box<Revision>(store);
    suspensionDireccionBox = Box<SuspensionDireccion>(store);
    motorBox = Box<Motor>(store);
    frenosBox = Box<Frenos>(store);
    fluidosBox = Box<Fluidos>(store);
    electricoBox = Box<Electrico>(store);
    servicioBox = Box<Servicio>(store);
    tipoServicioBox = Box<TipoServicio>(store);
    productoBox = Box<Producto>(store);
    tipoProductoBox = Box<TipoProducto>(store);
    ordenServicioBox = Box<OrdenServicio>(store);
    estatusBox = Box<Estatus>(store);
    bitacoraBox = Box<Bitacora>(store);
    marcaBox = Box<Marca>(store);
    modeloBox = Box<Modelo>(store);
    anioBox = Box<Anio>(store);
    tipoProyectoBox = Box<TipoProyecto>(store);
    catalogoProyectoBox = Box<CatalogoProyecto>(store);
    rolesBox = Box<Roles>(store);
    inversionesBox = Box<Inversiones>(store);
    productosSolicitadosBox = Box<ProdSolicitado>(store);
    productosProyectoBox = Box<ProdProyecto>(store);
    estadoInversionBox = Box<EstadoInversion>(store);
    pagosBox = Box<Pagos>(store);
    tipoProveedorBox = Box<TipoProveedor>(store);
    condicionesPagoBox = Box<CondicionesPago>(store);
    bancosBox = Box<Bancos>(store);
    proveedoresBox = Box<Proveedores>(store);
    familiaInversionBox = Box<FamiliaInversion>(store);
    productosProvBox = Box<ProductosProv>(store);
    inversionesXprodCotizadosBox = Box<InversionesXProdCotizados>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxDatabase._create(store);
  }
}
