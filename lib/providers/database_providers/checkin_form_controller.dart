import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:uuid/uuid.dart';

class CheckInFormController extends ChangeNotifier {

  GlobalKey<FormState> checkInFormKey = GlobalKey<FormState>();

  //***********************<Banderas Services>************************
  bool flagOilChange = false;
  bool flagTransmissionFluidChange = false;
  bool flagRadiatorFluidChange = false;

  List<String> issues = []; 
  TextEditingController from = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  //***********************<Variables>************************
  //Extras
  String gasDieselString = "Empty";
  int gasDieselPercent = 0; 
  bool isGasRegistered = false;
  String mileage = ""; 
  bool isMileageRegistered = false;
  int pendingMeasures = 2;
  Uuid uuid = Uuid();

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
    switch (value) {
      case 0:
        gasDieselString = "Empty";
        break;
      case 25:
        gasDieselString = "1/4";
        break;
      case 50:
        gasDieselString = "1/2";
        break;
      case 75:
        gasDieselString = "3/4";
        break;
      case 100:
        gasDieselString = "Full";
        break;
      default:
    }
    gasDieselPercent = value;
    if (isGasRegistered == false) {
      if (pendingMeasures >= 1) {
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
        if (pendingMeasures >= 0) {
          pendingMeasures += 1;
        }
      }
      isMileageRegistered = false;
    } else {
      if (isMileageRegistered == false) {
        if (pendingMeasures >= 1) {
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
        issues.remove("HeadLights");
        badStateLights -= 1;
      }
    } else {
      if (headLights == "Good") {
        issues.add("HeadLights");
        badStateLights += 1;
      }
    }
    headLights = report;
    notifyListeners();
  }
  void updateBrakeLights(String report) {
    if (report == "Good") {
      if (brakeLights == "Bad") {
        issues.remove("BrakeLights");
        badStateLights -= 1;
      }
    } else {
      if (brakeLights == "Good") {
        issues.add("BrakeLights");
        badStateLights += 1;
      }
    }
    brakeLights = report;
    notifyListeners();
  }
  void updateReverseLights(String report) {
    if (report == "Good") {
      if (reverseLights == "Bad") {
        issues.remove("ReverseLights");
        badStateLights -= 1;
      }
    } else {
      if (reverseLights == "Good") {
        issues.add("ReverseLights");
        badStateLights += 1;
      }
    }
    reverseLights = report;
    notifyListeners();
  }
  void updateWarningLights(String report) {
    if (report == "Good") {
      if (warningLights == "Bad") {
        issues.remove("WarningLights");
        badStateLights -= 1;
      }
    } else {
      if (warningLights == "Good") {
        issues.add("WarningLights");
        badStateLights += 1;
      }
    }
    warningLights = report;
    notifyListeners();
  }
  void updateTurnSignals(String report) {
    if (report == "Good") {
      if (turnSignals == "Bad") {
        issues.remove("TurnLights");
        badStateLights -= 1;
      }
    } else {
      if (turnSignals == "Good") {
        issues.add("TurnLights");
        badStateLights += 1;
      }
    }
    turnSignals = report;
    notifyListeners();
  }
  void updateFourWayFlashers(String report) {
    if (report == "Good") {
      if (fourWayFlashers == "Bad") {
        issues.remove("FourWay Flasher");
        badStateLights -= 1;
      }
    } else {
      if (fourWayFlashers == "Good") {
        issues.add("FourWay Flasher");
        badStateLights += 1;
      }
    }
    fourWayFlashers = report;
    notifyListeners();
  }
  void updateDashLights(String report) {
    if (report == "Good") {
      if (dashLights == "Bad") {
        issues.remove("DashLights");
        badStateLights -= 1;
      }
    } else {
      if (dashLights == "Good") {
        issues.add("DashLights");
        badStateLights += 1;
      }
    }
    dashLights = report;
    notifyListeners();
  }
  void updateStrobeLights(String report) {
    if (report == "Good") {
      if (strobeLights == "Bad") {
        issues.remove("Strobe Lights");
        badStateLights -= 1;
      }
    } else {
      if (strobeLights == "Good") {
        issues.add("Strobe Lights");
        badStateLights += 1;
      }
    }
    strobeLights = report;
    notifyListeners();
  }
  void updateCabRoofLights(String report) {
    if (report == "Good") {
      if (cabRoofLights == "Bad") {
        issues.remove("CabRoof Lights");
        badStateLights -= 1;
      }
    } else {
      if (cabRoofLights == "Good") {
        issues.add("CabRoof Lights");
        badStateLights += 1;
      }
    }
    cabRoofLights = report;
    notifyListeners();
  }
  void updateClearanceLights(String report) {
    if (report == "Good") {
      if (clearanceLights == "Bad") {
        issues.remove("Clearence Lights");
        badStateLights -= 1;
      }
    } else {
      if (clearanceLights == "Good") {
        issues.add("Clearence Lights");
        badStateLights += 1;
      }
    }
    clearanceLights = report;
    notifyListeners();
  }



