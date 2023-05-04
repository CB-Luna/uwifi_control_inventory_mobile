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
  final bitacora = ToMany<Bitacora>();

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
  final tecnicoMecanico = ToOne<Usuarios>();

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
  final tecnicoMecanico = ToOne<Usuarios>();

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
  final tecnicoMecanico = ToOne<Usuarios>();

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
  final tecnicoMecanico = ToOne<Usuarios>();

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
  final tecnicoMecanico = ToOne<Usuarios>();

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
class Bitacora {
  int id;
  String usuarioPropietario;
  String instruccion;
  String? instruccionAdicional;
  int idOrdenTrabajo;
  DateTime fechaRegistro;
  bool executeSupabase;
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
  final emprendimientos = ToMany<Emprendimientos>();
  @Backlink()
  final usuarios = ToMany<Usuarios>();
  @Backlink()
  final pagos = ToMany<Pagos>();

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
  bool? interno;
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

  //Relaciones del Técnico-Mecánico
  final suspesionesDirecciones = ToMany<SuspensionDireccion>();
  final motores = ToMany<Motor>();
  final fluidos = ToMany<Fluidos>();
  final frenos = ToMany<Frenos>();
  final electricos = ToMany<Electrico>();
  
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
    this.interno,
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
class Anio {
  int id;
  String anio;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final modelo = ToOne<Modelo>();

  Anio({
    this.id = 0,
    required this.anio,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Modelo {
  int id;
  String modelo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final marca = ToOne<Marca>();
  @Backlink()
  final anios = ToMany<Anio>();

  Modelo({
    this.id = 0,
    required this.modelo,
    DateTime? fechaRegistro,
    this.idDBR,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Marca {
  int id;
  String marca;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final modelos = ToMany<Modelo>();

  Marca({
    this.id = 0,
    required this.marca,
    DateTime? fechaRegistro,
    this.idDBR,
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



