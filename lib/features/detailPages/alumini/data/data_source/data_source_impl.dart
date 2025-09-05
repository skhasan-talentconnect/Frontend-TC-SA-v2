import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/endpoints.dart';
import 'package:tc_sa/core/network/exceptions.dart';
import 'package:tc_sa/core/network/network.dart';
import 'package:tc_sa/core/network/request.dart';
import 'package:tc_sa/core/network/typedef.dart';
import 'package:tc_sa/features/detailPages/alumini/data/data_source/data_source.dart';
import 'package:tc_sa/features/detailPages/alumini/data/entities/alumini_model.dart';

class AlumniDataSourceImpl implements AbstractAlumniService {
  final NetworkService _network = NetworkService();

  @override
  ResultFuture<AlumniModel?> addAlumni({
    required String schoolId,
    required List<AlumniScoreItem> topAlumnis,
    required List<FamousAlumniItem> famousAlumnies,
    required List<AlumniScoreItem> alumnis,
  }) async {
    final body = {
      'schoolId': schoolId,
      'topAlumnis': topAlumnis.map((e) => e.toJson()).toList(),
      'famousAlumnies': famousAlumnies.map((e) => e.toJson()).toList(),
      'alumnis': alumnis.map((e) => e.toJson()).toList(),
    };

    final req = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminSchoolsAlumnus, // "/alumnus"
      body: body,
    );

    try {
      final result = await _network.request(req);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        return Right(AlumniModel.fromJson(response['data'] as Map<String, dynamic>));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  @override
  ResultFuture<AlumniModel?> getAlumniBySchool({required String schoolId}) async {
    final req = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.adminSchoolsAlumnus}/$schoolId",
    );

    try {
      final result = await _network.request(req);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        return Right(AlumniModel.fromJson(response['data'] as Map<String, dynamic>));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  @override
  ResultFuture<AlumniModel?> updateAlumniBySchool({
    required String schoolId,
    List<AlumniScoreItem>? topAlumnis,
    List<FamousAlumniItem>? famousAlumnies,
    List<AlumniScoreItem>? alumnis,
  }) async {
    final body = <String, dynamic>{};
    if (topAlumnis != null) body['topAlumnis'] = topAlumnis.map((e) => e.toJson()).toList();
    if (famousAlumnies != null) body['famousAlumnies'] = famousAlumnies.map((e) => e.toJson()).toList();
    if (alumnis != null) body['alumnis'] = alumnis.map((e) => e.toJson()).toList();

    final req = Request(
      method: RequestMethod.put,
      endpoint: "${Endpoints.adminSchoolsAlumnus}/$schoolId",
      body: body,
    );

    try {
      final result = await _network.request(req);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        return Right(AlumniModel.fromJson(response['data'] as Map<String, dynamic>));
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }

  @override
  ResultFuture<String?> deleteAlumniBySchool({required String schoolId}) async {
    final req = Request(
      method: RequestMethod.delete,
      endpoint: "${Endpoints.adminSchoolsAlumnus}/$schoolId",
    );

    try {
      final result = await _network.request(req);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty) {
        return Right(response['message'] as String?);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return Right(null);
  }
}