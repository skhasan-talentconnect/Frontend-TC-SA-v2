import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import '../entities/infrastructure_model.dart';
import 'data_source.dart';

class InfrastructureService implements AbstractInfrastructureService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<InfrastructureModel?> getInfrastructureBySchoolId({
    required String schoolId,
  }) async {
    // Assuming you have an endpoint for infrastructure
    final endpoint = "${Endpoints.adminInfrastructure}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] != null) {
        final model = InfrastructureModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }

  @override
  ResultFuture<InfrastructureModel?> addInfrastructure({
    required String schoolId,
    required List<String> labs,
    required List<String> sportsGrounds,
    required int libraryBooks,
    required int smartClassrooms,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.adminInfrastructure,
      body: {
        "schoolId": schoolId,
        "labs": labs,
        "sportsGrounds": sportsGrounds,
        "libraryBooks": libraryBooks,
        "smartClassrooms": smartClassrooms,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        final model = InfrastructureModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }

  @override
  ResultFuture<InfrastructureModel?> updateInfrastructure({
    required String schoolId,
    List<String>? labs,
    List<String>? sportsGrounds,
    int? libraryBooks,
    int? smartClassrooms,
  }) async {
    final endpoint = "${Endpoints.adminInfrastructure}/$schoolId";
    
    Request r = Request(
      method: RequestMethod.put,
      endpoint: endpoint,
      body: {
        if (labs != null) "labs": labs,
        if (sportsGrounds != null) "sportsGrounds": sportsGrounds,
        if (libraryBooks != null) "libraryBooks": libraryBooks,
        if (smartClassrooms != null) "smartClassrooms": smartClassrooms,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        final model = InfrastructureModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}