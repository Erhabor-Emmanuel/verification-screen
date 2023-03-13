class VerifyModel {
  String? message;
  Data? data;

  VerifyModel({this.message, this.data});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? avsId;
  String? name;
  String? email;
  String? phone;
  String? landlordEmail;
  String? landlordPhone;
  String? apartmentType;
  String? rentValue;
  String? owedPrevious;
  String? tenantAddress;
  String? businessName;
  String? approveAmount;
  String? clientAddress;
  String? deviceStatus;
  String? ownershipStatus;
  String? clientAfford;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.avsId,
        this.name,
        this.email,
        this.phone,
        this.landlordEmail,
        this.landlordPhone,
        this.apartmentType,
        this.rentValue,
        this.owedPrevious,
        this.tenantAddress,
        this.businessName,
        this.approveAmount,
        this.clientAddress,
        this.deviceStatus,
        this.ownershipStatus,
        this.clientAfford,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avsId = json['avs_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    landlordEmail = json['landlord_email'];
    landlordPhone = json['landlord_phone'];
    apartmentType = json['apartment_type'];
    rentValue = json['rent_value'];
    owedPrevious = json['owed_previous'];
    tenantAddress = json['tenant_address'];
    businessName = json['business_name'];
    approveAmount = json['approve_amount'];
    clientAddress = json['client_address'];
    deviceStatus = json['device_status'];
    ownershipStatus = json['ownership_status'];
    clientAfford = json['client_afford'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avs_id'] = this.avsId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['landlord_email'] = this.landlordEmail;
    data['landlord_phone'] = this.landlordPhone;
    data['apartment_type'] = this.apartmentType;
    data['rent_value'] = this.rentValue;
    data['owed_previous'] = this.owedPrevious;
    data['tenant_address'] = this.tenantAddress;
    data['business_name'] = this.businessName;
    data['approve_amount'] = this.approveAmount;
    data['client_address'] = this.clientAddress;
    data['device_status'] = this.deviceStatus;
    data['ownership_status'] = this.ownershipStatus;
    data['client_afford'] = this.clientAfford;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
