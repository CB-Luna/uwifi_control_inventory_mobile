import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Emprendimientos {
  int id;
  String faseActual;
  String faseAnterior;
  int? idInversionJornada;
  String nombre;
  String descripcion;
  bool activo;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  final usuario = ToOne<Usuarios>(); //Promotor en Diagrama E-R
  final prioridadEmp = ToOne<PrioridadEmp>();
  final catalogoProyecto = ToOne<CatalogoProyecto>();
  final proveedores = ToMany<Proveedores>();
  final jornadas = ToMany<Jornadas>();
  final emprendedor = ToOne<Emprendedores>();
  final imagen = ToOne<Imagenes>();
  final bitacora = ToMany<Bitacora>();
  final faseEmp = ToMany<FasesEmp>();
  @Backlink()
  final ventas = ToMany<Ventas>();
  @Backlink()
  final productosEmp = ToMany<ProductosEmp>();
  @Backlink()
  final consultorias = ToMany<Consultorias>();
  @Backlink()
  final inversiones = ToMany<Inversiones>();

  Emprendimientos({
    this.id = 0,
    required this.faseActual,
    required this.faseAnterior,
    this.idInversionJornada,
    required this.nombre,
    required this.descripcion,
    this.activo = true,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class OrdenTrabajo {
  int id;
  DateTime fechaOrden;
  String gasolina;
  String kilometrajeMillaje;
  String descripcionFalla;
  DateTime fechaRegistro;
  bool completado;
  @Unique()
  String? idDBR;
  final asesor = ToOne<Usuarios>();
  final cliente = ToOne<Usuarios>();
  final vehiculo = ToOne<Vehiculo>();
  final formaPago = ToOne<FormaPago>();
  final revision = ToOne<Revision>();
  final ordenServicio = ToOne<OrdenServicio>();
  final estatus = ToOne<Estatus>();
  @Backlink()
  final observacion = ToMany<Observaciones>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();


  OrdenTrabajo({
    this.id = 0,
    required this.fechaOrden,
    required this.gasolina,
    required this.kilometrajeMillaje,
    required this.descripcionFalla,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Estatus {
  int id;
  double avance;
  String estatus;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final ordenTrabajo = ToMany<OrdenTrabajo>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();


  Estatus({
    this.id = 0,
    required this.avance,
    required this.estatus,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Observaciones {
  int id;
  DateTime fechaObservacion;
  String respuestaP1;
  String respuestaP2;
  String respuestaP3;
  String respuestaP4;
  String respuestaP5;
  String respuestaP6;
  String respuestaP7;
  String respuestaP8;
  String respuestaP9;
  String respuestaP10;
  String nombreAsesor;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final ordenTrabajo = ToOne<OrdenTrabajo>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Observaciones({
    this.id = 0,
    required this.fechaObservacion,
    required this.respuestaP1,
    required this.respuestaP2,
    required this.respuestaP3,
    required this.respuestaP4,
    required this.respuestaP5,
    required this.respuestaP6,
    required this.respuestaP7,
    required this.respuestaP8,
    required this.respuestaP9,
    required this.respuestaP10,
    required this.nombreAsesor,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Revision {
  int id;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final ordenTrabajo = ToOne<OrdenTrabajo>();
  final suspensionDireccion = ToOne<SuspensionDireccion>();
  final motor = ToOne<Motor>();
  final fluidos = ToOne<Fluidos>();
  final frenos = ToOne<Frenos>();
  final electrico = ToOne<Electrico>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Revision({
    this.id = 0,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class OrdenServicio {
  int id;
  DateTime fechaRegistro;
  DateTime fechaEntrega;
  double costoTotal;
  @Unique()
  String? idDBR;
  final ordenTrabajo = ToOne<OrdenTrabajo>();
  @Backlink()
  final servicios = ToMany<Servicio>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  OrdenServicio({
    this.id = 0,
    required this.costoTotal,
    required this.fechaEntrega,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Servicio {
  int id;
  String servicio;
  double costoServicio;
  String imagen;
  String path;
  bool autorizado;
  DateTime fechaRegistro;
  DateTime fechaEntrega;
  @Unique()
  String? idDBR;
  final ordenServicio = ToOne<OrdenServicio>();
  @Backlink()
  final productos = ToMany<Producto>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Servicio({
    this.id = 0,
    required this.servicio,
    required this.costoServicio,
    required this.imagen,
    required this.path,
    required this.autorizado,
    required this.fechaEntrega,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class TipoServicio {
  int id;
  String tipoServicio;
  DateTime fechaRegistro;
  String imagen;
  String path;
  double costo;
  @Unique()
  String? idDBR;

  TipoServicio({
    this.id = 0,
    required this.tipoServicio,
    required this.imagen,
    required this.path,
    required this.costo,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Producto {
  int id;
  String producto;
  int cantidad;
  double costo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final servicio = ToOne<Servicio>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Producto({
    this.id = 0,
    required this.producto,
    required this.cantidad,
    required this.costo,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class TipoProducto {
  int id;
  String tipoProducto;
  DateTime fechaRegistro;
  double costo;
  @Unique()
  String? idDBR;

  TipoProducto({
    this.id = 0,
    required this.tipoProducto,
    required this.costo,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class SuspensionDireccion {
  int id;
  String rotulaSuperiorIzq;
  String? rotulaSuperiorIzqObservaciones;
  String rotulaSuperiorDer;
  String? rotulaSuperiorDerObservaciones;
  String rotulaInferiorIzq;
  String? rotulaInferiorIzqObservaciones;
  String rotulaInferiorDer;
  String? rotulaInferiorDerObservaciones;
  String bujeHorquillaSuperiorIzq;
  String? bujeHorquillaSuperiorIzqObservaciones;
  String bujeHorquillaSuperiorDer;
  String? bujeHorquillaSuperiorDerObservaciones;
  String bujeHorquillaInferiorIzq;
  String? bujeHorquillaInferiorIzqObservaciones;
  String bujeHorquillaInferiorDer;
  String? bujeHorquillaInferiorDerObservaciones;
  String amortiguadorDelanteroIzq;
  String? amortiguadorDelanteroIzqObservaciones;
  String amortiguadorDelanteroDer;
  String? amortiguadorDelanteroDerObservaciones;
  String amortiguadorTraseroIzq;
  String? amortiguadorTraseroIzqObservaciones;
  String amortiguadorTraseroDer;
  String? amortiguadorTraseroDerObservaciones;
  String bujeBarraEstabilizadoraIzq;
  String? bujeBarraEstabilizadoraIzqObservaciones;
  String bujeBarraEstabilizadoraDer;
  String? bujeBarraEstabilizadoraDerObservaciones;
  String linkKitDelanteroIzq;
  String? linkKitDelanteroIzqObservaciones;
  String linkKitDelanteroDer;
  String? linkKitDelanteroDerObservaciones;
  String linkKitTraseroIzq;
  String? linkKitTraseroIzqObservaciones;
  String linkKitTraseroDer;
  String? linkKitTraseroDerObservaciones;
  String terminalInteriorIzq;
  String? terminalInteriorIzqObservaciones;
  String terminalInteriorDer;
  String? terminalInteriorDerObservaciones;
  String terminalExteriorIzq;
  String? terminalExteriorIzqObservaciones;
  String terminalExteriorDer;
  String? terminalExteriorDerObservaciones;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final revision = ToOne<Revision>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  SuspensionDireccion({
    this.id = 0,
    required this.rotulaSuperiorIzq,
    this.rotulaSuperiorIzqObservaciones,
    required this.rotulaSuperiorDer,
    this.rotulaSuperiorDerObservaciones,
    required this.rotulaInferiorIzq,
    this.rotulaInferiorIzqObservaciones,
    required this.rotulaInferiorDer,
    this.rotulaInferiorDerObservaciones,
    required this.bujeHorquillaSuperiorIzq,
    this.bujeHorquillaSuperiorIzqObservaciones,
    required this.bujeHorquillaSuperiorDer,
    this.bujeHorquillaSuperiorDerObservaciones,
    required this.bujeHorquillaInferiorIzq,
    this.bujeHorquillaInferiorIzqObservaciones,
    required this.bujeHorquillaInferiorDer,
    this.bujeHorquillaInferiorDerObservaciones,
    required this.amortiguadorDelanteroIzq,
    this.amortiguadorDelanteroIzqObservaciones,
    required this.amortiguadorDelanteroDer,
    this.amortiguadorDelanteroDerObservaciones,
    required this.amortiguadorTraseroIzq,
    this.amortiguadorTraseroIzqObservaciones,
    required this.amortiguadorTraseroDer,
    this.amortiguadorTraseroDerObservaciones,
    required this.bujeBarraEstabilizadoraIzq,
    this.bujeBarraEstabilizadoraIzqObservaciones,
    required this.bujeBarraEstabilizadoraDer,
    this.bujeBarraEstabilizadoraDerObservaciones,
    required this.linkKitDelanteroIzq,
    this.linkKitDelanteroIzqObservaciones,
    required this.linkKitDelanteroDer,
    this.linkKitDelanteroDerObservaciones,
    required this.linkKitTraseroIzq,
    this.linkKitTraseroIzqObservaciones,
    required this.linkKitTraseroDer,
    this.linkKitTraseroDerObservaciones,
    required this.terminalInteriorIzq,
    this.terminalInteriorIzqObservaciones,
    required this.terminalInteriorDer,
    this.terminalInteriorDerObservaciones,
    required this.terminalExteriorIzq,
    this.terminalExteriorIzqObservaciones,
    required this.terminalExteriorDer,
    this.terminalExteriorDerObservaciones,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Motor {
  int id;
  String aceite;
  String? aceiteObservaciones;
  String filtroDeAire;
  String? filtroDeAireObservaciones;
  String cpoDeAceleracion;
  String? cpoDeAceleracionObservaciones;
  String bujias;
  String? bujiasObservaciones;
  String bandaCadenaDeTiempo;
  String? bandaCadenaDeTiempoObservaciones;
  String soportes;
  String? soportesObservaciones;
  String bandas;
  String? bandasObservaciones;
  String mangueras;
  String? manguerasObservaciones;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final revision = ToOne<Revision>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Motor({
    this.id = 0,
    required this.aceite,
    this.aceiteObservaciones,
    required this.filtroDeAire,
    this.filtroDeAireObservaciones,
    required this.cpoDeAceleracion,
    this.cpoDeAceleracionObservaciones,
    required this.bujias,
    this.bujiasObservaciones,
    required this.bandaCadenaDeTiempo,
    this.bandaCadenaDeTiempoObservaciones,
    required this.soportes,
    this.soportesObservaciones,
    required this.bandas,
    this.bandasObservaciones,
    required this.mangueras,
    this.manguerasObservaciones,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Fluidos {
  int id;
  String atf;
  String? atfObservaciones;
  String power;
  String? powerObservaciones;
  String frenos;
  String? frenosObservaciones;
  String anticongelante;
  String? anticongelanteObservaciones;
  String wipers;
  String? wipersObservaciones;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final revision = ToOne<Revision>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Fluidos({
    this.id = 0,
    required this.atf,
    this.atfObservaciones,
    required this.power,
    this.powerObservaciones,
    required this.frenos,
    this.frenosObservaciones,
    required this.anticongelante,
    this.anticongelanteObservaciones,
    required this.wipers,
    this.wipersObservaciones,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Frenos {
  int id;
  String balatasDelanteras;
  String? balatasDelanterasObservaciones;
  String balatasTraserasDiscoTambor;
  String? balatasTraserasDiscoTamborObservaciones;
  String manguerasLineas;
  String? manguerasLineasObservaciones;
  String cilindroMaestro;
  String? cilindroMaestroObservaciones;
  String birlosYTuercas;
  String? birlosYTuercasObservaciones;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final revision = ToOne<Revision>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Frenos({
    this.id = 0,
    required this.balatasDelanteras,
    this.balatasDelanterasObservaciones,
    required this.balatasTraserasDiscoTambor,
    this.balatasTraserasDiscoTamborObservaciones,
    required this.manguerasLineas,
    this.manguerasLineasObservaciones,
    required this.cilindroMaestro,
    this.cilindroMaestroObservaciones,
    required this.birlosYTuercas,
    this.birlosYTuercasObservaciones,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Electrico {
  int id;
  String terminalesDeBaterias;
  String? terminalesDeBateriasObservaciones;
  String lucesFrenos;
  String? lucesFrenosObservaciones;
  String lucesDireccionales;
  String? lucesDireccionalesObservaciones;
  String lucesCuartos;
  String? lucesCuartosObservaciones;
  String checkEngine;
  String? checkEngineObservaciones;
  bool completado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final revision = ToOne<Revision>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Electrico({
    this.id = 0,
    required this.terminalesDeBaterias,
    this.terminalesDeBateriasObservaciones,
    required this.lucesFrenos,
    this.lucesFrenosObservaciones,
    required this.lucesDireccionales,
    this.lucesDireccionalesObservaciones,
    required this.lucesCuartos,
    this.lucesCuartosObservaciones,
    required this.checkEngine,
    this.checkEngineObservaciones,
    required this.completado,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Cliente {
  int id;
  String nombre;
  String apellidoP;
  String? apellidoM;
  String? telefono;
  String celular;
  String rfc;
  String correo;
  String domicilio;
  DateTime fechaRegistro; 
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final imagen = ToOne<Imagenes>();

  Cliente({
    this.id = 0,
    required this.nombre,
    required this.apellidoP,
    this.apellidoM,
    this.telefono,
    required this.celular,
    required this.rfc,
    required this.correo,
    required this.domicilio,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Vehiculo {
  int id;
  String marca;
  String modelo;
  String anio;
  String imagen;
  String path;
  @Unique()
  String vin;
  @Unique()
  String placas;
  String motor;
  String color;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final cliente = ToOne<Usuarios>();

  Vehiculo({
    this.id = 0,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.imagen,
    required this.path,
    required this.vin,
    required this.placas,
    required this.motor,
    required this.color,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class ProdSolicitado {
  int id;
  int idInversion;
  String producto;
  String? marcaSugerida;
  String descripcion;
  String? proveedorSugerido;
  int cantidad;
  double? costoEstimado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final unidadMedida = ToOne<UnidadMedida>();
  final tipoEmpaques = ToOne<TipoEmpaques>();
  final inversion = ToOne<Inversiones>();
  final imagen = ToOne<Imagenes>();
  final bitacora = ToMany<Bitacora>();
  final familiaInversion = ToOne<FamiliaInversion>();

  ProdSolicitado({
    this.id = 0,
    required this.idInversion,
    required this.producto,
    this.marcaSugerida,
    required this.descripcion,
    this.proveedorSugerido,
    required this.cantidad,
    this.costoEstimado,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class ProdProyecto {
  int id;
  String producto;
  String? marcaSugerida;
  String descripcion;
  String? proveedorSugerido;
  int cantidad;
  double? costoEstimado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final tipoEmpaque = ToOne<TipoEmpaques>();
  final catalogoProyecto = ToOne<CatalogoProyecto>();
  final imagen = ToOne<Imagenes>();
  final familiaInversion = ToOne<FamiliaInversion>();

  ProdProyecto({
    this.id = 0,
    required this.producto,
    this.marcaSugerida,
    required this.descripcion,
    this.proveedorSugerido,
    required this.cantidad,
    this.costoEstimado,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Inversiones {
  int id;
  DateTime? fechaCompra;
  int porcentajePago;
  double montoPagar;
  double saldo;
  double totalInversion;
  bool inversionRecibida;
  DateTime fechaRegistro;
  bool jornada3;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final bitacora = ToMany<Bitacora>();
  final emprendimiento = ToOne<Emprendimientos>();
  final prodSolicitados = ToMany<ProdSolicitado>();
  final inversionXprodCotizados = ToMany<InversionesXProdCotizados>();
  final estadoInversion = ToOne<EstadoInversion>();
  final pagos = ToMany<Pagos>();
  final imagenFirmaRecibido = ToOne<Imagenes>();
  final imagenProductoEntregado = ToOne<Imagenes>();

  Inversiones({
    this.id = 0,
    this.fechaCompra,
    this.porcentajePago = 0,
    this.montoPagar = 0.0,
    this.saldo = 0.0,
    this.totalInversion = 0.0,
    this.inversionRecibida = false,
    DateTime? fechaRegistro,
    this.jornada3 = false,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Pagos {
  int id;
  double montoAbonado;
  DateTime fechaMovimiento;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  int idEmprendimiento;
  final inversion = ToOne<Inversiones>();
  final usuario = ToOne<Usuarios>();
  final bitacora = ToMany<Bitacora>();

  Pagos({
    this.id = 0,
    this.montoAbonado = 0.0,
    required this.fechaMovimiento,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class InversionesXProdCotizados {
  int id;
  DateTime fechaRegistro;
  bool aceptado;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final inversion = ToOne<Inversiones>();
  final prodCotizados = ToMany<ProdCotizados>();
  final bitacora = ToMany<Bitacora>();

  InversionesXProdCotizados({
    this.id = 0,
    this.aceptado = false,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Bitacora {
  int id;
  String usuarioPropietario;
  String instruccion;
  String? instruccionAdicional;
  int idOrdenTrabajo;
  DateTime fechaRegistro;
  bool executeSupabase;
  final cliente = ToOne<Cliente>();
  final vehiculo = ToOne<Vehiculo>();
  final ordenTrabajo = ToOne<OrdenTrabajo>();
  final observacion = ToOne<Observaciones>();
  final revision = ToOne<Revision>();
  final suspensionDireccion = ToOne<SuspensionDireccion>();
  final motor = ToOne<Motor>();
  final fluidos = ToOne<Fluidos>();
  final frenos = ToOne<Frenos>();
  final electrico = ToOne<Electrico>();
  final ordenServicio  = ToOne<OrdenServicio>();
  final servicio = ToOne<Servicio>();
  final producto = ToOne<Producto>();
  final estatus = ToOne<Estatus>();
  final usuario = ToOne<Usuarios>();
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();
  @Backlink()
  final emprendimientos = ToMany<Emprendimientos>();
  @Backlink()
  final tareas = ToMany<Tareas>();
  @Backlink()
  final consultorias = ToMany<Consultorias>();
  @Backlink()
  final usuarios = ToMany<Usuarios>();
  @Backlink()
  final jornadas = ToMany<Jornadas>();
  @Backlink()
  final productosEmp = ToMany<ProductosEmp>();
  @Backlink()
  final productosCot = ToMany<ProdCotizados>();
  @Backlink()
  final inversiones = ToMany<Inversiones>();
  @Backlink()
  final prodSolicitados = ToMany<ProdSolicitado>();
  @Backlink()
  final ventas = ToMany<Ventas>();
  @Backlink()
  final prodVendidos = ToMany<ProdVendidos>();
  @Backlink()
  final inversionXprodCotizados = ToMany<InversionesXProdCotizados>();
  @Backlink()
  final pagos = ToMany<Pagos>();
  @Backlink()
  final imagenes = ToMany<Imagenes>();

  Bitacora({
    this.id = 0,
    required this.usuarioPropietario,
    required this.instruccion,
    this.instruccionAdicional,
    required this.idOrdenTrabajo,
    DateTime? fechaRegistro,
    this.executeSupabase = false,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Emprendedores {
  int id;
  String nombre;
  String apellidos;
  DateTime nacimiento;
  String curp;
  String integrantesFamilia;
  String? telefono;
  String comentarios;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  final comunidad = ToOne<Comunidades>();
  final emprendimiento = ToOne<Emprendimientos>();
  final imagen = ToOne<Imagenes>();
  final bitacora = ToMany<Bitacora>();

  Emprendedores({
    this.id = 0,
    required this.nombre,
    required this.apellidos,
    required this.nacimiento,
    required this.curp,
    required this.integrantesFamilia,
    this.telefono,
    required this.comentarios,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class TipoProyecto {
  int id;
  String tipoProyecto;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final categoriasProyecto = ToMany<CatalogoProyecto>();

  TipoProyecto({
    this.id = 0,
    required this.tipoProyecto,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class CatalogoProyecto {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final emprendimientos = ToMany<Emprendimientos>();
  final tipoProyecto = ToOne<TipoProyecto>();
  final prodProyecto = ToMany<ProdProyecto>();

  CatalogoProyecto({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class PrioridadEmp {
  int id;
  String prioridad;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final emprendimientos = ToMany<Emprendimientos>();

  PrioridadEmp({
    this.id = 0,
    required this.prioridad,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class EstadoInversion {
  int id;
  String estado;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final emprendimientos = ToMany<Inversiones>();

  EstadoInversion({
    this.id = 0,
    required this.estado,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class FasesEmp {
  int id;
  String fase;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final emprendimientos = ToMany<Emprendimientos>();

  FasesEmp({
    this.id = 0,
    required this.fase,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Jornadas {
  int id;
  String numJornada;
  DateTime fechaRevision;
  DateTime fechaRegistro;
  bool completada;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final emprendimiento = ToOne<Emprendimientos>();
  final tarea = ToOne<Tareas>();
  final bitacora = ToMany<Bitacora>();
  Jornadas({
    this.id = 0,
    required this.numJornada,
    required this.fechaRevision,
    DateTime? fechaRegistro,
    required this.completada,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Tareas {
  int id;
  String tarea;
  String descripcion;
  String? comentarios;
  DateTime fechaRevision;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final jornada = ToOne<Jornadas>();
  final consultoria = ToOne<Consultorias>();
  final bitacora = ToMany<Bitacora>();
  final imagenes = ToMany<Imagenes>();
  final porcentaje = ToOne<PorcentajeAvance>();
  Tareas({
    this.id = 0,
    required this.tarea,
    required this.descripcion,
    this.comentarios,
    required this.fechaRevision,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Usuarios {
  int id;
  String nombre;
  String apellidoP;
  String? apellidoM;
  String? telefono;
  String celular;
  String rfc;
  String? domicilio;
  String correo;
  String password;
  String? imagen;
  String? path;
  DateTime fechaRegistro;
  @Unique()
  String idDBR;
  final bitacora = ToMany<Bitacora>();
  final rol = ToOne<Roles>();
  final roles = ToMany<Roles>();
  final pagos = ToMany<Pagos>();
  @Backlink()
  final emprendimientos = ToMany<Emprendimientos>();
  final asesor = ToOne<Usuarios>(); //Para Rol de C Y M
  final clientes = ToMany<Usuarios>(); //Para Rol de A
  final tecnicosMecanicos = ToMany<Usuarios>(); //Para Rol de A
  final ordenesTrabajo = ToMany<OrdenTrabajo>(); //Para Rol de A, C Y M
  final ordenTrabajo = ToOne<OrdenTrabajo>(); //Para Rol de C Y M
  final vehiculos = ToMany<Vehiculo>();
  Usuarios({
    this.id = 0,
    required this.nombre,
    required this.apellidoP,
    this.apellidoM,
    this.telefono,
    required this.celular,
    required this.rfc,
    this.domicilio,
    required this.correo,
    required this.password,
    this.imagen,
    this.path,
    DateTime? fechaRegistro,
    required this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Roles {
  int id;
  String rol;
  DateTime fechaRegistro;
  @Unique()
  String idDBR;
  final bitacora = ToOne<Bitacora>();
  final usuarios = ToMany<Usuarios>();

  Roles({
    this.id = 0,
    required this.rol,
    DateTime? fechaRegistro,
    required this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Ventas {
  int id;
  DateTime fechaInicio;
  DateTime fechaTermino;
  double total;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  int idEmprendimiento;
  final bitacora = ToMany<Bitacora>();
  final emprendimiento = ToOne<Emprendimientos>();
  final prodVendidos = ToMany<ProdVendidos>();

  Ventas({
    this.id = 0,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.total,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class ProdVendidos {
  int id;
  String nombreProd;
  String descripcion;
  double costo;
  int cantVendida;
  double subtotal;
  double precioVenta;
  DateTime fechaRegistro;
  bool postEmiWeb;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final bitacora = ToMany<Bitacora>();
  final venta = ToOne<Ventas>();
  final unidadMedida = ToOne<UnidadMedida>();
  final productoEmp = ToOne<ProductosEmp>();
  ProdVendidos({
    required this.nombreProd,
    required this.descripcion,
    required this.costo,
    this.id = 0,
    required this.cantVendida,
    required this.subtotal,
    required this.precioVenta,
    DateTime? fechaRegistro,
    this.postEmiWeb = false,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class ProductosEmp {
  int id;
  String nombre;
  String descripcion;
  double costo;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  int idEmprendimiento;
  final emprendimientos = ToOne<Emprendimientos>();
  final unidadMedida = ToOne<UnidadMedida>();
  final imagen = ToOne<Imagenes>();
  final bitacora = ToMany<Bitacora>();
  @Backlink()
  final vendidos = ToMany<ProdVendidos>();

  ProductosEmp({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.costo,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class ProdCotizados {
  int id;
  bool aceptado;
  int cantidad;
  double costoTotal;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  double costoUnitario;
  int idEmprendimiento;
  final inversionXprodCotizados = ToOne<InversionesXProdCotizados>();
  final productosProv = ToOne<ProductosProv>();
  final bitacora = ToMany<Bitacora>();

  ProdCotizados({
    this.id = 0,
    this.aceptado = false,
    required this.cantidad,
    required this.costoTotal,
    required this.costoUnitario,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class TipoEmpaques {
  int id;
  String tipo;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final prodSolicitados = ToMany<ProdSolicitado>();
  final productosProyecto = ToMany<ProdProyecto>();

  TipoEmpaques({
    this.id = 0,
    required this.tipo,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Consultorias {
  int id;
  DateTime fechaRegistro;
  List<String>? documentos; //TODO preguntar que es un arraystring
  @Unique()
  String? idDBR;
  @Unique()
  String? idEmiWeb;
  bool archivado;
  int idEmprendimiento;
  final emprendimiento = ToOne<Emprendimientos>();
  final areaCirculo = ToOne<AreaCirculo>();
  final ambitoConsultoria = ToOne<AmbitoConsultoria>();
  final bitacora = ToMany<Bitacora>();
  final tareas = ToMany<Tareas>();
  Consultorias({
    this.id = 0,
    DateTime? fechaRegistro,
    this.documentos,
    this.idDBR,
    this.archivado = false,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class AreaCirculo {
  int id;
  String nombreArea;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final consultoria = ToOne<Consultorias>();
  final bitacora = ToOne<Bitacora>();

  AreaCirculo({
    this.id = 0,
    required this.nombreArea,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class AmbitoConsultoria {
  int id;
  String nombreAmbito;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final consultorias = ToMany<Consultorias>();
  final bitacora = ToOne<Bitacora>();

  AmbitoConsultoria({
    this.id = 0,
    required this.nombreAmbito,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Comunidades {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final municipios = ToOne<Municipios>();
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();

  Comunidades({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Municipios {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final estados = ToOne<Estados>();
  @Backlink()
  final comunidades = ToMany<Comunidades>();

  Municipios({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Estados {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  @Backlink()
  final municipios = ToMany<Municipios>();

  Estados({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Proveedores {
  int id;
  String nombreFiscal;
  String rfc;
  String direccion;
  String? nombreEncargado;
  String clabe;
  String telefono;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String idEmiWeb;
  @Unique()
  String? idDBR;
  final tipoProveedor = ToOne<TipoProveedor>();
  final comunidades = ToOne<Comunidades>();
  final condicionPago = ToOne<CondicionesPago>();
  final banco = ToOne<Bancos>();
  final productosProv = ToMany<ProductosProv>();

  Proveedores({
    this.id = 0,
    required this.nombreFiscal,
    required this.rfc,
    required this.direccion,
    this.nombreEncargado,
    required this.clabe,
    required this.telefono,
    DateTime? fechaRegistro,
    required this.archivado,
    required this.idEmiWeb,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class FamiliaInversion {
  int id;
  String familiaInversion;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  @Backlink()
  final prodSolicitados = ToMany<ProdSolicitado>();
  @Backlink()
  final prodProyecto = ToMany<ProdProyecto>();
  
  FamiliaInversion({
    this.id = 0,
    required this.familiaInversion,
    DateTime? fechaRegistro,
    required this.activo,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class ProductosProv {
  int id;
  String nombre;
  String descripcion;
  String marca;
  double costo;
  int tiempoEntrega;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final proveedor = ToOne<Proveedores>();
  final prodCotizados = ToMany<ProdCotizados>();
  final unidadMedida = ToOne<UnidadMedida>();
  final imagen = ToOne<Imagenes>();

  ProductosProv({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.marca,
    required this.costo,
    required this.tiempoEntrega,
    DateTime? fechaRegistro,
    required this.archivado,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class UnidadMedida {
  int id;
  String unidadMedida;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final productosEmp = ToMany<ProductosEmp>();
  final prodSolicitados = ToMany<ProdSolicitado>();
  final productosProv = ToMany<ProductosProv>();
  final prodVendidos = ToMany<ProdVendidos>();

  UnidadMedida({
    this.id = 0,
    required this.unidadMedida,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Bancos {
  int id;
  String banco;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  @Backlink()
  final proveedores = ToMany<Proveedores>();

  Bancos({
    this.id = 0,
    required this.banco,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class FormaPago {
  int id;
  String formaPago;
  DateTime fechaRegistro;
  @Unique()
  String idDBR;
  @Backlink()
  final ordenTrabajo = ToMany<OrdenTrabajo>();

  FormaPago({
    this.id = 0,
    required this.formaPago,
    DateTime? fechaRegistro,
    required this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class CondicionesPago {
  int id;
  String condicion;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  @Backlink()
  final proveedores = ToMany<Proveedores>();

  CondicionesPago({
    this.id = 0,
    required this.condicion,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class TipoProveedor {
  int id;
  String tipo;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  final proveedores = ToMany<Proveedores>();

  TipoProveedor({
    this.id = 0,
    required this.tipo,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Imagenes {
  int id;
  String imagenes;
  String? nombre;
  String? path;
  String? base64;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  String? idEmiWeb;
  int idEmprendimiento;
  final tarea = ToOne<Tareas>();
  final prodSolicitados = ToMany<ProdSolicitado>();
  final productosProv = ToOne<ProductosProv>();
  final prodProyecto = ToMany<ProdProyecto>();
  final inversion = ToOne<Inversiones>();
  final productosEmp = ToOne<ProductosEmp>();
  final bitacora = ToMany<Bitacora>();
  final emprendedor = ToOne<Emprendedores>();
  final emprendimiento = ToOne<Emprendimientos>();
  Imagenes({
    this.id = 0,
    required this.imagenes,
    this.nombre,
    this.path,
    this.base64,
    DateTime? fechaRegistro,
    this.idDBR,
    this.idEmiWeb,
    required this.idEmprendimiento,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class PorcentajeAvance {
  int id;
  String porcentajeAvance;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Unique()
  String idEmiWeb;
  @Backlink()
  final tareas = ToMany<Tareas>();

  PorcentajeAvance({
    this.id = 0,
    required this.porcentajeAvance,
    DateTime? fechaRegistro,
    this.idDBR,
    required this.idEmiWeb,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}
