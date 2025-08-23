import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart' show SharedPrefHelper;
import 'package:tc_sa/core/network/index.dart'
    show
        NetworkService,
        ResultFuture,
        Request,
        RequestMethod,
        Endpoints,
        APIException;
import 'package:tc_sa/features/users/profile/profile_model.dart';

class ProfileService {
  final NetworkService _networkService = NetworkService();

  final String? deviceToken = SharedPrefHelper.getString('deviceToken');
  ResultFuture<ProfileModel?> addProfile({
    required String authId,
    required String email,
    required String contactNo,
    required String dateOfBirth,
    required String name,
    required String gender,
    required String state,
    required String city,
    required String userType,
  }) async {
    Request r = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.users,
      body: {
        "authId": authId,
        "state": state,
        "city": city,
        "email": email,
        "contactNo": contactNo,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "userType": userType,
      },
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final profileModel = ProfileModel.fromJson(response['data']);

        return Right(profileModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<ProfileModel?> updateProfile({
    required String authId,
    required String email,
    required String contactNo,
    required String dateOfBirth,
    required String name,
    required String gender,
    required String state,
    required String city,
    required String userType,
  }) async {
    Request r = Request(
      method: RequestMethod.put,
      body: {
        "authId": authId,
        "state": state,
        "city": city,
        "email": email,
        "contactNo": contactNo,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "userType": userType,
      },
      endpoint: "${Endpoints.users}/$authId",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final profileModel = ProfileModel.fromJson(response['data']);
        return Right(profileModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  ResultFuture<ProfileModel?> getProfile({required String authId}) async {
    Request r = Request(
      method: RequestMethod.get,
      endpoint: "${Endpoints.users}/$authId",
    );
    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final profileModel = ProfileModel.fromJson(response['data']);

        return Right(profileModel);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }
}
