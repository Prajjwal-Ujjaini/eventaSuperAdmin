class ServiceTypeModel {
  String? serviceTypeId;
  String? serviceTypeName;
  String? serviceTypeDescription;
  String? createdAt;
  String? updatedAt;

  ServiceTypeModel({
    this.serviceTypeId,
    this.serviceTypeName,
    this.serviceTypeDescription,
    this.createdAt,
    this.updatedAt,
  });

  ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['serviceTypeId'];
    serviceTypeName = json['serviceTypeName'];
    serviceTypeDescription = json['serviceTypeDescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceTypeId'] = serviceTypeId;
    data['serviceTypeName'] = serviceTypeName;
    data['serviceTypeDescription'] = serviceTypeDescription;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
