
class AvisListModel {
  List<Data>? data;
  bool? status;

  AvisListModel({this.data, this.status});

  AvisListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? avsId;
  String? agentName;
  String? agentPhone;
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
  String? request;
  String? verified;
  String? assigned;
  String? vertical;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.avsId,
        this.agentName,
        this.agentPhone,
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
        this.request,
        this.verified,
        this.assigned,
        this.vertical,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avsId = json['avs_id'];
    agentName = json['agent_name'];
    agentPhone = json['agent_phone'];
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
    request = json['request'];
    verified = json['verified'];
    assigned = json['assigned'];
    vertical = json['vertical'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avs_id'] = this.avsId;
    data['agent_name'] = this.agentName;
    data['agent_phone'] = this.agentPhone;
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
    data['request'] = this.request;
    data['verified'] = this.verified;
    data['assigned'] = this.assigned;
    data['vertical'] = this.vertical;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
