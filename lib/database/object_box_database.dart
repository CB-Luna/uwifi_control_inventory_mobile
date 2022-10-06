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
  late final Box<Imagenes> imagenesBox;
  late final Box<StatusSync> statusSyncBox;
  late final Box<VariablesUsuario> variablesUsuarioBox;
  late final Box<Estados> estadosBox;
  late final Box<Municipios> municipiosBox;
  late final Box<Comunidades> comunidadesBox;
  late final Box<Tareas> tareasBox;
  late final Box<TipoProyecto> tipoProyectoBox;
  late final Box<FamiliaProd> familiaProductosBox;
  late final Box<CatalogoProyecto> catalogoProyectoBox;
  late final Box<ProductosEmp> productosEmpBox;
  late final Box<ProdCotizados> productosCotBox;
  late final Box<UnidadMedida> unidadesMedidaBox;
  late final Box<AmbitoConsultoria> ambitoConsultoriaBox;
  late final Box<AreaCirculo> areaCirculoBox;
  late final Box<Roles> rolesBox;
  late final Box<Inversiones> inversionesBox;
  late final Box<ProdSolicitado> productosSolicitadosBox;
  late final Box<ProdProyecto> productosProyectoBox;
  late final Box<FasesEmp> fasesEmpBox;
  late final Box<TipoEmpaques> tipoEmpaquesBox;
  late final Box<EstadoInversion> estadoInversionBox;
  late final Box<Ventas> ventasBox;
  late final Box<ProdVendidos> productosVendidosBox;
  late final Box<TipoProveedor> tipoProveedorBox;
  late final Box<CondicionesPago> condicionesPagoBox;
  late final Box<Bancos> bancosBox;
  late final Box<Proveedores> proveedoresBox;
  late final Box<ProductosProv> productosProvBox;
  late final Box<EstadoProdCotizado> estadosProductoCotizadosBox;
  late final Box<InversionesXProdCotizados> inversionesXprodCotizadosBox;
  late final Box<PorcentajeAvance> porcentajeAvanceBox;

  ObjectBoxDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    usuariosBox = Box<Usuarios>(store);
    emprendimientosBox = Box<Emprendimientos>(store);
    emprendedoresBox = Box<Emprendedores>(store);
    jornadasBox = Box<Jornadas>(store);                                                          
    consultoriasBox = Box<Consultorias>(store);
    bitacoraBox = Box<Bitacora>(store);
    imagenesBox = Box<Imagenes>(store);
    statusSyncBox = Box<StatusSync>(store);
    variablesUsuarioBox = Box<VariablesUsuario>(store);
    estadosBox = Box<Estados>(store);
    municipiosBox = Box<Municipios>(store);
    comunidadesBox = Box<Comunidades>(store);
    tareasBox = Box<Tareas>(store);
    tipoProyectoBox = Box<TipoProyecto>(store);
    familiaProductosBox = Box<FamiliaProd>(store);
    catalogoProyectoBox = Box<CatalogoProyecto>(store);
    productosEmpBox = Box<ProductosEmp>(store);
    productosCotBox = Box<ProdCotizados>(store);
    unidadesMedidaBox = Box<UnidadMedida>(store);
    ambitoConsultoriaBox = Box<AmbitoConsultoria>(store);
    areaCirculoBox = Box<AreaCirculo>(store);
    rolesBox = Box<Roles>(store);
    inversionesBox = Box<Inversiones>(store);
    productosSolicitadosBox = Box<ProdSolicitado>(store);
    productosProyectoBox = Box<ProdProyecto>(store);
    fasesEmpBox = Box<FasesEmp>(store);
    tipoEmpaquesBox = Box<TipoEmpaques>(store);
    estadoInversionBox = Box<EstadoInversion>(store);
    ventasBox = Box<Ventas>(store);
    productosVendidosBox = Box<ProdVendidos>(store);
    tipoProveedorBox = Box<TipoProveedor>(store);
    condicionesPagoBox = Box<CondicionesPago>(store);
    bancosBox = Box<Bancos>(store);
    proveedoresBox = Box<Proveedores>(store);
    productosProvBox = Box<ProductosProv>(store);
    estadosProductoCotizadosBox = Box<EstadoProdCotizado>(store);
    inversionesXprodCotizadosBox = Box<InversionesXProdCotizados>(store);
    porcentajeAvanceBox = Box<PorcentajeAvance>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxDatabase._create(store);
  }
  
}