  void updateWiperBladesFront(String report) {
    if (report == "Good") {
      if (wiperBladesFront == "Bad") {
        issues.remove("Wiper Blades Front");
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesFront == "Good") {
        issues.add("Wiper Blades Front");
        badStateLights += 1;
      }
    }
    wiperBladesFront = report;
    notifyListeners();
  }
  void updateWiperBladesBack(String report) {
    if (report == "Good") {
      if (wiperBladesBack == "Bad") {
        issues.remove("Wiper Blades Back");
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesBack == "Good") {
        issues.add("Wiper Blades Back");
        badStateLights += 1;
      }
    }
    wiperBladesBack = report;
    notifyListeners();
  }
  void updateWindshieldWiperFront(String report) {
    if (report == "Good") {
      if (windshieldWiperFront == "Bad") {
        issues.remove("Windshield Wiper Front");
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperFront == "Good") {
        issues.add("Windshield Wiper Front");
        badStateLights += 1;
      }
    }
    windshieldWiperFront = report;
    notifyListeners();
  }
  void updateWindshieldWiperBack(String report) {
    if (report == "Good") {
      if (windshieldWiperBack == "Bad") {
        issues.remove("Windshield Wiper Bad");
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperBack == "Good") {
        issues.add("Windshield Wiper Bad");
        badStateLights += 1;
      }
    }
    windshieldWiperBack = report;
    notifyListeners();
  }
  void updateGeneralBody(String report) {
    if (report == "Good") {
      if (generalBody == "Bad") {
        issues.remove("General Body");
        badStateLights -= 1;
      }
    } else {
      if (generalBody == "Good") {
        issues.add("General Body");
        badStateLights += 1;
      }
    }
    generalBody = report;
    notifyListeners();
  }
  void updateDecaling(String report) {
    if (report == "Good") {
      if (decaling == "Bad") {
        issues.remove("Decaling");
        badStateLights -= 1;
      }
    } else {
      if (decaling == "Good") {
        issues.add("Decaling");
        badStateLights += 1;
      }
    }
    decaling = report;
    notifyListeners();
  }
  void updateTires(String report) {
    if (report == "Good") {
      if (tires == "Bad") {
        issues.remove("Tires");
        badStateLights -= 1;
      }
    } else {
      if (tires == "Good") {
        issues.add("Tires");
        badStateLights += 1;
      }
    }
    tires = report;
    notifyListeners();
  }
  void updateGlass(String report) {
    if (report == "Good") {
      if (glass == "Bad") {
        issues.remove("Glass");
        badStateLights -= 1;
      }
    } else {
      if (glass == "Good") {
        issues.add("Glass");
        badStateLights += 1;
      }
    }
    glass = report;
    notifyListeners();
  }
  void updateMirrors(String report) {
    if (report == "Good") {
      if (mirrors == "Bad") {
        issues.remove("Mirrors");
        badStateLights -= 1;
      }
    } else {
      if (mirrors == "Good") {
        issues.add("Mirrors");
        badStateLights += 1;
      }
    }
    mirrors = report;
    notifyListeners();
  }
  void updateParking(String report) {
    if (report == "Good") {
      if (parking == "Bad") {
        issues.remove("Parking");
        badStateLights -= 1;
      }
    } else {
      if (parking == "Good") {
        issues.add("Parking");
        badStateLights += 1;
      }
    }
    parking = report;
    notifyListeners();
  }
  void updateBrakes(String report) {
    if (report == "Good") {
      if (brakes== "Bad") {
        issues.remove("Brakes");
        badStateLights -= 1;
      }
    } else {
      if (brakes== "Good") {
        issues.add("Brakes");
        badStateLights += 1;
      }
    }
    brakes = report;
    notifyListeners();
  }
  void updateEMGBrakes(String report) {
    if (report == "Good") {
      if (emgBrakes == "Bad") {
        issues.remove("EMGBrakes");
        badStateLights -= 1;
      }
    } else {
      if (emgBrakes == "Good") {
        issues.add("EMGBrakes");
        badStateLights += 1;
      }
    }
    emgBrakes = report;
    notifyListeners();
  }
  void updateHorn(String report) {
    if (report == "Good") {
      if (horn == "Bad") {
        issues.remove("Horn");
        badStateLights -= 1;
      }
    } else {
      if (horn == "Good") {
        issues.add("Horn");
        badStateLights += 1;
      }
    }
    horn = report;
    notifyListeners();
  }

  void updateEngineOil(String report) {
    if (report == "Good") {
      if (engineOil == "Bad") {
        issues.remove("Engine Oil");
        pendingMeasures -= 1;
      }
    } else {
      if (engineOil == "Good") {
        issues.add("Engine Oil");
        pendingMeasures += 1;
      }
    }
    engineOil = report;
    notifyListeners();
  }
  void updateTransmission(String report) {
    if (report == "Good") {
      if (transmission== "Bad") {
        issues.remove("Transmission");
        pendingMeasures -= 1;
      }
    } else {
      if (transmission== "Good") {
        issues.add("Transmission");
        pendingMeasures += 1;
      }
    }
    transmission = report;
    notifyListeners();
  }
  void updateCoolant(String report) {
    if (report == "Good") {
      if (coolant == "Bad") {
        issues.remove("Coolant");
        pendingMeasures -= 1;
      }
    } else {
      if (coolant == "Good") {
        issues.add("Coolant");
        pendingMeasures += 1;
      }
    }
    coolant = report;
    notifyListeners();
  }
  void updatePowerSteering(String report) {
    if (report == "Good") {
      if (powerSteering == "Bad") {
        issues.remove("Power Steering");
        pendingMeasures -= 1;
      }
    } else {
      if (powerSteering == "Good") {
        issues.add("Power Steering");
        pendingMeasures += 1;
      }
    }
    powerSteering = report;
    notifyListeners();
  }
  void updateDieselExhaustFluid(String report) {
    if (report == "Good") {
      if (dieselExhaustFluid == "Bad") {
        issues.remove("Diesel Exhaust Fluid");
        pendingMeasures -= 1;
      }
    } else {
      if (dieselExhaustFluid == "Good") {
        issues.add("Diesel Exhaust Fluid");
        pendingMeasures += 1;
      }
    }
    dieselExhaustFluid = report;
    notifyListeners();
  }
  void updateWindshieldWasherFluid(String report) {
    if (report == "Good") {
      if (windshieldWasherFluid == "Bad") {
        issues.remove("Windshield Washer Fluid");
        pendingMeasures -= 1;
      }
    } else {
      if (windshieldWasherFluid == "Good") {
        issues.add("Windshield Washer Fluid");
        pendingMeasures += 1;
      }
    }
    windshieldWasherFluid = report;
    notifyListeners();
  }

