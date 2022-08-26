import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Emprendimientos {
  int id;
  String imagen;
  String nombre;
  String descripcion;
  bool activo;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  final comunidad = ToOne<Comunidades>();
  final usuario = ToOne<Usuarios>(); //Promotor en Diagrama E-R
  final prioridadEmp = ToOne<PrioridadEmp>();
  final catalogoProyecto = ToOne<CatalogoProyecto>();
  final proveedores = ToMany<Proveedores>();
  final jornadas = ToMany<Jornadas>();
  final emprendedor = ToOne<Emprendedores>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();
  @Backlink()
  final fasesEmp = ToMany<FasesEmp>();
  @Backlink()
  final ventas = ToMany<Ventas>();
  @Backlink()
  final productosEmp = ToMany<ProductosEmp>();
  @Backlink()
  final productosCot = ToMany<ProductosCot>();
  @Backlink()
  final consultorias = ToMany<Consultorias>();
  
  Emprendimientos({
    this.id = 0,
    required this.imagen,
    required this.nombre,
    required this.descripcion,
    this.activo = true,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Bitacora{
  int id;
  String usuario;
  String instrucciones;
  DateTime fechaRegistro;
  DateTime? fechaSync;
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
  final productosCot = ToMany<ProductosCot>();
  
  Bitacora({
    this.id = 0,
    required this.usuario,
    required this.instrucciones,
    DateTime? fechaRegistro,
    this.fechaSync,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync!);
}

@Entity()
class Emprendedores {
  int id;
  String imagen;
  String nombre;
  String apellidos;
  DateTime nacimiento;
  String curp;
  String integrantesFamilia; //TODO preguntar por el tipo array
  String? telefono;
  String comentarios;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final comunidad = ToOne<Comunidades>();
  final emprendimiento = ToOne<Emprendimientos>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();

  Emprendedores({
    this.id = 0,
    required this.imagen,
    required this.nombre,
    required this.apellidos,
    required this.nacimiento,
    required this.curp,
    required this.integrantesFamilia,
    this.telefono,
    required this.comentarios,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class ClasificacionEmp {
  int id;
  String clasificacion;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final categoriasProyecto = ToMany<CatalogoProyecto>();
  final statusSync = ToOne<StatusSync>();
  
  ClasificacionEmp({
    this.id = 0,
    required this.clasificacion,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class CatalogoProyecto {
  int id;
  String nombre;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final emprendimientos = ToMany<Emprendimientos>();
  final clasificacionEmp = ToOne<ClasificacionEmp>();
  final statusSync = ToOne<StatusSync>();
  
  CatalogoProyecto({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.idDBR,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class PrioridadEmp {
  int id;
  String prioridad;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final emprendimientos = ToMany<Emprendimientos>();
  final statusSync = ToOne<StatusSync>();

  PrioridadEmp({
    this.id = 0,
    required this.prioridad,
    DateTime? fechaRegistro,
    this.idDBR,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class FasesEmp {
  int id;
  String fase;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final emprendimientos = ToMany<Emprendimientos>();
  final statusSync = ToOne<StatusSync>();

  FasesEmp({
    this.id = 0,
    required this.fase,
    DateTime? fechaRegistro,
    this.idDBR,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Jornadas {
  int id;
  String numJornada;
  DateTime fechaRevision;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final emprendimiento = ToOne<Emprendimientos>();
  final tarea = ToOne<Tareas>();
  final documentos = ToMany<Documentos>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();
  Jornadas({
    this.id = 0,
    required this.numJornada,
    required this.fechaRevision,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Tareas {
  int id;
  String tarea;
  String descripcion;
  String observacion;
  int porcentaje;
  bool activo;
  DateTime fechaRevision;
  DateTime fechaRegistro;
  List<String>? imagenes;
  @Unique()
  String? idDBR;
  final jornada = ToOne<Jornadas>();
  final consultoria = ToOne<Consultorias>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();
  final image = ToOne<Imagenes>();
  Tareas({
    this.id = 0,
    required this.tarea,
    required this.descripcion,
    required this.observacion,
    required this.porcentaje,
    this.activo = true,
    required this.fechaRevision,
    DateTime? fechaRegistro,
    this.imagenes,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Documentos {
  int id;
  String nombreArchivo;
  DateTime fechaCarga;
  String archivo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final tipoDocumento = ToOne<TipoDocumentos>();
  final jornada = ToOne<Jornadas>();
  final consultoria = ToOne<Consultorias>();
  final usuario = ToOne<Usuarios>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToOne<Bitacora>();
  Documentos({
    this.id = 0,
    required this.nombreArchivo,
    required this.fechaCarga,
    required this.archivo,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class TipoDocumentos {
  int id;
  String tipo;
  DateTime fechaRegistro;
  final documentos = ToMany<Documentos>();

  TipoDocumentos({
    this.id = 0,
    required this.tipo,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Usuarios {
  int id;
  String nombre;
  String apellidoP;
  String apellidoM;
  DateTime nacimiento;
  String telefono;
  String celular;
  String correo;
  String password;
  String imagen;
  DateTime fechaRegistro;
  bool archivado;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();
  final documentos = ToMany<Documentos>();
  final variablesUsuario = ToOne<VariablesUsuario>(); //Importante para evaluar la sincronizacion
  final rol = ToOne<Roles>();
  final image = ToOne<Imagenes>();
  @Backlink()
  final emprendimientos = ToMany<Emprendimientos>();


  Usuarios({
    this.id = 0,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.nacimiento,
    required this.telefono,
    required this.celular,
    required this.correo,
    required this.password,
    required this.imagen,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Roles {
  int id;
  String rol;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToOne<Bitacora>();
  final usuarios = ToMany<Usuarios>();

  Roles({
    this.id = 0,
    required this.rol,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}

@Entity()
class Ventas {
  int id;
  DateTime fechaInicio;
  DateTime fechaTermino;
  int total;
  DateTime fechaRegistro;
  DateTime fechaSync;
  @Unique()
  String? idDBR;
  final emprendimientos = ToOne<Emprendimientos>();

  Ventas({
    this.id = 0,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.total,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}


@Entity()
class Vendidos {
  int id;
  int cantVendida;
  int subtotal;
  DateTime fechaRegistro;
  DateTime fechaSync;
  @Unique()
  String? idDBR;
  final ventas = ToOne<Ventas>();
  final productoEmp = ToOne<ProductosEmp>();
  Vendidos({
    this.id = 0,
    required this.cantVendida,
    required this.subtotal,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class ProductosEmp {
  int id;
  String nombre;
  String descripcion;
  String imagen;
  double costo;
  int precioVenta;
  int cantidad;
  DateTime fechaRegistro;
  bool archivado;
  String proveedor;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  final emprendimientos = ToOne<Emprendimientos>();
  final familiaInversion = ToOne<FamiliaInversion>();
  final unidadMedida = ToOne<UnidadMedida>();
  final bitacora = ToMany<Bitacora>();
  @Backlink()
  final vendidos = ToMany<Vendidos>();

  ProductosEmp({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.costo,
    required this.precioVenta,
    required this.cantidad,
    DateTime? fechaRegistro,
    this.archivado = false,
    required this.proveedor,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class ProductosCot {
  int id;
  String nombre;
  String descripcion;
  String imagen;
  double costo;
  int precioVenta;
  int cantidad;
  DateTime fechaRegistro;
  bool archivado;
  String proveedor;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  final emprendimientos = ToOne<Emprendimientos>();
  final familiaInversion = ToOne<FamiliaInversion>();
  final unidadMedida = ToOne<UnidadMedida>();
  final bitacora = ToMany<Bitacora>();

  ProductosCot({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.costo,
    required this.precioVenta,
    required this.cantidad,
    DateTime? fechaRegistro,
    this.archivado = false,
    this.idDBR,
    required this.proveedor,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class FamiliaInversion {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();

  FamiliaInversion({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}



@Entity()
class Consultorias {
  int id;
  DateTime fechaRegistro;
  List<String>? documentos; //TODO preguntar que es un arraystring
  @Unique()
  String? idDBR;
  final emprendimiento = ToOne<Emprendimientos>();
  final areaCirculo = ToOne<AreaCirculo>();
  final ambitoConsultoria = ToOne<AmbitoConsultoria>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToMany<Bitacora>();
  final tareas = ToMany<Tareas>();
  Consultorias({
    this.id = 0,
    DateTime? fechaRegistro,
    this.documentos,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class AreaCirculo {
  int id;
  String nombreArea;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final consultoria = ToOne<Consultorias>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToOne<Bitacora>();

  AreaCirculo({
    this.id = 0,
    required this.nombreArea,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class AmbitoConsultoria {
  int id;
  String nombreAmbito;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final consultorias = ToMany<Consultorias>();
  final statusSync = ToOne<StatusSync>();
  final bitacora = ToOne<Bitacora>();

  AmbitoConsultoria({
    this.id = 0,
    required this.nombreAmbito,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Comunidades {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final municipios = ToOne<Municipios>();
  final statusSync = ToOne<StatusSync>();
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();
  @Backlink()
  final emprendimientos = ToMany<Emprendimientos>();

  Comunidades({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Municipios {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final estados = ToOne<Estados>();
  final statusSync = ToOne<StatusSync>();
  @Backlink()
  final comunidades = ToMany<Comunidades>();

  Municipios({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Estados {
  int id;
  String nombre;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  @Backlink()
  final municipios = ToMany<Municipios>();

  Estados({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Proveedores {
  int id;
  String nombreFiscal;
  String rfc;
  String direccion;
  String nombreEncargado;
  String clabe;
  String telefono;
  DateTime fechaRegistro;
  int registradoPor;
  bool archivado;
  @Unique()
  String? idDBR;
  final tipoProveedor = ToOne<TipoProveedor>();
  final comunidades = ToOne<Comunidades>();
  final condicionPago = ToOne<CondicionesPago>();
  final banco = ToOne<Bancos>();

  Proveedores({
    this.id = 0,
    required this.nombreFiscal,
    required this.rfc,
    required this.direccion,
    required this.nombreEncargado,
    required this.clabe,
    required this.telefono,
    DateTime? fechaRegistro,
    required this.registradoPor,
    required this.archivado,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class UnidadMedida {
  int id;
  String unidadMedida;
  DateTime fechaRegistro;
  bool activo;
  @Unique()
  String? idDBR;
  final statusSync = ToOne<StatusSync>();
  final productosEmp = ToMany<ProductosEmp>();

  UnidadMedida({
    this.id = 0,
    required this.unidadMedida,
    DateTime? fechaRegistro,
    this.activo = true,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Bancos {
  int id;
  String banco;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final proveedores = ToMany<Proveedores>();

  Bancos({
    this.id = 0,
    required this.banco,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class CondicionesPago {
  int id;
  String condicion;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final proveedores = ToMany<Proveedores>();

  CondicionesPago({
    this.id = 0,
    required this.condicion,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}
@Entity()
class TipoProveedor {
  int id;
  String tipo;
  bool activo;
  DateTime fechaRegistro;
  @Unique()
  String? idDBR;
  @Backlink()
  final proveedores = ToMany<Proveedores>();

  TipoProveedor({
    this.id = 0,
    required this.tipo,
    this.activo = true,
    DateTime? fechaRegistro,
    this.idDBR,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class StatusSync {
  int id;
  String status;
  DateTime fechaRegistro;
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
  final comunidades = ToMany<Comunidades>();
  @Backlink()
  final municipios = ToMany<Municipios>();
  @Backlink()
  final estados = ToMany<Estados>();
  @Backlink()
  final clasificacionesEmp = ToMany<ClasificacionEmp>();
  @Backlink()
  final fasesEmp = ToMany<FasesEmp>();
  @Backlink()
  final prioridadesEmp = ToMany<PrioridadEmp>();
  @Backlink()
  final productosEmp = ToMany<ProductosEmp>();
  @Backlink()
  final productosCot = ToMany<ProductosCot>();
  @Backlink()
  final familiasInversion = ToMany<FamiliaInversion>();
  @Backlink()
  final unidadesMedida = ToMany<UnidadMedida>();
  StatusSync({
    this.id = 0,
    this.status = "0E3hoVIByUxMUMZ", //M__
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class VariablesUsuario {
  int id;
  bool emprendedores;
  bool emprendimientos;
  DateTime fechaActualizacion;
  @Backlink()
  final usuarios = ToMany<Usuarios>();
  VariablesUsuario({
    this.id = 0,
    this.emprendedores = false,
    this.emprendimientos = false,
    DateTime? fechaActualizacion,
    }): fechaActualizacion = fechaActualizacion ?? DateTime.now();

  String get fechaActualizacionFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaActualizacion);

}

@Entity()
class Imagenes {
  int id;
  String imagenes;
  DateTime fechaRegistro;
  final tareas = ToMany<Tareas>();
  final usuarios = ToMany<Usuarios>();
  Imagenes({
    this.id = 0,
    required this.imagenes,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}
