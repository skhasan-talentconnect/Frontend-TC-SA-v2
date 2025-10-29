import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';

class AddEditProfileViewModel extends ViewStateProvider {
  final profileDataSourceImpl = ProfileDataSourceImpl();
DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;

  // Displayed on the UI (dd/MM/yyyy)
  String get displayPickedDate => pickedDate == null
      ? ''
      : DateFormat('dd/MM/yyyy').format(pickedDate!);

  // To send to API (yyyy-MM-dd)
  String get apiPickedDate => pickedDate == null
      ? ''
      : DateFormat('yyyy-MM-dd').format(pickedDate!);

  set pickedDate(DateTime? date) {
    _pickedDate = date;
    notifyListeners();
  }

  void initializeDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      try {
        // Handle both yyyy-MM-dd (from API) or dd/MM/yyyy (from display)
        if (dateString.contains('/')) {
          final parts = dateString.split('/');
          _pickedDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else {
          _pickedDate = DateTime.tryParse(dateString);
        }
      } catch (_) {
        _pickedDate = null;
      }
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