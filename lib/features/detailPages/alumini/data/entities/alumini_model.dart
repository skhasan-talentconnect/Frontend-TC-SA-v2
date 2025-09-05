// lib/features/detailPages/alumini/data/entities/alumni_model.dart

class AlumniModel {
  // server ids & timestamps
  final String? id;            // maps _id
  final String? schoolId;      // extracted even if the API sends a populated object
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  // handy flattened school fields (when populated)
  final String? schoolName;
  final String? schoolCity;
  final String? schoolState;

  // sections
  final List<AlumniScoreItem> topAlumnis;     // [{name, percentage}]
  final List<FamousAlumniItem> famousAlumnies; // [{name, profession}]
  final List<AlumniScoreItem> alumnis;        // [{name, percentage}]

  const AlumniModel({
    this.id,
    this.schoolId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.schoolName,
    this.schoolCity,
    this.schoolState,
    this.topAlumnis = const [],
    this.famousAlumnies = const [],
    this.alumnis = const [],
  });

  factory AlumniModel.fromJson(Map<String, dynamic> json) {
    // schoolId can be a string or a populated object
    String? sid;
    String? sName;
    String? sCity;
    String? sState;

    final dynamic schoolRaw = json['schoolId'];
    if (schoolRaw is String) {
      sid = schoolRaw;
    } else if (schoolRaw is Map<String, dynamic>) {
      sid = schoolRaw['_id'] as String?;
      sName = schoolRaw['name'] as String?;
      sCity = schoolRaw['city'] as String?;
      sState = schoolRaw['state'] as String?;
    }

    return AlumniModel(
      id: json['_id'] as String?,
      schoolId: sid,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] is int ? json['__v'] as int : int.tryParse('${json['__v'] ?? ''}'),
      schoolName: sName,
      schoolCity: sCity,
      schoolState: sState,
      topAlumnis: _toScoreList(json['topAlumnis']),
      famousAlumnies: _toFamousList(json['famousAlumnies']),
      alumnis: _toScoreList(json['alumnis']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'schoolId': schoolId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
        'topAlumnis': topAlumnis.map((e) => e.toJson()).toList(),
        'famousAlumnies': famousAlumnies.map((e) => e.toJson()).toList(),
        'alumnis': alumnis.map((e) => e.toJson()).toList(),
        // flattened school fields are for convenience; not required by backend
        'schoolName': schoolName,
        'schoolCity': schoolCity,
        'schoolState': schoolState,
      };

  // ---- helpers ----
  static List<AlumniScoreItem> _toScoreList(dynamic v) {
    if (v is List) {
      return v
          .whereType<Map<String, dynamic>>()
          .map(AlumniScoreItem.fromJson)
          .toList();
    }
    return const [];
  }

  static List<FamousAlumniItem> _toFamousList(dynamic v) {
    if (v is List) {
      return v
          .whereType<Map<String, dynamic>>()
          .map(FamousAlumniItem.fromJson)
          .toList();
    }
    return const [];
  }
}

class AlumniScoreItem {
  final String? name;
  final double? percentage;

  const AlumniScoreItem({this.name, this.percentage});

  factory AlumniScoreItem.fromJson(Map<String, dynamic> json) => AlumniScoreItem(
        name: json['name'] as String?,
        percentage: (json['percentage'] is num)
            ? (json['percentage'] as num).toDouble()
            : double.tryParse('${json['percentage'] ?? ''}'),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'percentage': percentage,
      };
}

class FamousAlumniItem {
  final String? name;
  final String? profession;

  const FamousAlumniItem({this.name, this.profession});

  factory FamousAlumniItem.fromJson(Map<String, dynamic> json) => FamousAlumniItem(
        name: json['name'] as String?,
        profession: json['profession'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'profession': profession,
      };
}
