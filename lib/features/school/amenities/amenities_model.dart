class AmenitiesModel {
  String? schoolId;
  List<String>? predefinedAmenities;
  List<String>? customAmenities;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AmenitiesModel({
    this.schoolId,
    this.predefinedAmenities,
    this.customAmenities,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AmenitiesModel.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    predefinedAmenities = json['predefinedAmenities'].cast<String>();
    customAmenities = json['customAmenities'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['predefinedAmenities'] = this.predefinedAmenities;
    data['customAmenities'] = this.customAmenities;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
