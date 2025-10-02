class InfrastructureModel {
  final String? id;
  final String? schoolId;
  final List<String> labs;
  final List<String> sportsGrounds;
  final int? libraryBooks;
  final int? smartClassrooms;

  InfrastructureModel({
    this.id,
    this.schoolId,
    this.labs = const [],
    this.sportsGrounds = const [],
    this.libraryBooks,
    this.smartClassrooms,
  });

  factory InfrastructureModel.fromJson(Map<String, dynamic> json) {
    return InfrastructureModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
      labs: (json['labs'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      sportsGrounds: (json['sportsGrounds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      libraryBooks: json['libraryBooks'] as int?,
      smartClassrooms: json['smartClassrooms'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'schoolId': schoolId,
        'labs': labs,
        'sportsGrounds': sportsGrounds,
        'libraryBooks': libraryBooks,
        'smartClassrooms': smartClassrooms,
      };
}