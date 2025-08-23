class ProfileModel {
  String? authId;
  String? email;
  String? contactNo;
  String? dateOfBirth;
  String? name;
  String? gender;
  String? state;
  String? city;
  List<String>? shortlistedSchools;
  String? userType;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProfileModel({
    this.authId,
    this.email,
    this.contactNo,
    this.dateOfBirth,
    this.name,
    this.gender,
    this.state,
    this.city,
    this.userType,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.shortlistedSchools,
    this.iV,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    authId = json['authId'];
    email = json['email'];
    contactNo = json['contactNo'];
    dateOfBirth = json['dateOfBirth'];
    name = json['name'];
    gender = json['gender'];
    state = json['state'];
    city = json['city'];
    userType = json['userType'];
    shortlistedSchools = json['shortlistedSchools'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authId'] = this.authId;
    data['email'] = this.email;
    data['contactNo'] = this.contactNo;
    data['dateOfBirth'] = this.dateOfBirth;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['state'] = this.state;
    data['city'] = this.city;
    data['userType'] = this.userType;
    data['_id'] = this.sId;
    data['shortlistedSchools'] = this.shortlistedSchools;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
