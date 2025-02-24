class ServiceTypeModel {
  String? serviceTypeId;
  String? serviceTypeName;
  String? serviceTypeDescription;
  String? image;
  String? createdAt;
  String? updatedAt;

  // Default constructor with optional parameters
  ServiceTypeModel({
    this.serviceTypeId = '',
    this.serviceTypeName = '',
    this.serviceTypeDescription = '',
    this.image = '',
    this.createdAt,
    this.updatedAt,
  });

  // ServiceTypeModel({
  //   this.serviceTypeId,
  //   this.serviceTypeName,
  //   this.serviceTypeDescription,
  //   this.image,
  //   this.createdAt,
  //   this.updatedAt,
  // });

  ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['_id'];
    serviceTypeName = json['serviceTypeName'];
    serviceTypeDescription = json['serviceTypeDescription'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = serviceTypeId;
    data['serviceTypeName'] = serviceTypeName;
    data['serviceTypeDescription'] = serviceTypeDescription;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'ServiceTypeModel(serviceTypeId: $serviceTypeId, serviceTypeName: $serviceTypeName, serviceTypeDescription: $serviceTypeDescription, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
