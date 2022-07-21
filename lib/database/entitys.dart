import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Emprendimientos {
  int id;
  String imagen;
  String nombre;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final usuarios = ToMany<Usuarios>();
  final prioridadProyecto = ToOne<PrioridadProyecto>();
  final jornada1 = ToOne<Jornada1>();
  final jornada2 = ToOne<Jornada2>();
  final jornada3 = ToOne<Jornada3>();
  final jornada4 = ToOne<Jornada4>();
  final comunidades = ToOne<Comunidades>();
  @Backlink()
  final emprendedores = ToMany<Emprendedores>();
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
    }) : fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
}

@Entity()
class Emprendedores {
  int id;
  String nombre;
  String apellidoP;
  String apellidoM;
  DateTime nacimiento;
  String curp;
  String integrantesFamilia; //TODO preguntar por el tipo array
  String telefono;
  String comentarios;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final comunidades = ToOne<Comunidades>();
  final emprendimientos = ToMany<Emprendimientos>();


  Emprendedores({
    this.id = 0,
    required this.nombre,
    required this.apellidoP,
    required this.apellidoM,
    required this.nacimiento,
    required this.curp,
    required this.integrantesFamilia,
    required this.telefono,
    required this.comentarios,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
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
class Jornada1 {
  int id;
  String tarea;
  String estado;
  DateTime fechaRevision;
  String circuloEmpresa;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();

  Jornada1({
    this.id = 0,
    required this.tarea,
    required this.estado,
    required this.fechaRevision,
    required this.circuloEmpresa,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Jornada2 {
  int id;
  String tarea;
  String estado;
  String comentarios;
  DateTime fechaRevision;
  String analisisFinanciero;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();

  Jornada2({
    this.id = 0,
    required this.tarea,
    required this.estado,
    required this.comentarios,
    required this.fechaRevision,
    required this.analisisFinanciero,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Jornada3 {
  int id;
  String tarea;
  String estado;
  String comentarios;
  DateTime fechaRevision;
  String convenio;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();

  Jornada3({
    this.id = 0,
    required this.tarea,
    required this.estado,
    required this.comentarios,
    required this.fechaRevision,
    required this.convenio,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Jornada4 {
  int id;
  String tarea;
  String estado;
  String comentarios;
  DateTime fechaRevision;
  String convenio;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();

  Jornada4({
    this.id = 0,
    required this.tarea,
    required this.estado,
    required this.comentarios,
    required this.fechaRevision,
    required this.convenio,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

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
  DateTime fechaSync;
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
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
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
  DateTime proximaVisita;
  String documentos; //TODO preguntar que es un arraystring
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimientos = ToOne<Emprendimientos>();
  @Backlink()
  final tareas = ToMany<Tareas>();
  Consultorias({
    this.id = 0,
    required this.proximaVisita,
    required this.documentos,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Tareas {
  int id;
  String nombre;
  String descripcion;
  String observacion;
  int porcentaje;
  DateTime fechaRevision;
  String imagenes; //TODO preguntar que es un arraystring
  DateTime fechaRegistro;
  DateTime fechaSync;
  final consultorias = ToOne<Consultorias>();

  Tareas({
    this.id = 0,
    required this.nombre,
    required this.descripcion,
    required this.observacion,
    required this.porcentaje,
    required this.fechaRevision,
    required this.imagenes,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

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