  void updateInsulated(String report) {
    if (report == "Good") {
      if (insulated == "Bad") {
        issues.remove("Insulated");
        badStateEquipment -= 1;
      }
    } else {
      if (insulated == "Good") {
        issues.add("Insulated");
        badStateEquipment += 1;
      }
    }
    insulated = report;
    notifyListeners();
  }
  void updateHolesDrilled(String report) {
    if (report == "Good") {
      if (holesDrilled == "Bad") {
        issues.remove("Holes Drilled");
        badStateEquipment -= 1;
      }
    } else {
      if (holesDrilled == "Good") {
        issues.add("Holes Drilled");
        badStateEquipment += 1;
      }
    }
    holesDrilled = report;
    notifyListeners();
  }
  void updateBucketLiner(String report) {
    if (report == "Good") {
      if (bucketLiner == "Bad") {
        issues.remove("Bucket Liner");
        badStateEquipment -= 1;
      }
    } else {
      if (bucketLiner == "Good") {
        issues.add("Bucket Liner");
        badStateEquipment += 1;
      }
    }
    bucketLiner = report;
    notifyListeners();
  }

  void updateRTAMagnet(String report) {
    if (report == "Good") {
      if (rtaMagnet == "Bad") {
        issues.remove("RTA Magnet");
        badStateSecurity -= 1;
      }
    } else {
      if (rtaMagnet == "Good") {
        issues.add("RTA Magnet");
        badStateSecurity += 1;
      }
    }
    rtaMagnet = report;
    notifyListeners();
  }
  void updateTriangleReflectors(String report) {
    if (report == "Good") {
      if (triangleReflectors == "Bad") {
        issues.remove("Triangle Reflectors");
        badStateSecurity -= 1;
      }
    } else {
      if (triangleReflectors == "Good") {
        issues.add("Triangle Reflectors");
        badStateSecurity += 1;
      }
    }
    triangleReflectors = report;
    notifyListeners();
  }
  void updateWheelChocks(String report) {
    if (report == "Good") {
      if (wheelChocks == "Bad") {
        issues.remove("Wheel Chocks");
        badStateSecurity -= 1;
      }
    } else {
      if (wheelChocks == "Good") {
        issues.add("Wheel Chocks");
        badStateSecurity += 1;
      }
    }
    wheelChocks = report;
    notifyListeners();
  }
  void updateFireExtinguisher(String report) {
    if (report == "Good") {
      if (fireExtinguisher == "Bad") {
        issues.remove("Fire Extinguisher");
        badStateSecurity -= 1;
      }
    } else {
      if (fireExtinguisher == "Good") {
        issues.add("Fire Extinguisher");
        badStateSecurity += 1;
      }
    }
    fireExtinguisher = report;
    notifyListeners();
  }
  void updateFirstAidKitSafetyVest(String report) {
    if (report == "Good") {
      if (firstAidKitSafetyVest == "Bad") {
        issues.remove("First AidKit Safety Vest");
        badStateSecurity -= 1;
      }
    } else {
      if (firstAidKitSafetyVest == "Good") {
        issues.add("First AidKit Safety Vest");
        badStateSecurity += 1;
      }
    }
    firstAidKitSafetyVest = report;
    notifyListeners();
  }
  void updateBackUpAlarm(String report) {
    if (report == "Good") {
      if (backUpAlarm == "Bad") {
        issues.remove("Back Up Alarm");
        badStateSecurity -= 1;
      }
    } else {
      if (backUpAlarm == "Good") {
        issues.add("Back Up Alarm");
        badStateSecurity += 1;
      }
    }
    backUpAlarm = report;
    notifyListeners();
  }

  void updateLadder(String report) {
    if (report == "Good") {
      if (ladder == "Bad") {
        issues.remove("Ladder");
        badStateSecurity -= 1;
      }
    } else {
      if (ladder == "Good") {
        issues.add("Ladder");
        badStateSecurity += 1;
      }
    }
    ladder = report;
    notifyListeners();
  }
  void updateStepLadder(String report) {
    if (report == "Good") {
      if (stepLadder == "Bad") {
        issues.remove("Step Ladder");
        badStateSecurity -= 1;
      }
    } else {
      if (stepLadder == "Good") {
        issues.add("Step Ladder");
        badStateSecurity += 1;
      }
    }
    stepLadder = report;
    notifyListeners();
  }
  void updateLadderStraps(String report) {
    if (report == "Good") {
      if (ladderStraps == "Bad") {
        issues.remove("Ladder Straps");
        badStateSecurity -= 1;
      }
    } else {
      if (ladderStraps == "Good") {
        issues.add("Ladder Straps");
        badStateSecurity += 1;
      }
    }
    ladderStraps = report;
    notifyListeners();
  }
  void updateHydraulicFluidForBucket(String report) {
    if (report == "Good") {
      if (hydraulicFluidForBucket == "Bad") {
        issues.remove("Hydraulic Fluid For Bucket");
        badStateSecurity -= 1;
      }
    } else {
      if (hydraulicFluidForBucket == "Good") {
        issues.add("Hydraulic Fluid For Bucket");
        badStateSecurity += 1;
      }
    }
    hydraulicFluidForBucket = report;
    notifyListeners();
  }
  void updateFiberReelRack(String report) {
    if (report == "Good") {
      if (fiberReelRack == "Bad") {
        issues.remove("Fiber Reel Rack");
        badStateSecurity -= 1;
      }
    } else {
      if (fiberReelRack == "Good") {
        issues.add("Fiber Reel Rack");
        badStateSecurity += 1;
      }
    }
    fiberReelRack = report;
    notifyListeners();
  }
  void updateBinsLockedAndSecure(String report) {
    if (report == "Good") {
      if (binsLockedAndSecure == "Bad") {
        issues.remove("Bins Locked And Secure");
        badStateSecurity -= 1;
      }
    } else {
      if (binsLockedAndSecure == "Good") {
        issues.add("Bins Locked And Secure");
        badStateSecurity += 1;
      }
    }
    binsLockedAndSecure = report;
    notifyListeners();
  }
  void updateSafetyHarness(String report) {
    if (report == "Good") {
      if (safetyHarness == "Bad") {
        issues.remove("Safety Harness");
        badStateSecurity -= 1;
      }
    } else {
      if (safetyHarness == "Good") {
        issues.add("Safety Harness");
        badStateSecurity += 1;
      }
    }
    safetyHarness = report;
    notifyListeners();
  }
  void updateLanyardSafetyHarness(String report) {
    if (report == "Good") {
      if (lanyardSafetyHarness == "Bad") {
        issues.remove("Lanyard Safety Harness");
        badStateSecurity -= 1;
      }
    } else {
      if (lanyardSafetyHarness == "Good") {
        issues.add("Lanyard Safety Harness");
        badStateSecurity += 1;
      }
    }
    lanyardSafetyHarness = report;
    notifyListeners();
  }

