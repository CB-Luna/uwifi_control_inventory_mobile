import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
class DeliveryFormController extends ChangeNotifier {

  GlobalKey<FormState> deliveryFormKey = GlobalKey<FormState>();

  //***********************<Variables>************************
  //Extras
  int gasDieselPercent = 0; 
  TextEditingController mileageController = TextEditingController(); 

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

  String ignitionKey = "Good";
  String binsBoxKey = "Good";
  String vehicleRegistrationCopy = "Good";
  String vehicleInsuranceCopy = "Good";
  String bucketLiftOperatorManual = "Good";


  //Images
  List<String> gasImages = [];
  List<String> mileageImages = [];

  List<String> headLightsImages = [];
  List<String> brakeLightsImages = [];
  List<String> reverseLightsImages = [];
  List<String> warningLightsImages = [];
  List<String> turnSignalsImages = [];
  List<String> fourWayFlashersImages = [];
  List<String> dashLightsImages = [];
  List<String> strobeLightsImages = [];
  List<String> cabRoofLightsImages = [];
  List<String> clearenceLightsImages = [];

  List<String> wiperBladesFrontImages = [];
  List<String> wiperBladesBackImages = [];
  List<String> windshieldWiperFrontImages = [];
  List<String> windshieldWiperBackImages = [];
  List<String> generalBodyImages = [];
  List<String> decalingImages = [];
  List<String> tiresImages = [];
  List<String> glassImages = [];
  List<String> mirrorsImages = [];
  List<String> parkingImages = [];
  List<String> brakesImages = [];
  List<String> emgBrakesImages = [];
  List<String> hornImages = [];

  List<String> engineOilImages = [];
  List<String> transmissionImages = [];
  List<String> coolantImages = [];
  List<String> powerSteeringImages = [];
  List<String> dieselExhaustFluidImages = [];
  List<String> windshieldWasherFluidImages = [];
  
  List<String> insulatedImages = [];
  List<String> holesDrilledImages = [];
  List<String> bucketLinerImages = [];

  List<String> rtaMagnetImages = [];
  List<String> triangleReflectorsImages = [];
  List<String> wheelChocksImages = [];
  List<String> fireExtinguisherImages = [];
  List<String> firstAidKitSafetyVestImages = [];
  List<String> backUpAlarmImages = [];

  List<String> ladderImages = [];
  List<String> stepLadderImages = [];
  List<String> ladderStrapsImages = [];
  List<String> hydraulicFluidForBucketImages = [];
  List<String> fiberReelRackImages = [];
  List<String> binsLockedAndSecureImages = [];
  List<String> safetyHarnessImages = [];
  List<String> lanyardSafetyHarnessImages = [];

  List<String> ignitionKeyImages = [];
  List<String> binsBoxKeyImages = [];
  List<String> vehicleRegistrationCopyImages = [];
  List<String> vehicleInsuranceCopyImages = [];
  List<String> bucketLiftOperatorManualImages = [];

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
  void addGasImage(String image) {
    gasImages.add(image);
    notifyListeners();
  }
  void updateGasImage(String image) {
    gasImages.removeLast();
    gasImages.add(image);
    notifyListeners();
  }
  void addMileageImage(String image) {
    mileageImages.add(image);
    notifyListeners();
  }
  void updateMileageImage(String image) {
    mileageImages.removeLast();
    mileageImages.add(image);
    notifyListeners();
  }


