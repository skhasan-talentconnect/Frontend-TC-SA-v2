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
  String? rank;
  String? status;
  String? mobileNo;
  List<String>? languageMedium;
  String? transportAvailable;
  String? createdAt;
  String? updatedAt;
  int? iV;

  // 🆕 Added social handles
  String? instagramHandle;
  String? twitterHandle;
  String? linkedinHandle;

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
    this.rank,
    this.status,
    this.mobileNo,
    this.languageMedium,
    this.transportAvailable,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.instagramHandle,
    this.twitterHandle,
    this.linkedinHandle,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        board: json['board'] as String?,
        state: json['state'] as String?,
        city: json['city'] as String?,
        schoolMode: json['schoolMode'] as String?,
        genderType: json['genderType'] as String?,
        shifts: (json['shifts'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        feeRange: json['feeRange'] as String?,
        upto: json['upto'] as String?,
        email: json['email'] as String?,
        specialist: (json['specialist'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        website: json['website'] as String?,
        rank: json['rank'] as String?,
        status: json['status'] as String?,
        mobileNo: json['mobileNo'] as String?,
        languageMedium: (json['languageMedium'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        transportAvailable: json['transportAvailable'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        iV: json['__v'] is int ? json['__v'] as int : int.tryParse('${json['__v'] ?? ''}'),
        instagramHandle: json['instagramHandle'] as String?,
        twitterHandle: json['twitterHandle'] as String?,
        linkedinHandle: json['linkedinHandle'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'board': board,
        'state': state,
        'city': city,
        'schoolMode': schoolMode,
        'genderType': genderType,
        'shifts': shifts ?? const [],
        'feeRange': feeRange,
        'upto': upto,
        'email': email,
        'specialist': specialist ?? const [],
        'tags': tags ?? const [],
        'website': website,
        'rank': rank,
        'status': status,
        'mobileNo': mobileNo,
        'languageMedium': languageMedium ?? const [],
        'transportAvailable': transportAvailable,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
        'instagramHandle': instagramHandle,
        'twitterHandle': twitterHandle,
        'linkedinHandle': linkedinHandle,
      };
}
