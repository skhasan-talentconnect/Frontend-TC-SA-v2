import 'package:flutter/material.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';

class AddEditProfileViewModel extends ViewStateProvider {
  final profileDataSourceImpl = ProfileDataSourceImpl();

  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;
  String get displayPickedDate =>
      '${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}';
  set pickedDate(DateTime? date) {
    _pickedDate = date;
    notifyListeners();
  }

  // Helper to set the initial date from the user profile string
  void initializeDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      _pickedDate = DateTime.tryParse(dateString);
    }
  }

  Future<Failure?> addProfile({
    required String name,
    required String email,
    required String phone,
    required String state,
    required String city,
    required String gender,
    required String area,
    required String dateOfBirth,
    required double? latitude,
    required double? longitude,
  }) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await profileDataSourceImpl.addProfile(
      name: name,
      email: email,
      phone: phone,
      state: state,
      area: area,
      city: city,
      gender: gender,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (result) {
        if (result != null) {
          getIt<AppStateProvider>().user = result;
          getIt<AppStateProvider>().getUserDetails(); // Refresh global state
        }
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String state,
    required String area,
    required String city,
    required String gender,
    required String dateOfBirth,
    required double? latitude,
    required double? longitude,
  }) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await profileDataSourceImpl.updateProfile(
      name: name,
      email: email,
      phone: phone,
      state: state,
      city: city,
      area: area,
      gender: gender,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude
    );

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (result) {
        if (result != null) {
          getIt<AppStateProvider>().user = result;
          getIt<AppStateProvider>().getUserDetails(); // Refresh global state
        }
      },
    );

    setViewState(ViewState.complete);
    return failure;
  }
}