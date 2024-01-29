import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/models/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uuid/uuid.dart';
class CheckOutFormController extends ChangeNotifier {
  
  bool validateForm(GlobalKey<FormState> keyForm) {
    return keyForm.currentState!.validate() ? true : false;
  }

  //************************Gateways Components *********/
  TextEditingController productIDTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController serialNumberTextController = TextEditingController();
  TextEditingController productCodeTextController = TextEditingController();
  String codeQR =  "";

  void autofillFieldsQR(String value) {
    codeQR = value;
    if (value.contains(productIDRegExpo) 
    && value.contains(nameRegExp) 
    && value.contains(descriptionRegExp)
    && value.contains(serialNumberRegExp)
    && value.contains(productCodeRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      Match? matchName = nameRegExp.firstMatch(value);
      Match? matchDescription = descriptionRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchProductID != null) {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "");
      }
      if (matchName != null) {
          nameTextController.text =
              matchName.group(0)!.replaceAll(nameFieldName, "");
      }
      if (matchDescription != null) {
          descriptionTextController.text =
              matchDescription.group(0)!.replaceAll(nameFieldDescription, "");
      }
      if (matchSerialNumber != null) {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "");
      }
      if (matchProductCode != null) {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "");
      }
    } 
    notifyListeners();
  }

  Future<bool> autofillFieldsOCR(String value) async {
    if (value.contains(productIDRegExpo) 
    && value.contains(nameRegExp) 
    && value.contains(descriptionRegExp)
    && value.contains(serialNumberRegExp)
    && value.contains(productCodeRegExp)) {
      // Intenta encontrar la primera coincidencia en el texto
      Match? matchProductID = productIDRegExpo.firstMatch(value);
      Match? matchName = nameRegExp.firstMatch(value);
      Match? matchDescription = descriptionRegExp.firstMatch(value);
      Match? matchSerialNumber = serialNumberRegExp.firstMatch(value);
      Match? matchProductCode = productCodeRegExp.firstMatch(value);
      // Si se encuentra una coincidencia, extrae la subcadena
      if (matchProductID != null) {
        await Future.microtask(() => {
          productIDTextController.text =
              matchProductID.group(0)!.replaceAll(nameFieldProductID, "")
        });
      }
      if (matchName != null) {
        await Future.microtask(() => {
          nameTextController.text =
              matchName.group(0)!.replaceAll(nameFieldName, "")
        });
      }
      if (matchDescription != null) {
        await Future.microtask(() => {
          descriptionTextController.text =
              matchDescription.group(0)!.replaceAll(nameFieldDescription, "")
        });
      }
      if (matchSerialNumber != null) {
        await Future.microtask(() => {
          serialNumberTextController.text =
              matchSerialNumber.group(0)!.replaceAll(nameFieldSerialNumber, "")
        });
      }
      if (matchProductCode != null) {
        await Future.microtask(() => {
          productCodeTextController.text =
              matchProductCode.group(0)!.replaceAll(nameFieldProductCode, "")
        });
      }
      return true;
    } else {
      return false;
    }
  }

  Future<String> addNewGatewayBackend(Users currentUser) async {
    try {
      if (await existsRegisterInBackend("router_detail", "serie_no", serialNumberTextController.text)) {
        return "Duplicate";
      }
      final recordInventoryProduct = await supabase.from('inventory_product').insert(
        {
          'inventory_location_fk': 1,
          'provider_invoice_fk': 1,
          'product_fk': productIDTextController.text,
          'barcode_type_fk': 1,
          'created_by': currentUser.id,
          'inventory_product_status_fk': 1
        },
      ).select<PostgrestList>('inventory_product_id');

      if (recordInventoryProduct.isNotEmpty) {
        final recordRouterDetail = await supabase.from('router_detail').insert(
          {
            'network_configuration': 'Static Routing',
            'inventory_product_fk': recordInventoryProduct.first['inventory_product_id'],
            'serie_no': serialNumberTextController.text,
            'location': 'Store'
          },
        ).select<PostgrestList>('router_detail_id');
        if (recordRouterDetail.isNotEmpty) {
          return "True";
        } else {
          return "False";
        }
      } else {
        return "False";
      }
    } catch (e) {
      return "$e";
    }
  }

  Future<bool> existsRegisterInBackend(String table, String column, String idUnique) async {
    final results = await supabase.from(table).select().eq(column, idUnique);
    return results.isNotEmpty;
  }

  void clearControllers() {
    productIDTextController.clear();
    nameTextController.clear();
    descriptionTextController.clear();
    serialNumberTextController.clear();
    codeQR =  "";
  }


  //***********************<Bnaderas Services>************************
  bool flagOilChange = false;
  bool flagTransmissionFluidChange = false;
  bool flagRadiatorFluidChange = false;
  bool flagTireChange = false;
  bool flagBrakeChange = false;

  List<String> issuesFluidCheck = []; 
  List<String> issuesLights = []; 
  List<String> issuesCarBodyWork = []; 
  List<String> issuesSecurity = []; 
  List<String> issuesExtra = []; 
  List<String> issuesEquipment = []; 
  List<String> issuesBucketInspection = []; 
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
        issuesLights.remove("HeadLights");
        badStateLights -= 1;
      }
    } else {
      if (headLights == "Good") {
        issuesLights.add("HeadLights");
        badStateLights += 1;
      }
    }
    headLights = report;
    notifyListeners();
  }
  void updateBrakeLights(String report) {
    if (report == "Good") {
      if (brakeLights == "Bad") {
        issuesLights.remove("BrakeLights");
        badStateLights -= 1;
      }
    } else {
      if (brakeLights == "Good") {
        issuesLights.add("BrakeLights");
        badStateLights += 1;
      }
    }
    brakeLights = report;
    notifyListeners();
  }
  void updateReverseLights(String report) {
    if (report == "Good") {
      if (reverseLights == "Bad") {
        issuesLights.remove("ReverseLights");
        badStateLights -= 1;
      }
    } else {
      if (reverseLights == "Good") {
        issuesLights.add("ReverseLights");
        badStateLights += 1;
      }
    }
    reverseLights = report;
    notifyListeners();
  }
  void updateWarningLights(String report) {
    if (report == "Good") {
      if (warningLights == "Bad") {
        issuesLights.remove("WarningLights");
        badStateLights -= 1;
      }
    } else {
      if (warningLights == "Good") {
        issuesLights.add("WarningLights");
        badStateLights += 1;
      }
    }
    warningLights = report;
    notifyListeners();
  }
  void updateTurnSignals(String report) {
    if (report == "Good") {
      if (turnSignals == "Bad") {
        issuesLights.remove("TurnLights");
        badStateLights -= 1;
      }
    } else {
      if (turnSignals == "Good") {
        issuesLights.add("TurnLights");
        badStateLights += 1;
      }
    }
    turnSignals = report;
    notifyListeners();
  }
  void updateFourWayFlashers(String report) {
    if (report == "Good") {
      if (fourWayFlashers == "Bad") {
        issuesLights.remove("FourWay Flasher");
        badStateLights -= 1;
      }
    } else {
      if (fourWayFlashers == "Good") {
        issuesLights.add("FourWay Flasher");
        badStateLights += 1;
      }
    }
    fourWayFlashers = report;
    notifyListeners();
  }
  void updateDashLights(String report) {
    if (report == "Good") {
      if (dashLights == "Bad") {
        issuesLights.remove("DashLights");
        badStateLights -= 1;
      }
    } else {
      if (dashLights == "Good") {
        issuesLights.add("DashLights");
        badStateLights += 1;
      }
    }
    dashLights = report;
    notifyListeners();
  }
  void updateStrobeLights(String report) {
    if (report == "Good") {
      if (strobeLights == "Bad") {
        issuesLights.remove("Strobe Lights");
        badStateLights -= 1;
      }
    } else {
      if (strobeLights == "Good") {
        issuesLights.add("Strobe Lights");
        badStateLights += 1;
      }
    }
    strobeLights = report;
    notifyListeners();
  }
  void updateCabRoofLights(String report) {
    if (report == "Good") {
      if (cabRoofLights == "Bad") {
        issuesLights.remove("CabRoof Lights");
        badStateLights -= 1;
      }
    } else {
      if (cabRoofLights == "Good") {
        issuesLights.add("CabRoof Lights");
        badStateLights += 1;
      }
    }
    cabRoofLights = report;
    notifyListeners();
  }
  void updateClearanceLights(String report) {
    if (report == "Good") {
      if (clearanceLights == "Bad") {
        issuesLights.remove("Clearence Lights");
        badStateLights -= 1;
      }
    } else {
      if (clearanceLights == "Good") {
        issuesLights.add("Clearence Lights");
        badStateLights += 1;
      }
    }
    clearanceLights = report;
    notifyListeners();
  }



  void updateWiperBladesFront(String report) {
    if (report == "Good") {
      if (wiperBladesFront == "Bad") {
        issuesCarBodyWork.remove("Wiper Blades Front");
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesFront == "Good") {
        issuesCarBodyWork.add("Wiper Blades Front");
        badStateLights += 1;
      }
    }
    wiperBladesFront = report;
    notifyListeners();
  }
  void updateWiperBladesBack(String report) {
    if (report == "Good") {
      if (wiperBladesBack == "Bad") {
        issuesCarBodyWork.remove("Wiper Blades Back");
        badStateLights -= 1;
      }
    } else {
      if (wiperBladesBack == "Good") {
        issuesCarBodyWork.add("Wiper Blades Back");
        badStateLights += 1;
      }
    }
    wiperBladesBack = report;
    notifyListeners();
  }
  void updateWindshieldWiperFront(String report) {
    if (report == "Good") {
      if (windshieldWiperFront == "Bad") {
        issuesCarBodyWork.remove("Windshield Wiper Front");
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperFront == "Good") {
        issuesCarBodyWork.add("Windshield Wiper Front");
        badStateLights += 1;
      }
    }
    windshieldWiperFront = report;
    notifyListeners();
  }
  void updateWindshieldWiperBack(String report) {
    if (report == "Good") {
      if (windshieldWiperBack == "Bad") {
        issuesCarBodyWork.remove("Windshield Wiper Bad");
        badStateLights -= 1;
      }
    } else {
      if (windshieldWiperBack == "Good") {
        issuesCarBodyWork.add("Windshield Wiper Bad");
        badStateLights += 1;
      }
    }
    windshieldWiperBack = report;
    notifyListeners();
  }
  void updateGeneralBody(String report) {
    if (report == "Good") {
      if (generalBody == "Bad") {
        issuesCarBodyWork.remove("General Body");
        badStateLights -= 1;
      }
    } else {
      if (generalBody == "Good") {
        issuesCarBodyWork.add("General Body");
        badStateLights += 1;
      }
    }
    generalBody = report;
    notifyListeners();
  }
  void updateDecaling(String report) {
    if (report == "Good") {
      if (decaling == "Bad") {
        issuesCarBodyWork.remove("Decaling");
        badStateLights -= 1;
      }
    } else {
      if (decaling == "Good") {
        issuesCarBodyWork.add("Decaling");
        badStateLights += 1;
      }
    }
    decaling = report;
    notifyListeners();
  }
  void updateTires(String report) {
    if (report == "Good") {
      if (tires == "Bad") {
        issuesCarBodyWork.remove("Tires");
        badStateLights -= 1;
      }
    } else {
      if (tires == "Good") {
        issuesCarBodyWork.add("Tires");
        badStateLights += 1;
      }
    }
    tires = report;
    notifyListeners();
  }
  void updateGlass(String report) {
    if (report == "Good") {
      if (glass == "Bad") {
        issuesCarBodyWork.remove("Glass");
        badStateLights -= 1;
      }
    } else {
      if (glass == "Good") {
        issuesCarBodyWork.add("Glass");
        badStateLights += 1;
      }
    }
    glass = report;
    notifyListeners();
  }
  void updateMirrors(String report) {
    if (report == "Good") {
      if (mirrors == "Bad") {
        issuesCarBodyWork.remove("Mirrors");
        badStateLights -= 1;
      }
    } else {
      if (mirrors == "Good") {
        issuesCarBodyWork.add("Mirrors");
        badStateLights += 1;
      }
    }
    mirrors = report;
    notifyListeners();
  }
  void updateParking(String report) {
    if (report == "Good") {
      if (parking == "Bad") {
        issuesCarBodyWork.remove("Parking");
        badStateLights -= 1;
      }
    } else {
      if (parking == "Good") {
        issuesCarBodyWork.add("Parking");
        badStateLights += 1;
      }
    }
    parking = report;
    notifyListeners();
  }
  void updateBrakes(String report) {
    if (report == "Good") {
      if (brakes== "Bad") {
        issuesCarBodyWork.remove("Brakes");
        badStateLights -= 1;
      }
    } else {
      if (brakes== "Good") {
        issuesCarBodyWork.add("Brakes");
        badStateLights += 1;
      }
    }
    brakes = report;
    notifyListeners();
  }
  void updateEMGBrakes(String report) {
    if (report == "Good") {
      if (emgBrakes == "Bad") {
        issuesCarBodyWork.remove("EMGBrakes");
        badStateLights -= 1;
      }
    } else {
      if (emgBrakes == "Good") {
        issuesCarBodyWork.add("EMGBrakes");
        badStateLights += 1;
      }
    }
    emgBrakes = report;
    notifyListeners();
  }
  void updateHorn(String report) {
    if (report == "Good") {
      if (horn == "Bad") {
        issuesCarBodyWork.remove("Horn");
        badStateLights -= 1;
      }
    } else {
      if (horn == "Good") {
        issuesCarBodyWork.add("Horn");
        badStateLights += 1;
      }
    }
    horn = report;
    notifyListeners();
  }

  void updateEngineOil(String report) {
    if (report == "Good") {
      if (engineOil == "Bad") {
        issuesCarBodyWork.remove("Engine Oil");
        pendingMeasures -= 1;
      }
    } else {
      if (engineOil == "Good") {
        issuesCarBodyWork.add("Engine Oil");
        pendingMeasures += 1;
      }
    }
    engineOil = report;
    notifyListeners();
  }
  void updateTransmission(String report) {
    if (report == "Good") {
      if (transmission== "Bad") {
        issuesFluidCheck.remove("Transmission");
        pendingMeasures -= 1;
      }
    } else {
      if (transmission== "Good") {
        issuesFluidCheck.add("Transmission");
        pendingMeasures += 1;
      }
    }
    transmission = report;
    notifyListeners();
  }
  void updateCoolant(String report) {
    if (report == "Good") {
      if (coolant == "Bad") {
        issuesFluidCheck.remove("Coolant");
        pendingMeasures -= 1;
      }
    } else {
      if (coolant == "Good") {
        issuesFluidCheck.add("Coolant");
        pendingMeasures += 1;
      }
    }
    coolant = report;
    notifyListeners();
  }
  void updatePowerSteering(String report) {
    if (report == "Good") {
      if (powerSteering == "Bad") {
        issuesFluidCheck.remove("Power Steering");
        pendingMeasures -= 1;
      }
    } else {
      if (powerSteering == "Good") {
        issuesFluidCheck.add("Power Steering");
        pendingMeasures += 1;
      }
    }
    powerSteering = report;
    notifyListeners();
  }
  void updateDieselExhaustFluid(String report) {
    if (report == "Good") {
      if (dieselExhaustFluid == "Bad") {
        issuesFluidCheck.remove("Diesel Exhaust Fluid");
        pendingMeasures -= 1;
      }
    } else {
      if (dieselExhaustFluid == "Good") {
        issuesFluidCheck.add("Diesel Exhaust Fluid");
        pendingMeasures += 1;
      }
    }
    dieselExhaustFluid = report;
    notifyListeners();
  }
  void updateWindshieldWasherFluid(String report) {
    if (report == "Good") {
      if (windshieldWasherFluid == "Bad") {
        issuesFluidCheck.remove("Windshield Washer Fluid");
        pendingMeasures -= 1;
      }
    } else {
      if (windshieldWasherFluid == "Good") {
        issuesFluidCheck.add("Windshield Washer Fluid");
        pendingMeasures += 1;
      }
    }
    windshieldWasherFluid = report;
    notifyListeners();
  }

  void updateInsulated(String report) {
    if (report == "Good") {
      if (insulated == "Bad") {
        issuesBucketInspection.remove("Insulated");
        badStateEquipment -= 1;
      }
    } else {
      if (insulated == "Good") {
        issuesBucketInspection.add("Insulated");
        badStateEquipment += 1;
      }
    }
    insulated = report;
    notifyListeners();
  }
  void updateHolesDrilled(String report) {
    if (report == "Good") {
      if (holesDrilled == "Bad") {
        issuesBucketInspection.remove("Holes Drilled");
        badStateEquipment -= 1;
      }
    } else {
      if (holesDrilled == "Good") {
        issuesBucketInspection.add("Holes Drilled");
        badStateEquipment += 1;
      }
    }
    holesDrilled = report;
    notifyListeners();
  }
  void updateBucketLiner(String report) {
    if (report == "Good") {
      if (bucketLiner == "Bad") {
        issuesBucketInspection.remove("Bucket Liner");
        badStateEquipment -= 1;
      }
    } else {
      if (bucketLiner == "Good") {
        issuesBucketInspection.add("Bucket Liner");
        badStateEquipment += 1;
      }
    }
    bucketLiner = report;
    notifyListeners();
  }

  void updateRTAMagnet(String report) {
    if (report == "Good") {
      if (rtaMagnet == "Bad") {
        issuesSecurity.remove("RTA Magnet");
        badStateSecurity -= 1;
      }
    } else {
      if (rtaMagnet == "Good") {
        issuesSecurity.add("RTA Magnet");
        badStateSecurity += 1;
      }
    }
    rtaMagnet = report;
    notifyListeners();
  }
  void updateTriangleReflectors(String report) {
    if (report == "Good") {
      if (triangleReflectors == "Bad") {
        issuesSecurity.remove("Triangle Reflectors");
        badStateSecurity -= 1;
      }
    } else {
      if (triangleReflectors == "Good") {
        issuesSecurity.add("Triangle Reflectors");
        badStateSecurity += 1;
      }
    }
    triangleReflectors = report;
    notifyListeners();
  }
  void updateWheelChocks(String report) {
    if (report == "Good") {
      if (wheelChocks == "Bad") {
        issuesSecurity.remove("Wheel Chocks");
        badStateSecurity -= 1;
      }
    } else {
      if (wheelChocks == "Good") {
        issuesSecurity.add("Wheel Chocks");
        badStateSecurity += 1;
      }
    }
    wheelChocks = report;
    notifyListeners();
  }
  void updateFireExtinguisher(String report) {
    if (report == "Good") {
      if (fireExtinguisher == "Bad") {
        issuesSecurity.remove("Fire Extinguisher");
        badStateSecurity -= 1;
      }
    } else {
      if (fireExtinguisher == "Good") {
        issuesSecurity.add("Fire Extinguisher");
        badStateSecurity += 1;
      }
    }
    fireExtinguisher = report;
    notifyListeners();
  }
  void updateFirstAidKitSafetyVest(String report) {
    if (report == "Good") {
      if (firstAidKitSafetyVest == "Bad") {
        issuesSecurity.remove("First AidKit Safety Vest");
        badStateSecurity -= 1;
      }
    } else {
      if (firstAidKitSafetyVest == "Good") {
        issuesSecurity.add("First AidKit Safety Vest");
        badStateSecurity += 1;
      }
    }
    firstAidKitSafetyVest = report;
    notifyListeners();
  }
  void updateBackUpAlarm(String report) {
    if (report == "Good") {
      if (backUpAlarm == "Bad") {
        issuesSecurity.remove("Back Up Alarm");
        badStateSecurity -= 1;
      }
    } else {
      if (backUpAlarm == "Good") {
        issuesSecurity.add("Back Up Alarm");
        badStateSecurity += 1;
      }
    }
    backUpAlarm = report;
    notifyListeners();
  }

  void updateLadder(String report) {
    if (report == "Good") {
      if (ladder == "Bad") {
        issuesExtra.remove("Ladder");
        badStateSecurity -= 1;
      }
    } else {
      if (ladder == "Good") {
        issuesExtra.add("Ladder");
        badStateSecurity += 1;
      }
    }
    ladder = report;
    notifyListeners();
  }
  void updateStepLadder(String report) {
    if (report == "Good") {
      if (stepLadder == "Bad") {
        issuesExtra.remove("Step Ladder");
        badStateSecurity -= 1;
      }
    } else {
      if (stepLadder == "Good") {
        issuesExtra.add("Step Ladder");
        badStateSecurity += 1;
      }
    }
    stepLadder = report;
    notifyListeners();
  }
  void updateLadderStraps(String report) {
    if (report == "Good") {
      if (ladderStraps == "Bad") {
        issuesExtra.remove("Ladder Straps");
        badStateSecurity -= 1;
      }
    } else {
      if (ladderStraps == "Good") {
        issuesExtra.add("Ladder Straps");
        badStateSecurity += 1;
      }
    }
    ladderStraps = report;
    notifyListeners();
  }
  void updateHydraulicFluidForBucket(String report) {
    if (report == "Good") {
      if (hydraulicFluidForBucket == "Bad") {
        issuesExtra.remove("Hydraulic Fluid For Bucket");
        badStateSecurity -= 1;
      }
    } else {
      if (hydraulicFluidForBucket == "Good") {
        issuesExtra.add("Hydraulic Fluid For Bucket");
        badStateSecurity += 1;
      }
    }
    hydraulicFluidForBucket = report;
    notifyListeners();
  }
  void updateFiberReelRack(String report) {
    if (report == "Good") {
      if (fiberReelRack == "Bad") {
        issuesExtra.remove("Fiber Reel Rack");
        badStateSecurity -= 1;
      }
    } else {
      if (fiberReelRack == "Good") {
        issuesExtra.add("Fiber Reel Rack");
        badStateSecurity += 1;
      }
    }
    fiberReelRack = report;
    notifyListeners();
  }
  void updateBinsLockedAndSecure(String report) {
    if (report == "Good") {
      if (binsLockedAndSecure == "Bad") {
        issuesExtra.remove("Bins Locked And Secure");
        badStateSecurity -= 1;
      }
    } else {
      if (binsLockedAndSecure == "Good") {
        issuesExtra.add("Bins Locked And Secure");
        badStateSecurity += 1;
      }
    }
    binsLockedAndSecure = report;
    notifyListeners();
  }
  void updateSafetyHarness(String report) {
    if (report == "Good") {
      if (safetyHarness == "Bad") {
        issuesExtra.remove("Safety Harness");
        badStateSecurity -= 1;
      }
    } else {
      if (safetyHarness == "Good") {
        issuesExtra.add("Safety Harness");
        badStateSecurity += 1;
      }
    }
    safetyHarness = report;
    notifyListeners();
  }
  void updateLanyardSafetyHarness(String report) {
    if (report == "Good") {
      if (lanyardSafetyHarness == "Bad") {
        issuesExtra.remove("Lanyard Safety Harness");
        badStateSecurity -= 1;
      }
    } else {
      if (lanyardSafetyHarness == "Good") {
        issuesExtra.add("Lanyard Safety Harness");
        badStateSecurity += 1;
      }
    }
    lanyardSafetyHarness = report;
    notifyListeners();
  }

  void updateIgnitionKey(String report) {
    if (report == "Yes") {
      if (ignitionKey == "No") {
        issuesEquipment.remove("Ignition Key");
        badStateEquipment -= 1;
      }
    } else {
      if (ignitionKey == "Yes") {
        issuesEquipment.add("Ignition Key");
        badStateEquipment += 1;
      }
    }
    ignitionKey = report;
    notifyListeners();
  }
  void updateBinsBoxKey(String report) {
    if (report == "Yes") {
      if (binsBoxKey == "No") {
        issuesEquipment.remove("BinsBox Key");
        badStateEquipment -= 1;
      }
    } else {
      if (binsBoxKey == "Yes") {
        issuesEquipment.add("BinsBox Key");
        badStateEquipment += 1;
      }
    }
    binsBoxKey = report;
    notifyListeners();
  }
  void updateVehicleRegistrationCopy(String report) {
    if (report == "Yes") {
      if (vehicleRegistrationCopy == "No") {
        issuesEquipment.remove("Vehicle Registration Copy");
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleRegistrationCopy == "Yes") {
        issuesEquipment.add("Vehicle Registration Copy");
        badStateEquipment += 1;
      }
    }
    vehicleRegistrationCopy = report;
    notifyListeners();
  }
  void updateVehicleInsuranceCopy(String report) {
    if (report == "Yes") {
      if (vehicleInsuranceCopy == "No") {
        issuesEquipment.remove("Vehicle Insurance Copy");
        badStateEquipment -= 1;
      }
    } else {
      if (vehicleInsuranceCopy == "Yes") {
        issuesEquipment.add("Vehicle Insurance Copy");
        badStateEquipment += 1;
      }
    }
    vehicleInsuranceCopy = report;
    notifyListeners();
  }
  void updateBucketLiftOperatorManual(String report) {
    if (report == "Yes") {
      if (bucketLiftOperatorManual == "No") {
        issuesEquipment.remove("Bucket Lift Operator Manual");
        badStateEquipment -= 1;
      }
    } else {
      if (bucketLiftOperatorManual == "Yes") {
        issuesEquipment.add("Bucket Lift Operator Manual");
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
  void deleteGasImage(ImageEvidence image) {
    gasImages.remove(image);
    notifyListeners();
  }
  void addMileageImage(ImageEvidence image) {
    mileageImages.add(image);
    notifyListeners();
  }
  void deleteMileageImage(ImageEvidence image) {
    mileageImages.remove(image);
    notifyListeners();
  }


  void addHeadLightsImage(ImageEvidence image) {
    headLightsImages.add(image);
    notifyListeners();
  }
  void deleteHeadLightsImage(ImageEvidence image) {
    headLightsImages.remove(image);
    notifyListeners();
  }
  void addBrakeLightsImage(ImageEvidence image) {
    brakeLightsImages.add(image);
    notifyListeners();
  }
  void deleteBrakeLightsImage(ImageEvidence image) {
    brakeLightsImages.remove(image);
    notifyListeners();
  }
  void addReverseLightsImage(ImageEvidence image) {
    reverseLightsImages.add(image);
    notifyListeners();
  }
  void deleteReverseLightsImage(ImageEvidence image) {
    reverseLightsImages.remove(image);
    notifyListeners();
  }
  void addWarningLightsImage(ImageEvidence image) {
    warningLightsImages.add(image);
    notifyListeners();
  }
  void deleteWarningLightsImage(ImageEvidence image) {
    warningLightsImages.remove(image);
    notifyListeners();
  }
  void addTurnSignalsImage(ImageEvidence image) {
    turnSignalsImages.add(image);
    notifyListeners();
  }
  void deleteTurnSignalsImage(ImageEvidence image) {
    turnSignalsImages.remove(image);
    notifyListeners();
  }
  void addFourWayFlashersImage(ImageEvidence image) {
    fourWayFlashersImages.add(image);
    notifyListeners();
  }
  void deleteFourWayFlashersImage(ImageEvidence image) {
    fourWayFlashersImages.remove(image);
    notifyListeners();
  }
  void addDashLightsImage(ImageEvidence image) {
    dashLightsImages.add(image);
    notifyListeners();
  }
  void deleteDashLightsImage(ImageEvidence image) {
    dashLightsImages.remove(image);
    notifyListeners();
  }
  void addStrobeLightsImage(ImageEvidence image) {
    strobeLightsImages.add(image);
    notifyListeners();
  }
  void deleteStrobeLightsImage(ImageEvidence image) {
    strobeLightsImages.remove(image);
    notifyListeners();
  }
  void addCabRoofLightsImage(ImageEvidence image) {
    cabRoofLightsImages.add(image);
    notifyListeners();
  }
  void deleteCabRoofLightsImage(ImageEvidence image) {
    cabRoofLightsImages.remove(image);
    notifyListeners();
  }
  void addClearanceLightsImage(ImageEvidence image) {
    clearanceLightsImages.add(image);
    notifyListeners();
  }
  void deleteClearanceLightsImage(ImageEvidence image) {
    clearanceLightsImages.remove(image);
    notifyListeners();
  }


  void addWiperBladesFrontImage(ImageEvidence image) {
    wiperBladesFrontImages.add(image);
    notifyListeners();
  }
  void deleteWiperBladesFrontImage(ImageEvidence image) {
    wiperBladesFrontImages.remove(image);
    notifyListeners();
  }
  void addWiperBladesBackImage(ImageEvidence image) {
    wiperBladesBackImages.add(image);
    notifyListeners();
  }
  void deleteWiperBladesBackImage(ImageEvidence image) {
    wiperBladesBackImages.remove(image);
    notifyListeners();
  }
  void addWindshieldWiperFrontImage(ImageEvidence image) {
    windshieldWiperFrontImages.add(image);
    notifyListeners();
  }
  void deleteWindshieldWiperFrontImage(ImageEvidence image) {
    windshieldWiperFrontImages.remove(image);
    notifyListeners();
  }
  void addWindshieldWiperBackImage(ImageEvidence image) {
    windshieldWiperBackImages.add(image);
    notifyListeners();
  }
  void deleteWindshieldWiperBackImage(ImageEvidence image) {
    windshieldWiperBackImages.remove(image);
    notifyListeners();
  }
  void addGeneralBodyImage(ImageEvidence image) {
    generalBodyImages.add(image);
    notifyListeners();
  }
  void deleteGeneralBodyImage(ImageEvidence image) {
    generalBodyImages.remove(image);
    notifyListeners();
  }
  void addDecalingImage(ImageEvidence image) {
    decalingImages.add(image);
    notifyListeners();
  }
  void deleteDecalingImage(ImageEvidence image) {
    decalingImages.remove(image);
    notifyListeners();
  }
  void addTiresImage(ImageEvidence image) {
    tiresImages.add(image);
    notifyListeners();
  }
  void deleteTiresImage(ImageEvidence image) {
    tiresImages.remove(image);
    notifyListeners();
  }
  void addGlassImage(ImageEvidence image) {
    glassImages.add(image);
    notifyListeners();
  }
  void deleteGlassImage(ImageEvidence image) {
    glassImages.remove(image);
    notifyListeners();
  }
  void addMirrorsImage(ImageEvidence image) {
    mirrorsImages.add(image);
    notifyListeners();
  }
  void deleteMirrorsImage(ImageEvidence image) {
    mirrorsImages.remove(image);
    notifyListeners();
  }
  void addParkingImage(ImageEvidence image) {
    parkingImages.add(image);
    notifyListeners();
  }
  void deleteParkingImage(ImageEvidence image) {
    parkingImages.remove(image);
    notifyListeners();
  }
  void addBrakesImage(ImageEvidence image) {
    brakesImages.add(image);
    notifyListeners();
  }
  void deleteBrakesImage(ImageEvidence image) {
    brakesImages.remove(image);
    notifyListeners();
  }
  void addEMGBrakesImage(ImageEvidence image) {
    emgBrakesImages.add(image);
    notifyListeners();
  }
  void deleteEMGBrakesImage(ImageEvidence image) {
    emgBrakesImages.remove(image);
    notifyListeners();
  }
  void addHornImage(ImageEvidence image) {
    hornImages.add(image);
    notifyListeners();
  }
  void deleteHornImage(ImageEvidence image) {
    hornImages.remove(image);
    notifyListeners();
  }

  void addEngineOilImage(ImageEvidence image) {
    engineOilImages.add(image);
    notifyListeners();
  }
  void deleteEngineOilImage(ImageEvidence image) {
    engineOilImages.remove(image);
    notifyListeners();
  }
  void addTransmissionImage(ImageEvidence image) {
    transmissionImages.add(image);
    notifyListeners();
  }
  void deleteTransmissionImage(ImageEvidence image) {
    transmissionImages.remove(image);
    notifyListeners();
  }
  void addCoolantImage(ImageEvidence image) {
    coolantImages.add(image);
    notifyListeners();
  }
  void deleteCoolantImage(ImageEvidence image) {
    coolantImages.remove(image);
    notifyListeners();
  }
  void addPowerSteeringImage(ImageEvidence image) {
    powerSteeringImages.add(image);
    notifyListeners();
  }
  void deletePowerSteeringImage(ImageEvidence image) {
    powerSteeringImages.remove(image);
    notifyListeners();
  }
  void addDieselExhaustFluidImage(ImageEvidence image) {
    dieselExhaustFluidImages.add(image);
    notifyListeners();
  }
  void deleteDieselExhaustFluidImage(ImageEvidence image) {
    dieselExhaustFluidImages.remove(image);
    notifyListeners();
  }
  void addWindshieldWasherFluidImage(ImageEvidence image) {
    windshieldWasherFluidImages.add(image);
    notifyListeners();
  }
  void deleteWindshieldWasherFluidImage(ImageEvidence image) {
    windshieldWasherFluidImages.remove(image);
    notifyListeners();
  }

  void addInsulatedImage(ImageEvidence image) {
    insulatedImages.add(image);
    notifyListeners();
  }
  void deleteInsulatedImage(ImageEvidence image) {
    insulatedImages.remove(image);
    notifyListeners();
  }
  void addHolesDrilledImage(ImageEvidence image) {
    holesDrilledImages.add(image);
    notifyListeners();
  }
  void deleteHolesDrilledImage(ImageEvidence image) {
    holesDrilledImages.remove(image);
    notifyListeners();
  }
  void addBucketLinerImage(ImageEvidence image) {
    bucketLinerImages.add(image);
    notifyListeners();
  }
  void deleteBucketLinerImage(ImageEvidence image) {
    bucketLinerImages.remove(image);
    notifyListeners();
  }

  void addRTAMagnetImage(ImageEvidence image) {
    rtaMagnetImages.add(image);
    notifyListeners();
  }
  void deleteRTAMagnetImage(ImageEvidence image) {
    rtaMagnetImages.remove(image);
    notifyListeners();
  }
  void addTriangleReflectorsImage(ImageEvidence image) {
    triangleReflectorsImages.add(image);
    notifyListeners();
  }
  void deleteTriangleReflectorsImage(ImageEvidence image) {
    triangleReflectorsImages.remove(image);
    notifyListeners();
  }
  void addWheelChocksImage(ImageEvidence image) {
    wheelChocksImages.add(image);
    notifyListeners();
  }
  void deleteWheelChocksImage(ImageEvidence image) {
    wheelChocksImages.remove(image);
    notifyListeners();
  }
  void addFireExtinguisherImage(ImageEvidence image) {
    fireExtinguisherImages.add(image);
    notifyListeners();
  }
  void deleteFireExtinguisherImage(ImageEvidence image) {
    fireExtinguisherImages.remove(image);
    notifyListeners();
  }
  void addFirstAidKitSafetyVestImage(ImageEvidence image) {
    firstAidKitSafetyVestImages.add(image);
    notifyListeners();
  }
  void deleteFirstAidKitSafetyVestImage(ImageEvidence image) {
    firstAidKitSafetyVestImages.remove(image);
    notifyListeners();
  }
  void addBackUpAlarmImage(ImageEvidence image) {
    backUpAlarmImages.add(image);
    notifyListeners();
  }
  void deleteBackUpAlarmImage(ImageEvidence image) {
    backUpAlarmImages.remove(image);
    notifyListeners();
  }

  void addLadderImage(ImageEvidence image) {
    ladderImages.add(image);
    notifyListeners();
  }
  void deleteLadderImage(ImageEvidence image) {
    ladderImages.remove(image);
    notifyListeners();
  }
  void addStepLadderImage(ImageEvidence image) {
    stepLadderImages.add(image);
    notifyListeners();
  }
  void deleteStepLadderImage(ImageEvidence image) {
    stepLadderImages.remove(image);
    notifyListeners();
  }
  void addLadderStrapsImage(ImageEvidence image) {
    ladderStrapsImages.add(image);
    notifyListeners();
  }
  void deleteLadderStrapsImage(ImageEvidence image) {
    ladderStrapsImages.remove(image);
    notifyListeners();
  }
  void addHydraulicFluidForBucketImage(ImageEvidence image) {
    hydraulicFluidForBucketImages.add(image);
    notifyListeners();
  }
  void deleteHydraulicFluidForBucketImage(ImageEvidence image) {
    hydraulicFluidForBucketImages.remove(image);
    notifyListeners();
  }
  void addFiberReelRackImage(ImageEvidence image) {
    fiberReelRackImages.add(image);
    notifyListeners();
  }
  void deleteFiberReelRackImage(ImageEvidence image) {
    fiberReelRackImages.remove(image);
    notifyListeners();
  }
  void addBinsLockedAndSecureImage(ImageEvidence image) {
    binsLockedAndSecureImages.add(image);
    notifyListeners();
  }
  void deleteBinsLockedAndSecureImage(ImageEvidence image) {
    binsLockedAndSecureImages.remove(image);
    notifyListeners();
  }
  void addSafetyHarnessImage(ImageEvidence image) {
    safetyHarnessImages.add(image);
    notifyListeners();
  }
  void deleteSafetyHarnessImage(ImageEvidence image) {
    safetyHarnessImages.remove(image);
    notifyListeners();
  }
  void addLanyardSafetyHarnessImage(ImageEvidence image) {
    lanyardSafetyHarnessImages.add(image);
    notifyListeners();
  }
  void deleteLanyardSafetyHarnessImage(ImageEvidence image) {
    lanyardSafetyHarnessImages.remove(image);
    notifyListeners();
  }

  void addIgnitionKeyImage(ImageEvidence image) {
    ignitionKeyImages.add(image);
    notifyListeners();
  }
  void deleteIgnitionKeyImage(ImageEvidence image) {
    ignitionKeyImages.remove(image);
    notifyListeners();
  }
  void addBinsBoxKeyImage(ImageEvidence image) {
    binsBoxKeyImages.add(image);
    notifyListeners();
  }
  void deleteBinsBoxKeyImage(ImageEvidence image) {
    binsBoxKeyImages.remove(image);
    notifyListeners();
  }
  void addVehicleRegistrationCopyImage(ImageEvidence image) {
    vehicleRegistrationCopyImages.add(image);
    notifyListeners();
  }
  void deleteVehicleRegistrationCopyImage(ImageEvidence image) {
    vehicleRegistrationCopyImages.remove(image);
    notifyListeners();
  }
  void addVehicleInsuranceCopyImage(ImageEvidence image) {
    vehicleInsuranceCopyImages.add(image);
    notifyListeners();
  }
  void deleteVehicleInsuranceCopyImage(ImageEvidence image) {
    vehicleInsuranceCopyImages.remove(image);
    notifyListeners();
  }
  void addBucketLiftOperatorManualImage(ImageEvidence image) {
    bucketLiftOperatorManualImages.add(image);
    notifyListeners();
  }
  void deleteBucketLiftOperatorManualImage(ImageEvidence image) {
    bucketLiftOperatorManualImages.remove(image);
    notifyListeners();
  }

  //Required images in bad state fields
  void clearInsulated() {
    insulated = "Good";
    badStateEquipment -= 1;
    notifyListeners();
  }
  void clearHolesDrilled() {
    holesDrilled = "Good";
    badStateEquipment -= 1;
    notifyListeners();
  }
  void clearBucketLiner() {
    bucketLiner = "Good";
    badStateEquipment -= 1;
    notifyListeners();
  }

  void clearWiperBladesFront() {
    wiperBladesFront = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearWiperBladesBack() {
    wiperBladesBack = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearWindshieldWiperFront() {
    windshieldWiperFront = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearWindshieldWiperBack() {
    windshieldWiperBack = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearGeneralBody() {
    generalBody = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearDecaling() {
    decaling = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearTires() {
    tires = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearGlass() {
    glass = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearMirrors() {
    mirrors = "Good";
    badStateLights -= 1;
    notifyListeners();
  }
  void clearParking() {
    parking = "Good";
    badStateLights -= 1;
    notifyListeners();
  }

  void cleanInformation()
  {
    //Banderas
    issuesFluidCheck.clear();
    issuesLights.clear();
    issuesCarBodyWork.clear();
    issuesSecurity.clear();
    issuesExtra.clear();
    issuesEquipment.clear();
    issuesBucketInspection.clear();
    from.clear();
    password.clear();
    to.clear();
    subject.clear();
    body.clear();

    flagOilChange = false;
    flagTransmissionFluidChange = false;
    flagRadiatorFluidChange = false;
    flagTireChange = false;
    flagBrakeChange = false;

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
  
  bool addControlForm(Users? user, Vehicle? vehicleRevision, DateTime dateAddedR) {
    try {
     
        notifyListeners();
        return false;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  bool sendEmail(Users user) {
    return true;
 }
}