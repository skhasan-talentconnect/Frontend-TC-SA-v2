class SupportModel {
  String? supportId;
  String? category;
  String? title;
  String? description;
  String? studId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SupportModel({
    this.supportId,
    this.category,
    this.title,
    this.description,
    this.studId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SupportModel.fromJson(Map<String, dynamic> json) {
    supportId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    studId = json['studId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = supportId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['studId'] = this.studId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
