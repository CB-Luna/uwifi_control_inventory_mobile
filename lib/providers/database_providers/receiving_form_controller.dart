import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/database/image.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
class ReceivingFormController extends ChangeNotifier {

  GlobalKey<FormState> receivingFormKey = GlobalKey<FormState>();

  //***********************<Variables>************************
  //Extras
  int gasDieselPercent = 0; 
  bool isGasRegistered = false;
  String mileage = ""; 
  bool isMileageRegistered = false;

  //Reports
  String headLights = "Good";
  String brakeLights = "Good";
  String reverseLights = "Good";
  String warningLights = "Good";
  String turnSignals = "Good";
  String fourWayFlashers = "Good";
  String dashLights = "Good";
  String strobeLights = "Good";
  String cabRoofLights = "Good";
  String clearenceLights = "Good";

  String wiperBladesFront = "Good";
  String wiperBladesBack = "Good";
  String windshieldWiperFront = "Good";
  String windshieldWiperBack = "Good";
  String generalBody = "Good";
  String decaling = "Good";
  String tires = "Good";
  String glass = "Good";
  String mirrors = "Good";
  String parking = "Good";
  String brakes = "Good";
  String emgBrakes = "Good";
  String horn = "Good";

  String engineOil = "Good";
  String transmission = "Good";
  String coolant = "Good";
  String powerSteering = "Good";
  String dieselExhaustFluid = "Good";
  String windshieldWasherFluid = "Good";

  String insulated = "Good";
  String holesDrilled = "Good";
  String bucketLiner = "Good";

  String rtaMagnet = "Good";
  String triangleReflectors = "Good";
  String wheelChocks = "Good";
  String fireExtinguisher = "Good";
  String firstAidKitSafetyVest = "Good";
  String backUpAlarm = "Good";

  String ladder = "Good";
  String stepLadder = "Good";
  String ladderStraps = "Good";
  String hydraulicFluidForBucket = "Good";
  String fiberReelRack = "Good";
  String binsLockedAndSecure = "Good";
  String safetyHarness = "Good";
  String lanyardSafetyHarness = "Good";

  String ignitionKey = "Yes";
  String binsBoxKey = "Yes";
  String vehicleRegistrationCopy = "Yes";
  String vehicleInsuranceCopy = "Yes";
  String bucketLiftOperatorManual = "Yes";


  //Images
  List<ImageEvidence> gasImages = [];
  List<ImageEvidence> mileageImages = [];

  List<ImageEvidence> headLightsImages = [];
  List<ImageEvidence> brakeLightsImages = [];
  List<ImageEvidence> reverseLightsImages = [];
  List<ImageEvidence> warningLightsImages = [];
  List<ImageEvidence> turnSignalsImages = [];
  List<ImageEvidence> fourWayFlashersImages = [];
  List<ImageEvidence> dashLightsImages = [];
  List<ImageEvidence> strobeLightsImages = [];
  List<ImageEvidence> cabRoofLightsImages = [];
  List<ImageEvidence> clearenceLightsImages = [];

  List<ImageEvidence> wiperBladesFrontImages = [];
  List<ImageEvidence> wiperBladesBackImages = [];
  List<ImageEvidence> windshieldWiperFrontImages = [];
  List<ImageEvidence> windshieldWiperBackImages = [];
  List<ImageEvidence> generalBodyImages = [];
  List<ImageEvidence> decalingImages = [];
  List<ImageEvidence> tiresImages = [];
  List<ImageEvidence> glassImages = [];
  List<ImageEvidence> mirrorsImages = [];
  List<ImageEvidence> parkingImages = [];
  List<ImageEvidence> brakesImages = [];
  List<ImageEvidence> emgBrakesImages = [];
  List<ImageEvidence> hornImages = [];

  List<ImageEvidence> engineOilImages = [];
  List<ImageEvidence> transmissionImages = [];
  List<ImageEvidence> coolantImages = [];
  List<ImageEvidence> powerSteeringImages = [];
  List<ImageEvidence> dieselExhaustFluidImages = [];
  List<ImageEvidence> windshieldWasherFluidImages = [];
  
  List<ImageEvidence> insulatedImages = [];
  List<ImageEvidence> holesDrilledImages = [];
  List<ImageEvidence> bucketLinerImages = [];

  List<ImageEvidence> rtaMagnetImages = [];
  List<ImageEvidence> triangleReflectorsImages = [];
  List<ImageEvidence> wheelChocksImages = [];
  List<ImageEvidence> fireExtinguisherImages = [];
  List<ImageEvidence> firstAidKitSafetyVestImages = [];
  List<ImageEvidence> backUpAlarmImages = [];

  List<ImageEvidence> ladderImages = [];
  List<ImageEvidence> stepLadderImages = [];
  List<ImageEvidence> ladderStrapsImages = [];
  List<ImageEvidence> hydraulicFluidForBucketImages = [];
  List<ImageEvidence> fiberReelRackImages = [];
  List<ImageEvidence> binsLockedAndSecureImages = [];
  List<ImageEvidence> safetyHarnessImages = [];
  List<ImageEvidence> lanyardSafetyHarnessImages = [];

  List<ImageEvidence> ignitionKeyImages = [];
  List<ImageEvidence> binsBoxKeyImages = [];
  List<ImageEvidence> vehicleRegistrationCopyImages = [];
  List<ImageEvidence> vehicleInsuranceCopyImages = [];
  List<ImageEvidence> bucketLiftOperatorManualImages = [];

  //Comments
  TextEditingController gasComments = TextEditingController();
  TextEditingController mileageComments = TextEditingController();

