// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  bool status;
  List<UserData>? data;
  String? token;
  String? message;

  LoginData({
    this.status = false,
    this.data,
    this.token,
    this.message,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    status: json["status"],
    data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromJson(x))),
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "token": token,
    "message": message,
  };
}

class UserData {
  int? id;
  String? username;
  String? phone;
  dynamic password;
  dynamic profile;
  dynamic proof1;
  dynamic proof2;
  String? apiToken;
  String? deviceToken;
  String? deviceType;
  String? wallet;
  int? reserveWallet;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.username,
    this.phone,
    this.password,
    this.profile,
    this.proof1,
    this.proof2,
    this.apiToken,
    this.deviceToken,
    this.deviceType,
    this.wallet,
    this.reserveWallet,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    username: json["username"],
    phone: json["phone"],
    password: json["password"],
    profile: json["profile"],
    proof1: json["proof1"],
    proof2: json["proof2"],
    apiToken: json["api_token"],
    deviceToken: json["device_token"],
    deviceType: json["device_type"],
    wallet: json["wallet"],
    reserveWallet: json["reserve_wallet"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "phone": phone,
    "password": password,
    "profile": profile,
    "proof1": proof1,
    "proof2": proof2,
    "api_token": apiToken,
    "device_token": deviceToken,
    "device_type": deviceType,
    "wallet": wallet,
    "reserve_wallet": reserveWallet,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
