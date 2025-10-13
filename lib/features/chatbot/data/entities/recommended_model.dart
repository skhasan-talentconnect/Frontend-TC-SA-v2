class RecommendedSchool {
  final String name;
  final String? website; // Nullable in case the AI doesn't provide one

  RecommendedSchool({required this.name, this.website});

  factory RecommendedSchool.fromJson(Map<String, dynamic> json) {
    return RecommendedSchool(
      name: json['name'] as String,
      website: json['website'] as String?,
    );
  }
}