  TextEditingController headLightsComments = TextEditingController();
  TextEditingController brakeLightsComments = TextEditingController();
  TextEditingController reverseLightsComments = TextEditingController();
  TextEditingController warningLightsComments = TextEditingController();
  TextEditingController turnSignalsComments = TextEditingController();
  TextEditingController fourWayFlashersComments = TextEditingController();
  TextEditingController dashLightsComments = TextEditingController();
  TextEditingController strobeLightsComments = TextEditingController();
  TextEditingController cabRoofLightsComments = TextEditingController();
  TextEditingController clearenceLightsComments = TextEditingController();

  TextEditingController wiperBladesFrontComments = TextEditingController();
  TextEditingController wiperBladesBackComments = TextEditingController();
  TextEditingController windshieldWiperFrontComments = TextEditingController();
  TextEditingController windshieldWiperBackComments = TextEditingController();
  TextEditingController generalBodyComments = TextEditingController();
  TextEditingController decalingComments = TextEditingController();
  TextEditingController tiresComments = TextEditingController();
  TextEditingController glassComments = TextEditingController();
  TextEditingController mirrorsComments = TextEditingController();
  TextEditingController parkingComments = TextEditingController();
  TextEditingController brakesComments = TextEditingController();
  TextEditingController emgBrakesComments = TextEditingController();
  TextEditingController hornComments = TextEditingController();

  TextEditingController engineOilComments = TextEditingController();
  TextEditingController transmissionComments = TextEditingController();
  TextEditingController coolantComments = TextEditingController();
  TextEditingController powerSteeringComments = TextEditingController();
  TextEditingController dieselExhaustFluidComments = TextEditingController();
  TextEditingController windshieldWasherFluidComments = TextEditingController();
  
  TextEditingController insulatedComments = TextEditingController();
  TextEditingController holesDrilledComments = TextEditingController();
  TextEditingController bucketLinerComments = TextEditingController();

  TextEditingController rtaMagnetComments = TextEditingController();
  TextEditingController triangleReflectorsComments = TextEditingController();
  TextEditingController wheelChocksComments = TextEditingController();
  TextEditingController fireExtinguisherComments = TextEditingController();
  TextEditingController firstAidKitSafetyVestComments = TextEditingController();
  TextEditingController backUpAlarmComments = TextEditingController();

  TextEditingController ladderComments = TextEditingController();
  TextEditingController stepLadderComments = TextEditingController();
  TextEditingController ladderStrapsComments = TextEditingController();
  TextEditingController hydraulicFluidForBucketComments = TextEditingController();
  TextEditingController fiberReelRackComments = TextEditingController();
  TextEditingController binsLockedAndSecureComments = TextEditingController();
  TextEditingController safetyHarnessComments = TextEditingController();
  TextEditingController lanyardSafetyHarnessComments = TextEditingController();

  TextEditingController ignitionKeyComments = TextEditingController();
  TextEditingController binsBoxKeyComments = TextEditingController();
  TextEditingController vehicleRegistrationCopyComments = TextEditingController();
  TextEditingController vehicleInsuranceCopyComments = TextEditingController();
  TextEditingController bucketLiftOperatorManualComments = TextEditingController();


  //***********************<Functions>************************

  //Extras
  void updateGasDieselPercent(int value) {
    gasDieselPercent = value;
    isGasRegistered = true;
    notifyListeners();
  }

  void updateMileage(String value) {
    mileage = value;
    if (value == "" || value.isEmpty) {
      isMileageRegistered = false;
    } else {
      isMileageRegistered = true;
    }
    notifyListeners();
  }

  //Reports

  void updateHeadLights(String report) {
    headLights = report;
    notifyListeners();
  }
  void updateBrakeLights(String report) {
    brakeLights = report;
    notifyListeners();
  }
  void updateReverseLights(String report) {
    reverseLights = report;
    notifyListeners();
  }
  void updateWarningLights(String report) {
    warningLights = report;
    notifyListeners();
  }
  void updateTurnSignals(String report) {
    turnSignals = report;
    notifyListeners();
  }
  void updateFourWayFlashers(String report) {
    fourWayFlashers = report;
    notifyListeners();
  }
  void updateDashLights(String report) {
    dashLights = report;
    notifyListeners();
  }
  void updateStrobeLights(String report) {
    strobeLights = report;
    notifyListeners();
  }
  void updateCabRoofLights(String report) {
    cabRoofLights = report;
    notifyListeners();
  }
  void updateClearenceLights(String report) {
    clearenceLights = report;
    notifyListeners();
  }



  void updateWiperBladesFront(String report) {
    wiperBladesFront = report;
    notifyListeners();
  }
  void updateWiperBladesBack(String report) {
    wiperBladesBack = report;
    notifyListeners();
  }
  void updateWindshieldWiperFront(String report) {
    windshieldWiperFront = report;
    notifyListeners();
  }
  void updateWindshieldWiperBack(String report) {
    windshieldWiperBack = report;
    notifyListeners();
  }
  void updateGeneralBody(String report) {
    generalBody = report;
    notifyListeners();
  }
  void updateDecaling(String report) {
    decaling = report;
    notifyListeners();
  }
  void updateTires(String report) {
    tires = report;
    notifyListeners();
  }
  void updateGlass(String report) {
    glass = report;
    notifyListeners();
  }
  void updateMirrors(String report) {
    mirrors = report;
    notifyListeners();
  }
  void updateParking(String report) {
    parking = report;
    notifyListeners();
  }
  void updateBrakes(String report) {
    brakes = report;
    notifyListeners();
  }
  void updateEMGBrakes(String report) {
    emgBrakes = report;
    notifyListeners();
  }
  void updateHorn(String report) {
    horn = report;
    notifyListeners();
  }

  void updateEngineOil(String report) {
    engineOil = report;
    notifyListeners();
  }
  void updateTransmission(String report) {
    transmission = report;
    notifyListeners();
  }
  void updateCoolant(String report) {
    coolant = report;
    notifyListeners();
  }
  void updatePowerSteering(String report) {
    powerSteering = report;
    notifyListeners();
  }
  void updateDieselExhaustFluid(String report) {
    dieselExhaustFluid = report;
    notifyListeners();
  }
  void updateWindshieldWasherFluid(String report) {
    windshieldWasherFluid = report;
    notifyListeners();
  }

