class ActivitiesModel {
  String? schoolId;
  List<String>? activities;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ActivitiesModel({
    this.schoolId,
    this.activities,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ActivitiesModel.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    activities = json['activities'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['activities'] = this.activities;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;

    return data;
  }
}
