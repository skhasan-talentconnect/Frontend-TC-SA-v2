class AcademicsModel {
  final String? id;
  final String? schoolId;
  final double? averageClass10Result;
  final double? averageClass12Result;
  final double? averageSchoolMarks;
  final List<String> specialExamsTraining;
  final List<String> extraCurricularActivities;

  AcademicsModel({
    this.id,
    this.schoolId,
    this.averageClass10Result,
    this.averageClass12Result,
    this.averageSchoolMarks,
    this.specialExamsTraining = const [],
    this.extraCurricularActivities = const [],
  });

  factory AcademicsModel.fromJson(Map<String, dynamic> json) {
    return AcademicsModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      averageClass10Result: (json['averageClass10Result'] as num?)?.toDouble(),
      averageClass12Result: (json['averageClass12Result'] as num?)?.toDouble(),
      averageSchoolMarks: (json['averageSchoolMarks'] as num?)?.toDouble(),
      specialExamsTraining: (json['specialExamsTraining'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
      extraCurricularActivities: (json['extraCurricularActivities'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
    );
  }
}