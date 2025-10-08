class InternationalExposureModel {
  final String? id;
  final String? schoolId;
  final List<ExchangeProgramModel> exchangePrograms;
  final List<GlobalTieUpModel> globalTieUps;

  InternationalExposureModel({
    this.id,
    this.schoolId,
    this.exchangePrograms = const [],
    this.globalTieUps = const [],
  });

  factory InternationalExposureModel.fromJson(Map<String, dynamic> json) {
    return InternationalExposureModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      exchangePrograms: (json['exchangePrograms'] as List<dynamic>?)
              ?.map((e) => ExchangeProgramModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      globalTieUps: (json['globalTieUps'] as List<dynamic>?)
              ?.map((e) => GlobalTieUpModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class ExchangeProgramModel {
  final String? partnerSchool;
  final String? programType;
  final String? duration;
  final int? studentsParticipated;
  final int? activeSince;

  ExchangeProgramModel({
    this.partnerSchool,
    this.programType,
    this.duration,
    this.studentsParticipated,
    this.activeSince,
  });

  factory ExchangeProgramModel.fromJson(Map<String, dynamic> json) {
    return ExchangeProgramModel(
      partnerSchool: json['partnerSchool'] as String?,
      programType: json['programType'] as String?,
      duration: json['duration'] as String?,
      studentsParticipated: json['studentsParticipated'] as int?,
      activeSince: json['activeSince'] as int?,
    );
  }
}

class GlobalTieUpModel {
  final String? partnerName;
  final String? natureOfTieUp;
  final int? activeSince;
  final String? description;

  GlobalTieUpModel({
    this.partnerName,
    this.natureOfTieUp,
    this.activeSince,
    this.description,
  });

  factory GlobalTieUpModel.fromJson(Map<String, dynamic> json) {
    return GlobalTieUpModel(
      partnerName: json['partnerName'] as String?,
      natureOfTieUp: json['natureOfTieUp'] as String?,
      activeSince: json['activeSince'] as int?,
      description: json['description'] as String?,
    );
  }
}