class SafetyAndSecurityModel {
  final String? id;
  final String? schoolId;
  final double? cctvCoveragePercentage;
  final MedicalFacilityModel? medicalFacility;
  final TransportSafetyModel? transportSafety;
  final List<String> fireSafetyMeasures;
  final bool? visitorManagementSystem;

  SafetyAndSecurityModel({
    this.id,
    this.schoolId,
    this.cctvCoveragePercentage,
    this.medicalFacility,
    this.transportSafety,
    this.fireSafetyMeasures = const [],
    this.visitorManagementSystem,
  });

  factory SafetyAndSecurityModel.fromJson(Map<String, dynamic> json) {
    return SafetyAndSecurityModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      cctvCoveragePercentage: (json['cctvCoveragePercentage'] as num?)?.toDouble(),
      medicalFacility: json['medicalFacility'] != null
          ? MedicalFacilityModel.fromJson(json['medicalFacility'])
          : null,
      transportSafety: json['transportSafety'] != null
          ? TransportSafetyModel.fromJson(json['transportSafety'])
          : null,
      fireSafetyMeasures: (json['fireSafetyMeasures'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      visitorManagementSystem: json['visitorManagementSystem'] as bool?,
    );
  }
}

class MedicalFacilityModel {
  final String? doctorAvailability;
  final bool? medkitAvailable;
  final bool? ambulanceAvailable;

  MedicalFacilityModel({
    this.doctorAvailability,
    this.medkitAvailable,
    this.ambulanceAvailable,
  });

  factory MedicalFacilityModel.fromJson(Map<String, dynamic> json) {
    return MedicalFacilityModel(
      doctorAvailability: json['doctorAvailability'] as String?,
      medkitAvailable: json['medkitAvailable'] as bool?,
      ambulanceAvailable: json['ambulanceAvailable'] as bool?,
    );
  }
}

class TransportSafetyModel {
  final bool? gpsTrackerAvailable;
  final bool? driversVerified;

  TransportSafetyModel({
    this.gpsTrackerAvailable,
    this.driversVerified,
  });

  factory TransportSafetyModel.fromJson(Map<String, dynamic> json) {
    return TransportSafetyModel(
      gpsTrackerAvailable: json['gpsTrackerAvailable'] as bool?,
      driversVerified: json['driversVerified'] as bool?,
    );
  }
}