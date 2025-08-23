class PreferenceModel {
  String? sId;
  String? studentId;
  String? state;
  String? city;
  String? boards;
  String? preferredStandard;
  String? interests;
  String? schoolType;
  String? shift;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PreferenceModel(
      {this.sId,
        this.studentId,
        this.state,
        this.city,
        this.boards,
        this.preferredStandard,
        this.interests,
        this.schoolType,
        this.shift,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PreferenceModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    studentId = json['studentId'];
    state = json['state'];
    city = json['city'];
    boards = json['boards'];
    preferredStandard = json['preferredStandard'];
    interests = json['interests'];
    schoolType = json['schoolType'];
    shift = json['shift'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['studentId'] = this.studentId;
    data['state'] = this.state;
    data['city'] = this.city;
    data['boards'] = this.boards;
    data['preferredStandard'] = this.preferredStandard;
    data['interests'] = this.interests;
    data['schoolType'] = this.schoolType;
    data['shift'] = this.shift;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}