  void updateInsulated(String report) {
    insulated = report;
    notifyListeners();
  }
  void updateHolesDrilled(String report) {
    holesDrilled = report;
    notifyListeners();
  }
  void updateBucketLiner(String report) {
    bucketLiner = report;
    notifyListeners();
  }

  void updateRTAMagnet(String report) {
    rtaMagnet = report;
    notifyListeners();
  }
  void updateTriangleReflectors(String report) {
    triangleReflectors = report;
    notifyListeners();
  }
  void updateWheelChocks(String report) {
    wheelChocks = report;
    notifyListeners();
  }
  void updateFireExtinguisher(String report) {
    fireExtinguisher = report;
    notifyListeners();
  }
  void updateFirstAidKitSafetyVest(String report) {
    firstAidKitSafetyVest = report;
    notifyListeners();
  }
  void updateBackUpAlarm(String report) {
    backUpAlarm = report;
    notifyListeners();
  }

  void updateLadder(String report) {
    ladder = report;
    notifyListeners();
  }
  void updateStepLadder(String report) {
    stepLadder = report;
    notifyListeners();
  }
  void updateLadderStraps(String report) {
    ladderStraps = report;
    notifyListeners();
  }
  void updateHydraulicFluidForBucket(String report) {
    hydraulicFluidForBucket = report;
    notifyListeners();
  }
  void updateFiberReelRack(String report) {
    fiberReelRack = report;
    notifyListeners();
  }
  void updateBinsLockedAndSecure(String report) {
    binsLockedAndSecure = report;
    notifyListeners();
  }
  void updateSafetyHarness(String report) {
    safetyHarness = report;
    notifyListeners();
  }
  void updateLanyardSafetyHarness(String report) {
    lanyardSafetyHarness = report;
    notifyListeners();
  }

  void updateIgnitionKey(String report) {
    ignitionKey = report;
    notifyListeners();
  }
  void updateBinsBoxKey(String report) {
    binsBoxKey = report;
    notifyListeners();
  }
  void updateVehicleRegistrationCopy(String report) {
    vehicleRegistrationCopy = report;
    notifyListeners();
  }
  void updateVehicleInsuranceCopy(String report) {
    vehicleInsuranceCopy = report;
    notifyListeners();
  }
  void updateBucketLiftOperatorManual(String report) {
    bucketLiftOperatorManual = report;
    notifyListeners();
  }



  //Images
  void addGasImage(ImageEvidence image) {
    gasImages.add(image);
    notifyListeners();
  }
  void updateGasImage(ImageEvidence image) {
    gasImages.removeLast();
    gasImages.add(image);
    notifyListeners();
  }
  void addMileageImage(ImageEvidence image) {
    mileageImages.add(image);
    notifyListeners();
  }
  void updateMileageImage(ImageEvidence image) {
    mileageImages.removeLast();
    mileageImages.add(image);
    notifyListeners();
  }


  void addHeadLightsImage(ImageEvidence image) {
    headLightsImages.add(image);
    notifyListeners();
  }
  void updateHeadLightsImage(ImageEvidence image) {
    headLightsImages.removeLast();
    headLightsImages.add(image);
    notifyListeners();
  }
  void addBrakeLightsImage(ImageEvidence image) {
    brakeLightsImages.add(image);
    notifyListeners();
  }
  void updateBrakeLightsImage(ImageEvidence image) {
    brakeLightsImages.removeLast();
    brakeLightsImages.add(image);
    notifyListeners();
  }
  void addReverseLightsImage(ImageEvidence image) {
    reverseLightsImages.add(image);
    notifyListeners();
  }
  void updateReverseLightsImage(ImageEvidence image) {
    reverseLightsImages.removeLast();
    reverseLightsImages.add(image);
    notifyListeners();
  }
  void addWarningLightsImage(ImageEvidence image) {
    warningLightsImages.add(image);
    notifyListeners();
  }
  void updateWarningLightsImage(ImageEvidence image) {
    warningLightsImages.removeLast();
    warningLightsImages.add(image);
    notifyListeners();
  }
  void addTurnSignalsImage(ImageEvidence image) {
    turnSignalsImages.add(image);
    notifyListeners();
  }
  void updateTurnSignalsImage(ImageEvidence image) {
    turnSignalsImages.removeLast();
    turnSignalsImages.add(image);
    notifyListeners();
  }
  void addFourWayFlashersImage(ImageEvidence image) {
    fourWayFlashersImages.add(image);
    notifyListeners();
  }
  void updateFourWayFlashersImage(ImageEvidence image) {
    fourWayFlashersImages.removeLast();
    fourWayFlashersImages.add(image);
    notifyListeners();
  }
  void addDashLightsImage(ImageEvidence image) {
    dashLightsImages.add(image);
    notifyListeners();
  }
  void updateDashLightsImage(ImageEvidence image) {
    dashLightsImages.removeLast();
    dashLightsImages.add(image);
    notifyListeners();
  }
  void addStrobeLightsImage(ImageEvidence image) {
    strobeLightsImages.add(image);
    notifyListeners();
  }
  void updateStrobeLightsImage(ImageEvidence image) {
    strobeLightsImages.removeLast();
    strobeLightsImages.add(image);
    notifyListeners();
  }
  void addCabRoofLightsImage(ImageEvidence image) {
    cabRoofLightsImages.add(image);
    notifyListeners();
  }
  void updateCabRoofLightsImage(ImageEvidence image) {
    cabRoofLightsImages.removeLast();
    cabRoofLightsImages.add(image);
    notifyListeners();
  }
  void addClearenceLightsImage(ImageEvidence image) {
    clearenceLightsImages.add(image);
    notifyListeners();
  }
  void updateClearenceLightsImage(ImageEvidence image) {
    clearenceLightsImages.removeLast();
    clearenceLightsImages.add(image);
    notifyListeners();
  }


