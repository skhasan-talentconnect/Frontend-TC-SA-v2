class ReviewModel {
  final String? id;
  final String? schoolId;
  final String? text;
  final double? ratings;
  final int? likes;
  final StudentReviewInfo? student;
  final String? status;
  final DateTime? createdAt;

  ReviewModel({
    this.id,
    this.schoolId,
    this.text,
    this.ratings,
    this.likes,
    this.student,
    this.status,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      text: json['text'] as String?,
      ratings: (json['ratings'] as num?)?.toDouble(),
      likes: json['likes'] as int?,
      student: json['student'] != null
          ? StudentReviewInfo.fromJson(json['student'])
          : null,
      status: json['status'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}

class StudentReviewInfo {
  final String? name;
  final String? studentId;

  StudentReviewInfo({this.name, this.studentId});

  factory StudentReviewInfo.fromJson(Map<String, dynamic> json) {
    return StudentReviewInfo(
      name: json['name'] as String?,
      studentId: json['studentId'] as String?,
    );
  }
}