  void updateIgnitionKey(String report) {
    if (report == "Yes") {
      if (ignitionKey == "No") {
        issues.remove("Ignition Key");
        badStateEquipment -= 1;
      }
    } else {
      if (ignitionKey == "Yes") {
        issues.add("Ignition Key");
        badStateEquipment += 1;
      }
    }
    ignitionKey = report;
    notifyListeners();
  }
  void updateBinsBoxKey(String report) {
    if (report == "Yes") {
      if (binsBoxKey == "No") {
        issues.remove("BinsBox Key");
        badStateEquipment -= 1;
      }
    } else {
      if (binsBoxKey == "Yes") {
        issues.add("BinsBox Key");
        badStateEquipment += 1;
      }
    }
    binsBoxKey = report;
    notifyListeners();
  }
  void updateVehicleRegistrationCopy(String report) {
    if (report == "Yes") {
      if (vehicleRegistrationCopy == "No") {
        issues.remove("Vehicle Registration Copy");
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleRegistrationCopy == "Yes") {
        issues.add("Vehicle Registration Copy");
        badStateEquipment += 1;
      }
    }
    vehicleRegistrationCopy = report;
    notifyListeners();
  }
  void updateVehicleInsuranceCopy(String report) {
    if (report == "Yes") {
      if (vehicleInsuranceCopy == "No") {
        issues.remove("Vehicle Insurance Copy");
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleInsuranceCopy == "Yes") {
        issues.add("Vehicle Insurance Copy");
        badStateEquipment += 1;
      }
    }
    vehicleInsuranceCopy = report;
    notifyListeners();
  }
  void updateBucketLiftOperatorManual(String report) {
    if (report == "Yes") {
      if (bucketLiftOperatorManual == "No") {
        issues.remove("Bucket Lift Operator Manual");
        badStateEquipment -= 1;
      }
    } else {
      if (bucketLiftOperatorManual == "Yes") {
        issues.add("Bucket Lift Operator Manual");
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
    //Banderas
    issues.clear();
    from.clear();
    password.clear();
    to.clear();
    subject.clear();
    body.clear();

    flagOilChange = false;
    flagTransmissionFluidChange = false;
    flagRadiatorFluidChange = false;

    //Extras
    gasDieselString = "Empty";
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

  bool validateKeyForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate() ? true : false;
  }

  List<String> getListImages(List<ImageEvidence> imagesEvidence) {
    List<String> listImages = [];
    for (var elementImage in imagesEvidence) {
        listImages.add(encodeUint8Element(elementImage.uint8List));
      }
    return listImages;
  }

  String encodeUint8Element(Uint8List element) {
  String encodedElement = base64.encode(element);
  return encodedElement;
}

  List<String> getListPath(List<ImageEvidence> imagesEvidence) {
    List<String> listPath = [];
    for (var elementImage in imagesEvidence) {
        listPath.add(elementImage.path);
      }
    return listPath;
  }

  List<String> getListNames(List<ImageEvidence> imagesEvidence) {
    List<String> listNames = [];
    for (var elementImage in imagesEvidence) {
        listNames.add("${uuid.v4()}${elementImage.name}");
      }
    return listNames;
  }
  
  bool addControlForm(Users? user, DateTime dateAddedD) {
    try {
      //TODO:Ver cómo se debe recuperar el form de hoy
      final controlForm = dataBase.controlFormBox.query(ControlForm_.today.equals(true)).build().findFirst(); //Se recupera el control Form
      if (controlForm != null) {
        Measures measures = Measures(
          gas: gasDieselString, 
          gasComments: gasComments.text,
          gasImages: getListImages(gasImages), 
          gasPath: getListPath(gasImages), 
          gasNames: getListNames(gasImages),
          mileage: int.parse(mileage.replaceAll(",", "")), 
          mileageComments: mileageComments.text,
          mileageImages: getListImages(mileageImages),
          mileagePath: getListPath(mileageImages),
          mileageNames: getListNames(mileageImages),
        );

      final lights = Lights(
        headLights: headLights, 
        headLightsComments: headLightsComments.text, 
        headLightsImages: getListImages(headLightsImages), 
        headLightsPath: getListPath(headLightsImages), 
        headLightsNames: getListNames(headLightsImages), 
        brakeLights: brakeLights, 
        brakeLightsComments: brakeLightsComments.text, 
        brakeLightsImages: getListImages(brakeLightsImages), 
        brakeLightsPath: getListPath(brakeLightsImages), 
        brakeLightsNames: getListNames(brakeLightsImages), 
        reverseLights: reverseLights, 
        reverseLightsComments: reverseLightsComments.text, 
        reverseLightsImages: getListImages(reverseLightsImages), 
        reverseLightsPath: getListPath(reverseLightsImages), 
        reverseLightsNames: getListNames(reverseLightsImages), 
        warningLights: warningLights, 
        warningLightsComments: warningLightsComments.text, 
        warningLightsImages: getListImages(warningLightsImages), 
        warningLightsPath: getListPath(warningLightsImages),
        warningLightsNames: getListNames(warningLightsImages), 
        turnSignals: turnSignals, 
        turnSignalsComments: turnSignalsComments.text, 
        turnSignalsImages: getListImages(turnSignalsImages), 
        turnSignalsPath: getListPath(turnSignalsImages), 
        turnSignalsNames: getListNames(turnSignalsImages), 
        fourWayFlashers: fourWayFlashers, 
        fourWayFlashersComments: fourWayFlashersComments.text, 
        fourWayFlashersImages: getListImages(fourWayFlashersImages), 
        fourWayFlashersPath: getListPath(fourWayFlashersImages), 
        fourWayFlashersNames: getListNames(fourWayFlashersImages), 
        dashLights: dashLights, 
        dashLightsComments: dashLightsComments.text, 
        dashLightsImages: getListImages(dashLightsImages), 
        dashLightsPath: getListPath(dashLightsImages), 
        dashLightsNames: getListNames(dashLightsImages), 
        strobeLights: strobeLights, 
        strobeLightsComments: strobeLightsComments.text, 
        strobeLightsImages: getListImages(strobeLightsImages), 
        strobeLightsPath: getListPath(strobeLightsImages), 
        strobeLightsNames: getListNames(strobeLightsImages), 
        cabRoofLights: cabRoofLights, 
        cabRoofLightsComments: cabRoofLightsComments.text, 
        cabRoofLightsImages: getListImages(cabRoofLightsImages), 
        cabRoofLightsPath: getListPath(cabRoofLightsImages),
        cabRoofLightsNames: getListNames(cabRoofLightsImages),
        clearanceLights: clearanceLights, 
        clearanceLightsComments: clearanceLightsComments.text, 
        clearanceLightsImages: getListImages(clearanceLightsImages), 
        clearanceLightsPath: getListPath(clearanceLightsImages),
        clearanceLightsNames: getListNames(clearanceLightsImages), 
      );

      final carBodywork = CarBodywork(
        wiperBladesFront: wiperBladesFront, 
        wiperBladesFrontComments: wiperBladesFrontComments.text, 
        wiperBladesFrontImages: getListImages(wiperBladesFrontImages), 
        wiperBladesFrontPath: getListPath(wiperBladesFrontImages), 
        wiperBladesFrontNames: getListNames(wiperBladesFrontImages), 
        wiperBladesBack: wiperBladesBack, 
        wiperBladesBackComments: wiperBladesBackComments.text, 
        wiperBladesBackImages: getListImages(wiperBladesBackImages), 
        wiperBladesBackPath: getListPath(wiperBladesBackImages), 
        wiperBladesBackNames: getListNames(wiperBladesBackImages), 
        windshieldWiperFront: windshieldWiperFront, 
        windshieldWiperFrontComments: windshieldWiperFrontComments.text, 
        windshieldWiperFrontImages: getListImages(windshieldWiperFrontImages), 
        windshieldWiperFrontPath: getListPath(windshieldWiperFrontImages), 
        windshieldWiperFrontNames: getListNames(windshieldWiperFrontImages), 
        windshieldWiperBack: windshieldWiperBack, 
        windshieldWiperBackComments: windshieldWiperBackComments.text, 
        windshieldWiperBackImages: getListImages(windshieldWiperBackImages), 
        windshieldWiperBackPath: getListPath(windshieldWiperBackImages), 
        windshieldWiperBackNames: getListNames(windshieldWiperBackImages), 
        generalBody: generalBody, 
        generalBodyComments: generalBodyComments.text, 
        generalBodyImages: getListImages(generalBodyImages), 
        generalBodyPath: getListPath(generalBodyImages), 
        generalBodyNames: getListNames(generalBodyImages), 
        decaling: decaling, 
        decalingComments: decalingComments.text, 
        decalingImages: getListImages(decalingImages), 
        decalingPath: getListPath(decalingImages),
        decalingNames: getListNames(decalingImages), 
        tires: tires, 
        tiresComments: tiresComments.text, 
        tiresImages: getListImages(tiresImages), 
        tiresPath: getListPath(tiresImages),
        tiresNames: getListNames(tiresImages),
        glass: glass, 
        glassComments: glassComments.text, 
        glassImages: getListImages(glassImages), 
        glassPath: getListPath(glassImages), 
        glassNames: getListNames(glassImages), 
        mirrors: mirrors, 
        mirrorsComments: mirrorsComments.text, 
        mirrorsImages: getListImages(mirrorsImages), 
        mirrorsPath: getListPath(mirrorsImages), 
        mirrorsNames: getListNames(mirrorsImages), 
        parking: parking, 
        parkingComments: parkingComments.text, 
        parkingImages: getListImages(parkingImages), 
        parkingPath: getListPath(parkingImages), 
        parkingNames: getListNames(parkingImages), 
        brakes: brakes, 
        brakesComments: brakesComments.text, 
        brakesImages: getListImages(brakesImages), 
        brakesPath: getListPath(brakesImages),
        brakesNames: getListNames(brakesImages),
        emgBrakes: emgBrakes, 
        emgBrakesComments: emgBrakesComments.text, 
        emgBrakesImages: getListImages(emgBrakesImages), 
        emgBrakesPath: getListPath(emgBrakesImages),
        emgBrakesNames: getListNames(emgBrakesImages),
        horn: horn, 
        hornComments: hornComments.text, 
        hornImages: getListImages(hornImages), 
        hornPath: getListPath(hornImages),
        hornNames: getListNames(hornImages),
      );

      final fluidsCheck = FluidsCheck(
        engineOil: engineOil, 
        engineOilComments: engineOilComments.text, 
        engineOilImages: getListImages(engineOilImages), 
        engineOilPath: getListPath(engineOilImages),
        engineOilNames: getListNames(engineOilImages),
        transmission: transmission, 
        transmissionComments: transmissionComments.text, 
        transmissionImages: getListImages(transmissionImages), 
        transmissionPath: getListPath(transmissionImages),
        transmissionNames: getListNames(transmissionImages),
        coolant: coolant, 
        coolantComments: coolantComments.text, 
        coolantImages: getListImages(coolantImages), 
        coolantPath: getListPath(coolantImages),
        coolantNames: getListNames(coolantImages),
        powerSteering: powerSteering, 
        powerSteeringComments: powerSteeringComments.text, 
        powerSteeringImages: getListImages(powerSteeringImages), 
        powerSteeringPath: getListPath(powerSteeringImages),
        powerSteeringNames: getListNames(powerSteeringImages),
        dieselExhaustFluid: dieselExhaustFluid, 
        dieselExhaustFluidComments: dieselExhaustFluidComments.text, 
        dieselExhaustFluidImages: getListImages(dieselExhaustFluidImages), 
        dieselExhaustFluidPath: getListPath(dieselExhaustFluidImages),
        dieselExhaustFluidNames: getListNames(dieselExhaustFluidImages),
        windshieldWasherFluid: windshieldWasherFluid, 
        windshieldWasherFluidComments: windshieldWasherFluidComments.text, 
        windshieldWasherFluidImages: getListImages(windshieldWasherFluidImages), 
        windshieldWasherFluidPath: getListPath(windshieldWasherFluidImages),
        windshieldWasherFluidNames: getListNames(windshieldWasherFluidImages),
      );

      final bucketInspection = BucketInspection(
        insulated: insulated, 
        insulatedComments: insulatedComments.text, 
        insulatedImages: getListImages(insulatedImages), 
        insulatedPath: getListPath(insulatedImages),
        insulatedNames: getListNames(insulatedImages),
        holesDrilled: holesDrilled, 
        holesDrilledComments: holesDrilledComments.text, 
        holesDrilledImages: getListImages(holesDrilledImages), 
        holesDrilledPath: getListPath(holesDrilledImages),
        holesDrilledNames: getListNames(holesDrilledImages),
        bucketLiner: bucketLiner, 
        bucketLinerComments: bucketLinerComments.text, 
        bucketLinerImages: getListImages(bucketLinerImages), 
        bucketLinerPath: getListPath(bucketLinerImages),
        bucketLinerNames: getListNames(bucketLinerImages),
      );

      final security = Security(
        rtaMagnet: rtaMagnet, 
        rtaMagnetComments: rtaMagnetComments.text, 
        rtaMagnetImages: getListImages(rtaMagnetImages), 
        rtaMagnetPath: getListPath(rtaMagnetImages),
        rtaMagnetNames: getListNames(rtaMagnetImages),
        triangleReflectors: triangleReflectors, 
        triangleReflectorsComments: triangleReflectorsComments.text, 
        triangleReflectorsImages: getListImages(triangleReflectorsImages), 
        triangleReflectorsPath: getListPath(triangleReflectorsImages),
        triangleReflectorsNames: getListNames(triangleReflectorsImages),
        wheelChocks: wheelChocks, 
        wheelChocksComments: wheelChocksComments.text, 
        wheelChocksImages: getListImages(wheelChocksImages), 
        wheelChocksPath: getListPath(wheelChocksImages),
        wheelChocksNames: getListNames(wheelChocksImages),
        fireExtinguisher: fireExtinguisher, 
        fireExtinguisherComments: fireExtinguisherComments.text, 
        fireExtinguisherImages: getListImages(fireExtinguisherImages), 
        fireExtinguisherPath: getListPath(fireExtinguisherImages),
        fireExtinguisherNames: getListNames(fireExtinguisherImages),
        firstAidKitSafetyVest: firstAidKitSafetyVest, 
        firstAidKitSafetyVestComments: firstAidKitSafetyVestComments.text, 
        firstAidKitSafetyVestImages: getListImages(firstAidKitSafetyVestImages), 
        firstAidKitSafetyVestPath: getListPath(firstAidKitSafetyVestImages),
        firstAidKitSafetyVestNames: getListNames(firstAidKitSafetyVestImages),
        backUpAlarm: backUpAlarm, 
        backUpAlarmComments: backUpAlarmComments.text, 
        backUpAlarmImages: getListImages(backUpAlarmImages), 
        backUpAlarmPath: getListPath(backUpAlarmImages),
        backUpAlarmNames: getListNames(backUpAlarmImages),
      );

      final extra = Extra(
        ladder: ladder, 
        ladderComments: ladderComments.text, 
        ladderImages: getListImages(ladderImages), 
        ladderPath: getListPath(ladderImages),
        ladderNames: getListNames(ladderImages),
        stepLadder: stepLadder, 
        stepLadderComments: stepLadderComments.text, 
        stepLadderImages: getListImages(stepLadderImages), 
        stepLadderPath: getListPath(stepLadderImages),
        stepLadderNames: getListNames(stepLadderImages),
        ladderStraps: ladderStraps, 
        ladderStrapsComments: ladderStrapsComments.text, 
        ladderStrapsImages: getListImages(ladderStrapsImages), 
        ladderStrapsPath: getListPath(ladderStrapsImages),
        ladderStrapsNames: getListNames(ladderStrapsImages),
        hydraulicFluidForBucket: hydraulicFluidForBucket, 
        hydraulicFluidForBucketComments: hydraulicFluidForBucketComments.text, 
        hydraulicFluidForBucketImages: getListImages(hydraulicFluidForBucketImages), 
        hydraulicFluidForBucketPath: getListPath(hydraulicFluidForBucketImages),
        hydraulicFluidForBucketNames: getListNames(hydraulicFluidForBucketImages),
        fiberReelRack: fiberReelRack, 
        fiberReelRackComments: fiberReelRackComments.text, 
        fiberReelRackImages: getListImages(fiberReelRackImages), 
        fiberReelRackPath: getListPath(fiberReelRackImages),
        fiberReelRackNames: getListNames(fiberReelRackImages),
        binsLockedAndSecure: binsLockedAndSecure, 
        binsLockedAndSecureComments: binsLockedAndSecureComments.text, 
        binsLockedAndSecureImages: getListImages(binsLockedAndSecureImages), 
        binsLockedAndSecurePath: getListPath(binsLockedAndSecureImages),
        binsLockedAndSecureNames: getListNames(binsLockedAndSecureImages),
        safetyHarness: safetyHarness, 
        safetyHarnessComments: safetyHarnessComments.text, 
        safetyHarnessImages: getListImages(safetyHarnessImages), 
        safetyHarnessPath: getListPath(safetyHarnessImages),
        safetyHarnessNames: getListNames(safetyHarnessImages),
        lanyardSafetyHarness: lanyardSafetyHarness, 
        lanyardSafetyHarnessComments: lanyardSafetyHarnessComments.text, 
        lanyardSafetyHarnessImages: getListImages(lanyardSafetyHarnessImages), 
        lanyardSafetyHarnessPath: getListPath(lanyardSafetyHarnessImages),
        lanyardSafetyHarnessNames: getListNames(lanyardSafetyHarnessImages),
      );

      final equipment = Equipment(
        ignitionKey: ignitionKey, 
        ignitionKeyComments: ignitionKeyComments.text, 
        ignitionKeyImages: getListImages(ignitionKeyImages), 
        ignitionKeyPath: getListPath(ignitionKeyImages),
        ignitionKeyNames: getListNames(ignitionKeyImages),
        binsBoxKey: binsBoxKey, 
        binsBoxKeyComments: binsBoxKeyComments.text, 
        binsBoxKeyImages: getListImages(binsBoxKeyImages), 
        binsBoxKeyPath: getListPath(binsBoxKeyImages),
        binsBoxKeyNames: getListNames(binsBoxKeyImages),
        vehicleRegistrationCopy: vehicleRegistrationCopy, 
        vehicleRegistrationCopyComments: vehicleRegistrationCopyComments.text, 
        vehicleRegistrationCopyImages: getListImages(vehicleRegistrationCopyImages), 
        vehicleRegistrationCopyPath: getListPath(vehicleRegistrationCopyImages),
        vehicleRegistrationCopyNames: getListNames(vehicleRegistrationCopyImages),
        vehicleInsuranceCopy: vehicleInsuranceCopy, 
        vehicleInsuranceCopyComments: vehicleInsuranceCopyComments.text, 
        vehicleInsuranceCopyImages: getListImages(vehicleInsuranceCopyImages), 
        vehicleInsuranceCopyPath: getListPath(vehicleInsuranceCopyImages),
        vehicleInsuranceCopyNames: getListNames(vehicleInsuranceCopyImages),
        bucketLiftOperatorManual: bucketLiftOperatorManual, 
        bucketLiftOperatorManualComments: bucketLiftOperatorManualComments.text, 
        bucketLiftOperatorManualImages: getListImages(bucketLiftOperatorManualImages), 
        bucketLiftOperatorManualPath: getListPath(bucketLiftOperatorManualImages),
        bucketLiftOperatorManualNames: getListNames(bucketLiftOperatorManualImages),
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

          controlForm.measuresD.target = measures;
          controlForm.lightsD.target = lights;
          controlForm.carBodyworkD.target = carBodywork;
          controlForm.fluidsCheckD.target = fluidsCheck;
          controlForm.bucketInspectionD.target = bucketInspection;
          controlForm.securityD.target = security;
          controlForm.extraD.target = extra;
          controlForm.equipmentD.target = equipment;

          controlForm.issuesD = badStateLights + pendingMeasures + badStateSecurity + badStateEquipment;
          controlForm.dateAddedD = dateAddedD;

          if (flagOilChange) {
          final vehicleService = VehicleServices(
            completed: false, 
            mileageRemaining: int.parse(vehicle.ruleOilChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleOilChange.target!.lastMileageService),
          );
          final service = dataBase.serviceBox.query(Service_.service.equals("Oil Change")).build().findUnique();
          vehicleService.service.target = service;
          vehicleService.vehicle.target = vehicle;
          vehicle.ruleOilChange.target!.registered = "True";
          dataBase.ruleBox.put(vehicle.ruleOilChange.target!);
          vehicle.vehicleServices.add(vehicleService);

          dataBase.vehicleServicesBox.put(vehicleService);
          dataBase.vehicleBox.put(vehicle);

          final nuevaInstruccion = Bitacora(
            instruccion: 'syncAddOilChangeService',
            usuarioPropietario: prefs.getString("userId")!,
            idControlForm: controlForm.id,
          ); //Se crea la nueva instruccion a realizar en bitacora

          nuevaInstruccion.vehicleService.target = vehicleService; //Se asigna el vehicle service a la nueva instrucción
          vehicleService.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al vehicle service
          dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
        } else {
          //Se actualiza el millaje del servicio
          if (vehicle.ruleOilChange.target!.registered == "True") {
              final service = dataBase.serviceBox.query(Service_.service.equals("Oil Change")).build().findUnique();
              final serviceVehicle = dataBase.vehicleServicesBox.query(VehicleServices_.vehicle.equals(vehicle.id).and(VehicleServices_.service.equals(service?.id ?? 0)).and(VehicleServices_.completed.equals(false))).build().findFirst();
              if (serviceVehicle != null) {
                serviceVehicle.mileageRemaining = int.parse(vehicle.ruleOilChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleOilChange.target!.lastMileageService);
                dataBase.vehicleServicesBox.put(serviceVehicle);

                final nuevaInstruccion = Bitacora(
                  instruccion: 'syncUpdateMileageRemainingVehicleServices',
                  usuarioPropietario: prefs.getString("userId")!,
                  idControlForm: controlForm.id,
                ); //Se crea la nueva instruccion a realizar en bitacora

                nuevaInstruccion.vehicleService.target = serviceVehicle; //Se asigna el verhicle service a la nueva instrucción
                serviceVehicle.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el verhicle service
                dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
              }
            }
          }

        if (flagTransmissionFluidChange) {
          final vehicleService = VehicleServices(
            completed: false, 
            mileageRemaining: int.parse(vehicle.ruleTransmissionFluidChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleTransmissionFluidChange.target!.lastMileageService),
          );
          final service = dataBase.serviceBox.query(Service_.service.equals("Transmission Fluid Change")).build().findUnique();
          vehicleService.service.target = service;
          vehicleService.vehicle.target = vehicle;
          vehicle.ruleTransmissionFluidChange.target!.registered = "True";
          dataBase.ruleBox.put(vehicle.ruleTransmissionFluidChange.target!);
          vehicle.vehicleServices.add(vehicleService);

          dataBase.vehicleServicesBox.put(vehicleService);
          dataBase.vehicleBox.put(vehicle);

          final nuevaInstruccion = Bitacora(
              instruccion: 'syncAddFluidTransmissionChangeService',
              usuarioPropietario: prefs.getString("userId")!,
              idControlForm: controlForm.id,
            ); //Se crea la nueva instruccion a realizar en bitacora

            nuevaInstruccion.vehicleService.target = vehicleService; //Se asigna el vehicle service a la nueva instrucción
            vehicleService.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al vehicle service
            dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
          } else {
          //Se actualiza el millaje del servicio
          if (vehicle.ruleTransmissionFluidChange.target!.registered == "True") {
              final service = dataBase.serviceBox.query(Service_.service.equals("Transmission Fluid Change")).build().findUnique();
              final serviceVehicle = dataBase.vehicleServicesBox.query(VehicleServices_.vehicle.equals(vehicle.id).and(VehicleServices_.service.equals(service?.id ?? 0)).and(VehicleServices_.completed.equals(false))).build().findFirst();
              if (serviceVehicle != null) {
                serviceVehicle.mileageRemaining = int.parse(vehicle.ruleTransmissionFluidChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleTransmissionFluidChange.target!.lastMileageService);
                dataBase.vehicleServicesBox.put(serviceVehicle);

                final nuevaInstruccion = Bitacora(
                  instruccion: 'syncUpdateMileageRemainingVehicleServices',
                  usuarioPropietario: prefs.getString("userId")!,
                  idControlForm: controlForm.id,
                ); //Se crea la nueva instruccion a realizar en bitacora

                nuevaInstruccion.vehicleService.target = serviceVehicle; //Se asigna el verhicle service a la nueva instrucción
                serviceVehicle.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el verhicle service
                dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
              }
            }
          }

        if (flagRadiatorFluidChange) {
          final vehicleService = VehicleServices(
            completed: false, 
            mileageRemaining: int.parse(vehicle.ruleRadiatorFluidChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleRadiatorFluidChange.target!.lastMileageService),
          );
          final service = dataBase.serviceBox.query(Service_.service.equals("Radiator Fluid Change")).build().findUnique();
          vehicleService.service.target = service;
          vehicleService.vehicle.target = vehicle;
          vehicle.ruleRadiatorFluidChange.target!.registered = "True";
          dataBase.ruleBox.put(vehicle.ruleRadiatorFluidChange.target!);
          vehicle.vehicleServices.add(vehicleService);

          dataBase.vehicleServicesBox.put(vehicleService);
          dataBase.vehicleBox.put(vehicle);

          final nuevaInstruccion = Bitacora(
            instruccion: 'syncAddFluidRadiatorChangeService',
            usuarioPropietario: prefs.getString("userId")!,
            idControlForm: controlForm.id,
          ); //Se crea la nueva instruccion a realizar en bitacora

          nuevaInstruccion.vehicleService.target = vehicleService; //Se asigna el vehicle service a la nueva instrucción
          vehicleService.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción al vehicle service
          dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
        } else {
          //Se actualiza el millaje del servicio
          if (vehicle.ruleRadiatorFluidChange.target!.registered == "True") {
              final service = dataBase.serviceBox.query(Service_.service.equals("Radiator Fluid Change")).build().findUnique();
              final serviceVehicle = dataBase.vehicleServicesBox.query(VehicleServices_.vehicle.equals(vehicle.id).and(VehicleServices_.service.equals(service?.id ?? 0)).and(VehicleServices_.completed.equals(false))).build().findFirst();
              if (serviceVehicle != null) {
                serviceVehicle.mileageRemaining = int.parse(vehicle.ruleRadiatorFluidChange.target!.value) - (int.parse(mileage.replaceAll(",", "")) - vehicle.ruleRadiatorFluidChange.target!.lastMileageService);
                dataBase.vehicleServicesBox.put(serviceVehicle);

                final nuevaInstruccion = Bitacora(
                  instruccion: 'syncUpdateMileageRemainingVehicleServices',
                  usuarioPropietario: prefs.getString("userId")!,
                  idControlForm: controlForm.id,
                ); //Se crea la nueva instruccion a realizar en bitacora

                nuevaInstruccion.vehicleService.target = serviceVehicle; //Se asigna el verhicle service a la nueva instrucción
                serviceVehicle.bitacora.add(nuevaInstruccion); //Se asigna la nueva instrucción a el verhicle service
                dataBase.bitacoraBox.put(nuevaInstruccion); //Agregamos la nueva instrucción en objectBox
              }
            }
        }

          //Se actualiza el mileage del vehicle
          vehicle.mileage = int.parse(mileage.replaceAll(",", ""));
          dataBase.vehicleBox.put(vehicle);

          //Se actualiza el Control Form
          dataBase.controlFormBox.put(controlForm);

          final nuevaInstruccion = Bitacora(
            instruccion: 'syncAddControlFormD',
            usuarioPropietario: prefs.getString("userId")!,
            idControlForm: controlForm.id,
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
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendEmail(String nameUserSender) async {
    var urlAutomatizacion =
        Uri.parse("https://supa43.rtatel.com/notifications/api");
    final headers = ({
      "Content-Type": "application/json",
    });
    var responseAutomatizacion = await post(urlAutomatizacion,
        headers: headers,
        body: jsonEncode({
          "action": "rtaMail",
          "template": "Issues_Form_Notification_RTA_CV",
          "subject": "Issues_Form_Notification_RTA_CV",
          "mailto": "control.rta@cbluna.com",
          "variables": [
            {"name": "nameUserSender", "value": nameUserSender},
            {"name": "typeForm", "value": "Check In Form"},
            {"name": "issuesList","value": "Issues in: ${issues.join(", ")}"}
          ]
        }));
    if (responseAutomatizacion.statusCode == 200) {
      print("Proceso exitoso");
      return true;
    } else {
      print(responseAutomatizacion.body);
      return false;
    }
 }

}