  void addWiperBladesFrontImage(ImageEvidence image) {
    wiperBladesFrontImages.add(image);
    notifyListeners();
  }
  void updateWiperBladesFrontImage(ImageEvidence image) {
    wiperBladesFrontImages.removeLast();
    wiperBladesFrontImages.add(image);
    notifyListeners();
  }
  void addWiperBladesBackImage(ImageEvidence image) {
    wiperBladesBackImages.add(image);
    notifyListeners();
  }
  void updateWiperBladesBackImage(ImageEvidence image) {
    wiperBladesBackImages.removeLast();
    wiperBladesBackImages.add(image);
    notifyListeners();
  }
  void addWindshieldWiperFrontImage(ImageEvidence image) {
    windshieldWiperFrontImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWiperFrontImage(ImageEvidence image) {
    windshieldWiperFrontImages.removeLast();
    windshieldWiperFrontImages.add(image);
    notifyListeners();
  }
  void addWindshieldWiperBackImage(ImageEvidence image) {
    windshieldWiperBackImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWiperBackImage(ImageEvidence image) {
    windshieldWiperBackImages.removeLast();
    windshieldWiperBackImages.add(image);
    notifyListeners();
  }
  void addGeneralBodyImage(ImageEvidence image) {
    generalBodyImages.add(image);
    notifyListeners();
  }
  void updateGeneralBodyImage(ImageEvidence image) {
    generalBodyImages.removeLast();
    generalBodyImages.add(image);
    notifyListeners();
  }
  void addDecalingImage(ImageEvidence image) {
    decalingImages.add(image);
    notifyListeners();
  }
  void updateDecalingImage(ImageEvidence image) {
    decalingImages.removeLast();
    decalingImages.add(image);
    notifyListeners();
  }
  void addTiresImage(ImageEvidence image) {
    tiresImages.add(image);
    notifyListeners();
  }
  void updateTiresImage(ImageEvidence image) {
    tiresImages.removeLast();
    tiresImages.add(image);
    notifyListeners();
  }
  void addGlassImage(ImageEvidence image) {
    glassImages.add(image);
    notifyListeners();
  }
  void updateGlassImage(ImageEvidence image) {
    glassImages.removeLast();
    glassImages.add(image);
    notifyListeners();
  }
  void addMirrorsImage(ImageEvidence image) {
    mirrorsImages.add(image);
    notifyListeners();
  }
  void updateMirrorsImage(ImageEvidence image) {
    mirrorsImages.removeLast();
    mirrorsImages.add(image);
    notifyListeners();
  }
  void addParkingImage(ImageEvidence image) {
    parkingImages.add(image);
    notifyListeners();
  }
  void updateParkingImage(ImageEvidence image) {
    parkingImages.removeLast();
    parkingImages.add(image);
    notifyListeners();
  }
  void addBrakesImage(ImageEvidence image) {
    brakesImages.add(image);
    notifyListeners();
  }
  void updateBrakesImage(ImageEvidence image) {
    brakesImages.removeLast();
    brakesImages.add(image);
    notifyListeners();
  }
  void addEMGBrakesImage(ImageEvidence image) {
    emgBrakesImages.add(image);
    notifyListeners();
  }
  void updateEMGBrakesImage(ImageEvidence image) {
    emgBrakesImages.removeLast();
    emgBrakesImages.add(image);
    notifyListeners();
  }
  void addHornImage(ImageEvidence image) {
    hornImages.add(image);
    notifyListeners();
  }
  void updateHornImage(ImageEvidence image) {
    hornImages.removeLast();
    hornImages.add(image);
    notifyListeners();
  }

  void addEngineOilImage(ImageEvidence image) {
    engineOilImages.add(image);
    notifyListeners();
  }
  void updateEngineOilImage(ImageEvidence image) {
    engineOilImages.removeLast();
    engineOilImages.add(image);
    notifyListeners();
  }
  void addTransmissionImage(ImageEvidence image) {
    transmissionImages.add(image);
    notifyListeners();
  }
  void updateTransmissionImage(ImageEvidence image) {
    transmissionImages.removeLast();
    transmissionImages.add(image);
    notifyListeners();
  }
  void addCoolantImage(ImageEvidence image) {
    coolantImages.add(image);
    notifyListeners();
  }
  void updateCoolantImage(ImageEvidence image) {
    coolantImages.removeLast();
    coolantImages.add(image);
    notifyListeners();
  }
  void addPowerSteeringImage(ImageEvidence image) {
    powerSteeringImages.add(image);
    notifyListeners();
  }
  void updatePowerSteeringImage(ImageEvidence image) {
    powerSteeringImages.removeLast();
    powerSteeringImages.add(image);
    notifyListeners();
  }
  void addDieselExhaustFluidImage(ImageEvidence image) {
    dieselExhaustFluidImages.add(image);
    notifyListeners();
  }
  void updateDieselExhaustFluidImage(ImageEvidence image) {
    dieselExhaustFluidImages.removeLast();
    dieselExhaustFluidImages.add(image);
    notifyListeners();
  }
  void addWindshieldWasherFluidImage(ImageEvidence image) {
    windshieldWasherFluidImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWasherFluidImage(ImageEvidence image) {
    windshieldWasherFluidImages.removeLast();
    windshieldWasherFluidImages.add(image);
    notifyListeners();
  }

  void addInsulatedImage(ImageEvidence image) {
    insulatedImages.add(image);
    notifyListeners();
  }
  void updateInsulatedImage(ImageEvidence image) {
    insulatedImages.removeLast();
    insulatedImages.add(image);
    notifyListeners();
  }
  void addHolesDrilledImage(ImageEvidence image) {
    holesDrilledImages.add(image);
    notifyListeners();
  }
  void updateHolesDrilledImage(ImageEvidence image) {
    holesDrilledImages.removeLast();
    holesDrilledImages.add(image);
    notifyListeners();
  }
  void addBucketLinerImage(ImageEvidence image) {
    bucketLinerImages.add(image);
    notifyListeners();
  }
  void updateBucketLinerImage(ImageEvidence image) {
    bucketLinerImages.removeLast();
    bucketLinerImages.add(image);
    notifyListeners();
  }

  void addRTAMagnetImage(ImageEvidence image) {
    rtaMagnetImages.add(image);
    notifyListeners();
  }
  void updateRTAMagnetImage(ImageEvidence image) {
    rtaMagnetImages.removeLast();
    rtaMagnetImages.add(image);
    notifyListeners();
  }
  void addTriangleReflectorsImage(ImageEvidence image) {
    triangleReflectorsImages.add(image);
    notifyListeners();
  }
  void updateTriangleReflectorsImage(ImageEvidence image) {
    triangleReflectorsImages.removeLast();
    triangleReflectorsImages.add(image);
    notifyListeners();
  }
  void addWheelChocksImage(ImageEvidence image) {
    wheelChocksImages.add(image);
    notifyListeners();
  }
  void updateWheelChocksImage(ImageEvidence image) {
    wheelChocksImages.removeLast();
    wheelChocksImages.add(image);
    notifyListeners();
  }
  void addFireExtinguisherImage(ImageEvidence image) {
    fireExtinguisherImages.add(image);
    notifyListeners();
  }
  void updateFireExtinguisherImage(ImageEvidence image) {
    fireExtinguisherImages.removeLast();
    fireExtinguisherImages.add(image);
    notifyListeners();
  }
  void addFirstAidKitSafetyVestImage(ImageEvidence image) {
    firstAidKitSafetyVestImages.add(image);
    notifyListeners();
  }
  void updateFirstAidKitSafetyVestImage(ImageEvidence image) {
    firstAidKitSafetyVestImages.removeLast();
    firstAidKitSafetyVestImages.add(image);
    notifyListeners();
  }
  void addBackUpAlarmImage(ImageEvidence image) {
    backUpAlarmImages.add(image);
    notifyListeners();
  }
  void updateBackUpAlarmImage(ImageEvidence image) {
    backUpAlarmImages.removeLast();
    backUpAlarmImages.add(image);
    notifyListeners();
  }

  void addLadderImage(ImageEvidence image) {
    ladderImages.add(image);
    notifyListeners();
  }
  void updateLadderImage(ImageEvidence image) {
    ladderImages.removeLast();
    ladderImages.add(image);
    notifyListeners();
  }
  void addStepLadderImage(ImageEvidence image) {
    stepLadderImages.add(image);
    notifyListeners();
  }
  void updateStepLadderImage(ImageEvidence image) {
    stepLadderImages.removeLast();
    stepLadderImages.add(image);
    notifyListeners();
  }
  void addLadderStrapsImage(ImageEvidence image) {
    ladderStrapsImages.add(image);
    notifyListeners();
  }
  void updateLadderStrapsImage(ImageEvidence image) {
    ladderStrapsImages.removeLast();
    ladderStrapsImages.add(image);
    notifyListeners();
  }
  void addHydraulicFluidForBucketImage(ImageEvidence image) {
    hydraulicFluidForBucketImages.add(image);
    notifyListeners();
  }
  void updateHydraulicFluidForBucketImage(ImageEvidence image) {
    hydraulicFluidForBucketImages.removeLast();
    hydraulicFluidForBucketImages.add(image);
    notifyListeners();
  }
  void addFiberReelRackImage(ImageEvidence image) {
    fiberReelRackImages.add(image);
    notifyListeners();
  }
  void updateFiberReelRackImage(ImageEvidence image) {
    fiberReelRackImages.removeLast();
    fiberReelRackImages.add(image);
    notifyListeners();
  }
  void addBinsLockedAndSecureImage(ImageEvidence image) {
    binsLockedAndSecureImages.add(image);
    notifyListeners();
  }
  void updateBinsLockedAndSecureImage(ImageEvidence image) {
    binsLockedAndSecureImages.removeLast();
    binsLockedAndSecureImages.add(image);
    notifyListeners();
  }
  void addSafetyHarnessImage(ImageEvidence image) {
    safetyHarnessImages.add(image);
    notifyListeners();
  }
  void updateSafetyHarnessImage(ImageEvidence image) {
    safetyHarnessImages.removeLast();
    safetyHarnessImages.add(image);
    notifyListeners();
  }
  void addLanyardSafetyHarnessImage(ImageEvidence image) {
    lanyardSafetyHarnessImages.add(image);
    notifyListeners();
  }
  void updateLanyardSafetyHarnessImage(ImageEvidence image) {
    lanyardSafetyHarnessImages.removeLast();
    lanyardSafetyHarnessImages.add(image);
    notifyListeners();
  }

  void addIgnitionKeyImage(ImageEvidence image) {
    ignitionKeyImages.add(image);
    notifyListeners();
  }
  void updateIgnitionKeyImage(ImageEvidence image) {
    ignitionKeyImages.removeLast();
    ignitionKeyImages.add(image);
    notifyListeners();
  }
  void addBinsBoxKeyImage(ImageEvidence image) {
    binsBoxKeyImages.add(image);
    notifyListeners();
  }
  void updateBinsBoxKeyImage(ImageEvidence image) {
    binsBoxKeyImages.removeLast();
    binsBoxKeyImages.add(image);
    notifyListeners();
  }
  void addVehicleRegistrationCopyImage(ImageEvidence image) {
    vehicleRegistrationCopyImages.add(image);
    notifyListeners();
  }
  void updateVehicleRegistrationCopyImage(ImageEvidence image) {
    vehicleRegistrationCopyImages.removeLast();
    vehicleRegistrationCopyImages.add(image);
    notifyListeners();
  }
  void addVehicleInsuranceCopyImage(ImageEvidence image) {
    vehicleInsuranceCopyImages.add(image);
    notifyListeners();
  }
  void updateVehicleInsuranceCopyImage(ImageEvidence image) {
    vehicleInsuranceCopyImages.removeLast();
    vehicleInsuranceCopyImages.add(image);
    notifyListeners();
  }
  void addBucketLiftOperatorManualImage(ImageEvidence image) {
    bucketLiftOperatorManualImages.add(image);
    notifyListeners();
  }
  void updateBucketLiftOperatorManualImage(ImageEvidence image) {
    bucketLiftOperatorManualImages.removeLast();
    bucketLiftOperatorManualImages.add(image);
    notifyListeners();
  }

  void cleanInformation()
  {
    //Extras
    gasDieselPercent = 0;
    isGasRegistered = false;
    mileage = "";
    isMileageRegistered = false;

    //Reports
    brakeLights = "Good";
    reverseLights = "Good";
    warningLights = "Good";
    turnSignals = "Good";
    fourWayFlashers = "Good";
    dashLights = "Good";
    strobeLights = "Good";
    cabRoofLights = "Good";
    clearenceLights = "Good";

    wiperBladesFront = "Good";
    wiperBladesBack = "Good";
    windshieldWiperFront = "Good";
    windshieldWiperBack = "Good";
    generalBody = "Good";
    decaling = "Good";
    tires = "Good";
    glass = "Good";
    mirrors = "Good";
    parking = "Good";
    brakes = "Good";
    emgBrakes = "Good";
    horn = "Good";

    engineOil = "Good";
    transmission = "Good";
    coolant = "Good";
    powerSteering = "Good";
    dieselExhaustFluid = "Good";
    windshieldWasherFluid = "Good";

    insulated = "Good";
    holesDrilled = "Good";
    bucketLiner = "Good";

    rtaMagnet = "Good";
    triangleReflectors = "Good";
    wheelChocks = "Good";
    fireExtinguisher = "Good";
    firstAidKitSafetyVest = "Good";
    backUpAlarm = "Good";

    ladder = "Good";
    stepLadder = "Good";
    ladderStraps = "Good";
    hydraulicFluidForBucket = "Good";
    fiberReelRack = "Good";
    binsLockedAndSecure = "Good";
    safetyHarness = "Good";
    lanyardSafetyHarness = "Good";

    ignitionKey = "Yes";
    binsBoxKey = "Yes";
    vehicleRegistrationCopy = "Yes";
    vehicleInsuranceCopy = "Yes";
    bucketLiftOperatorManual = "Yes";

    //Images
    gasImages.clear();
    mileageImages.clear();
    headLightsImages.clear();
    brakeLightsImages.clear();
    reverseLightsImages.clear();
    warningLightsImages.clear();
    turnSignalsImages.clear();
    fourWayFlashersImages.clear();
    dashLightsImages.clear();
    strobeLightsImages.clear();
    cabRoofLightsImages.clear();
    clearenceLightsImages.clear();

    wiperBladesFrontImages.clear();
    wiperBladesBackImages.clear();
    windshieldWiperFrontImages.clear();
    windshieldWiperBackImages.clear();
    generalBodyImages.clear();
    decalingImages.clear();
    tiresImages.clear();
    glassImages.clear();
    mirrorsImages.clear();
    parkingImages.clear();
    brakesImages.clear();
    emgBrakesImages.clear();
    hornImages.clear();

    engineOilImages.clear();
    transmissionImages.clear();
    coolantImages.clear();
    powerSteeringImages.clear();
    dieselExhaustFluidImages.clear();
    windshieldWasherFluidImages.clear();
    
    insulatedImages.clear();
    holesDrilledImages.clear();
    bucketLinerImages.clear();

    rtaMagnetImages.clear();
    triangleReflectorsImages.clear();
    wheelChocksImages.clear();
    fireExtinguisherImages.clear();
    firstAidKitSafetyVestImages.clear();
    backUpAlarmImages.clear();

    ladderImages.clear();
    stepLadderImages.clear();
    ladderStrapsImages.clear();
    hydraulicFluidForBucketImages.clear();
    fiberReelRackImages.clear();
    binsLockedAndSecureImages.clear();
    safetyHarnessImages.clear();
    lanyardSafetyHarnessImages.clear();

    ignitionKeyImages = [];
    binsBoxKeyImages = [];
    vehicleRegistrationCopyImages = [];
    vehicleInsuranceCopyImages = [];
    bucketLiftOperatorManualImages = [];

    //Comments
    gasComments.clear();
    mileageComments.clear();

    headLightsComments.clear();
    brakeLightsComments.clear();
    reverseLightsComments.clear();
    warningLightsComments.clear();
    turnSignalsComments.clear();
    fourWayFlashersComments.clear();
    dashLightsComments.clear();
    strobeLightsComments.clear();
    cabRoofLightsComments.clear();
    clearenceLightsComments.clear();

    wiperBladesFrontComments.clear();
    wiperBladesBackComments.clear();
    windshieldWiperFrontComments.clear();
    windshieldWiperBackComments.clear();
    generalBodyComments.clear();
    decalingComments.clear();
    tiresComments.clear();
    glassComments.clear();
    mirrorsComments.clear();
    parkingComments.clear();
    brakesComments.clear();
    emgBrakesComments.clear();
    hornComments.clear();

    engineOilComments.clear();
    transmissionComments.clear();
    coolantComments.clear();
    powerSteeringComments.clear();
    dieselExhaustFluidComments.clear();
    windshieldWasherFluidComments.clear();
    
    insulatedComments.clear();
    holesDrilledComments.clear();
    bucketLinerComments.clear();

    rtaMagnetComments.clear();
    triangleReflectorsComments.clear();
    wheelChocksComments.clear();
    fireExtinguisherComments.clear();
    firstAidKitSafetyVestComments.clear();
    backUpAlarmComments.clear();

    ladderComments.clear();
    stepLadderComments.clear();
    ladderStrapsComments.clear();
    hydraulicFluidForBucketComments.clear();
    fiberReelRackComments.clear();
    binsLockedAndSecureComments.clear();
    safetyHarnessComments.clear();
    lanyardSafetyHarnessComments.clear();

    ignitionKeyComments.clear();
    binsBoxKeyComments.clear();
    vehicleRegistrationCopyComments.clear();
    vehicleInsuranceCopyComments.clear();
    bucketLiftOperatorManualComments.clear();

    notifyListeners();
  }


  bool validateForm() {
    if (isGasRegistered && isMileageRegistered) {
      return true;
    } else {
      return false;
    }
  }


  
  bool addControlForm(Usuarios? user) {
    try {
      final measures = Measures(
        gas: "$gasDieselPercent %", 
        gasComments: gasComments.text, 
        gasImages: gasImages,
        mileage: int.parse(mileage), 
        mileageComments: mileageComments.text,
        mileageImages: mileageImages,
      );

      final lights = Lights(
        headLights: headLights, 
        headLightsComments: headLightsComments.text, 
        headLightsImages: headLightsImages,
        brakeLights: brakeLights, 
        brakeLightsComments: brakeLightsComments.text, 
        brakeLightsImages: brakeLightsImages,
        reverseLights: reverseLights, 
        reverseLightsComments: reverseLightsComments.text, 
        reverseLightsImages: reverseLightsImages,
        warningLights: warningLights, 
        warningLightsComments: warningLightsComments.text, 
        warningLightsImages: warningLightsImages,
        turnSignals: turnSignals, 
        turnSignalsComments: turnSignalsComments.text, 
        turnSignalsImages: turnSignalsImages,
        fourWayFlashers: fourWayFlashers, 
        fourWayFlashersComments: fourWayFlashersComments.text, 
        fourWayFlashersImages: fourWayFlashersImages,
        dashLights: dashLights, 
        dashLightsComments: dashLightsComments.text, 
        dashLightsImages: dashLightsImages,
        strobeLights: strobeLights, 
        strobeLightsComments: strobeLightsComments.text, 
        strobeLightsImages: strobeLightsImages,
        cabRoofLights: cabRoofLights, 
        cabRoofLightsComments: cabRoofLightsComments.text, 
        cabRoofLightsImages: cabRoofLightsImages,
        clearenceLights: clearenceLights, 
        clearenceLightsComments: clearenceLightsComments.text, 
        clearenceLightsImages: clearenceLightsImages,
      );

      final carBodywork = CarBodywork(
        wiperBladesFront: wiperBladesFront, 
        wiperBladesFrontComments: wiperBladesFrontComments.text, 
        wiperBladesFrontImages: wiperBladesFrontImages,
        wiperBladesBack: wiperBladesBack, 
        wiperBladesBackComments: wiperBladesBackComments.text, 
        wiperBladesBackImages: wiperBladesBackImages,
        windshieldWiperFront: windshieldWiperFront, 
        windshieldWiperFrontComments: windshieldWiperFrontComments.text, 
        windshieldWiperFrontImages: windshieldWiperFrontImages,
        windshieldWiperBack: windshieldWiperBack, 
        windshieldWiperBackComments: windshieldWiperBackComments.text, 
        windshieldWiperBackImages: windshieldWiperBackImages,
        generalBody: generalBody, 
        generalBodyComments: generalBodyComments.text, 
        generalBodyImages: generalBodyImages,
        decaling: decaling, 
        decalingComments: decalingComments.text, 
        decalingImages: decalingImages,
        tires: tires, 
        tiresComments: tiresComments.text, 
        tiresImages: tiresImages,
        glass: glass, 
        glassComments: glassComments.text, 
        glassImages: glassImages,
        mirrors: mirrors, 
        mirrorsComments: mirrorsComments.text, 
        mirrorsImages: mirrorsImages,
        parking: parking, 
        parkingComments: parkingComments.text, 
        parkingImages: parkingImages,
        brakes: brakes, 
        brakesComments: brakesComments.text, 
        brakesImages: brakesImages,
        emgBrakes: emgBrakes, 
        emgBrakesComments: emgBrakesComments.text, 
        emgBrakesImages: emgBrakesImages,
        horn: horn, 
        hornComments: hornComments.text, 
        hornImages: hornImages,
      );

      final fluidsCheck = FluidsCheck(
        engineOil: engineOil, 
        engineOilComments: engineOilComments.text, 
        engineOilImages: engineOilImages,
        transmission: transmission, 
        transmissionComments: transmissionComments.text, 
        transmissionImages: transmissionImages,
        coolant: coolant, 
        coolantComments: coolantComments.text, 
        coolantImages: coolantImages,
        powerSteering: powerSteering, 
        powerSteeringComments: powerSteeringComments.text, 
        powerSteeringImages: powerSteeringImages,
        dieselExhaustFluid: dieselExhaustFluid, 
        dieselExhaustFluidComments: dieselExhaustFluidComments.text, 
        dieselExhaustFluidImages: dieselExhaustFluidImages,
        windshieldWasherFluid: windshieldWasherFluid, 
        windshieldWasherFluidComments: windshieldWasherFluidComments.text, 
        windshieldWasherFluidImages: windshieldWasherFluidImages,
      );

      final bucketInspection = BucketInspection(
        insulated: insulated, 
        insulatedComments: insulatedComments.text, 
        insulatedImages: insulatedImages,
        holesDrilled: holesDrilled, 
        holesDrilledComments: holesDrilledComments.text, 
        holesDrilledImages: holesDrilledImages,
        bucketLiner: bucketLiner, 
        bucketLinerComments: bucketLinerComments.text, 
        bucketLinerImages: bucketLinerImages,
      );

      final security = Security(
        rtaMagnet: rtaMagnet, 
        rtaMagnetComments: rtaMagnetComments.text, 
        rtaMagnetImages: rtaMagnetImages,
        triangleReflectors: triangleReflectors, 
        triangleReflectorsComments: triangleReflectorsComments.text, 
        triangleReflectorsImages: triangleReflectorsImages,
        wheelChocks: wheelChocks, 
        wheelChocksComments: wheelChocksComments.text, 
        wheelChocksImages: wheelChocksImages,
        fireExtinguisher: fireExtinguisher, 
        fireExtinguisherComments: fireExtinguisherComments.text, 
        fireExtinguisherImages: fireExtinguisherImages,
        firstAidKitSafetyVest: firstAidKitSafetyVest, 
        firstAidKitSafetyVestComments: firstAidKitSafetyVestComments.text, 
        firstAidKitSafetyVestImages: firstAidKitSafetyVestImages,
        backUpAlarm: backUpAlarm, 
        backUpAlarmComments: backUpAlarmComments.text, 
        backUpAlarmImages: backUpAlarmImages,
      );

      final extra = Extra(
        ladder: ladder, 
        ladderComments: ladderComments.text, 
        ladderImages: ladderImages,
        stepLadder: stepLadder, 
        stepLadderComments: stepLadderComments.text, 
        stepLadderImages: stepLadderImages,
        ladderStraps: ladderStraps, 
        ladderStrapsComments: ladderStrapsComments.text, 
        ladderStrapsImages: ladderStrapsImages,
        hydraulicFluidForBucket: hydraulicFluidForBucket, 
        hydraulicFluidForBucketComments: hydraulicFluidForBucketComments.text, 
        hydraulicFluidForBucketImages: hydraulicFluidForBucketImages,
        fiberReelRack: fiberReelRack, 
        fiberReelRackComments: fiberReelRackComments.text, 
        fiberReelRackImages: fiberReelRackImages,
        binsLockedAndSecure: binsLockedAndSecure, 
        binsLockedAndSecureComments: binsLockedAndSecureComments.text, 
        binsLockedAndSecureImages: binsLockedAndSecureImages,
        safetyHarness: safetyHarness, 
        safetyHarnessComments: safetyHarnessComments.text, 
        safetyHarnessImages: safetyHarnessImages,
        lanyardSafetyHarness: lanyardSafetyHarness, 
        lanyardSafetyHarnessComments: lanyardSafetyHarnessComments.text, 
        lanyardSafetyHarnessImages: lanyardSafetyHarnessImages,
      );

      final equipment = Equipment(
        ignitionKey: ignitionKey, 
        ignitionKeyComments: ignitionKeyComments.text, 
        ignitionKeyImages: ignitionKeyImages,
        binsBoxKey: binsBoxKey, 
        binsBoxKeyComments: binsBoxKeyComments.text, 
        binsBoxKeyImages: binsBoxKeyImages,
        vehicleRegistrationCopy: vehicleRegistrationCopy, 
        vehicleRegistrationCopyComments: vehicleRegistrationCopyComments.text, 
        vehicleRegistrationCopyImages: vehicleRegistrationCopyImages,
        vehicleInsuranceCopy: vehicleInsuranceCopy, 
        vehicleInsuranceCopyComments: vehicleInsuranceCopyComments.text, 
        vehicleInsuranceCopyImages: vehicleInsuranceCopyImages,
        bucketLiftOperatorManual: bucketLiftOperatorManual, 
        bucketLiftOperatorManualComments: bucketLiftOperatorManualComments.text, 
        bucketLiftOperatorManualImages: bucketLiftOperatorManualImages,
      );

      final controlForm = ControlForm(
        typeForm: true, //Receiving
      );
      
      final vehicle = user?.vehicle.target;

      if (user != null && vehicle != null) {
        //Measures
        measures.controlForm.target = controlForm;
        dataBase.measuresFormBox.put(measures);

        //Lights
        lights.controlForm.target = controlForm;
        dataBase.lightsFormBox.put(lights);

        //Car Bodywork
        carBodywork.controlForm.target = controlForm;
        dataBase.carBodyworkFormBox.put(carBodywork);
        
        //Fluids Check
        fluidsCheck.controlForm.target = controlForm;
        dataBase.fluidsCheckFormBox.put(fluidsCheck);

        //Bucket Inspection
        bucketInspection.controlForm.target = controlForm;
        dataBase.bucketInspectionFormBox.put(bucketInspection);

        //Security
        security.controlForm.target = controlForm;
        dataBase.securityFormBox.put(security);

        //Extra
        extra.controlForm.target = controlForm;
        dataBase.extraFormBox.put(extra);

        //Equipment
        equipment.controlForm.target = controlForm;
        dataBase.equipmentFormBox.put(equipment);
        
        //Control Form

        controlForm.measures.target = measures;
        controlForm.lights.target = lights;
        controlForm.carBodywork.target = carBodywork;
        controlForm.fluidsCheck.target = fluidsCheck;
        controlForm.bucketInspection.target = bucketInspection;
        controlForm.security.target = security;
        controlForm.extra.target = extra;
        controlForm.equipment.target = equipment;

        controlForm.vehicle.target = vehicle;
        controlForm.employee.target = user;

        final idControlForm = dataBase.controlFormBox.put(controlForm);

        //Employee
        user.controlForms.add(controlForm);
        dataBase.usuariosBox.put(user);

        final nuevaInstruccion = Bitacora(
          instruccion: 'syncAddControlForm',
          usuarioPropietario: prefs.getString("userId")!,
          idControlForm: idControlForm,
        ); //Se crea la nueva instruccion a realizar en bitacora

        nuevaInstruccion.controlForm.target = controlForm; //Se asigna la orden de trabajo a la nueva instrucción
        controlForm.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
        dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox

        notifyListeners();
        return true;
      } 
      else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

}