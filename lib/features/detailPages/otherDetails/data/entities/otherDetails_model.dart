class OtherDetailsModel {
  final String? id;
  final String? schoolId;
  final GenderRatioModel? genderRatio;
  final ScholarshipDiversityModel? scholarshipDiversity;
  final SpecialNeedsSupportModel? specialNeedsSupport;

  OtherDetailsModel({
    this.id,
    this.schoolId,
    this.genderRatio,
    this.scholarshipDiversity,
    this.specialNeedsSupport,
  });

  factory OtherDetailsModel.fromJson(Map<String, dynamic> json) {
    return OtherDetailsModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      genderRatio: json['genderRatio'] != null
          ? GenderRatioModel.fromJson(json['genderRatio'])
          : null,
      scholarshipDiversity: json['scholarshipDiversity'] != null
          ? ScholarshipDiversityModel.fromJson(json['scholarshipDiversity'])
          : null,
      specialNeedsSupport: json['specialNeedsSupport'] != null
          ? SpecialNeedsSupportModel.fromJson(json['specialNeedsSupport'])
          : null,
    );
  }
}

class GenderRatioModel {
  final double? male;
  final double? female;
  final double? others;

  GenderRatioModel({this.male, this.female, this.others});

  factory GenderRatioModel.fromJson(Map<String, dynamic> json) {
    return GenderRatioModel(
      male: (json['male'] as num?)?.toDouble(),
      female: (json['female'] as num?)?.toDouble(),
      others: (json['others'] as num?)?.toDouble(),
    );
  }
}

class ScholarshipDiversityModel {
  final List<String> types;
  final int? studentsCoveredPercentage;

  ScholarshipDiversityModel({
    this.types = const [],
    this.studentsCoveredPercentage,
  });

  factory ScholarshipDiversityModel.fromJson(Map<String, dynamic> json) {
    return ScholarshipDiversityModel(
      types: (json['types'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      studentsCoveredPercentage: json['studentsCoveredPercentage'] as int?,
    );
  }
}

class SpecialNeedsSupportModel {
  final bool? dedicatedStaff;
  final int? studentsSupportedPercentage;
  final List<String> facilitiesAvailable;

  SpecialNeedsSupportModel({
    this.dedicatedStaff,
    this.studentsSupportedPercentage,
    this.facilitiesAvailable = const [],
  });

  factory SpecialNeedsSupportModel.fromJson(Map<String, dynamic> json) {
    return SpecialNeedsSupportModel(
      dedicatedStaff: json['dedicatedStaff'] as bool?,
      studentsSupportedPercentage: json['studentsSupportedPercentage'] as int?,
      facilitiesAvailable: (json['facilitiesAvailable'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }
}