// lib/features/auth/otp/presentation/view_models/otp_view_model.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tc_sa/core/index.dart'
  show APIException, APIFailure, AppStateProvider, DioExceptionExt, Endpoints, Failure, NetworkService, Request, RequestMethod, ResultFuture, Toasts, ViewState, ViewStateProvider, getIt;
import 'package:tc_sa/core/services/secret_repo.dart';
import 'package:tc_sa/common/index.dart' show Toasts;
import 'package:tc_sa/features/auth/authentication/data/entities/auth_model.dart';
import 'package:tc_sa/features/auth/mobileOtp/data/data_source/data_source.dart';
import 'package:tc_sa/features/auth/mobileOtp/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/auth/mobileOtp/data/entities/otp_model.dart';


class OtpViewModel extends ViewStateProvider {
  final OtpDataSource _ds = getIt<OtpDataSourceImpl>();
  final AppStateProvider _app = getIt<AppStateProvider>();
NetworkService _networkService=getIt<NetworkService>();
  String? message;

  Future<Failure?> sendOtp(String phone, {context}) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final res = await _ds.sendOtp(phone: phone);
    res.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (ok) => message = ok ? null : 'Failed to send OTP',
    );

    setViewState(ViewState.complete);
    notifyListeners();

    if (context != null) {
      Toasts.showSuccessOrFailureToast(
        context,
        failure: failure,
        successMsg: 'OTP sent successfully',
        failureMsg: message,
        popOnSuccess: false,
      );
    }
    return failure;
  }

ResultFuture<AuthModel?> verifyOtp({
  required String phone,
  required String otp,
  context, // add optional context so we can show toast
}) async {
  setViewState(ViewState.busy);
  Failure? failure;

  Request r = Request(
    method: RequestMethod.post,
    endpoint: Endpoints.authVerifyOtp,
    body: {"phone": phone, "otp": otp},
  );

  try {
    final result = await _networkService.request(r);
    final response = result.data as Map<String, dynamic>;

    if (response.isNotEmpty) {
      // Build AuthModel from response
      final authModel = AuthModel.fromJson(response['data']['auth']);
      
      // Save token & id exactly like login
      await SecretRepo.setString('auth_token', response['data']['token']);
      await SecretRepo.setString('auth_id', authModel.sId ?? '');

      setViewState(ViewState.complete);
      notifyListeners();

      if (context != null) {
        Toasts.showSuccessToast(context, message: 'OTP verified successfully');
      }

      return Right(authModel);
    }
  } catch (e) {
    failure = APIException(
      message: (e is DioException) ? e.getErrorFromResponse() : e.toString(),
      statusCode: (e is DioException) ? e.getStatusCodeFromResponse() : 500,
    ) as Failure?;

    setViewState(ViewState.complete);
    notifyListeners();

    if (context != null) {
      Toasts.showErrorToast(context, message: failure!.message ?? 'OTP verification failed');
    }

    return Left(failure as APIException);
  }

  setViewState(ViewState.complete);
  notifyListeners();
  return Right(null);
}

}