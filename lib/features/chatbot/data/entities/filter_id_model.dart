class FilterIdsResult {
  final int count;
  final List<String> schoolIds;

  FilterIdsResult({
    required this.count,
    required this.schoolIds,
  });

  factory FilterIdsResult.fromJson(Map<String, dynamic> json) {
    return FilterIdsResult(
      count: (json['count'] ?? 0) is int ? json['count'] : int.tryParse('${json['count']}') ?? 0,
      schoolIds: (json['schoolIds'] as List<dynamic>? ?? const [])
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'schoolIds': schoolIds,
  };
}
