import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Emprendimiento {
  int id;
  String imagen;
  String nombre;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  @Backlink()
  final jornada = ToMany<Jornada>();
  final usuario = ToMany<Usuario>();

  
  Emprendimiento({
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
class PriporidadProyecto {
  int id;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  
  PriporidadProyecto({
    this.id = 0,
    required this.descripcion,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }) : fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);
}

@Entity()
class ClasificacionProyecto {
  int id;
  String descripcion;
  DateTime fechaRegistro;
  DateTime fechaSync;
  
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
class Jornada {
  int id;
  int numeroJornada;
  DateTime fechaRevision;
  String circuloEmpresa;
  String analisisFinanciero;
  String convenio;
  String agregarRegistro;
  DateTime fechaRegistro;
  DateTime fechaSync;
  final emprendimiento = ToOne<Emprendimiento>();

  Jornada({
    this.id = 0,
    required this.numeroJornada,
    required this.fechaRevision,
    required this.circuloEmpresa,
    required this.analisisFinanciero,
    required this.convenio,
    required this.agregarRegistro,
    DateTime? fechaRegistro,
    DateTime? fechaSync,
    }): fechaRegistro = fechaRegistro ?? DateTime.now(), fechaSync = fechaSync ?? DateTime.now();

  String get fechaRegistroFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
  String get fechaSyncFormat => DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaSync);

}

@Entity()
class Usuario {
  int id;
  String nombre;
  String apellido;
  String telefono;
  String celular;
  String correo;
  String password;
  String imagen;
  int rol;
  DateTime fechaRegistro;
  DateTime fechaSync;
  @Backlink()
  final emprendimiento = ToMany<Emprendimiento>();


  Usuario({
    this.id = 0,
    required this.nombre,
    required this.apellido,
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
