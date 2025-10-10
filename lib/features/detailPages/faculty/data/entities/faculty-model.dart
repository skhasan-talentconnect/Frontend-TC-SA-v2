class FacultyModel {
  final String? id;
  final String? schoolId;
  final List<FacultyMemberModel> facultyMembers;

  FacultyModel({
    this.id,
    this.schoolId,
    this.facultyMembers = const [],
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      facultyMembers: (json['facultyMembers'] as List<dynamic>?)
              ?.map((e) => FacultyMemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class FacultyMemberModel {
  final String? name;
  final String? qualification;
  final List<String> awards;
  final int? experience;
  final String? id;

  FacultyMemberModel({
    this.name,
    this.qualification,
    this.awards = const [],
    this.experience,
    this.id,
  });

  factory FacultyMemberModel.fromJson(Map<String, dynamic> json) {
    return FacultyMemberModel(
      name: json['name'] as String?,
      qualification: json['qualification'] as String?,
      awards: (json['awards'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      experience: json['experience'] as int?,
      id: json['_id'] as String?,
    );
  }
}