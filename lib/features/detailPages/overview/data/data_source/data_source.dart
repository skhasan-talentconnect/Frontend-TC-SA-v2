import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/applied_form_model.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

abstract class OverviewDataSource {
  ResultFuture<SchoolModel?> addSchool({
    required String name,
    required String description,
    required String board,
    required String state,
    required String city,
    required String schoolMode,
    required String genderType,
    required List<String> shifts,
    required String feeRange,
    required String upto,
    required String email,
    required String status,
    required String mobileNo,
    required List<String> languageMedium,
    required String transportAvailable,
    List<String>? specialist,
    List<String>? tags,
    String? website,
    // 🆕 Added optional fields for social handles
    String? instagramHandle,
    String? twitterHandle,
    String? linkedinHandle,
  });

  ResultFuture<SchoolModel?> updateSchool({
    required String id,
    required String name,
    required String description,
    required String board,
    required String state,
    required String city,
    required String schoolMode,
    required String genderType,
    required List<String> shifts,
    required String feeRange,
    required String upto,
    required String email,
    required String status,
    required String mobileNo,
    required List<String> languageMedium,
    required String transportAvailable,
    List<String>? specialist,
    List<String>? tags,
    String? website,
    // 🆕 Added optional fields for social handles
    String? instagramHandle,
    String? twitterHandle,
    String? linkedinHandle,
  });

  ResultFuture<String?> deleteSchool({required String id});

  ResultFuture<SchoolModel?> getSchoolById({required String id});

  ResultFuture<List<SchoolModel>?> getSchoolsByStatus({required String status});

  ResultFuture<AppliedFormModel?> getIsSchoolApplied({
    required String schoolId,
  });
}
