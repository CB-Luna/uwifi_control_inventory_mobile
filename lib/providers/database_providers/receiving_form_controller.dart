import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
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
  int pendingMeasures = 2;

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
  String clearanceLights = "Good";

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

  int badStateLights = 0;

  String engineOil = "Good";
  String transmission = "Good";
  String coolant = "Good";
  String powerSteering = "Good";
  String dieselExhaustFluid = "Good";
  String windshieldWasherFluid = "Good";

  String insulated = "Good";
  String holesDrilled = "Good";
  String bucketLiner = "Good";

  int badStateFluids = 0;

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

  int badStateSecurity = 0;

  String ignitionKey = "Yes";
  String binsBoxKey = "Yes";
  String vehicleRegistrationCopy = "Yes";
  String vehicleInsuranceCopy = "Yes";
  String bucketLiftOperatorManual = "Yes";

  int badStateEquipment = 0;


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
  List<ImageEvidence> clearanceLightsImages = [];

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
  TextEditingController clearanceLightsComments = TextEditingController();

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
    if (isGasRegistered == false) {
      if (pendingMeasures == 2 || pendingMeasures == 1) {
        pendingMeasures -= 1;
      }
    }
    isGasRegistered = true;
    notifyListeners();
  }

  void updateMileage(String value) {
    mileage = value;
    if (value == "" || value.isEmpty) {
      if (isMileageRegistered == true) {
        if (pendingMeasures == 0 || pendingMeasures == 1) {
          pendingMeasures += 1;
        }
      }
      isMileageRegistered = false;
    } else {
      if (isMileageRegistered == false) {
        if (pendingMeasures == 2 || pendingMeasures == 1) {
          pendingMeasures -= 1;
        }
      }
      isMileageRegistered = true;
    }
    notifyListeners();
  }

  //Reports

  void updateHeadLights(String report) {
    if (report == "Good") {
      if (headLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (headLights == "Good") {
        badStateLights += 1;
      }
    }
    headLights = report;
    notifyListeners();
  }
  void updateBrakeLights(String report) {
    if (report == "Good") {
      if (brakeLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (brakeLights == "Good") {
        badStateLights += 1;
      }
    }
    brakeLights = report;
    notifyListeners();
  }
  void updateReverseLights(String report) {
    if (report == "Good") {
      if (reverseLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (reverseLights == "Good") {
        badStateLights += 1;
      }
    }
    reverseLights = report;
    notifyListeners();
  }
  void updateWarningLights(String report) {
    if (report == "Good") {
      if (warningLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (warningLights == "Good") {
        badStateLights += 1;
      }
    }
    warningLights = report;
    notifyListeners();
  }
  void updateTurnSignals(String report) {
    if (report == "Good") {
      if (turnSignals == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (turnSignals == "Good") {
        badStateLights += 1;
      }
    }
    turnSignals = report;
    notifyListeners();
  }
  void updateFourWayFlashers(String report) {
    if (report == "Good") {
      if (fourWayFlashers == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (fourWayFlashers == "Good") {
        badStateLights += 1;
      }
    }
    fourWayFlashers = report;
    notifyListeners();
  }
  void updateDashLights(String report) {
    if (report == "Good") {
      if (dashLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (dashLights == "Good") {
        badStateLights += 1;
      }
    }
    dashLights = report;
    notifyListeners();
  }
  void updateStrobeLights(String report) {
    if (report == "Good") {
      if (strobeLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (strobeLights == "Good") {
        badStateLights += 1;
      }
    }
    strobeLights = report;
    notifyListeners();
  }
  void updateCabRoofLights(String report) {
    if (report == "Good") {
      if (cabRoofLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (cabRoofLights == "Good") {
        badStateLights += 1;
      }
    }
    cabRoofLights = report;
    notifyListeners();
  }
  void updateClearanceLights(String report) {
    if (report == "Good") {
      if (clearanceLights == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (clearanceLights == "Good") {
        badStateLights += 1;
      }
    }
    clearanceLights = report;
    notifyListeners();
  }



  void updateWiperBladesFront(String report) {
    if (report == "Good") {
      if (wiperBladesFront == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesFront == "Good") {
        badStateLights += 1;
      }
    }
    wiperBladesFront = report;
    notifyListeners();
  }
  void updateWiperBladesBack(String report) {
    if (report == "Good") {
      if (wiperBladesBack == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesBack == "Good") {
        badStateLights += 1;
      }
    }
    wiperBladesBack = report;
    notifyListeners();
  }
  void updateWindshieldWiperFront(String report) {
    if (report == "Good") {
      if (windshieldWiperFront == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperFront == "Good") {
        badStateLights += 1;
      }
    }
    windshieldWiperFront = report;
    notifyListeners();
  }
  void updateWindshieldWiperBack(String report) {
    if (report == "Good") {
      if (windshieldWiperBack == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperBack == "Good") {
        badStateLights += 1;
      }
    }
    windshieldWiperBack = report;
    notifyListeners();
  }
  void updateGeneralBody(String report) {
    if (report == "Good") {
      if (generalBody == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (generalBody == "Good") {
        badStateLights += 1;
      }
    }
    generalBody = report;
    notifyListeners();
  }
  void updateDecaling(String report) {
    if (report == "Good") {
      if (decaling == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (decaling == "Good") {
        badStateLights += 1;
      }
    }
    decaling = report;
    notifyListeners();
  }
  void updateTires(String report) {
    if (report == "Good") {
      if (tires == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (tires == "Good") {
        badStateLights += 1;
      }
    }
    tires = report;
    notifyListeners();
  }
  void updateGlass(String report) {
    if (report == "Good") {
      if (glass == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (glass == "Good") {
        badStateLights += 1;
      }
    }
    glass = report;
    notifyListeners();
  }
  void updateMirrors(String report) {
    if (report == "Good") {
      if (mirrors == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (mirrors == "Good") {
        badStateLights += 1;
      }
    }
    mirrors = report;
    notifyListeners();
  }
  void updateParking(String report) {
    if (report == "Good") {
      if (parking == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (parking == "Good") {
        badStateLights += 1;
      }
    }
    parking = report;
    notifyListeners();
  }
  void updateBrakes(String report) {
    if (report == "Good") {
      if (brakes== "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (brakes== "Good") {
        badStateLights += 1;
      }
    }
    brakes = report;
    notifyListeners();
  }
  void updateEMGBrakes(String report) {
    if (report == "Good") {
      if (emgBrakes == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (emgBrakes == "Good") {
        badStateLights += 1;
      }
    }
    emgBrakes = report;
    notifyListeners();
  }
  void updateHorn(String report) {
    if (report == "Good") {
      if (horn == "Bad") {
        badStateLights -= 1;
      }
    } else {
      if (horn == "Good") {
        badStateLights += 1;
      }
    }
    horn = report;
    notifyListeners();
  }

  void updateEngineOil(String report) {
    if (report == "Good") {
      if (engineOil == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (engineOil == "Good") {
        badStateFluids += 1;
      }
    }
    engineOil = report;
    notifyListeners();
  }
  void updateTransmission(String report) {
    if (report == "Good") {
      if (transmission== "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (transmission== "Good") {
        badStateFluids += 1;
      }
    }
    transmission = report;
    notifyListeners();
  }
  void updateCoolant(String report) {
    if (report == "Good") {
      if (coolant == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (coolant == "Good") {
        badStateFluids += 1;
      }
    }
    coolant = report;
    notifyListeners();
  }
  void updatePowerSteering(String report) {
    if (report == "Good") {
      if (powerSteering == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (powerSteering == "Good") {
        badStateFluids += 1;
      }
    }
    powerSteering = report;
    notifyListeners();
  }
  void updateDieselExhaustFluid(String report) {
    if (report == "Good") {
      if (dieselExhaustFluid == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (dieselExhaustFluid == "Good") {
        badStateFluids += 1;
      }
    }
    dieselExhaustFluid = report;
    notifyListeners();
  }
  void updateWindshieldWasherFluid(String report) {
    if (report == "Good") {
      if (windshieldWasherFluid == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (windshieldWasherFluid == "Good") {
        badStateFluids += 1;
      }
    }
    windshieldWasherFluid = report;
    notifyListeners();
  }

  void updateInsulated(String report) {
    if (report == "Good") {
      if (insulated == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (insulated == "Good") {
        badStateFluids += 1;
      }
    }
    insulated = report;
    notifyListeners();
  }
  void updateHolesDrilled(String report) {
    if (report == "Good") {
      if (holesDrilled == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (holesDrilled == "Good") {
        badStateFluids += 1;
      }
    }
    holesDrilled = report;
    notifyListeners();
  }
  void updateBucketLiner(String report) {
    if (report == "Good") {
      if (bucketLiner == "Bad") {
        badStateFluids -= 1;
      }
    } else {
      if (bucketLiner == "Good") {
        badStateFluids += 1;
      }
    }
    bucketLiner = report;
    notifyListeners();
  }

  void updateRTAMagnet(String report) {
    if (report == "Good") {
      if (rtaMagnet == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (rtaMagnet == "Good") {
        badStateSecurity += 1;
      }
    }
    rtaMagnet = report;
    notifyListeners();
  }
  void updateTriangleReflectors(String report) {
    if (report == "Good") {
      if (triangleReflectors == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (triangleReflectors == "Good") {
        badStateSecurity += 1;
      }
    }
    triangleReflectors = report;
    notifyListeners();
  }
  void updateWheelChocks(String report) {
    if (report == "Good") {
      if (wheelChocks == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (wheelChocks == "Good") {
        badStateSecurity += 1;
      }
    }
    wheelChocks = report;
    notifyListeners();
  }
  void updateFireExtinguisher(String report) {
    if (report == "Good") {
      if (fireExtinguisher == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (fireExtinguisher == "Good") {
        badStateSecurity += 1;
      }
    }
    fireExtinguisher = report;
    notifyListeners();
  }
  void updateFirstAidKitSafetyVest(String report) {
    if (report == "Good") {
      if (firstAidKitSafetyVest == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (firstAidKitSafetyVest == "Good") {
        badStateSecurity += 1;
      }
    }
    firstAidKitSafetyVest = report;
    notifyListeners();
  }
  void updateBackUpAlarm(String report) {
    if (report == "Good") {
      if (backUpAlarm == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (backUpAlarm == "Good") {
        badStateSecurity += 1;
      }
    }
    backUpAlarm = report;
    notifyListeners();
  }

  void updateLadder(String report) {
    if (report == "Good") {
      if (ladder == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (ladder == "Good") {
        badStateSecurity += 1;
      }
    }
    ladder = report;
    notifyListeners();
  }
  void updateStepLadder(String report) {
    if (report == "Good") {
      if (stepLadder == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (stepLadder == "Good") {
        badStateSecurity += 1;
      }
    }
    stepLadder = report;
    notifyListeners();
  }
  void updateLadderStraps(String report) {
    if (report == "Good") {
      if (ladderStraps == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (ladderStraps == "Good") {
        badStateSecurity += 1;
      }
    }
    ladderStraps = report;
    notifyListeners();
  }
  void updateHydraulicFluidForBucket(String report) {
    if (report == "Good") {
      if (hydraulicFluidForBucket == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (hydraulicFluidForBucket == "Good") {
        badStateSecurity += 1;
      }
    }
    hydraulicFluidForBucket = report;
    notifyListeners();
  }
  void updateFiberReelRack(String report) {
    if (report == "Good") {
      if (fiberReelRack == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (fiberReelRack == "Good") {
        badStateSecurity += 1;
      }
    }
    fiberReelRack = report;
    notifyListeners();
  }
  void updateBinsLockedAndSecure(String report) {
    if (report == "Good") {
      if (binsLockedAndSecure == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (binsLockedAndSecure == "Good") {
        badStateSecurity += 1;
      }
    }
    binsLockedAndSecure = report;
    notifyListeners();
  }
  void updateSafetyHarness(String report) {
    if (report == "Good") {
      if (safetyHarness == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (safetyHarness == "Good") {
        badStateSecurity += 1;
      }
    }
    safetyHarness = report;
    notifyListeners();
  }
  void updateLanyardSafetyHarness(String report) {
    if (report == "Good") {
      if (lanyardSafetyHarness == "Bad") {
        badStateSecurity -= 1;
      }
    } else {
      if (lanyardSafetyHarness == "Good") {
        badStateSecurity += 1;
      }
    }
    lanyardSafetyHarness = report;
    notifyListeners();
  }

  void updateIgnitionKey(String report) {
    if (report == "Yes") {
      if (ignitionKey == "No") {
        badStateEquipment -= 1;
      }
    } else {
      if (ignitionKey == "Yes") {
        badStateEquipment += 1;
      }
    }
    ignitionKey = report;
    notifyListeners();
  }
  void updateBinsBoxKey(String report) {
    if (report == "Yes") {
      if (binsBoxKey == "No") {
        badStateEquipment -= 1;
      }
    } else {
      if (binsBoxKey == "Yes") {
        badStateEquipment += 1;
      }
    }
    binsBoxKey = report;
    notifyListeners();
  }
  void updateVehicleRegistrationCopy(String report) {
    if (report == "Yes") {
      if (vehicleRegistrationCopy == "No") {
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleRegistrationCopy == "Yes") {
        badStateEquipment += 1;
      }
    }
    vehicleRegistrationCopy = report;
    notifyListeners();
  }
  void updateVehicleInsuranceCopy(String report) {
    if (report == "Yes") {
      if (vehicleInsuranceCopy == "No") {
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleInsuranceCopy == "Yes") {
        badStateEquipment += 1;
      }
    }
    vehicleInsuranceCopy = report;
    notifyListeners();
  }
  void updateBucketLiftOperatorManual(String report) {
    if (report == "Yes") {
      if (bucketLiftOperatorManual == "No") {
        badStateEquipment -= 1;
      }
    } else {
      if (bucketLiftOperatorManual == "Yes") {
        badStateEquipment += 1;
      }
    }
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
  void addClearanceLightsImage(ImageEvidence image) {
    clearanceLightsImages.add(image);
    notifyListeners();
  }
  void updateClearanceLightsImage(ImageEvidence image) {
    clearanceLightsImages.removeLast();
    clearanceLightsImages.add(image);
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
    pendingMeasures = 2;

    //Reports
    brakeLights = "Good";
    reverseLights = "Good";
    warningLights = "Good";
    turnSignals = "Good";
    fourWayFlashers = "Good";
    dashLights = "Good";
    strobeLights = "Good";
    cabRoofLights = "Good";
    clearanceLights = "Good";

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

    badStateLights = 0;

    engineOil = "Good";
    transmission = "Good";
    coolant = "Good";
    powerSteering = "Good";
    dieselExhaustFluid = "Good";
    windshieldWasherFluid = "Good";

    insulated = "Good";
    holesDrilled = "Good";
    bucketLiner = "Good";

    badStateFluids = 0;

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

    badStateSecurity = 0;

    ignitionKey = "Yes";
    binsBoxKey = "Yes";
    vehicleRegistrationCopy = "Yes";
    vehicleInsuranceCopy = "Yes";
    bucketLiftOperatorManual = "Yes";

    badStateEquipment = 0;

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
    clearanceLightsImages.clear();

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
    clearanceLightsComments.clear();

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

  List<String> getListImages(List<ImageEvidence> imagesEvidence) {
    List<String> listImages = [];
    for (var elementImage in imagesEvidence) {
        listImages.add(elementImage.base64);
      }
    return listImages;
  }

  List<String> getListPath(List<ImageEvidence> imagesEvidence) {
    List<String> listPath = [];
    for (var elementImage in imagesEvidence) {
        listPath.add(elementImage.path);
      }
    return listPath;
  }
  
  bool addControlForm(Users? user) {
    try {
      Measures measures = Measures(
        gas: "$gasDieselPercent%", 
        gasComments: gasComments.text,
        gasImages: getListImages(gasImages), 
        gasPath: getListPath(gasImages), 
        mileage: int.parse(mileage), 
        mileageComments: mileageComments.text,
        mileageImages: getListImages(mileageImages),
        mileagePath: getListPath(mileageImages),
      );


      final lights = Lights(
        headLights: headLights, 
        headLightsComments: headLightsComments.text, 
        headLightsImages: getListImages(headLightsImages), 
        headLightsPath: getListPath(headLightsImages), 
        brakeLights: brakeLights, 
        brakeLightsComments: brakeLightsComments.text, 
        brakeLightsImages: getListImages(brakeLightsImages), 
        brakeLightsPath: getListPath(brakeLightsImages), 
        reverseLights: reverseLights, 
        reverseLightsComments: reverseLightsComments.text, 
        reverseLightsImages: getListImages(reverseLightsImages), 
        reverseLightsPath: getListPath(reverseLightsImages), 
        warningLights: warningLights, 
        warningLightsComments: warningLightsComments.text, 
        warningLightsImages: getListImages(warningLightsImages), 
        warningLightsPath: getListPath(warningLightsImages), 
        turnSignals: turnSignals, 
        turnSignalsComments: turnSignalsComments.text, 
        turnSignalsImages: getListImages(turnSignalsImages), 
        turnSignalsPath: getListPath(turnSignalsImages), 
        fourWayFlashers: fourWayFlashers, 
        fourWayFlashersComments: fourWayFlashersComments.text, 
        fourWayFlashersImages: getListImages(fourWayFlashersImages), 
        fourWayFlashersPath: getListPath(fourWayFlashersImages), 
        dashLights: dashLights, 
        dashLightsComments: dashLightsComments.text, 
        dashLightsImages: getListImages(dashLightsImages), 
        dashLightsPath: getListPath(dashLightsImages), 
        strobeLights: strobeLights, 
        strobeLightsComments: strobeLightsComments.text, 
        strobeLightsImages: getListImages(strobeLightsImages), 
        strobeLightsPath: getListPath(strobeLightsImages), 
        cabRoofLights: cabRoofLights, 
        cabRoofLightsComments: cabRoofLightsComments.text, 
        cabRoofLightsImages: getListImages(cabRoofLightsImages), 
        cabRoofLightsPath: getListPath(cabRoofLightsImages),
        clearanceLights: clearanceLights, 
        clearanceLightsComments: clearanceLightsComments.text, 
        clearanceLightsImages: getListImages(clearanceLightsImages), 
        clearanceLightsPath: getListPath(clearanceLightsImages), 
      );

      final carBodywork = CarBodywork(
        wiperBladesFront: wiperBladesFront, 
        wiperBladesFrontComments: wiperBladesFrontComments.text, 
        wiperBladesFrontImages: getListImages(wiperBladesFrontImages), 
        wiperBladesFrontPath: getListPath(wiperBladesFrontImages), 
        wiperBladesBack: wiperBladesBack, 
        wiperBladesBackComments: wiperBladesBackComments.text, 
        wiperBladesBackImages: getListImages(wiperBladesBackImages), 
        wiperBladesBackPath: getListPath(wiperBladesBackImages), 
        windshieldWiperFront: windshieldWiperFront, 
        windshieldWiperFrontComments: windshieldWiperFrontComments.text, 
        windshieldWiperFrontImages: getListImages(windshieldWiperFrontImages), 
        windshieldWiperFrontPath: getListPath(windshieldWiperFrontImages), 
        windshieldWiperBack: windshieldWiperBack, 
        windshieldWiperBackComments: windshieldWiperBackComments.text, 
        windshieldWiperBackImages: getListImages(windshieldWiperBackImages), 
        windshieldWiperBackPath: getListPath(windshieldWiperBackImages), 
        generalBody: generalBody, 
        generalBodyComments: generalBodyComments.text, 
        generalBodyImages: getListImages(generalBodyImages), 
        generalBodyPath: getListPath(generalBodyImages), 
        decaling: decaling, 
        decalingComments: decalingComments.text, 
        decalingImages: getListImages(decalingImages), 
        decalingPath: getListPath(decalingImages), 
        tires: tires, 
        tiresComments: tiresComments.text, 
        tiresImages: getListImages(tiresImages), 
        tiresPath: getListPath(tiresImages), 
        glass: glass, 
        glassComments: glassComments.text, 
        glassImages: getListImages(glassImages), 
        glassPath: getListPath(glassImages), 
        mirrors: mirrors, 
        mirrorsComments: mirrorsComments.text, 
        mirrorsImages: getListImages(mirrorsImages), 
        mirrorsPath: getListPath(mirrorsImages), 
        parking: parking, 
        parkingComments: parkingComments.text, 
        parkingImages: getListImages(parkingImages), 
        parkingPath: getListPath(parkingImages), 
        brakes: brakes, 
        brakesComments: brakesComments.text, 
        brakesImages: getListImages(brakesImages), 
        brakesPath: getListPath(brakesImages),
        emgBrakes: emgBrakes, 
        emgBrakesComments: emgBrakesComments.text, 
        emgBrakesImages: getListImages(emgBrakesImages), 
        emgBrakesPath: getListPath(emgBrakesImages),
        horn: horn, 
        hornComments: hornComments.text, 
        hornImages: getListImages(hornImages), 
        hornPath: getListPath(hornImages),
      );

      final fluidsCheck = FluidsCheck(
        engineOil: engineOil, 
        engineOilComments: engineOilComments.text, 
        engineOilImages: getListImages(engineOilImages), 
        engineOilPath: getListPath(engineOilImages),
        transmission: transmission, 
        transmissionComments: transmissionComments.text, 
        transmissionImages: getListImages(transmissionImages), 
        transmissionPath: getListPath(transmissionImages),
        coolant: coolant, 
        coolantComments: coolantComments.text, 
        coolantImages: getListImages(coolantImages), 
        coolantPath: getListPath(coolantImages),
        powerSteering: powerSteering, 
        powerSteeringComments: powerSteeringComments.text, 
        powerSteeringImages: getListImages(powerSteeringImages), 
        powerSteeringPath: getListPath(parkingImages),
        dieselExhaustFluid: dieselExhaustFluid, 
        dieselExhaustFluidComments: dieselExhaustFluidComments.text, 
        dieselExhaustFluidImages: getListImages(dieselExhaustFluidImages), 
        dieselExhaustFluidPath: getListPath(dieselExhaustFluidImages),
        windshieldWasherFluid: windshieldWasherFluid, 
        windshieldWasherFluidComments: windshieldWasherFluidComments.text, 
        windshieldWasherFluidImages: getListImages(windshieldWasherFluidImages), 
        windshieldWasherFluidPath: getListPath(windshieldWasherFluidImages),
      );

      final bucketInspection = BucketInspection(
        insulated: insulated, 
        insulatedComments: insulatedComments.text, 
        insulatedImages: getListImages(insulatedImages), 
        insulatedPath: getListPath(insulatedImages),
        holesDrilled: holesDrilled, 
        holesDrilledComments: holesDrilledComments.text, 
        holesDrilledImages: getListImages(holesDrilledImages), 
        holesDrilledPath: getListPath(holesDrilledImages),
        bucketLiner: bucketLiner, 
        bucketLinerComments: bucketLinerComments.text, 
        bucketLinerImages: getListImages(bucketLinerImages), 
        bucketLinerPath: getListPath(bucketLinerImages),
      );

      final security = Security(
        rtaMagnet: rtaMagnet, 
        rtaMagnetComments: rtaMagnetComments.text, 
        rtaMagnetImages: getListImages(rtaMagnetImages), 
        rtaMagnetPath: getListPath(rtaMagnetImages),
        triangleReflectors: triangleReflectors, 
        triangleReflectorsComments: triangleReflectorsComments.text, 
        triangleReflectorsImages: getListImages(triangleReflectorsImages), 
        triangleReflectorsPath: getListPath(triangleReflectorsImages),
        wheelChocks: wheelChocks, 
        wheelChocksComments: wheelChocksComments.text, 
        wheelChocksImages: getListImages(wheelChocksImages), 
        wheelChocksPath: getListPath(wheelChocksImages),
        fireExtinguisher: fireExtinguisher, 
        fireExtinguisherComments: fireExtinguisherComments.text, 
        fireExtinguisherImages: getListImages(fireExtinguisherImages), 
        fireExtinguisherPath: getListPath(fireExtinguisherImages),
        firstAidKitSafetyVest: firstAidKitSafetyVest, 
        firstAidKitSafetyVestComments: firstAidKitSafetyVestComments.text, 
        firstAidKitSafetyVestImages: getListImages(firstAidKitSafetyVestImages), 
        firstAidKitSafetyVestPath: getListPath(firstAidKitSafetyVestImages),
        backUpAlarm: backUpAlarm, 
        backUpAlarmComments: backUpAlarmComments.text, 
        backUpAlarmImages: getListImages(backUpAlarmImages), 
        backUpAlarmPath: getListPath(backUpAlarmImages),
      );

      final extra = Extra(
        ladder: ladder, 
        ladderComments: ladderComments.text, 
        ladderImages: getListImages(ladderImages), 
        ladderPath: getListPath(ladderImages),
        stepLadder: stepLadder, 
        stepLadderComments: stepLadderComments.text, 
        stepLadderImages: getListImages(stepLadderImages), 
        stepLadderPath: getListPath(stepLadderImages),
        ladderStraps: ladderStraps, 
        ladderStrapsComments: ladderStrapsComments.text, 
        ladderStrapsImages: getListImages(ladderStrapsImages), 
        ladderStrapsPath: getListPath(ladderStrapsImages),
        hydraulicFluidForBucket: hydraulicFluidForBucket, 
        hydraulicFluidForBucketComments: hydraulicFluidForBucketComments.text, 
        hydraulicFluidForBucketImages: getListImages(hydraulicFluidForBucketImages), 
        hydraulicFluidForBucketPath: getListPath(hydraulicFluidForBucketImages),
        fiberReelRack: fiberReelRack, 
        fiberReelRackComments: fiberReelRackComments.text, 
        fiberReelRackImages: getListImages(fiberReelRackImages), 
        fiberReelRackPath: getListPath(fiberReelRackImages),
        binsLockedAndSecure: binsLockedAndSecure, 
        binsLockedAndSecureComments: binsLockedAndSecureComments.text, 
        binsLockedAndSecureImages: getListImages(binsLockedAndSecureImages), 
        binsLockedAndSecurePath: getListPath(binsLockedAndSecureImages),
        safetyHarness: safetyHarness, 
        safetyHarnessComments: safetyHarnessComments.text, 
        safetyHarnessImages: getListImages(safetyHarnessImages), 
        safetyHarnessPath: getListPath(safetyHarnessImages),
        lanyardSafetyHarness: lanyardSafetyHarness, 
        lanyardSafetyHarnessComments: lanyardSafetyHarnessComments.text, 
        lanyardSafetyHarnessImages: getListImages(lanyardSafetyHarnessImages), 
        lanyardSafetyHarnessPath: getListPath(lanyardSafetyHarnessImages),
      );

      final equipment = Equipment(
        ignitionKey: ignitionKey, 
        ignitionKeyComments: ignitionKeyComments.text, 
        ignitionKeyImages: getListImages(ignitionKeyImages), 
        ignitionKeyPath: getListPath(ignitionKeyImages),
        binsBoxKey: binsBoxKey, 
        binsBoxKeyComments: binsBoxKeyComments.text, 
        binsBoxKeyImages: getListImages(binsBoxKeyImages), 
        binsBoxKeyPath: getListPath(binsBoxKeyImages),
        vehicleRegistrationCopy: vehicleRegistrationCopy, 
        vehicleRegistrationCopyComments: vehicleRegistrationCopyComments.text, 
        vehicleRegistrationCopyImages: getListImages(vehicleRegistrationCopyImages), 
        vehicleRegistrationCopyPath: getListPath(vehicleRegistrationCopyImages),
        vehicleInsuranceCopy: vehicleInsuranceCopy, 
        vehicleInsuranceCopyComments: vehicleInsuranceCopyComments.text, 
        vehicleInsuranceCopyImages: getListImages(vehicleInsuranceCopyImages), 
        vehicleInsuranceCopyPath: getListPath(vehicleInsuranceCopyImages),
        bucketLiftOperatorManual: bucketLiftOperatorManual, 
        bucketLiftOperatorManualComments: bucketLiftOperatorManualComments.text, 
        bucketLiftOperatorManualImages: getListImages(bucketLiftOperatorManualImages), 
        bucketLiftOperatorManualPath: getListPath(bucketLiftOperatorManualImages),
      );

      final controlForm = ControlForm(
        issuesR: badStateLights + badStateFluids + badStateSecurity + badStateEquipment,
        today: true,
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

        controlForm.measuresR.target = measures;
        controlForm.lightsR.target = lights;
        controlForm.carBodyworkR.target = carBodywork;
        controlForm.fluidsCheckR.target = fluidsCheck;
        controlForm.bucketInspectionR.target = bucketInspection;
        controlForm.securityR.target = security;
        controlForm.extraR.target = extra;
        controlForm.equipmentR.target = equipment;

        controlForm.vehicle.target = vehicle;
        controlForm.employee.target = user;

        final idControlForm = dataBase.controlFormBox.put(controlForm);

        //Employee
        user.controlForms.add(controlForm);
        dataBase.usersBox.put(user);

        final nuevaInstruccion = Bitacora(
          instruccion: 'syncAddControlFormR',
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