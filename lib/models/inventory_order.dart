import 'dart:convert';

class InventoryOrder {
  int? orderId;
  String? orderType;
  int? customerId;
  dynamic creatorEmail;
  List<OrderAction>? orderActions;
  int? orderTypeId;
  String? customerEmail;
  String? customerPhone;
  DateTime? orderCreation;
  DateTime? orderFinished;
  String? customerStatus;
  dynamic orderCreatorId;
  dynamic creatorLastName;
  DateTime? customerCreation;
  dynamic creatorFirstName;
  String? customerLastName;
  String? customerFirstName;
  dynamic creatorSequentialId;

  InventoryOrder({
    this.orderId,
    this.orderType,
    this.customerId,
    this.creatorEmail,
    this.orderActions,
    this.orderTypeId,
    this.customerEmail,
    this.customerPhone,
    this.orderCreation,
    this.orderFinished,
    this.customerStatus,
    this.orderCreatorId,
    this.creatorLastName,
    this.customerCreation,
    this.creatorFirstName,
    this.customerLastName,
    this.customerFirstName,
    this.creatorSequentialId,
  });

  get fullName => '$customerFirstName $customerLastName';

  factory InventoryOrder.fromJson(String str) => InventoryOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InventoryOrder.fromMap(Map<String, dynamic> json) => InventoryOrder(
        orderId: json["order_id"],
        orderType: json["order_type"],
        customerId: json["customer_id"],
        creatorEmail: json["creator_email"],
        orderActions: json["order_actions"] == null ? [] : List<OrderAction>.from(json["order_actions"]!.map((x) => OrderAction.fromMap(x))),
        orderTypeId: json["order_type_id"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        orderCreation: json["order_creation"] == null ? null : DateTime.parse(json["order_creation"]),
        orderFinished: json["order_finished"] == null ? null : DateTime.parse(json["order_finished"]),
        customerStatus: json["customer_status"],
        orderCreatorId: json["order_creator_id"],
        creatorLastName: json["creator_last_name"],
        customerCreation: json["customer_creation"] == null ? null : DateTime.parse(json["customer_creation"]),
        creatorFirstName: json["creator_first_name"],
        customerLastName: json["customer_last_name"],
        customerFirstName: json["customer_first_name"],
        creatorSequentialId: json["creator_sequential_id"],
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "order_type": orderType,
        "customer_id": customerId,
        "creator_email": creatorEmail,
        "order_actions": orderActions == null ? [] : List<dynamic>.from(orderActions!.map((x) => x.toMap())),
        "order_type_id": orderTypeId,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "order_creation": orderCreation?.toIso8601String(),
        "order_finished": orderFinished?.toIso8601String(),
        "customer_status": customerStatus,
        "order_creator_id": orderCreatorId,
        "creator_last_name": creatorLastName,
        "customer_creation": customerCreation?.toIso8601String(),
        "creator_first_name": creatorFirstName,
        "customer_last_name": customerLastName,
        "customer_first_name": customerFirstName,
        "creator_sequential_id": creatorSequentialId,
      };
}

class OrderAction {
  String? status;
  int? orderFk;
  DateTime? startedAt;
  dynamic startedBy;
  DateTime? finishedAt;
  dynamic finishedBy;
  int? orderActionId;
  int? orderStatusFk;

  OrderAction({
    this.status,
    this.orderFk,
    this.startedAt,
    this.startedBy,
    this.finishedAt,
    this.finishedBy,
    this.orderActionId,
    this.orderStatusFk,
  });

  factory OrderAction.fromJson(String str) => OrderAction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderAction.fromMap(Map<String, dynamic> json) => OrderAction(
        status: json["status"],
        orderFk: json["order_fk"],
        startedAt: json["started_at"] == null ? null : DateTime.parse(json["started_at"]),
        startedBy: json["started_by"],
        finishedAt: json["finished_at"] == null ? null : DateTime.parse(json["finished_at"]),
        finishedBy: json["finished_by"],
        orderActionId: json["order_action_id"],
        orderStatusFk: json["order_status_fk"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "order_fk": orderFk,
        "started_at": startedAt?.toIso8601String(),
        "started_by": startedBy,
        "finished_at": finishedAt?.toIso8601String(),
        "finished_by": finishedBy,
        "order_action_id": orderActionId,
        "order_status_fk": orderStatusFk,
      };
}