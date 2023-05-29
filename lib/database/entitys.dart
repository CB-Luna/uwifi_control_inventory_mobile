import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';
import 'package:taller_alex_app_asesor/database/image.dart';

@Entity()
class ControlForm {
  int id;
  bool typeForm;
  bool today;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  final employee = ToOne<Users>();
  final vehicle = ToOne<Vehicle>();
  final measures = ToOne<Measures>();
  final lights = ToOne<Lights>();
  final carBodywork = ToOne<CarBodywork>();
  final fluidsCheck = ToOne<FluidsCheck>();
  final bucketInspection = ToOne<BucketInspection>();
  final security = ToOne<Security>();
  final extra = ToOne<Extra>();
  final equipment = ToOne<Equipment>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  ControlForm({
    this.id = 0,
    required this.typeForm,
    this.today = true,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Status {
  int id;
  String status;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();


  Status({
    this.id = 0,
    required this.status,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Company {
  int id;
  String company;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();


  Company({
    this.id = 0,
    required this.company,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Role {
  int id;
  String role;
  DateTime dateAdded;
  @Unique()
  String idDBR;
  final bitacora = ToOne<Bitacora>();
  final users = ToMany<Users>();

  Role({
    this.id = 0,
    required this.role,
    DateTime? dateAdded,
    required this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Measures {
  int id;
  String gas;
  String gasComments;
  late List<ImageEvidence> gasImages;
  int mileage;
  String mileageComments;
  late List<ImageEvidence> mileageImages;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  Measures({
    this.id = 0,
    required this.gas,
    required this.gasComments,
    List<ImageEvidence>? gasImages,
    required this.mileage,
    required this.mileageComments,
    List<ImageEvidence>? mileageImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Lights {
  int id;
  String headLights;
  String headLightsComments;
  late List<ImageEvidence> headLightsImages;
  String brakeLights;
  String brakeLightsComments;
  late List<ImageEvidence> brakeLightsImages;
  String reverseLights;
  String reverseLightsComments;
  late List<ImageEvidence> reverseLightsImages;
  String warningLights;
  String warningLightsComments;
  late List<ImageEvidence> warningLightsImages;
  String turnSignals;
  String turnSignalsComments;
  late List<ImageEvidence> turnSignalsImages;
  String fourWayFlashers;
  String fourWayFlashersComments;
  late List<ImageEvidence> fourWayFlashersImages;
  String dashLights;
  String dashLightsComments;
  late List<ImageEvidence> dashLightsImages;
  String strobeLights;
  String strobeLightsComments;
  late List<ImageEvidence> strobeLightsImages;
  String cabRoofLights;
  String cabRoofLightsComments;
  late List<ImageEvidence> cabRoofLightsImages;
  String clearenceLights;
  String clearenceLightsComments;
  late List<ImageEvidence> clearenceLightsImages;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  Lights({
    this.id = 0,
    required this.headLights,
    required this.headLightsComments,
    List<ImageEvidence>? headLightsImages,
    required this.brakeLights,
    required this.brakeLightsComments,
    List<ImageEvidence>? brakeLightsImages,
    required this.reverseLights,
    required this.reverseLightsComments,
    List<ImageEvidence>? reverseLightsImages,
    required this.warningLights,
    required this.warningLightsComments,
    List<ImageEvidence>? warningLightsImages,
    required this.turnSignals,
    required this.turnSignalsComments,
    List<ImageEvidence>? turnSignalsImages,
    required this.fourWayFlashers,
    required this.fourWayFlashersComments,
    List<ImageEvidence>? fourWayFlashersImages,
    required this.dashLights,
    required this.dashLightsComments,
    List<ImageEvidence>? dashLightsImages,
    required this.strobeLights,
    required this.strobeLightsComments,
    List<ImageEvidence>? strobeLightsImages,
    required this.cabRoofLights,
    required this.cabRoofLightsComments,
    List<ImageEvidence>? cabRoofLightsImages,
    required this.clearenceLights,
    required this.clearenceLightsComments,
    List<ImageEvidence>? clearenceLightsImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class CarBodywork {
  int id;
  String wiperBladesFront;
  String wiperBladesFrontComments;
  late List<ImageEvidence> wiperBladesFrontImages;
  String wiperBladesBack;
  String wiperBladesBackComments;
  late List<ImageEvidence> wiperBladesBackImages;
  String windshieldWiperFront;
  String windshieldWiperFrontComments;
  late List<ImageEvidence> windshieldWiperFrontImages;
  String windshieldWiperBack;
  String windshieldWiperBackComments;
  late List<ImageEvidence> windshieldWiperBackImages;
  String generalBody;
  String generalBodyComments;
  late List<ImageEvidence> generalBodyImages;
  String decaling;
  String decalingComments;
  late List<ImageEvidence> decalingImages;
  String tires;
  String tiresComments;
  late List<ImageEvidence> tiresImages;
  String glass;
  String glassComments;
  late List<ImageEvidence> glassImages;
  String mirrors;
  String mirrorsComments;
  late List<ImageEvidence> mirrorsImages;
  String parking;
  String parkingComments;
  late List<ImageEvidence> parkingImages;
  String brakes;
  String brakesComments;
  late List<ImageEvidence> brakesImages;
  String emgBrakes;
  String emgBrakesComments;
  late List<ImageEvidence> emgBrakesImages;
  String horn;
  String hornComments;
  late List<ImageEvidence> hornImages;

  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  CarBodywork({
    this.id = 0,
    required this.wiperBladesFront,
    required this.wiperBladesFrontComments,
    List<ImageEvidence>? wiperBladesFrontImages,
    required this.wiperBladesBack,
    required this.wiperBladesBackComments,
    List<ImageEvidence>? wiperBladesBackImages,
    required this.windshieldWiperFront,
    required this.windshieldWiperFrontComments,
    List<ImageEvidence>? windshieldWiperFrontImages,
    required this.windshieldWiperBack,
    required this.windshieldWiperBackComments,
    List<ImageEvidence>? windshieldWiperBackImages,
    required this.generalBody,
    required this.generalBodyComments,
    List<ImageEvidence>? generalBodyImages,
    required this.decaling,
    required this.decalingComments,
    List<ImageEvidence>? decalingImages,
    required this.tires,
    required this.tiresComments,
    List<ImageEvidence>? tiresImages,
    required this.glass,
    required this.glassComments,
    List<ImageEvidence>? glassImages,
    required this.mirrors,
    required this.mirrorsComments,
    List<ImageEvidence>? mirrorsImages,
    required this.parking,
    required this.parkingComments,
    List<ImageEvidence>? parkingImages,
    required this.brakes,
    required this.brakesComments,
    List<ImageEvidence>? brakesImages,
    required this.emgBrakes,
    required this.emgBrakesComments,
    List<ImageEvidence>? emgBrakesImages,
    required this.horn,
    required this.hornComments,
    List<ImageEvidence>? hornImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class FluidsCheck {
  int id;
  String engineOil;
  String engineOilComments;
  late List<ImageEvidence> engineOilImages;
  String transmission;
  String transmissionComments;
  late List<ImageEvidence> transmissionImages;
  String coolant;
  String coolantComments;
  late List<ImageEvidence> coolantImages;
  String powerSteering;
  String powerSteeringComments;
  late List<ImageEvidence> powerSteeringImages;
  String dieselExhaustFluid;
  String dieselExhaustFluidComments;
  late List<ImageEvidence> dieselExhaustFluidImages;
  String windshieldWasherFluid;
  String windshieldWasherFluidComments;
  late List<ImageEvidence> windshieldWasherFluidImages;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  FluidsCheck({
    this.id = 0,
    required this.engineOil,
    required this.engineOilComments,
    List<ImageEvidence>? engineOilImages,
    required this.transmission,
    required this.transmissionComments,
    List<ImageEvidence>? transmissionImages,
    required this.coolant,
    required this.coolantComments,
    List<ImageEvidence>? coolantImages,
    required this.powerSteering,
    required this.powerSteeringComments,
    List<ImageEvidence>? powerSteeringImages,
    required this.dieselExhaustFluid,
    required this.dieselExhaustFluidComments,
    List<ImageEvidence>? dieselExhaustFluidImages,
    required this.windshieldWasherFluid,
    required this.windshieldWasherFluidComments,
    List<ImageEvidence>? windshieldWasherFluidImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class BucketInspection {
  int id;
  String insulated;
  String insulatedComments;
  late List<ImageEvidence> insulatedImages;
  String holesDrilled;
  String holesDrilledComments;
  late List<ImageEvidence> holesDrilledImages;
  String bucketLiner;
  String bucketLinerComments;
  late List<ImageEvidence> bucketLinerImages;

  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  BucketInspection({
    this.id = 0,
    required this.insulated,
    required this.insulatedComments,
    List<ImageEvidence>? insulatedImages,
    required this.holesDrilled,
    required this.holesDrilledComments,
    List<ImageEvidence>? holesDrilledImages,
    required this.bucketLiner,
    required this.bucketLinerComments,
    List<ImageEvidence>? bucketLinerImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Security {
  int id;
  String rtaMagnet;
  String rtaMagnetComments;
  late List<ImageEvidence> rtaMagnetImages;
  String triangleReflectors;
  String triangleReflectorsComments;
  late List<ImageEvidence> triangleReflectorsImages;
  String wheelChocks;
  String wheelChocksComments;
  late List<ImageEvidence> wheelChocksImages;
  String fireExtinguisher;
  String fireExtinguisherComments;
  late List<ImageEvidence> fireExtinguisherImages;
  String firstAidKitSafetyVest;
  String firstAidKitSafetyVestComments;
  late List<ImageEvidence> firstAidKitSafetyVestImages;
  String backUpAlarm;
  String backUpAlarmComments;
  late List<ImageEvidence> backUpAlarmImages;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  Security ({
    this.id = 0,
    required this.rtaMagnet,
    required this.rtaMagnetComments,
    List<ImageEvidence>? rtaMagnetImages,
    required this.triangleReflectors,
    required this.triangleReflectorsComments,
    List<ImageEvidence>? triangleReflectorsImages,
    required this.wheelChocks,
    required this.wheelChocksComments,
    List<ImageEvidence>? wheelChocksImages,
    required this.fireExtinguisher,
    required this.fireExtinguisherComments,
    List<ImageEvidence>? fireExtinguisherImages,
    required this.firstAidKitSafetyVest,
    required this.firstAidKitSafetyVestComments,
    List<ImageEvidence>? firstAidKitSafetyVestImages,
    required this.backUpAlarm,
    required this.backUpAlarmComments,
    List<ImageEvidence>? backUpAlarmImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Extra {
  int id;
  String ladder;
  String ladderComments;
  late List<ImageEvidence> ladderImages;
  String stepLadder;
  String stepLadderComments;
  late List<ImageEvidence> stepLadderImages;
  String ladderStraps;
  String ladderStrapsComments;
  late List<ImageEvidence> ladderStrapsImages;
  String hydraulicFluidForBucket;
  String hydraulicFluidForBucketComments;
  late List<ImageEvidence> hydraulicFluidForBucketImages;
  String fiberReelRack;
  String fiberReelRackComments;
  late List<ImageEvidence> fiberReelRackImages;
  String binsLockedAndSecure;
  String binsLockedAndSecureComments;
  late List<ImageEvidence> binsLockedAndSecureImages;
  String safetyHarness;
  String safetyHarnessComments;
  late List<ImageEvidence> safetyHarnessImages;
  String lanyardSafetyHarness;
  String lanyardSafetyHarnessComments;
  late List<ImageEvidence> lanyardSafetyHarnessImages;

  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  Extra ({
    this.id = 0,
    required this.ladder,
    required this.ladderComments,
    List<ImageEvidence>? ladderImages,
    required this.stepLadder,
    required this.stepLadderComments,
    List<ImageEvidence>? stepLadderImages,
    required this.ladderStraps,
    required this.ladderStrapsComments,
    List<ImageEvidence>? ladderStrapsImages,
    required this.hydraulicFluidForBucket,
    required this.hydraulicFluidForBucketComments,
    List<ImageEvidence>? hydraulicFluidForBucketImages,
    required this.fiberReelRack,
    required this.fiberReelRackComments,
    List<ImageEvidence>? fiberReelRackImages,
    required this.binsLockedAndSecure,
    required this.binsLockedAndSecureComments,
    List<ImageEvidence>? binsLockedAndSecureImages,
    required this.safetyHarness,
    required this.safetyHarnessComments,
    List<ImageEvidence>? safetyHarnessImages,
    required this.lanyardSafetyHarness,
    required this.lanyardSafetyHarnessComments,
    List<ImageEvidence>? lanyardSafetyHarnessImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Equipment {
  int id;
  String ignitionKey;
  String ignitionKeyComments;
  late List<ImageEvidence> ignitionKeyImages;
  String binsBoxKey;
  String binsBoxKeyComments;
  late List<ImageEvidence> binsBoxKeyImages;
  String vehicleRegistrationCopy;
  String vehicleRegistrationCopyComments;
  late List<ImageEvidence> vehicleRegistrationCopyImages;
  String vehicleInsuranceCopy;
  String vehicleInsuranceCopyComments;
  late List<ImageEvidence> vehicleInsuranceCopyImages;
  String bucketLiftOperatorManual;
  String bucketLiftOperatorManualComments;
  late List<ImageEvidence> bucketLiftOperatorManualImages;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final controlForm = ToOne<ControlForm>();

  Equipment ({
    this.id = 0,
    required this.ignitionKey,
    required this.ignitionKeyComments,
    List<ImageEvidence>? ignitionKeyImages,
    required this.binsBoxKey,
    required this.binsBoxKeyComments,
    List<ImageEvidence>? binsBoxKeyImages,
    required this.vehicleRegistrationCopy,
    required this.vehicleRegistrationCopyComments,
    List<ImageEvidence>? vehicleRegistrationCopyImages,
    required this.vehicleInsuranceCopy,
    required this.vehicleInsuranceCopyComments,
    List<ImageEvidence>? vehicleInsuranceCopyImages,
    required this.bucketLiftOperatorManual,
    required this.bucketLiftOperatorManualComments,
    List<ImageEvidence>? bucketLiftOperatorManualImages,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}



@Entity()
class Vehicle {
  int id;
  String make;
  String model;
  String year;
  String image;
  String path;
  @Unique()
  String vin;
  @Unique()
  String licensePlates;
  String motor;
  String color;
  DateTime oilChangeDue;
  DateTime registrationDue;
  DateTime insuranceRenewalDue;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final status = ToOne<Status>();
  final company = ToOne<Company>();

  Vehicle({
    this.id = 0,
    required this.make,
    required this.model,
    required this.year,
    required this.image,
    required this.path,
    required this.vin,
    required this.licensePlates,
    required this.motor,
    required this.color,
    required this.oilChangeDue,
    required this.registrationDue,
    required this.insuranceRenewalDue,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Bitacora {
  int id;
  String usuarioPropietario;
  String instruccion;
  String? instruccionAdicional;
  int idControlForm;
  DateTime fechaRegistro;
  bool executeSupabase;
  final vehicle = ToOne<Vehicle>();
  final controlForm = ToOne<ControlForm>();
  final measures = ToOne<Measures>();
  final lights = ToOne<Lights>();
  final carBodywork = ToOne<CarBodywork>();
  final fluidsCheck = ToOne<FluidsCheck>();
  final bucketInspection = ToOne<BucketInspection>();
  final security = ToOne<Security>();
  final extra = ToOne<Extra>();
  final equipment = ToOne<Equipment>();
  final status = ToOne<Status>();
  final company = ToOne<Company>();
  final user = ToOne<Users>();
  @Backlink()
  final users = ToMany<Users>();

  Bitacora({
    this.id = 0,
    required this.usuarioPropietario,
    required this.instruccion,
    this.instruccionAdicional,
    required this.idControlForm,
    DateTime? fechaRegistro,
    this.executeSupabase = false,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  String get fechaRegistroFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(fechaRegistro);
}


@Entity()
class Users {
  int id;
  String name;
  String lastName;
  String? middleName;
  String? homePhone;
  String mobilePhone;
  String? address;
  String correo;
  String password;
  String? image;
  String? path;
  DateTime birthDate;
  DateTime dateAdded;
  @Unique()
  String idDBR;
  final bitacora = ToMany<Bitacora>();
  final role = ToOne<Role>();
  final roles = ToMany<Role>();
  final company = ToOne<Company>(); 
  final vehicle = ToOne<Vehicle>();
  @Backlink()
  final controlForms = ToMany<ControlForm>();
  
  Users({
    this.id = 0,
    required this.name,
    required this.lastName,
    this.middleName,
    this.homePhone,
    required this.mobilePhone,
    this.address,
    required this.correo,
    required this.password,
    this.image,
    this.path,
    required this.birthDate,
    DateTime? dateAdded,
    required this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}




