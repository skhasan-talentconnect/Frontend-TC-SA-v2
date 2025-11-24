class AdmissionTimelineModel {
  final String? id;
  final String? schoolId;
  final List<TimelineEntryModel> timelines;

  AdmissionTimelineModel({
    this.id,
    this.schoolId,
    this.timelines = const [],
  });

  factory AdmissionTimelineModel.fromJson(Map<String, dynamic> json) {
    return AdmissionTimelineModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      timelines: (json['timelines'] as List<dynamic>?)
              ?.map((e) => TimelineEntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class TimelineEntryModel {
  final DateTime? admissionStartDate;
  final DateTime? admissionEndDate;
  final String? status;
  final List<String> documentsRequired;
  final EligibilityModel? eligibility;
  final num? applicationFee;

  TimelineEntryModel({
    this.admissionStartDate,
    this.admissionEndDate,
    this.status,
    this.documentsRequired = const [],
    this.eligibility,
        this.applicationFee,
  });

  factory TimelineEntryModel.fromJson(Map<String, dynamic> json) {
    return TimelineEntryModel(
      admissionStartDate: DateTime.tryParse(json['admissionStartDate'] ?? ''),
      applicationFee: json['applicationFee'] is num
          ? json['applicationFee'] as num
          : (json['applicationFee'] != null ? num.tryParse(json['applicationFee'].toString()) : null),
    
      admissionEndDate: DateTime.tryParse(json['admissionEndDate'] ?? ''),
      
      status: json['status'] as String?,
      documentsRequired: (json['documentsRequired'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      eligibility: json['eligibility'] != null
          ? EligibilityModel.fromJson(json['eligibility'])
          : null,
    );
  }
}

class EligibilityModel {
  final String? admissionLevel;
  final String? ageCriteria;
  final String? otherInfo;

  EligibilityModel({
    this.admissionLevel,
    this.ageCriteria,
    this.otherInfo,
  });

  factory EligibilityModel.fromJson(Map<String, dynamic> json) {
    return EligibilityModel(
      admissionLevel: json['admissionLevel'] as String?,
      ageCriteria: json['ageCriteria'] as String?,
      otherInfo: json['otherInfo'] as String?,
    );
  }
}