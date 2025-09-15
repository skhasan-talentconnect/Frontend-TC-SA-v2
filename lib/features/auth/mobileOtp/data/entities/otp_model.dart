// lib/features/auth/otp/data/models/otp_verify_payload.dart
class OtpVerifyPayload {
  final String token;
  final Map<String, dynamic>? auth;
  OtpVerifyPayload({required this.token, this.auth});

  factory OtpVerifyPayload.fromMap(Map<String, dynamic> map) {
    final data = map['data'] as Map<String, dynamic>?;
    return OtpVerifyPayload(
      token: (data?['token'] ?? '').toString(),
      auth : data?['auth'] as Map<String, dynamic>?,
    );
  }
}
