import 'dart:convert';

class StudentApplication {
  // Core
  final String? studId;
  final String? name;
  final String? location;
  final DateTime? dob;
final String? applicationId;
  final int? age;
  final String? gender; // Male | Female | Other
  final String? motherTongue;
  final String? placeOfBirth;
  final bool? speciallyAbled;
  final String? speciallyAbledType;
  final String? nationality;
  final String? religion;
  final String? caste;
  final String? subcaste;
  final String? aadharNo;
  final String? bloodGroup;
  final String? allergicTo;
  final String? interest;

  // Last school
  final String? lastSchoolName;
  final String? classCompleted;
  final String? lastAcademicYear;
  final String? reasonForLeaving;
  final String? board;

  // Father
  final String? fatherName;
  final int? fatherAge;
  final String? fatherQualification;
  final String? fatherProfession;
  final String? fatherAnnualIncome;
  final String? fatherPhoneNo;
  final String? fatherAadharNo;
  final String? fatherEmail;

  // Mother
  final String? motherName;
  final int? motherAge;
  final String? motherQualification;
  final String? motherProfession;
  final String? motherAnnualIncome;
  final String? motherPhoneNo;
  final String? motherAadharNo;
  final String? motherEmail;

  // Relationship
  final String? relationshipStatus; // Married | Divorced | Single Mother | Single Father | Widowed | Other

  // Guardian (if divorced etc.)
  final String? guardianName;
  final String? guardianContactNo;
  final String? guardianRelationToStudent;
  final String? guardianQualification;
  final String? guardianProfession;
  final String? guardianEmail;
  final String? guardianAadharNo;

  // Addresses
  final String? presentAddress;
  final String? permanentAddress;

  // Siblings
  final List<Sibling>? siblings;

  // Other
  final String? homeLanguage;
  final String? yearlyBudget;

  StudentApplication({
    this.studId,
    this.name,
    this.location,
    this.dob,
    this.age,
    this.gender,
    this.motherTongue,
    this.placeOfBirth,
    this.speciallyAbled,
    this.speciallyAbledType,
    this.applicationId,

    this.nationality,
    this.religion,
    this.caste,
    this.subcaste,
    this.aadharNo,
    this.bloodGroup,
    this.allergicTo,
    this.interest,
    this.lastSchoolName,
    this.classCompleted,
    this.lastAcademicYear,
    this.reasonForLeaving,
    this.board,
    this.fatherName,
    this.fatherAge,
    this.fatherQualification,
    this.fatherProfession,
    this.fatherAnnualIncome,
    this.fatherPhoneNo,
    this.fatherAadharNo,
    this.fatherEmail,
    this.motherName,
    this.motherAge,
    this.motherQualification,
    this.motherProfession,
    this.motherAnnualIncome,
    this.motherPhoneNo,
    this.motherAadharNo,
    this.motherEmail,
    this.relationshipStatus,
    this.guardianName,
    this.guardianContactNo,
    this.guardianRelationToStudent,
    this.guardianQualification,
    this.guardianProfession,
    this.guardianEmail,
    this.guardianAadharNo,
    this.presentAddress,
    this.permanentAddress,
    this.siblings,
    this.homeLanguage,
    this.yearlyBudget,
  });

