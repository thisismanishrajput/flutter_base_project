import 'package:objectbox/objectbox.dart';

@Entity()
class OrderModel {
  @Id()
  int id = 0;

  bool? status;
  String? message;
  final data = ToMany<MyOrder>(); // Establish relation with MyOrder

  OrderModel({
    this.status,
    this.message,
  });

  // fromJson method
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final orderModel = OrderModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

    if (json['data'] != null) {
      (json['data'] as List).forEach((item) {
        orderModel.data.add(MyOrder.fromJson(item));
      });
    }

    return orderModel;
  }
}

@Entity()
class MyOrder {
  @Id()
  int id = 0;

  int? chargingStatusesId;
  int? appusersId;
  String? sessionId;
  String? startTime;
  String? endTime;
  String? status;
  String? endTimeExtend;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? actualStartTime;
  String? actualEndTime;
  String? kwh;

  final chargingStation = ToOne<ChargingStation>(); // Relation to ChargingStation
  final wallet = ToOne<Wallet>(); // Relation to Wallet

  MyOrder({
    this.chargingStatusesId,
    this.appusersId,
    this.sessionId,
    this.startTime,
    this.endTime,
    this.status,
    this.endTimeExtend,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.actualStartTime,
    this.actualEndTime,
    this.kwh,
  });

  // fromJson method
  factory MyOrder.fromJson(Map<String, dynamic> json) {
    final myOrder = MyOrder(
      chargingStatusesId: json['chargingStatusesId'] as int?,
      appusersId: json['appusersId'] as int?,
      sessionId: json['sessionId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      status: json['status'] as String?,
      endTimeExtend: json['endTimeExtend'] as String?,
      amount: json['amount'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      actualStartTime: json['actualStartTime'] as String?,
      actualEndTime: json['actualEndTime'] as String?,
      kwh: json['kwh'] as String?,
    );

    if (json['chargingStation'] != null) {
      myOrder.chargingStation.target = ChargingStation.fromJson(json['chargingStation']);
    }

    if (json['wallet'] != null) {
      myOrder.wallet.target = Wallet.fromJson(json['wallet']);
    }

    return myOrder;
  }
}

@Entity()
class ChargingStation {
  @Id()
  int id = 0;

  String? deviceId;
  String? locationId;
  String? evseUid;
  String? connectorId;
  String? name;
  String? mobileNo;
  String? address;
  String? latitude;
  String? longitude;
  String? description;

  ChargingStation({
    this.deviceId,
    this.locationId,
    this.evseUid,
    this.connectorId,
    this.name,
    this.mobileNo,
    this.address,
    this.latitude,
    this.longitude,
    this.description,
  });

  // fromJson method
  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      deviceId: json['deviceId'] as String?,
      locationId: json['locationId'] as String?,
      evseUid: json['evseUid'] as String?,
      connectorId: json['connectorId'] as String?,
      name: json['name'] as String?,
      mobileNo: json['mobileNo'] as String?,
      address: json['address'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      description: json['description'] as String?,
    );
  }
}

@Entity()
class Wallet {
  @Id()
  int id = 0;

  int? appusersId;
  int? bookingsId;
  String? amount;
  String? walletType;

  Wallet({
    this.appusersId,
    this.bookingsId,
    this.amount,
    this.walletType,
  });

  // fromJson method
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      appusersId: json['appusersId'] as int?,
      bookingsId: json['bookingsId'] as int?,
      amount: json['amount'] as String?,
      walletType: json['walletType'] as String?,
    );
  }
}
