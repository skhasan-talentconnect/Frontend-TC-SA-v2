class ActivitiesModel {
  String? schoolId;
  List<String>? activities;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ActivitiesModel({
    this.schoolId,
    this.activities,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) => ActivitiesModel(
        schoolId: json['schoolId'] as String?,
        activities: (json['activities'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        iV: json['__v'] is int ? json['__v'] as int : int.tryParse('${json['__v'] ?? ''}'),
      );

  Map<String, dynamic> toJson() => {
        'schoolId': schoolId,
        'activities': activities ?? const [],
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
      };
}
