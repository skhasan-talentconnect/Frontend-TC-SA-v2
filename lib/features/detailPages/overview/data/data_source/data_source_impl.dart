import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/applied_form_model.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

class OverviewDataSourceImpl {
  final NetworkService _networkService = NetworkService();

  // 🏫 ADD SCHOOL
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
    // 🆕 New optional fields
    String? instagramHandle,
    String? twitterHandle,
    String? linkedinHandle,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminSchools,
      body: {
        "name": name,
        "description": description,
        "board": board,
        "state": state,
        "city": city,
        "schoolMode": schoolMode,
        "genderType": genderType,
        "shifts": shifts,
        "feeRange": feeRange,
        "upto": upto,
        "email": email,
        "specialist": specialist,
        "tags": tags,
        "website": website,
        "status": status,
        "mobileNo": mobileNo,
        "languageMedium": languageMedium,
        "transportAvailable": transportAvailable,
        if (instagramHandle != null) "instagramHandle": instagramHandle,
        if (twitterHandle != null) "twitterHandle": twitterHandle,
        if (linkedinHandle != null) "linkedinHandle": linkedinHandle,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final school = SchoolModel.fromJson(response['data']);
        return Right(school);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  

  // 🏫 UPDATE SCHOOL
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
    // 🆕 New optional fields
    String? instagramHandle,
    String? twitterHandle,
    String? linkedinHandle,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.adminSchools}/$id",
      body: {
        "name": name,
        "description": description,
        "board": board,
        "state": state,
        "city": city,
        "schoolMode": schoolMode,
        "genderType": genderType,
        "shifts": shifts,
        "feeRange": feeRange,
        "upto": upto,
        "email": email,
        "specialist": specialist,
        "tags": tags,
        "website": website,
        "status": status,
        "mobileNo": mobileNo,
        "languageMedium": languageMedium,
        "transportAvailable": transportAvailable,
        if (instagramHandle != null) "instagramHandle": instagramHandle,
        if (twitterHandle != null) "twitterHandle": twitterHandle,
        if (linkedinHandle != null) "linkedinHandle": linkedinHandle,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final school = SchoolModel.fromJson(response['data']);
        return Right(school);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  // 🏫 DELETE SCHOOL
  ResultFuture<String?> deleteSchool({required String id}) async {
    Request r = Request(
      method: RequestMethod.delete,
      endpoint: "${Endpoints.adminSchools}/$id",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final msg = response['message'];
        return Right(msg);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  // 🏫 GET SCHOOL BY ID
  ResultFuture<SchoolModel?> getSchoolById({required String id}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchools}/$id",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final school = SchoolModel.fromJson(response['data']);
        return Right(school);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  // 🏫 GET SCHOOLS BY STATUS
  ResultFuture<List<SchoolModel>?> getSchoolsByStatus({
    required String status,
  }) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchools}/status/$status",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final List<dynamic> schoolsData = response['data'];
        final List<SchoolModel> schools =
            schoolsData.map((json) => SchoolModel.fromJson(json)).toList();
        return Right(schools);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  // 🧾 CHECK IF SCHOOL APPLIED
  ResultFuture<AppliedFormModel?> getIsSchoolApplied({
    required String schoolId,
  }) async {
    final studId = getIt<AppStateProvider>().user?.sId;

    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.formIsApplied}/$studId/$schoolId",
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        final AppliedFormModel isApplied = AppliedFormModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );
        return Right(isApplied);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }



}
