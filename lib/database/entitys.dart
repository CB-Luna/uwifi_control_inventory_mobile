import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';

@Entity()
class ControlForm {
  int id;
  bool typeForm;
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
  List<String> gasImages;
  List<String> gasPath;
  int mileage;
  String mileageComments;
  List<String> mileageImages;
  List<String> mileagePath;
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
    required this.gasImages,
    required this.gasPath,
    required this.mileage,
    required this.mileageComments,
    required this.mileageImages,
    required this.mileagePath,
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
  List<String> headLightsImages;
  List<String> headLightsPath;
  String brakeLights;
  String brakeLightsComments;
  List<String> brakeLightsImages;
  List<String> brakeLightsPath;
  String reverseLights;
  String reverseLightsComments;
  List<String> reverseLightsImages;
  List<String> reverseLightsPath;
  String warningLights;
  String warningLightsComments;
  List<String> warningLightsImages;
  List<String> warningLightsPath;
  String turnSignals;
  String turnSignalsComments;
  List<String> turnSignalsImages;
  List<String> turnSignalsPath;
  String fourWayFlashers;
  String fourWayFlashersComments;
  List<String> fourWayFlashersImages;
  List<String> fourWayFlashersPath;
  String dashLights;
  String dashLightsComments;
  List<String> dashLightsImages;
  List<String> dashLightsPath;
  String strobeLights;
  String strobeLightsComments;
  List<String> strobeLightsImages;
  List<String> strobeLightsPath;
  String cabRoofLights;
  String cabRoofLightsComments;
  List<String> cabRoofLightsImages;
  List<String> cabRoofLightsPath;
  String clearanceLights;
  String clearanceLightsComments;
  List<String> clearanceLightsImages;
  List<String> clearanceLightsPath;
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
    required this.headLightsImages,
    required this.headLightsPath,
    required this.brakeLights,
    required this.brakeLightsComments,
    required this.brakeLightsImages,
    required this.brakeLightsPath,
    required this.reverseLights,
    required this.reverseLightsComments,
    required this.reverseLightsImages,
    required this.reverseLightsPath,
    required this.warningLights,
    required this.warningLightsComments,
    required this.warningLightsImages,
    required this.warningLightsPath,
    required this.turnSignals,
    required this.turnSignalsComments,
    required this.turnSignalsImages,
    required this.turnSignalsPath,
    required this.fourWayFlashers,
    required this.fourWayFlashersComments,
    required this.fourWayFlashersImages,
    required this.fourWayFlashersPath,
    required this.dashLights,
    required this.dashLightsComments,
    required this.dashLightsImages,
    required this.dashLightsPath,
    required this.strobeLights,
    required this.strobeLightsComments,
    required this.strobeLightsImages,
    required this.strobeLightsPath,
    required this.cabRoofLights,
    required this.cabRoofLightsComments,
    required this.cabRoofLightsImages,
    required this.cabRoofLightsPath,
    required this.clearanceLights,
    required this.clearanceLightsComments,
    required this.clearanceLightsImages,
    required this.clearanceLightsPath,
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
  List<String> wiperBladesFrontImages;
  List<String> wiperBladesFrontPath;
  String wiperBladesBack;
  String wiperBladesBackComments;
  List<String> wiperBladesBackImages;
  List<String> wiperBladesBackPath;
  String windshieldWiperFront;
  String windshieldWiperFrontComments;
  List<String> windshieldWiperFrontImages;
  List<String> windshieldWiperFrontPath;
  String windshieldWiperBack;
  String windshieldWiperBackComments;
  List<String> windshieldWiperBackImages;
  List<String> windshieldWiperBackPath;
  String generalBody;
  String generalBodyComments;
  List<String> generalBodyImages;
  List<String> generalBodyPath;
  String decaling;
  String decalingComments;
  List<String> decalingImages;
  List<String> decalingPath;
  String tires;
  String tiresComments;
  List<String> tiresImages;
  List<String> tiresPath;
  String glass;
  String glassComments;
  List<String> glassImages;
  List<String> glassPath;
  String mirrors;
  String mirrorsComments;
  List<String> mirrorsImages;
  List<String> mirrorsPath;
  String parking;
  String parkingComments;
  List<String> parkingImages;
  List<String> parkingPath;
  String brakes;
  String brakesComments;
  List<String> brakesImages;
  List<String> brakesPath;
  String emgBrakes;
  String emgBrakesComments;
  List<String> emgBrakesImages;
  List<String> emgBrakesPath;
  String horn;
  String hornComments;
  List<String> hornImages;
  List<String> hornPath;

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
    required this.wiperBladesFrontImages,
    required this.wiperBladesFrontPath,
    required this.wiperBladesBack,
    required this.wiperBladesBackComments,
    required this.wiperBladesBackImages,
    required this.wiperBladesBackPath,
    required this.windshieldWiperFront,
    required this.windshieldWiperFrontComments,
    required this.windshieldWiperFrontImages,
    required this.windshieldWiperFrontPath,
    required this.windshieldWiperBack,
    required this.windshieldWiperBackComments,
    required this.windshieldWiperBackImages,
    required this.windshieldWiperBackPath,
    required this.generalBody,
    required this.generalBodyComments,
    required this.generalBodyImages,
    required this.generalBodyPath,
    required this.decaling,
    required this.decalingComments,
    required this.decalingImages,
    required this.decalingPath,
    required this.tires,
    required this.tiresComments,
    required this.tiresImages,
    required this.tiresPath,
    required this.glass,
    required this.glassComments,
    required this.glassImages,
    required this.glassPath,
    required this.mirrors,
    required this.mirrorsComments,
    required this.mirrorsImages,
    required this.mirrorsPath,
    required this.parking,
    required this.parkingComments,
    required this.parkingImages,
    required this.parkingPath,
    required this.brakes,
    required this.brakesComments,
    required this.brakesImages,
    required this.brakesPath,
    required this.emgBrakes,
    required this.emgBrakesComments,
    required this.emgBrakesImages,
    required this.emgBrakesPath,
    required this.horn,
    required this.hornComments,
    required this.hornImages,
    required this.hornPath,
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
  List<String> engineOilImages;
  List<String> engineOilPath;
  String transmission;
  String transmissionComments;
  List<String> transmissionImages;
  List<String> transmissionPath;
  String coolant;
  String coolantComments;
  List<String> coolantImages;
  List<String> coolantPath;
  String powerSteering;
  String powerSteeringComments;
  List<String> powerSteeringImages;
  List<String> powerSteeringPath;
  String dieselExhaustFluid;
  String dieselExhaustFluidComments;
  List<String> dieselExhaustFluidImages;
  List<String> dieselExhaustFluidPath;
  String windshieldWasherFluid;
  String windshieldWasherFluidComments;
  List<String> windshieldWasherFluidImages;
  List<String> windshieldWasherFluidPath;
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
    required this.engineOilImages,
    required this.engineOilPath,
    required this.transmission,
    required this.transmissionComments,
    required this.transmissionImages,
    required this.transmissionPath,
    required this.coolant,
    required this.coolantComments,
    required this.coolantImages,
    required this.coolantPath,
    required this.powerSteering,
    required this.powerSteeringComments,
    required this.powerSteeringImages,
    required this.powerSteeringPath,
    required this.dieselExhaustFluid,
    required this.dieselExhaustFluidComments,
    required this.dieselExhaustFluidImages,
    required this.dieselExhaustFluidPath,
    required this.windshieldWasherFluid,
    required this.windshieldWasherFluidComments,
    required this.windshieldWasherFluidImages,
    required this.windshieldWasherFluidPath,
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
  List<String> insulatedImages;
  List<String> insulatedPath;
  String holesDrilled;
  String holesDrilledComments;
  List<String> holesDrilledImages;
  List<String> holesDrilledPath;
  String bucketLiner;
  String bucketLinerComments;
  List<String> bucketLinerImages;
  List<String> bucketLinerPath;

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
    required this.insulatedImages,
    required this.insulatedPath,
    required this.holesDrilled,
    required this.holesDrilledComments,
    required this.holesDrilledImages,
    required this.holesDrilledPath,
    required this.bucketLiner,
    required this.bucketLinerComments,
    required this.bucketLinerImages,
    required this.bucketLinerPath,
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
  List<String> rtaMagnetImages;
  List<String> rtaMagnetPath;
  String triangleReflectors;
  String triangleReflectorsComments;
  List<String> triangleReflectorsImages;
  List<String> triangleReflectorsPath;
  String wheelChocks;
  String wheelChocksComments;
  List<String> wheelChocksImages;
  List<String> wheelChocksPath;
  String fireExtinguisher;
  String fireExtinguisherComments;
  List<String> fireExtinguisherImages;
  List<String> fireExtinguisherPath;
  String firstAidKitSafetyVest;
  String firstAidKitSafetyVestComments;
  List<String> firstAidKitSafetyVestImages;
  List<String> firstAidKitSafetyVestPath;
  String backUpAlarm;
  String backUpAlarmComments;
  List<String> backUpAlarmImages;
  List<String> backUpAlarmPath;
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
    required this.rtaMagnetImages,
    required this.rtaMagnetPath,
    required this.triangleReflectors,
    required this.triangleReflectorsComments,
    required this.triangleReflectorsImages,
    required this.triangleReflectorsPath,
    required this.wheelChocks,
    required this.wheelChocksComments,
    required this.wheelChocksImages,
    required this.wheelChocksPath,
    required this.fireExtinguisher,
    required this.fireExtinguisherComments,
    required this.fireExtinguisherImages,
    required this.fireExtinguisherPath,
    required this.firstAidKitSafetyVest,
    required this.firstAidKitSafetyVestComments,
    required this.firstAidKitSafetyVestImages,
    required this.firstAidKitSafetyVestPath,
    required this.backUpAlarm,
    required this.backUpAlarmComments,
    required this.backUpAlarmImages,
    required this.backUpAlarmPath,
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
  List<String> ladderImages;
  List<String> ladderPath;
  String stepLadder;
  String stepLadderComments;
  List<String> stepLadderImages;
  List<String> stepLadderPath;
  String ladderStraps;
  String ladderStrapsComments;
  List<String> ladderStrapsImages;
  List<String> ladderStrapsPath;
  String hydraulicFluidForBucket;
  String hydraulicFluidForBucketComments;
  List<String> hydraulicFluidForBucketImages;
  List<String> hydraulicFluidForBucketPath;
  String fiberReelRack;
  String fiberReelRackComments;
  List<String> fiberReelRackImages;
  List<String> fiberReelRackPath;
  String binsLockedAndSecure;
  String binsLockedAndSecureComments;
  List<String> binsLockedAndSecureImages;
  List<String> binsLockedAndSecurePath;
  String safetyHarness;
  String safetyHarnessComments;
  List<String> safetyHarnessImages;
  List<String> safetyHarnessPath;
  String lanyardSafetyHarness;
  String lanyardSafetyHarnessComments;
  List<String> lanyardSafetyHarnessImages;
  List<String> lanyardSafetyHarnessPath;

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
    required this.ladderImages,
    required this.ladderPath,
    required this.stepLadder,
    required this.stepLadderComments,
    required this.stepLadderImages,
    required this.stepLadderPath,
    required this.ladderStraps,
    required this.ladderStrapsComments,
    required this.ladderStrapsImages,
    required this.ladderStrapsPath,
    required this.hydraulicFluidForBucket,
    required this.hydraulicFluidForBucketComments,
    required this.hydraulicFluidForBucketImages,
    required this.hydraulicFluidForBucketPath,
    required this.fiberReelRack,
    required this.fiberReelRackComments,
    required this.fiberReelRackImages,
    required this.fiberReelRackPath,
    required this.binsLockedAndSecure,
    required this.binsLockedAndSecureComments,
    required this.binsLockedAndSecureImages,
    required this.binsLockedAndSecurePath,
    required this.safetyHarness,
    required this.safetyHarnessComments,
    required this.safetyHarnessImages,
    required this.safetyHarnessPath,
    required this.lanyardSafetyHarness,
    required this.lanyardSafetyHarnessComments,
    required this.lanyardSafetyHarnessImages,
    required this.lanyardSafetyHarnessPath,
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
  List<String> ignitionKeyImages;
  List<String> ignitionKeyPath;
  String binsBoxKey;
  String binsBoxKeyComments;
  List<String> binsBoxKeyImages;
  List<String> binsBoxKeyPath;
  String vehicleRegistrationCopy;
  String vehicleRegistrationCopyComments;
  List<String> vehicleRegistrationCopyImages;
  List<String> vehicleRegistrationCopyPath;
  String vehicleInsuranceCopy;
  String vehicleInsuranceCopyComments;
  List<String> vehicleInsuranceCopyImages;
  List<String> vehicleInsuranceCopyPath;
  String bucketLiftOperatorManual;
  String bucketLiftOperatorManualComments;
  List<String> bucketLiftOperatorManualImages;
  List<String> bucketLiftOperatorManualPath;
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
    required this.ignitionKeyImages,
    required this.ignitionKeyPath,
    required this.binsBoxKey,
    required this.binsBoxKeyComments,
    required this.binsBoxKeyImages,
    required this.binsBoxKeyPath,
    required this.vehicleRegistrationCopy,
    required this.vehicleRegistrationCopyComments,
    required this.vehicleRegistrationCopyImages,
    required this.vehicleRegistrationCopyPath,
    required this.vehicleInsuranceCopy,
    required this.vehicleInsuranceCopyComments,
    required this.vehicleInsuranceCopyImages,
    required this.vehicleInsuranceCopyPath,
    required this.bucketLiftOperatorManual,
    required this.bucketLiftOperatorManualComments,
    required this.bucketLiftOperatorManualImages,
    required this.bucketLiftOperatorManualPath,
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




