// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

VerificationModel verificationModelFromJson(String str) => VerificationModel.fromJson(json.decode(str));

String verificationModelToJson(VerificationModel data) => json.encode(data.toJson());

class VerificationModel {
  VerificationModel({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory VerificationModel.fromJson(Map<String, dynamic> json) => VerificationModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.avsId,
    required this.name,
    required this.email,
    required this.phone,
    required this.landlordEmail,
    required this.landlordPhone,
    required this.apartmentType,
    required this.rentValue,
    required this.owedPrevious,
    required this.tenantAddress,
    required this.businessName,
    required this.approveAmount,
    required this.clientAddress,
    required this.deviceStatus,
    required this.ownershipStatus,
    required this.clientAfford,
    required this.updatedAt,
    required this.createdAt,
  });

  int id;
  String avsId;
  String name;
  String email;
  String phone;
  String landlordEmail;
  String landlordPhone;
  String apartmentType;
  String rentValue;
  String owedPrevious;
  String tenantAddress;
  String businessName;
  String approveAmount;
  String clientAddress;
  String deviceStatus;
  String ownershipStatus;
  String clientAfford;
  DateTime updatedAt;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    avsId: json["avs_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    landlordEmail: json["landlord_email"],
    landlordPhone: json["landlord_phone"],
    apartmentType: json["apartment_type"],
    rentValue: json["rent_value"],
    owedPrevious: json["owed_previous"],
    tenantAddress: json["tenant_address"],
    businessName: json["business_name"],
    approveAmount: json["approve_amount"],
    clientAddress: json["client_address"],
    deviceStatus: json["device_status"],
    ownershipStatus: json["ownership_status"],
    clientAfford: json["client_afford"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avs_id": avsId,
    "name": name,
    "email": email,
    "phone": phone,
    "landlord_email": landlordEmail,
    "landlord_phone": landlordPhone,
    "apartment_type": apartmentType,
    "rent_value": rentValue,
    "owed_previous": owedPrevious,
    "tenant_address": tenantAddress,
    "business_name": businessName,
    "approve_amount": approveAmount,
    "client_address": clientAddress,
    "device_status": deviceStatus,
    "ownership_status": ownershipStatus,
    "client_afford": clientAfford,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
