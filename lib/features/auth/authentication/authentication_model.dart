class AuthenticationModel {
  String? sId;
  String? email;
  String? password;
  bool? isEmailVerified;
  String? userType;
  String? authProvider;
  String? deviceToken;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AuthenticationModel({
    this.sId,
    this.email,
    this.password,
    this.isEmailVerified,
    this.userType,
    this.authProvider,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
    userType = json['userType'];
    authProvider = json['authProvider'];
    deviceToken = json['deviceToken'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isEmailVerified'] = this.isEmailVerified;
    data['userType'] = this.userType;
    data['authProvider'] = this.authProvider;
    data['deviceToken'] = this.deviceToken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