  /// Safe factory with null checks and DateTime parsing
  factory StudentApplication.fromJson(Map<String, dynamic> json) {
    return StudentApplication(
      studId: json['studId']?.toString(),
      name: json['name']?.toString(),
      applicationId: json['_id']?.toString(),

      location: json['location']?.toString(),
      dob: json['dob'] != null ? DateTime.tryParse(json['dob'].toString()) : null,
      age: json['age'] is int ? json['age'] as int : (json['age'] is num ? (json['age'] as num).toInt() : null),
      gender: json['gender']?.toString(),
      motherTongue: json['motherTongue']?.toString(),
      placeOfBirth: json['placeOfBirth']?.toString(),
      speciallyAbled: json['speciallyAbled'] is bool ? json['speciallyAbled'] as bool : null,
      speciallyAbledType: json['speciallyAbledType']?.toString(),
      nationality: json['nationality']?.toString(),
      religion: json['religion']?.toString(),
      caste: json['caste']?.toString(),
      subcaste: json['subcaste']?.toString(),
      aadharNo: json['aadharNo']?.toString(),
      bloodGroup: json['bloodGroup']?.toString(),
      allergicTo: json['allergicTo']?.toString(),
      interest: json['interest']?.toString(),
      lastSchoolName: json['lastSchoolName']?.toString(),
      classCompleted: json['classCompleted']?.toString(),
      lastAcademicYear: json['lastAcademicYear']?.toString(),
      reasonForLeaving: json['reasonForLeaving']?.toString(),
      board: json['board']?.toString(),
      fatherName: json['fatherName']?.toString(),
      fatherAge: json['fatherAge'] is int ? json['fatherAge'] as int : (json['fatherAge'] is num ? (json['fatherAge'] as num).toInt() : null),
      fatherQualification: json['fatherQualification']?.toString(),
      fatherProfession: json['fatherProfession']?.toString(),
      fatherAnnualIncome: json['fatherAnnualIncome']?.toString(),
      fatherPhoneNo: json['fatherPhoneNo']?.toString(),
      fatherAadharNo: json['fatherAadharNo']?.toString(),
      fatherEmail: json['fatherEmail']?.toString(),
      motherName: json['motherName']?.toString(),
      motherAge: json['motherAge'] is int ? json['motherAge'] as int : (json['motherAge'] is num ? (json['motherAge'] as num).toInt() : null),
      motherQualification: json['motherQualification']?.toString(),
      motherProfession: json['motherProfession']?.toString(),
      motherAnnualIncome: json['motherAnnualIncome']?.toString(),
      motherPhoneNo: json['motherPhoneNo']?.toString(),
      motherAadharNo: json['motherAadharNo']?.toString(),
      motherEmail: json['motherEmail']?.toString(),
      relationshipStatus: json['relationshipStatus']?.toString(),
      guardianName: json['guardianName']?.toString(),
      guardianContactNo: json['guardianContactNo']?.toString(),
      guardianRelationToStudent: json['guardianRelationToStudent']?.toString(),
      guardianQualification: json['guardianQualification']?.toString(),
      guardianProfession: json['guardianProfession']?.toString(),
      guardianEmail: json['guardianEmail']?.toString(),
      guardianAadharNo: json['guardianAadharNo']?.toString(),
      presentAddress: json['presentAddress']?.toString(),
      permanentAddress: json['permanentAddress']?.toString(),
      siblings: (json['siblings'] is List)
          ? (json['siblings'] as List)
              .map((e) => Sibling.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      homeLanguage: json['homeLanguage']?.toString(),
      yearlyBudget: json['yearlyBudget']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studId": studId,
      "name": name,
      "location": location,
      // >>> IMPORTANT: send ISO string for backend Date type
      "dob": dob?.toIso8601String(),
      "age": age,
      "gender": gender,
      "motherTongue": motherTongue,
      "placeOfBirth": placeOfBirth,
      "_id": applicationId,

      "speciallyAbled": speciallyAbled,
      "speciallyAbledType": speciallyAbledType,
      "nationality": nationality,
      "religion": religion,
      "caste": caste,
      "subcaste": subcaste,
      "aadharNo": aadharNo,
      "bloodGroup": bloodGroup,
      "allergicTo": allergicTo,
      "interest": interest,
      "lastSchoolName": lastSchoolName,
      "classCompleted": classCompleted,
      "lastAcademicYear": lastAcademicYear,
      "reasonForLeaving": reasonForLeaving,
      "board": board,
      "fatherName": fatherName,
      "fatherAge": fatherAge,
      "fatherQualification": fatherQualification,
      "fatherProfession": fatherProfession,
      "fatherAnnualIncome": fatherAnnualIncome,
      "fatherPhoneNo": fatherPhoneNo,
      "fatherAadharNo": fatherAadharNo,
      "fatherEmail": fatherEmail,
      "motherName": motherName,
      "motherAge": motherAge,
      "motherQualification": motherQualification,
      "motherProfession": motherProfession,
      "motherAnnualIncome": motherAnnualIncome,
      "motherPhoneNo": motherPhoneNo,
      "motherAadharNo": motherAadharNo,
      "motherEmail": motherEmail,
      "relationshipStatus": relationshipStatus,
      "guardianName": guardianName,
      "guardianContactNo": guardianContactNo,
      "guardianRelationToStudent": guardianRelationToStudent,
      "guardianQualification": guardianQualification,
      "guardianProfession": guardianProfession,
      "guardianEmail": guardianEmail,
      "guardianAadharNo": guardianAadharNo,
      "presentAddress": presentAddress,
      "permanentAddress": permanentAddress,
      "siblings": siblings?.map((e) => e.toJson()).toList(),
      "homeLanguage": homeLanguage,
      "yearlyBudget": yearlyBudget,
    };
  }

  static StudentApplication fromJsonStr(String source) =>
      StudentApplication.fromJson(json.decode(source) as Map<String, dynamic>);

  String toJsonStr() => json.encode(toJson());

  StudentApplication copyWith({
    String? studId,
    String? applicationId,
    String? name,
    String? location,
    DateTime? dob,
    int? age,
    String? gender,
    String? motherTongue,
    String? placeOfBirth,
    bool? speciallyAbled,
    String? speciallyAbledType,
    String? nationality,
    String? religion,
    String? caste,
    String? subcaste,
    String? aadharNo,
    String? bloodGroup,
    String? allergicTo,
    String? interest,
    String? lastSchoolName,
    String? classCompleted,
    String? lastAcademicYear,
    String? reasonForLeaving,
    String? board,
    String? fatherName,
    int? fatherAge,
    String? fatherQualification,
    String? fatherProfession,
    String? fatherAnnualIncome,
    String? fatherPhoneNo,
    String? fatherAadharNo,
    String? fatherEmail,
    String? motherName,
    int? motherAge,
    String? motherQualification,
    String? motherProfession,
    String? motherAnnualIncome,
    String? motherPhoneNo,
    String? motherAadharNo,
    String? motherEmail,
    String? relationshipStatus,
    String? guardianName,
    String? guardianContactNo,
    String? guardianRelationToStudent,
    String? guardianQualification,
    String? guardianProfession,
    String? guardianEmail,
    String? guardianAadharNo,
    String? presentAddress,
    String? permanentAddress,
    List<Sibling>? siblings,
    String? homeLanguage,
    String? yearlyBudget,
  }) {
    return StudentApplication(
      studId: studId ?? this.studId,
      name: name ?? this.name,
      location: location ?? this.location,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      motherTongue: motherTongue ?? this.motherTongue,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      speciallyAbled: speciallyAbled ?? this.speciallyAbled,
      speciallyAbledType: speciallyAbledType ?? this.speciallyAbledType,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subcaste: subcaste ?? this.subcaste,
      aadharNo: aadharNo ?? this.aadharNo,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergicTo: allergicTo ?? this.allergicTo,
      applicationId: applicationId ?? this.applicationId,
      interest: interest ?? this.interest,
      lastSchoolName: lastSchoolName ?? this.lastSchoolName,
      classCompleted: classCompleted ?? this.classCompleted,
      lastAcademicYear: lastAcademicYear ?? this.lastAcademicYear,
      reasonForLeaving: reasonForLeaving ?? this.reasonForLeaving,
      board: board ?? this.board,
      fatherName: fatherName ?? this.fatherName,
      fatherAge: fatherAge ?? this.fatherAge,
      fatherQualification: fatherQualification ?? this.fatherQualification,
      fatherProfession: fatherProfession ?? this.fatherProfession,
      fatherAnnualIncome: fatherAnnualIncome ?? this.fatherAnnualIncome,
      fatherPhoneNo: fatherPhoneNo ?? this.fatherPhoneNo,
      fatherAadharNo: fatherAadharNo ?? this.fatherAadharNo,
      fatherEmail: fatherEmail ?? this.fatherEmail,
      motherName: motherName ?? this.motherName,
      motherAge: motherAge ?? this.motherAge,
      motherQualification: motherQualification ?? this.motherQualification,
      motherProfession: motherProfession ?? this.motherProfession,
      motherAnnualIncome: motherAnnualIncome ?? this.motherAnnualIncome,
      motherPhoneNo: motherPhoneNo ?? this.motherPhoneNo,
      motherAadharNo: motherAadharNo ?? this.motherAadharNo,
      motherEmail: motherEmail ?? this.motherEmail,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      guardianName: guardianName ?? this.guardianName,
      guardianContactNo: guardianContactNo ?? this.guardianContactNo,
      guardianRelationToStudent: guardianRelationToStudent ?? this.guardianRelationToStudent,
      guardianQualification: guardianQualification ?? this.guardianQualification,
      guardianProfession: guardianProfession ?? this.guardianProfession,
      guardianEmail: guardianEmail ?? this.guardianEmail,
      guardianAadharNo: guardianAadharNo ?? this.guardianAadharNo,
      presentAddress: presentAddress ?? this.presentAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      siblings: siblings ?? this.siblings,
      homeLanguage: homeLanguage ?? this.homeLanguage,
      yearlyBudget: yearlyBudget ?? this.yearlyBudget,
    );
  }
}

class Sibling {
  final String? name;
  final int? age;
  final String? sex;
  final String? nameOfInstitute;
  final String? className;

  Sibling({
    this.name,
    this.age,
    this.sex,
    this.nameOfInstitute,
    this.className,
  });

  factory Sibling.fromJson(Map<String, dynamic> json) {
    return Sibling(
      name: json['name']?.toString(),
      age: json['age'] is int ? json['age'] as int : (json['age'] is num ? (json['age'] as num).toInt() : null),
      sex: json['sex']?.toString(),
      nameOfInstitute: json['nameOfInstitute']?.toString(),
      className: json['className']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "sex": sex,
      "nameOfInstitute": nameOfInstitute,
      "className": className,
    };
  }
}
