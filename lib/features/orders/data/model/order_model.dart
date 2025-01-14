// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool? status;
  List<MyOrder>? data;
  String? message;

  OrderModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<MyOrder>.from(json["data"]!.map((x) => MyOrder.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class MyOrder {
  int? id;
  int? chargingStatusesId;
  int? appusersId;
  String? sessionId;
  String? startTime;
  String? endTime;
  String? status; /// 0: Upcoming, 1: Start, 2: Complete, 3: Gone
  String? endTimeExtend;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? actualStartTime;
  String? actualEndTime;
  dynamic emspApiStartSessionStatus;
  dynamic emspApiStopSessionStatus;
  String? kwh;
  ChargingStation? chargingStation;
  Wallet? wallet;

  MyOrder({
    this.id,
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
    this.emspApiStartSessionStatus,
    this.emspApiStopSessionStatus,
    this.kwh,
    this.chargingStation,
    this.wallet,
  });

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
    id: json["id"],
    chargingStatusesId: json["charging_statuses_id"],
    appusersId: json["appusers_id"],
    sessionId: json["session_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    status: json["status"],
    endTimeExtend: json["end_time_extend"],
    amount: json["amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    actualStartTime: json["actual_start_time"],
    actualEndTime: json["actual_end_time"],
    emspApiStartSessionStatus: json["emsp_api_start_session_status"],
    emspApiStopSessionStatus: json["emsp_api_stop_session_status"],
    kwh: json["kwh"],
    chargingStation: json["charging_station"] == null ? null : ChargingStation.fromJson(json["charging_station"]),
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "charging_statuses_id": chargingStatusesId,
    "appusers_id": appusersId,
    "session_id": sessionId,
    "start_time": startTime,
    "end_time": endTime,
    "status": status,
    "end_time_extend": endTimeExtend,
    "amount": amount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "actual_start_time": actualStartTime,
    "actual_end_time": actualEndTime,
    "emsp_api_start_session_status": emspApiStartSessionStatus,
    "emsp_api_stop_session_status": emspApiStopSessionStatus,
    "kwh": kwh,
    "charging_station": chargingStation?.toJson(),
    "wallet": wallet?.toJson(),
  };
}

class ChargingStation {
  int? id;
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
  String? image1;
  String? image2;
  String? image3;
  int? morningRate;
  String? morningStartTime;
  String? morningEndTime;
  int? afternoonRate;
  String? afternoonStartTime;
  String? afternoonEndTime;
  int? eveningRate;
  String? eveningStartTime;
  String? eveningEndTime;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? powerStatus;
  dynamic powerStatusUpdatedAt;

  ChargingStation({
    this.id,
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
    this.image1,
    this.image2,
    this.image3,
    this.morningRate,
    this.morningStartTime,
    this.morningEndTime,
    this.afternoonRate,
    this.afternoonStartTime,
    this.afternoonEndTime,
    this.eveningRate,
    this.eveningStartTime,
    this.eveningEndTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.powerStatus,
    this.powerStatusUpdatedAt,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) => ChargingStation(
    id: json["id"],
    deviceId: json["device_id"],
    locationId: json["location_id"],
    evseUid: json["evse_uid"],
    connectorId: json["connector_id"],
    name: json["name"],
    mobileNo: json["mobile_no"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    morningRate: json["morning_rate"],
    morningStartTime: json["morning_start_time"],
    morningEndTime: json["morning_end_time"],
    afternoonRate: json["afternoon_rate"],
    afternoonStartTime: json["afternoon_start_time"],
    afternoonEndTime: json["afternoon_end_time"],
    eveningRate: json["evening_rate"],
    eveningStartTime: json["evening_start_time"],
    eveningEndTime: json["evening_end_time"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    powerStatus: json["power_status"],
    powerStatusUpdatedAt: json["power_status_updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "device_id":deviceId,
    "location_id": locationId,
    "evse_uid": evseUid,
    "connector_id": connectorId,
    "name": name,
    "mobile_no": mobileNo,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "morning_rate": morningRate,
    "morning_start_time": morningStartTime,
    "morning_end_time": morningEndTime,
    "afternoon_rate": afternoonRate,
    "afternoon_start_time": afternoonStartTime,
    "afternoon_end_time":afternoonEndTime,
    "evening_rate": eveningRate,
    "evening_start_time": eveningStartTime,
    "evening_end_time": eveningEndTime,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "power_status": powerStatus,
    "power_status_updated_at": powerStatusUpdatedAt,
  };
}


class Wallet {
  int? id;
  int? appusersId;
  int? bookingsId;
  String? amount;
  String? walletType;
  dynamic transactionId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Wallet({
    this.id,
    this.appusersId,
    this.bookingsId,
    this.amount,
    this.walletType,
    this.transactionId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    appusersId: json["appusers_id"],
    bookingsId: json["bookings_id"],
    amount: json["amount"],
    walletType: json["wallet_type"],
    transactionId: json["transaction_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appusers_id": appusersId,
    "bookings_id": bookingsId,
    "amount": amount,
    "wallet_type":walletType,
    "transaction_id": transactionId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

