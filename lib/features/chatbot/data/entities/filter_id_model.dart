
import 'package:tc_sa/features/chatbot/data/entities/recommended_model.dart';

class FilterIdsResult {
  final int count;
  final List<String> schoolIds; // From DB filter
   final List<RecommendedSchool> recommendedSchools; // 2. Change this from List<String>
// From AI filter
  final String? aiResponse;

  FilterIdsResult({
    required this.count,
    required this.schoolIds,
    required this.recommendedSchools,
    this.aiResponse,
  });

  factory FilterIdsResult.fromJson(Map<String, dynamic> json) {
    // The count field is not always present in the AI response, so default to 0.
    final int count = (json['count'] ?? 0) as int;

    // Use a null-aware operator `??` to provide a default empty list if the key is missing.
    final List<String> schoolIds = (json['schoolIds'] as List<dynamic>?)
            ?.map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        [];

  final List<RecommendedSchool> recommendedSchools = 
      (json['recommendedSchools'] as List<dynamic>? ?? [])
        .map((e) => RecommendedSchool.fromJson(e as Map<String, dynamic>))
        .toList();

    final String? aiResponse = json['aiResponse'] as String?;

    return FilterIdsResult(
      count: count,
      schoolIds: schoolIds,
      recommendedSchools: recommendedSchools,
      aiResponse: aiResponse,
    );
  }
}