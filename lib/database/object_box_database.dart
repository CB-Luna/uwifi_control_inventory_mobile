import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';
// import 'package:uwifi_control_inventory_mobile/objectbox.g.dart';

class ObjectBoxDatabase {
  late final Store store;

  late final Box<Users> usersBox;
  late final Box<Vehicle> vehicleBox;
  late final Box<ControlForm> controlFormBox;
  late final Box<Measures> measuresFormBox;
  late final Box<Lights> lightsFormBox;
  late final Box<CarBodywork> carBodyworkFormBox;
  late final Box<FluidsCheck> fluidsCheckFormBox;
  late final Box<BucketInspection> bucketInspectionFormBox;
  late final Box<Security> securityFormBox;
  late final Box<Extra> extraFormBox;
  late final Box<Equipment> equipmentFormBox;
  late final Box<Status> statusBox;
  late final Box<Company> companyBox;
  late final Box<Service> serviceBox;
  late final Box<VehicleServices> vehicleServicesBox;
  late final Box<Bitacora> bitacoraBox;
  late final Box<Role> roleBox;
  late final Box<Rule> ruleBox;
  late final Box<Image> imageBox;

  ObjectBoxDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    usersBox = Box<Users>(store);
    vehicleBox = Box<Vehicle>(store);
    controlFormBox = Box<ControlForm>(store);
    measuresFormBox = Box<Measures>(store);
    lightsFormBox = Box<Lights>(store);
    carBodyworkFormBox = Box<CarBodywork>(store);
    fluidsCheckFormBox = Box<FluidsCheck>(store);
    bucketInspectionFormBox = Box<BucketInspection>(store);
    securityFormBox = Box<Security>(store);
    extraFormBox = Box<Extra>(store);
    equipmentFormBox = Box<Equipment>(store);
    statusBox = Box<Status>(store);
    serviceBox = Box<Service>(store);
    vehicleServicesBox = Box<VehicleServices>(store);
    companyBox = Box<Company>(store);
    bitacoraBox = Box<Bitacora>(store);
    roleBox = Box<Role>(store);
    ruleBox = Box<Rule>(store);
    imageBox = Box<Image>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBoxDatabase._create(store);
  }
}
