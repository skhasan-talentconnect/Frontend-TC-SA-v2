import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/payments/data/datasource/payment_data_source.dart';
import 'package:tc_sa/features/payments/data/entities/payment_info.dart';

class PaymentDataSourceImpl implements PaymentDataSource {
  NetworkService networkService = getIt<NetworkService>();

  @override
  ResultFuture<PaymentInfo?> createPayment({required String formId}) async {
    Request request = Request(
      method: RequestMethod.post,
      endpoint: '${Endpoints.paymentCreateOrder}/$formId',
    );

    try {
      final result = await networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final payment = PaymentInfo.fromJson(
          response['data'] as Map<String, dynamic>,
        );
        return Right(payment);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<bool> verifyPayment({
    required String formId,
    required String razorpayPaymentId,
    required String razorpayOrderId,
    required String razorpaySignature,
  }) async {
    Request request = Request(
      method: RequestMethod.post,
      endpoint: '${Endpoints.paymentVerify}/$formId',
      body: {
        'razorpay_payment_id': razorpayPaymentId,
        'razorpay_order_id': razorpayOrderId,
        'razorpay_signature': razorpaySignature,
      },
    );

    try {
      final result = await networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        return Right(true);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(false);
  }
}
