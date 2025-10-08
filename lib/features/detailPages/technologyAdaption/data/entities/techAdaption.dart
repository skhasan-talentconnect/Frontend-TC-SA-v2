class TechnologyAdoptionModel {
  final String? id;
  final String? schoolId;
  final double? smartClassroomsPercentage;
  final List<String> eLearningPlatforms;

  TechnologyAdoptionModel({
    this.id,
    this.schoolId,
    this.smartClassroomsPercentage,
    this.eLearningPlatforms = const [],
  });

  factory TechnologyAdoptionModel.fromJson(Map<String, dynamic> json) {
    return TechnologyAdoptionModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      smartClassroomsPercentage: (json['smartClassroomsPercentage'] as num?)?.toDouble(),
      eLearningPlatforms: (json['eLearningPlatforms'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
    );
  }
}