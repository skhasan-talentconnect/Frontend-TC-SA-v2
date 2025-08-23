class SchoolModel {
  String? id;
  String? name;
  String? description;
  String? board;
  String? state;
  String? city;
  String? schoolMode;
  String? genderType;
  List<String>? shifts;
  String? feeRange;
  String? upto;
  String? email;
  List<String>? specialist;
  List<String>? tags;
  String? website;
  String? status;
  String? mobileNo;
  List<String>? languageMedium;
  String? transportAvailable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SchoolModel({
    this.id,
    this.name,
    this.description,
    this.board,
    this.state,
    this.city,
    this.schoolMode,
    this.genderType,
    this.shifts,
    this.feeRange,
    this.upto,
    this.email,
    this.specialist,
    this.tags,
    this.website,
    this.status,
    this.mobileNo,
    this.languageMedium,
    this.transportAvailable,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SchoolModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    board = json['board'];
    state = json['state'];
    city = json['city'];
    schoolMode = json['schoolMode'];
    genderType = json['genderType'];
    shifts = json['shifts'].cast<String>();
    feeRange = json['feeRange'];
    upto = json['upto'];
    email = json['email'];
    specialist = json['specialist'].cast<String>();
    tags = json['tags'].cast<String>();
    website = json['website'];
    status = json['status'];
    mobileNo = json['mobileNo'];
    languageMedium = json['languageMedium'].cast<String>();
    transportAvailable = json['transportAvailable'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['board'] = this.board;
    data['state'] = this.state;
    data['city'] = this.city;
    data['schoolMode'] = this.schoolMode;
    data['genderType'] = this.genderType;
    data['shifts'] = this.shifts;
    data['feeRange'] = this.feeRange;
    data['upto'] = this.upto;
    data['email'] = this.email;
    data['specialist'] = this.specialist;
    data['tags'] = this.tags;
    data['website'] = this.website;
    data['status'] = this.status;
    data['mobileNo'] = this.mobileNo;
    data['languageMedium'] = this.languageMedium;
    data['transportAvailable'] = this.transportAvailable;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
