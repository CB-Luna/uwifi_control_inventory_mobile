import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Emprendimientos {
  int id;
  String imagen;
  String nombre;
  String descripcion;
  DateTime fechaRegistro;
  final usuarios = ToMany<Usuarios>();
  final prioridadProyecto = ToOne<PrioridadProyecto>();
  final jornadas = ToMany<Jornadas>();
  final comunidades = ToOne<Comunidades>();
  final emprendedor = ToOne<Emprendedores>();
  @Backlink()
  final clasifiProyecto = ToMany<ClasificacionProyecto>();
  @Backlink()
  final estadoEmp = ToMany<EstadoEmp>();
  @Backlink()
  final ventas = ToMany<Ventas>();
  @Backlink()
  final prodEmprendi = ToMany<ProdEmprendi>();
  @Backlink()
  final consultorias = ToMany<Consultorias>();
  
  Emprendimientos({
    this.id = 0,
    required this.imagen,
    required this.nombre,
    required this.descripcion,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Emprendedores {
  int id;
  String imagen;
  String nombre;
  String apellidoP;
  String apellidoM;
  DateTime nacimiento;
  String curp;
  String integrantesFamilia; //TODO preguntar por el tipo array
  String telefono;
  String comentarios;
  DateTime fechaRegistro;
  final comunidades = ToOne<Comunidades>();
  final emprendimiento = ToOne<Emprendimientos>();
  final statusSync = ToOne<StatusSync>();

  Emprendedores({
    this.id = 0,
    required this.imagen,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.nacimiento,
    required this.curp,
    required this.integrantesFamilia,
    required this.telefono,
    required this.comentarios,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class ClasificacionProyecto {
  int id;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();
  
  ClasificacionProyecto({
    this.id = 0,
    required this.descripcion,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
}

@Entity()
class PrioridadProyecto {
  int id;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();

  PrioridadProyecto({
    this.id = 0,
    required this.descripcion,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
}


@Entity()
class EstadoEmp {
  int id;
  String estado;
  DateTime fechaActualizacion;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();
  
  EstadoEmp({
    this.id = 0,
    required this.estado,
    DateTime? fechaActualizacion,
    DateTime? fechaSync,
    }) : fechaActualizacion = fechaActualizacion ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaActualizacionFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaActualizacion);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
}

@Entity()
class Jornadas {
  int id;
  String numJornada;
  DateTime proximaVisita;
  DateTime fechaRegistro;
  final emprendimiento = ToOne<Emprendimientos>();
  final tarea = ToOne<Tareas>();
  final statusSync = ToOne<StatusSync>();
  Jornadas({
    this.id = 0,
    required this.numJornada,
    required this.proximaVisita,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Tareas {
  int id;
  String descripcion;
  String observacion;
  int porcentaje;
  String imagenes;
  DateTime fechaRevision;
  DateTime fechaRegistro;
  final jornada = ToOne<Jornadas>();
  final consultoria = ToOne<Consultorias>();
  final statusSync = ToOne<StatusSync>();
  Tareas({
    this.id = 0,
    required this.descripcion,
    required this.observacion,
    required this.porcentaje,
    required this.imagenes,
    required this.fechaRevision,
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
  int rol;
  DateTime fechaRegistro;
  final statusSync = ToOne<StatusSync>();
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
    required this.rol,
    DateTime? fechaRegistro,
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
  final emprendimientos = ToOne<Emprendimientos>();

  Ventas({
    this.id = 0,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.total,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
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
  final ventas = ToOne<Ventas>();
  final prodEmprendi = ToOne<ProdEmprendi>();
  Vendidos({
    this.id = 0,
    required this.cantVendida,
    required this.subtotal,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class ProdEmprendi {
  int id;
  String nombre;
  String descripcion;
  String imagen;
  int costo;
  int precioVenta;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();
  @Backlink()
  final vendidos = ToMany<Vendidos>();

  ProdEmprendi({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.costo,
    required this.precioVenta,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Consultorias {
  int id;
  String documentos; //TODO preguntar que es un arraystring
  DateTime fechaRegistro;
  final emprendimiento = ToOne<Emprendimientos>();
  final statusSync = ToOne<StatusSync>();
  @Backlink()
  final tareas = ToMany<Tareas>();
  Consultorias({
    this.id = 0,
    required this.documentos,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}

@Entity()
class Comunidades {
  int id;
  String nombre;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final municipios = ToOne<Municipios>();
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();
  @Backlink()
  final emprendimientos = ToMany<Emprendimientos>();

  Comunidades({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Municipios {
  int id;
  String nombre;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final estados = ToOne<Estados>();
  @Backlink()
  final comunidades = ToMany<Comunidades>();

  Municipios({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Estados {
  int id;
  String nombre;
  DateTime fechaRegistro;
  DateTime fechaSync;
  @Backlink()
  final municipios = ToMany<Municipios>();

  Estados({
    this.id = 0,
    required this.nombre,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class StatusSync {
  int id;
  String status;
  DateTime fechaRegistro;
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();
  @Backlink()
  final tareas = ToMany<Tareas>();
  @Backlink()
  final consultorias = ToMany<Consultorias>();
  @Backlink()
  final usuarios = ToMany<Usuarios>();
  @Backlink()
  final jornadas = ToMany<Jornadas>();
  StatusSync({
    this.id = 0,
    required this.status,
    DateTime? fechaRegistro,
    }): fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);

}