  void addHeadLightsImage(String image) {
    headLightsImages.add(image);
    notifyListeners();
  }
  void updateHeadLightsImage(String image) {
    headLightsImages.removeLast();
    headLightsImages.add(image);
    notifyListeners();
  }
  void addBrakeLightsImage(String image) {
    brakeLightsImages.add(image);
    notifyListeners();
  }
  void updateBrakeLightsImage(String image) {
    brakeLightsImages.removeLast();
    brakeLightsImages.add(image);
    notifyListeners();
  }
  void addReverseLightsImage(String image) {
    reverseLightsImages.add(image);
    notifyListeners();
  }
  void updateReverseLightsImage(String image) {
    reverseLightsImages.removeLast();
    reverseLightsImages.add(image);
    notifyListeners();
  }
  void addWarningLightsImage(String image) {
    warningLightsImages.add(image);
    notifyListeners();
  }
  void updateWarningLightsImage(String image) {
    warningLightsImages.removeLast();
    warningLightsImages.add(image);
    notifyListeners();
  }
  void addTurnSignalsImage(String image) {
    turnSignalsImages.add(image);
    notifyListeners();
  }
  void updateTurnSignalsImage(String image) {
    turnSignalsImages.removeLast();
    turnSignalsImages.add(image);
    notifyListeners();
  }
  void addFourWayFlashersImage(String image) {
    fourWayFlashersImages.add(image);
    notifyListeners();
  }
  void updateFourWayFlashersImage(String image) {
    fourWayFlashersImages.removeLast();
    fourWayFlashersImages.add(image);
    notifyListeners();
  }
  void addDashLightsImage(String image) {
    dashLightsImages.add(image);
    notifyListeners();
  }
  void updateDashLightsImage(String image) {
    dashLightsImages.removeLast();
    dashLightsImages.add(image);
    notifyListeners();
  }
  void addStrobeLightsImage(String image) {
    strobeLightsImages.add(image);
    notifyListeners();
  }
  void updateStrobeLightsImage(String image) {
    strobeLightsImages.removeLast();
    strobeLightsImages.add(image);
    notifyListeners();
  }
  void addCabRoofLightsImage(String image) {
    cabRoofLightsImages.add(image);
    notifyListeners();
  }
  void updateCabRoofLightsImage(String image) {
    cabRoofLightsImages.removeLast();
    cabRoofLightsImages.add(image);
    notifyListeners();
  }
  void addClearenceLightsImage(String image) {
    clearenceLightsImages.add(image);
    notifyListeners();
  }
  void updateClearenceLightsImage(String image) {
    clearenceLightsImages.removeLast();
    clearenceLightsImages.add(image);
    notifyListeners();
  }


