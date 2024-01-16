import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ControlForm {
  int id;
  DateTime dateAddedR;
  DateTime? dateAddedD;
  @Unique()
  String? idDBR;
  int issuesR;
  int? issuesD;
  final employee = ToOne<Users>();
  final vehicle = ToOne<Vehicle>();
  final measuresR = ToOne<Measures>();
  final lightsR = ToOne<Lights>();
  final carBodyworkR = ToOne<CarBodywork>();
  final fluidsCheckR = ToOne<FluidsCheck>();
  final bucketInspectionR = ToOne<BucketInspection>();
  final securityR = ToOne<Security>();
  final extraR = ToOne<Extra>();
  final equipmentR = ToOne<Equipment>();
  final measuresD = ToOne<Measures>();
  final lightsD = ToOne<Lights>();
  final carBodyworkD = ToOne<CarBodywork>();
  final fluidsCheckD = ToOne<FluidsCheck>();
  final bucketInspectionD = ToOne<BucketInspection>();
  final securityD = ToOne<Security>();
  final extraD = ToOne<Extra>();
  final equipmentD = ToOne<Equipment>();
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  ControlForm({
    this.id = 0,
    required this.issuesR,
    this.issuesD,
    DateTime? dateAddedR,
    this.dateAddedD,
    this.idDBR,
  }) : dateAddedR = dateAddedR ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAddedR);
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
  List<String> gasNames;
  int mileage;
  String mileageComments;
  List<String> mileageImages;
  List<String> mileagePath;
  List<String> mileageNames;
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
    required this.gasNames,
    required this.gasPath,
    required this.mileage,
    required this.mileageComments,
    required this.mileageImages,
    required this.mileageNames,
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
  List<String> headLightsNames;
  String brakeLights;
  String brakeLightsComments;
  List<String> brakeLightsImages;
  List<String> brakeLightsPath;
  List<String> brakeLightsNames;
  String reverseLights;
  String reverseLightsComments;
  List<String> reverseLightsImages;
  List<String> reverseLightsPath;
  List<String> reverseLightsNames;
  String warningLights;
  String warningLightsComments;
  List<String> warningLightsImages;
  List<String> warningLightsPath;
  List<String> warningLightsNames;
  String turnSignals;
  String turnSignalsComments;
  List<String> turnSignalsImages;
  List<String> turnSignalsPath;
  List<String> turnSignalsNames;
  String fourWayFlashers;
  String fourWayFlashersComments;
  List<String> fourWayFlashersImages;
  List<String> fourWayFlashersPath;
  List<String> fourWayFlashersNames;
  String dashLights;
  String dashLightsComments;
  List<String> dashLightsImages;
  List<String> dashLightsPath;
  List<String> dashLightsNames;
  String strobeLights;
  String strobeLightsComments;
  List<String> strobeLightsImages;
  List<String> strobeLightsPath;
  List<String> strobeLightsNames;
  String cabRoofLights;
  String cabRoofLightsComments;
  List<String> cabRoofLightsImages;
  List<String> cabRoofLightsPath;
  List<String> cabRoofLightsNames;
  String clearanceLights;
  String clearanceLightsComments;
  List<String> clearanceLightsImages;
  List<String> clearanceLightsPath;
  List<String> clearanceLightsNames;
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
    required this.headLightsNames,
    required this.brakeLights,
    required this.brakeLightsComments,
    required this.brakeLightsImages,
    required this.brakeLightsPath,
    required this.brakeLightsNames,
    required this.reverseLights,
    required this.reverseLightsComments,
    required this.reverseLightsImages,
    required this.reverseLightsPath,
    required this.reverseLightsNames,
    required this.warningLights,
    required this.warningLightsComments,
    required this.warningLightsImages,
    required this.warningLightsPath,
    required this.warningLightsNames,
    required this.turnSignals,
    required this.turnSignalsComments,
    required this.turnSignalsImages,
    required this.turnSignalsPath,
    required this.turnSignalsNames,
    required this.fourWayFlashers,
    required this.fourWayFlashersComments,
    required this.fourWayFlashersImages,
    required this.fourWayFlashersPath,
    required this.fourWayFlashersNames,
    required this.dashLights,
    required this.dashLightsComments,
    required this.dashLightsImages,
    required this.dashLightsPath,
    required this.dashLightsNames,
    required this.strobeLights,
    required this.strobeLightsComments,
    required this.strobeLightsImages,
    required this.strobeLightsPath,
    required this.strobeLightsNames,
    required this.cabRoofLights,
    required this.cabRoofLightsComments,
    required this.cabRoofLightsImages,
    required this.cabRoofLightsPath,
    required this.cabRoofLightsNames,
    required this.clearanceLights,
    required this.clearanceLightsComments,
    required this.clearanceLightsImages,
    required this.clearanceLightsPath,
    required this.clearanceLightsNames,
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
  List<String> wiperBladesFrontNames;
  String wiperBladesBack;
  String wiperBladesBackComments;
  List<String> wiperBladesBackImages;
  List<String> wiperBladesBackPath;
  List<String> wiperBladesBackNames;
  String windshieldWiperFront;
  String windshieldWiperFrontComments;
  List<String> windshieldWiperFrontImages;
  List<String> windshieldWiperFrontPath;
  List<String> windshieldWiperFrontNames;
  String windshieldWiperBack;
  String windshieldWiperBackComments;
  List<String> windshieldWiperBackImages;
  List<String> windshieldWiperBackPath;
  List<String> windshieldWiperBackNames;
  String generalBody;
  String generalBodyComments;
  List<String> generalBodyImages;
  List<String> generalBodyPath;
  List<String> generalBodyNames;
  String decaling;
  String decalingComments;
  List<String> decalingImages;
  List<String> decalingPath;
  List<String> decalingNames;
  String tires;
  String tiresComments;
  List<String> tiresImages;
  List<String> tiresPath;
  List<String> tiresNames;
  String glass;
  String glassComments;
  List<String> glassImages;
  List<String> glassPath;
  List<String> glassNames;
  String mirrors;
  String mirrorsComments;
  List<String> mirrorsImages;
  List<String> mirrorsPath;
  List<String> mirrorsNames;
  String parking;
  String parkingComments;
  List<String> parkingImages;
  List<String> parkingPath;
  List<String> parkingNames;
  String brakes;
  String brakesComments;
  List<String> brakesImages;
  List<String> brakesPath;
  List<String> brakesNames;
  String emgBrakes;
  String emgBrakesComments;
  List<String> emgBrakesImages;
  List<String> emgBrakesPath;
  List<String> emgBrakesNames;
  String horn;
  String hornComments;
  List<String> hornImages;
  List<String> hornPath;
  List<String> hornNames;

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
    required this.wiperBladesFrontNames,
    required this.wiperBladesBack,
    required this.wiperBladesBackComments,
    required this.wiperBladesBackImages,
    required this.wiperBladesBackPath,
    required this.wiperBladesBackNames,
    required this.windshieldWiperFront,
    required this.windshieldWiperFrontComments,
    required this.windshieldWiperFrontImages,
    required this.windshieldWiperFrontPath,
    required this.windshieldWiperFrontNames,
    required this.windshieldWiperBack,
    required this.windshieldWiperBackComments,
    required this.windshieldWiperBackImages,
    required this.windshieldWiperBackPath,
    required this.windshieldWiperBackNames,
    required this.generalBody,
    required this.generalBodyComments,
    required this.generalBodyImages,
    required this.generalBodyPath,
    required this.generalBodyNames,
    required this.decaling,
    required this.decalingComments,
    required this.decalingImages,
    required this.decalingPath,
    required this.decalingNames,
    required this.tires,
    required this.tiresComments,
    required this.tiresImages,
    required this.tiresPath,
    required this.tiresNames,
    required this.glass,
    required this.glassComments,
    required this.glassImages,
    required this.glassPath,
    required this.glassNames,
    required this.mirrors,
    required this.mirrorsComments,
    required this.mirrorsImages,
    required this.mirrorsPath,
    required this.mirrorsNames,
    required this.parking,
    required this.parkingComments,
    required this.parkingImages,
    required this.parkingPath,
    required this.parkingNames,
    required this.brakes,
    required this.brakesComments,
    required this.brakesImages,
    required this.brakesPath,
    required this.brakesNames,
    required this.emgBrakes,
    required this.emgBrakesComments,
    required this.emgBrakesImages,
    required this.emgBrakesPath,
    required this.emgBrakesNames,
    required this.horn,
    required this.hornComments,
    required this.hornImages,
    required this.hornPath,
    required this.hornNames,
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
  List<String> engineOilNames;
  String transmission;
  String transmissionComments;
  List<String> transmissionImages;
  List<String> transmissionPath;
  List<String> transmissionNames;
  String coolant;
  String coolantComments;
  List<String> coolantImages;
  List<String> coolantPath;
  List<String> coolantNames;
  String powerSteering;
  String powerSteeringComments;
  List<String> powerSteeringImages;
  List<String> powerSteeringPath;
  List<String> powerSteeringNames;
  String dieselExhaustFluid;
  String dieselExhaustFluidComments;
  List<String> dieselExhaustFluidImages;
  List<String> dieselExhaustFluidPath;
  List<String> dieselExhaustFluidNames;
  String windshieldWasherFluid;
  String windshieldWasherFluidComments;
  List<String> windshieldWasherFluidImages;
  List<String> windshieldWasherFluidPath;
  List<String> windshieldWasherFluidNames;
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
    required this.engineOilNames,
    required this.transmission,
    required this.transmissionComments,
    required this.transmissionImages,
    required this.transmissionPath,
    required this.transmissionNames,
    required this.coolant,
    required this.coolantComments,
    required this.coolantImages,
    required this.coolantPath,
    required this.coolantNames,
    required this.powerSteering,
    required this.powerSteeringComments,
    required this.powerSteeringImages,
    required this.powerSteeringPath,
    required this.powerSteeringNames,
    required this.dieselExhaustFluid,
    required this.dieselExhaustFluidComments,
    required this.dieselExhaustFluidImages,
    required this.dieselExhaustFluidPath,
    required this.dieselExhaustFluidNames,
    required this.windshieldWasherFluid,
    required this.windshieldWasherFluidComments,
    required this.windshieldWasherFluidImages,
    required this.windshieldWasherFluidPath,
    required this.windshieldWasherFluidNames,
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
  List<String> insulatedNames;
  String holesDrilled;
  String holesDrilledComments;
  List<String> holesDrilledImages;
  List<String> holesDrilledPath;
  List<String> holesDrilledNames;
  String bucketLiner;
  String bucketLinerComments;
  List<String> bucketLinerImages;
  List<String> bucketLinerPath;
  List<String> bucketLinerNames;

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
    required this.insulatedNames,
    required this.holesDrilled,
    required this.holesDrilledComments,
    required this.holesDrilledImages,
    required this.holesDrilledPath,
    required this.holesDrilledNames,
    required this.bucketLiner,
    required this.bucketLinerComments,
    required this.bucketLinerImages,
    required this.bucketLinerPath,
    required this.bucketLinerNames,
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
  List<String> rtaMagnetNames;
  String triangleReflectors;
  String triangleReflectorsComments;
  List<String> triangleReflectorsImages;
  List<String> triangleReflectorsPath;
  List<String> triangleReflectorsNames;
  String wheelChocks;
  String wheelChocksComments;
  List<String> wheelChocksImages;
  List<String> wheelChocksPath;
  List<String> wheelChocksNames;
  String fireExtinguisher;
  String fireExtinguisherComments;
  List<String> fireExtinguisherImages;
  List<String> fireExtinguisherPath;
  List<String> fireExtinguisherNames;
  String firstAidKitSafetyVest;
  String firstAidKitSafetyVestComments;
  List<String> firstAidKitSafetyVestImages;
  List<String> firstAidKitSafetyVestPath;
  List<String> firstAidKitSafetyVestNames;
  String backUpAlarm;
  String backUpAlarmComments;
  List<String> backUpAlarmImages;
  List<String> backUpAlarmPath;
  List<String> backUpAlarmNames;
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
    required this.rtaMagnetNames,
    required this.triangleReflectors,
    required this.triangleReflectorsComments,
    required this.triangleReflectorsImages,
    required this.triangleReflectorsPath,
    required this.triangleReflectorsNames,
    required this.wheelChocks,
    required this.wheelChocksComments,
    required this.wheelChocksImages,
    required this.wheelChocksPath,
    required this.wheelChocksNames,
    required this.fireExtinguisher,
    required this.fireExtinguisherComments,
    required this.fireExtinguisherImages,
    required this.fireExtinguisherPath,
    required this.fireExtinguisherNames,
    required this.firstAidKitSafetyVest,
    required this.firstAidKitSafetyVestComments,
    required this.firstAidKitSafetyVestImages,
    required this.firstAidKitSafetyVestPath,
    required this.firstAidKitSafetyVestNames,
    required this.backUpAlarm,
    required this.backUpAlarmComments,
    required this.backUpAlarmImages,
    required this.backUpAlarmPath,
    required this.backUpAlarmNames,
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
  List<String> ladderNames;
  String stepLadder;
  String stepLadderComments;
  List<String> stepLadderImages;
  List<String> stepLadderPath;
  List<String> stepLadderNames;
  String ladderStraps;
  String ladderStrapsComments;
  List<String> ladderStrapsImages;
  List<String> ladderStrapsPath;
  List<String> ladderStrapsNames;
  String hydraulicFluidForBucket;
  String hydraulicFluidForBucketComments;
  List<String> hydraulicFluidForBucketImages;
  List<String> hydraulicFluidForBucketPath;
  List<String> hydraulicFluidForBucketNames;
  String fiberReelRack;
  String fiberReelRackComments;
  List<String> fiberReelRackImages;
  List<String> fiberReelRackPath;
  List<String> fiberReelRackNames;
  String binsLockedAndSecure;
  String binsLockedAndSecureComments;
  List<String> binsLockedAndSecureImages;
  List<String> binsLockedAndSecurePath;
  List<String> binsLockedAndSecureNames;
  String safetyHarness;
  String safetyHarnessComments;
  List<String> safetyHarnessImages;
  List<String> safetyHarnessPath;
  List<String> safetyHarnessNames;
  String lanyardSafetyHarness;
  String lanyardSafetyHarnessComments;
  List<String> lanyardSafetyHarnessImages;
  List<String> lanyardSafetyHarnessPath;
  List<String> lanyardSafetyHarnessNames;

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
    required this.ladderNames,
    required this.stepLadder,
    required this.stepLadderComments,
    required this.stepLadderImages,
    required this.stepLadderPath,
    required this.stepLadderNames,
    required this.ladderStraps,
    required this.ladderStrapsComments,
    required this.ladderStrapsImages,
    required this.ladderStrapsPath,
    required this.ladderStrapsNames,
    required this.hydraulicFluidForBucket,
    required this.hydraulicFluidForBucketComments,
    required this.hydraulicFluidForBucketImages,
    required this.hydraulicFluidForBucketPath,
    required this.hydraulicFluidForBucketNames,
    required this.fiberReelRack,
    required this.fiberReelRackComments,
    required this.fiberReelRackImages,
    required this.fiberReelRackPath,
    required this.fiberReelRackNames,
    required this.binsLockedAndSecure,
    required this.binsLockedAndSecureComments,
    required this.binsLockedAndSecureImages,
    required this.binsLockedAndSecurePath,
    required this.binsLockedAndSecureNames,
    required this.safetyHarness,
    required this.safetyHarnessComments,
    required this.safetyHarnessImages,
    required this.safetyHarnessPath,
    required this.safetyHarnessNames,
    required this.lanyardSafetyHarness,
    required this.lanyardSafetyHarnessComments,
    required this.lanyardSafetyHarnessImages,
    required this.lanyardSafetyHarnessPath,
    required this.lanyardSafetyHarnessNames,
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
  List<String> ignitionKeyNames;
  String binsBoxKey;
  String binsBoxKeyComments;
  List<String> binsBoxKeyImages;
  List<String> binsBoxKeyPath;
  List<String> binsBoxKeyNames;
  String vehicleRegistrationCopy;
  String vehicleRegistrationCopyComments;
  List<String> vehicleRegistrationCopyImages;
  List<String> vehicleRegistrationCopyPath;
  List<String> vehicleRegistrationCopyNames;
  String vehicleInsuranceCopy;
  String vehicleInsuranceCopyComments;
  List<String> vehicleInsuranceCopyImages;
  List<String> vehicleInsuranceCopyPath;
  List<String> vehicleInsuranceCopyNames;
  String bucketLiftOperatorManual;
  String bucketLiftOperatorManualComments;
  List<String> bucketLiftOperatorManualImages;
  List<String> bucketLiftOperatorManualPath;
  List<String> bucketLiftOperatorManualNames;
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
    required this.ignitionKeyNames,
    required this.binsBoxKey,
    required this.binsBoxKeyComments,
    required this.binsBoxKeyImages,
    required this.binsBoxKeyPath,
    required this.binsBoxKeyNames,
    required this.vehicleRegistrationCopy,
    required this.vehicleRegistrationCopyComments,
    required this.vehicleRegistrationCopyImages,
    required this.vehicleRegistrationCopyPath,
    required this.vehicleRegistrationCopyNames,
    required this.vehicleInsuranceCopy,
    required this.vehicleInsuranceCopyComments,
    required this.vehicleInsuranceCopyImages,
    required this.vehicleInsuranceCopyPath,
    required this.vehicleInsuranceCopyNames,
    required this.bucketLiftOperatorManual,
    required this.bucketLiftOperatorManualComments,
    required this.bucketLiftOperatorManualImages,
    required this.bucketLiftOperatorManualPath,
    required this.bucketLiftOperatorManualNames,
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
  String? image;
  String? path;
  @Unique()
  String vin;
  @Unique()
  String licensePlates;
  String motor;
  String color;
  int mileage;
  DateTime? oilChangeDue;
  DateTime? lastTransmissionFluidChange;
  DateTime? lastRadiatorFluidChange;
  DateTime? lastTireChange;
  DateTime? lastBrakeChange;
  bool carWash;
  bool weeklyCheckUp;
  bool filterCheckTSM;
  DateTime dateAdded;
  
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  @Backlink()
  final vehicleServices = ToMany<VehicleServices>();
  final status = ToOne<Status>();
  final company = ToOne<Company>();

  //Rules
  final ruleOilChange = ToOne<Rule>();
  final ruleTransmissionFluidChange = ToOne<Rule>();
  final ruleRadiatorFluidChange = ToOne<Rule>();
  final ruleTireChange = ToOne<Rule>();
  final ruleBrakeChange = ToOne<Rule>();


  Vehicle({
    this.id = 0,
    required this.make,
    required this.model,
    required this.year,
    this.image,
    this.path,
    required this.vin,
    required this.licensePlates,
    required this.motor,
    required this.color,
    required this.mileage,
    this.oilChangeDue,
    this.lastTransmissionFluidChange,
    this.lastRadiatorFluidChange,
    this.lastTireChange,
    this.lastBrakeChange,
    required this.carWash,
    required this.weeklyCheckUp,
    required this.filterCheckTSM,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Rule {
  int id;
  String value;
  String registered;
  int lastMileageService;
  DateTime dateAdded;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final vehicle = ToOne<Vehicle>();

  Rule({
    this.id = 0,
    required this.value,
    required this.registered,
    required this.lastMileageService,
    DateTime? dateAdded,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Service {
  int id;
  String service;
  String description;
  DateTime dateAdded;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();

  Service({
    this.id = 0,
    required this.service,
    required this.description,
    DateTime? dateAdded,
    this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class VehicleServices {
  int id;
  bool completed;
  DateTime? serviceDate;
  DateTime dateAdded;
  int? mileageRemaining;
  @Unique()
  String? idDBR;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final vehicle = ToOne<Vehicle>();
  final service = ToOne<Service>();

  VehicleServices({
    this.id = 0,
    required this.completed,
    this.serviceDate,
    DateTime? dateAdded,
    this.mileageRemaining,
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
  final service = ToOne<Service>();
  final vehicleService = ToOne<VehicleServices>();
  final rule = ToOne<Rule>();
  final email = ToOne<Email>();
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
  String? mobilePhone;
  String address;
  String correo;
  String password;
  String? image;
  String? nameImage;
  String? path;
  DateTime? birthDate;
  DateTime dateAdded;
  int recordsMonthCurrentR;
  int recordsMonthSecondR;
  int recordsMonthThirdR;
  int recordsMonthCurrentD;
  int recordsMonthSecondD;
  int recordsMonthThirdD;
  @Unique()
  String idDBR;
  final bitacora = ToMany<Bitacora>();
  final role = ToOne<Role>();
  final roles = ToMany<Role>();
  final company = ToOne<Company>(); 
  final vehicle = ToOne<Vehicle>();
  final emails = ToMany<Email>();
  @Backlink()
  final controlForms = ToMany<ControlForm>();
  final actualControlForm = ToOne<ControlForm>();
  
  Users({
    this.id = 0,
    required this.name,
    required this.lastName,
    this.middleName,
    this.homePhone,
    this.mobilePhone,
    required this.address,
    required this.correo,
    required this.password,
    this.image,
    this.nameImage,
    this.path,
    this.birthDate,
    DateTime? dateAdded,
    required this.recordsMonthCurrentR,
    required this.recordsMonthSecondR,
    required this.recordsMonthThirdR,
    required this.recordsMonthCurrentD,
    required this.recordsMonthSecondD,
    required this.recordsMonthThirdD,
    required this.idDBR,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}

@Entity()
class Email {
  int id;
  String url;
  String body;
  DateTime dateAdded;
  @Backlink()
  final bitacora = ToMany<Bitacora>();
  final user = ToOne<Users>();

  Email({
    this.id = 0,
    required this.url,
    required this.body,
    DateTime? dateAdded,
  }) : dateAdded = dateAdded ?? DateTime.now();

  String get dateAddedFormat =>
      DateFormat('dd.MM.yyyy hh:mm:ss').format(dateAdded);
}



