// lib/features/auth/otp/data/data_source/otp_data_source_impl.dart
import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart'
  show Request, RequestMethod, NetworkService, Endpoints, APIException, getIt, ResultFuture;
import 'package:tc_sa/features/auth/mobileOtp/data/data_source/data_source.dart';
import 'package:tc_sa/features/auth/mobileOtp/data/entities/otp_model.dart';



class OtpDataSourceImpl implements OtpDataSource {
  final _net = getIt<NetworkService>();

  @override
  ResultFuture<bool> sendOtp({required String phone}) async {
    final req = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authSendOtp,
      body: {"phone": phone},
    );
    try {
      final res = await _net.request(req);
      final map = res.data as Map<String, dynamic>?;
      final msg = map?['message']?.toString().toLowerCase() ?? '';
      return Right(msg.contains('otp sent'));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<OtpVerifyPayload> verifyOtp({required String phone, required String otp}) async {
    final req = Request(
      method: RequestMethod.post,
      endpoint: Endpoints.authVerifyOtp,
      body: {"phone": phone, "otp": otp},
    );
    try {
      final res   = await _net.request(req);
      final map   = res.data as Map<String, dynamic>?;
      if (map == null) throw APIException(message: 'Empty response', statusCode: 404);
      if ((map['status']?.toString().toLowerCase() ?? '') != 'success') {
        throw APIException(message: map['message']?.toString() ?? 'Verification failed', statusCode: 404);
      }
      final payload = OtpVerifyPayload.fromMap(map);
      if (payload.token.isEmpty) throw APIException(message: 'Token missing', statusCode: 404);
      return Right(payload);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}