  void addWiperBladesFrontImage(String image) {
    wiperBladesFrontImages.add(image);
    notifyListeners();
  }
  void updateWiperBladesFrontImage(String image) {
    wiperBladesFrontImages.removeLast();
    wiperBladesFrontImages.add(image);
    notifyListeners();
  }
  void addWiperBladesBackImage(String image) {
    wiperBladesBackImages.add(image);
    notifyListeners();
  }
  void updateWiperBladesBackImage(String image) {
    wiperBladesBackImages.removeLast();
    wiperBladesBackImages.add(image);
    notifyListeners();
  }
  void addWindshieldWiperFrontImage(String image) {
    windshieldWiperFrontImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWiperFrontImage(String image) {
    windshieldWiperFrontImages.removeLast();
    windshieldWiperFrontImages.add(image);
    notifyListeners();
  }
  void addWindshieldWiperBackImage(String image) {
    windshieldWiperBackImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWiperBackImage(String image) {
    windshieldWiperBackImages.removeLast();
    windshieldWiperBackImages.add(image);
    notifyListeners();
  }
  void addGeneralBodyImage(String image) {
    generalBodyImages.add(image);
    notifyListeners();
  }
  void updateGeneralBodyImage(String image) {
    generalBodyImages.removeLast();
    generalBodyImages.add(image);
    notifyListeners();
  }
  void addDecalingImage(String image) {
    decalingImages.add(image);
    notifyListeners();
  }
  void updateDecalingImage(String image) {
    decalingImages.removeLast();
    decalingImages.add(image);
    notifyListeners();
  }
  void addTiresImage(String image) {
    tiresImages.add(image);
    notifyListeners();
  }
  void updateTiresImage(String image) {
    tiresImages.removeLast();
    tiresImages.add(image);
    notifyListeners();
  }
  void addGlassImage(String image) {
    glassImages.add(image);
    notifyListeners();
  }
  void updateGlassImage(String image) {
    glassImages.removeLast();
    glassImages.add(image);
    notifyListeners();
  }
  void addMirrorsImage(String image) {
    mirrorsImages.add(image);
    notifyListeners();
  }
  void updateMirrorsImage(String image) {
    mirrorsImages.removeLast();
    mirrorsImages.add(image);
    notifyListeners();
  }
  void addParkingImage(String image) {
    parkingImages.add(image);
    notifyListeners();
  }
  void updateParkingImage(String image) {
    parkingImages.removeLast();
    parkingImages.add(image);
    notifyListeners();
  }
  void addBrakesImage(String image) {
    brakesImages.add(image);
    notifyListeners();
  }
  void updateBrakesImage(String image) {
    brakesImages.removeLast();
    brakesImages.add(image);
    notifyListeners();
  }
  void addEMGBrakesImage(String image) {
    emgBrakesImages.add(image);
    notifyListeners();
  }
  void updateEMGBrakesImage(String image) {
    emgBrakesImages.removeLast();
    emgBrakesImages.add(image);
    notifyListeners();
  }
  void addHornImage(String image) {
    hornImages.add(image);
    notifyListeners();
  }
  void updateHornImage(String image) {
    hornImages.removeLast();
    hornImages.add(image);
    notifyListeners();
  }

  void addEngineOilImage(String image) {
    engineOilImages.add(image);
    notifyListeners();
  }
  void updateEngineOilImage(String image) {
    engineOilImages.removeLast();
    engineOilImages.add(image);
    notifyListeners();
  }
  void addTransmissionImage(String image) {
    transmissionImages.add(image);
    notifyListeners();
  }
  void updateTransmissionImage(String image) {
    transmissionImages.removeLast();
    transmissionImages.add(image);
    notifyListeners();
  }
  void addCoolantImage(String image) {
    coolantImages.add(image);
    notifyListeners();
  }
  void updateCoolantImage(String image) {
    coolantImages.removeLast();
    coolantImages.add(image);
    notifyListeners();
  }
  void addPowerSteeringImage(String image) {
    powerSteeringImages.add(image);
    notifyListeners();
  }
  void updatePowerSteeringImage(String image) {
    powerSteeringImages.removeLast();
    powerSteeringImages.add(image);
    notifyListeners();
  }
  void addDieselExhaustFluidImage(String image) {
    dieselExhaustFluidImages.add(image);
    notifyListeners();
  }
  void updateDieselExhaustFluidImage(String image) {
    dieselExhaustFluidImages.removeLast();
    dieselExhaustFluidImages.add(image);
    notifyListeners();
  }
  void addWindshieldWasherFluidImage(String image) {
    windshieldWasherFluidImages.add(image);
    notifyListeners();
  }
  void updateWindshieldWasherFluidImage(String image) {
    windshieldWasherFluidImages.removeLast();
    windshieldWasherFluidImages.add(image);
    notifyListeners();
  }

  void addInsulatedImage(String image) {
    insulatedImages.add(image);
    notifyListeners();
  }
  void updateInsulatedImage(String image) {
    insulatedImages.removeLast();
    insulatedImages.add(image);
    notifyListeners();
  }
  void addHolesDrilledImage(String image) {
    holesDrilledImages.add(image);
    notifyListeners();
  }
  void updateHolesDrilledImage(String image) {
    holesDrilledImages.removeLast();
    holesDrilledImages.add(image);
    notifyListeners();
  }
  void addBucketLinerImage(String image) {
    bucketLinerImages.add(image);
    notifyListeners();
  }
  void updateBucketLinerImage(String image) {
    bucketLinerImages.removeLast();
    bucketLinerImages.add(image);
    notifyListeners();
  }

  void addRTAMagnetImage(String image) {
    rtaMagnetImages.add(image);
    notifyListeners();
  }
  void updateRTAMagnetImage(String image) {
    rtaMagnetImages.removeLast();
    rtaMagnetImages.add(image);
    notifyListeners();
  }
  void addTriangleReflectorsImage(String image) {
    triangleReflectorsImages.add(image);
    notifyListeners();
  }
  void updateTriangleReflectorsImage(String image) {
    triangleReflectorsImages.removeLast();
    triangleReflectorsImages.add(image);
    notifyListeners();
  }
  void addWheelChocksImage(String image) {
    wheelChocksImages.add(image);
    notifyListeners();
  }
  void updateWheelChocksImage(String image) {
    wheelChocksImages.removeLast();
    wheelChocksImages.add(image);
    notifyListeners();
  }
  void addFireExtinguisherImage(String image) {
    fireExtinguisherImages.add(image);
    notifyListeners();
  }
  void updateFireExtinguisherImage(String image) {
    fireExtinguisherImages.removeLast();
    fireExtinguisherImages.add(image);
    notifyListeners();
  }
  void addFirstAidKitSafetyVestImage(String image) {
    firstAidKitSafetyVestImages.add(image);
    notifyListeners();
  }
  void updateFirstAidKitSafetyVestImage(String image) {
    firstAidKitSafetyVestImages.removeLast();
    firstAidKitSafetyVestImages.add(image);
    notifyListeners();
  }
  void addbackUpAlarmImage(String image) {
    backUpAlarmImages.add(image);
    notifyListeners();
  }
  void updatebackUpAlarmImage(String image) {
    backUpAlarmImages.removeLast();
    backUpAlarmImages.add(image);
    notifyListeners();
  }

  void addLadderImage(String image) {
    ladderImages.add(image);
    notifyListeners();
  }
  void updateLadderImage(String image) {
    ladderImages.removeLast();
    ladderImages.add(image);
    notifyListeners();
  }
  void addStepLadderImage(String image) {
    stepLadderImages.add(image);
    notifyListeners();
  }
  void updateStepLadderImage(String image) {
    stepLadderImages.removeLast();
    stepLadderImages.add(image);
    notifyListeners();
  }
  void addLadderStrapsImage(String image) {
    ladderStrapsImages.add(image);
    notifyListeners();
  }
  void updateLadderStrapsImage(String image) {
    ladderStrapsImages.removeLast();
    ladderStrapsImages.add(image);
    notifyListeners();
  }
  void addHydraulicFluidForBucketImage(String image) {
    hydraulicFluidForBucketImages.add(image);
    notifyListeners();
  }
  void updateHydraulicFluidForBucketImage(String image) {
    hydraulicFluidForBucketImages.removeLast();
    hydraulicFluidForBucketImages.add(image);
    notifyListeners();
  }
  void addFiberReelRackImage(String image) {
    fiberReelRackImages.add(image);
    notifyListeners();
  }
  void updateFiberReelRackImage(String image) {
    fiberReelRackImages.removeLast();
    fiberReelRackImages.add(image);
    notifyListeners();
  }
  void addBinsLockedAndSecureImage(String image) {
    binsLockedAndSecureImages.add(image);
    notifyListeners();
  }
  void updateBinsLockedAndSecureImage(String image) {
    binsLockedAndSecureImages.removeLast();
    binsLockedAndSecureImages.add(image);
    notifyListeners();
  }
  void addSafetyHarnessImage(String image) {
    safetyHarnessImages.add(image);
    notifyListeners();
  }
  void updateSafetyHarnessImage(String image) {
    safetyHarnessImages.removeLast();
    safetyHarnessImages.add(image);
    notifyListeners();
  }
  void addLanyardSafetyHarnessImage(String image) {
    lanyardSafetyHarnessImages.add(image);
    notifyListeners();
  }
  void updateLanyardSafetyHarnessImage(String image) {
    lanyardSafetyHarnessImages.removeLast();
    lanyardSafetyHarnessImages.add(image);
    notifyListeners();
  }

  void addIgnitionKeyImage(String image) {
    ignitionKeyImages.add(image);
    notifyListeners();
  }
  void updateIgnitionKeyImage(String image) {
    ignitionKeyImages.removeLast();
    ignitionKeyImages.add(image);
    notifyListeners();
  }
  void addBinsBoxKeyImage(String image) {
    binsBoxKeyImages.add(image);
    notifyListeners();
  }
  void updateBinsBoxKeyImage(String image) {
    binsBoxKeyImages.removeLast();
    binsBoxKeyImages.add(image);
    notifyListeners();
  }
  void addVehicleRegistrationCopyImage(String image) {
    vehicleRegistrationCopyImages.add(image);
    notifyListeners();
  }
  void updateVehicleRegistrationCopyImage(String image) {
    vehicleRegistrationCopyImages.removeLast();
    vehicleRegistrationCopyImages.add(image);
    notifyListeners();
  }
  void addVehicleInsuranceCopyImage(String image) {
    vehicleInsuranceCopyImages.add(image);
    notifyListeners();
  }
  void updateVehicleInsuranceCopyImage(String image) {
    vehicleInsuranceCopyImages.removeLast();
    vehicleInsuranceCopyImages.add(image);
    notifyListeners();
  }
  void addBucketLiftOperatorManualImage(String image) {
    bucketLiftOperatorManualImages.add(image);
    notifyListeners();
  }
  void updateBucketLiftOperatorManualImage(String image) {
    bucketLiftOperatorManualImages.removeLast();
    bucketLiftOperatorManualImages.add(image);
    notifyListeners();
  }

  void cleanInformation()
  {
    //Extras
    gasDieselPercent = 0;
    mileageController.clear();

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

    ignitionKey = "Good";
    binsBoxKey = "Good";
    vehicleRegistrationCopy = "Good";
    vehicleInsuranceCopy = "Good";
    bucketLiftOperatorManual = "Good";

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


  bool validateForm(GlobalKey<FormState> deliveryFormKey) {
    return deliveryFormKey.currentState!.validate() ? true : false;
  }


  
  bool add(Usuarios usuario, String medida) {
    // final nuevaOrdenTrabajo = OrdenTrabajo(
    //   fechaOrden: fechaOrden!,
    //   gasolina: "$gasDieselPercent %",
    //   kilometrajeMillaje: "$kilometrajeMillaje $medida",
    //   descripcionFalla: descripcionFalla,  
    //   completado: false,
    // );
    
    // final cliente = vehiculo?.cliente.target;
    // final formaPago = dataBase.formaPagoBox.get(idFormaPago!);
    if (true) {
      // //Recepción
      // final estatus = dataBase.estatusBox
      //     .query(Estatus_.estatus.equals("Recepción"))
      //     .build()
      //     .findFirst();
      // nuevaOrdenTrabajo.estatus.target = estatus;

      // nuevaOrdenTrabajo.cliente.target = cliente;
      // nuevaOrdenTrabajo.vehiculo.target = vehiculo;
      // // nuevaOrdenTrabajo.formaPago.target = formaPago;
      // nuevaOrdenTrabajo.asesor.target = usuario;
      // final idOrdenTrabajo = dataBase.ordenTrabajoBox.put(nuevaOrdenTrabajo); //Agregamos la orden de trabajo en objectBox
      // usuario.ordenesTrabajo.add(nuevaOrdenTrabajo);
      // dataBase.usuariosBox.put(usuario);

      // final nuevaInstruccion = Bitacora(
      //   instruccion: 'syncAgregarOrdenTrabajo',
      //   usuarioPropietario: prefs.getString("userId")!,
      //   idOrdenTrabajo: idOrdenTrabajo,
      // ); //Se crea la nueva instruccion a realizar en bitacora

      // nuevaInstruccion.ordenTrabajo.target = nuevaOrdenTrabajo; //Se asigna la orden de trabajo a la nueva instrucción
      // nuevaOrdenTrabajo.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a la orden de trabajo
      // dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox

      notifyListeners();
      return true;
    } 
    // else {
    //   notifyListeners();
    //   return false;
    // }
  }

}