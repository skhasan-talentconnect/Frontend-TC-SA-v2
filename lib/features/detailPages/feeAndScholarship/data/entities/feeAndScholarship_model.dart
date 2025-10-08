class FeesAndScholarshipsModel {
  final String? id;
  final String? schoolId;
   final double? feesTransparency;
  final List<ClassFeeModel> classFees;
  final List<ScholarshipModel> scholarships;

  FeesAndScholarshipsModel({
    this.id,
    this.schoolId,
      this.feesTransparency,
    this.classFees = const [],
    this.scholarships = const [],
  });

  factory FeesAndScholarshipsModel.fromJson(Map<String, dynamic> json) {
    return FeesAndScholarshipsModel(
      id: json['_id'] as String?,
      schoolId: json['schoolId'] as String?,
        feesTransparency: (json['feesTransparency'] as num?)?.toDouble(),
      classFees: (json['classFees'] as List<dynamic>?)
              ?.map((e) => ClassFeeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      scholarships: (json['scholarships'] as List<dynamic>?)
              ?.map((e) => ScholarshipModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'schoolId': schoolId,
          'feesTransparency': feesTransparency,
        'classFees': classFees.map((e) => e.toJson()).toList(),
        'scholarships': scholarships.map((e) => e.toJson()).toList(),
      };
}

class ClassFeeModel {
  final String? className;
  final int? tuition;
  final int? activity;
  final int? transport;
  final int? hostel;
  final int? misc;

  ClassFeeModel({
    this.className,
    this.tuition,
    this.activity,
    this.transport,
    this.hostel,
    this.misc,
  });

  factory ClassFeeModel.fromJson(Map<String, dynamic> json) {
    return ClassFeeModel(
      className: json['className'] as String?,
      tuition: json['tuition'] as int?,
      activity: json['activity'] as int?,
      transport: json['transport'] as int?,
      hostel: json['hostel'] as int?,
      misc: json['misc'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'className': className,
        'tuition': tuition,
        'activity': activity,
        'transport': transport,
        'hostel': hostel,
        'misc': misc,
      };
}

class ScholarshipModel {
  final String? name;
  final int? amount;
  final String? type;
  final List<String> documentsRequired;

  ScholarshipModel({
    this.name,
    this.amount,
    this.type,
    this.documentsRequired = const [],
  });

  factory ScholarshipModel.fromJson(Map<String, dynamic> json) {
    return ScholarshipModel(
      name: json['name'] as String?,
      amount: json['amount'] as int?,
      type: json['type'] as String?,
      documentsRequired: (json['documentsRequired'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amount,
        'type': type,
        'documentsRequired': documentsRequired,
      };
}