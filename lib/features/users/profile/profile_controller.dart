import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/users/profile/profile_service.dart';

class PrefController extends ViewStateController {
  final ProfileService _profileService = ProfileService();

  Future<Failure?> addProfile({
    required String authId,
    required String state,
    required String city,
    required String gender,
    required String dateOfBirth,
    required String email,
    required String name,
    required String userType,
    required String contactNo,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _profileService.addProfile(
      authId: authId,
      state: state,
      city: city,
      email: email,
      contactNo: contactNo,
      name: name,
      gender: gender,
      dateOfBirth: dateOfBirth,
      userType: userType,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> updateProfile({
    required String authId,
    required String state,
    required String city,
    required String gender,
    required String dateOfBirth,
    required String email,
    required String name,
    required String userType,
    required String contactNo,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _profileService.updateProfile(
      state: state,
      city: city,
      email: email,
      contactNo: contactNo,
      name: name,
      gender: gender,
      dateOfBirth: dateOfBirth,
      userType: userType,
      authId: authId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> getProfile({required String authId}) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final result = await _profileService.getProfile(authId: authId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
