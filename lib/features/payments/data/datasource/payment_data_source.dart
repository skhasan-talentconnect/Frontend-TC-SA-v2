import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/payments/data/entities/payment_info.dart';

abstract class PaymentDataSource {
  ResultFuture<PaymentInfo?> createPayment({required String formId});

  ResultFuture<bool> verifyPayment({
    required String formId,
    required String razorpayPaymentId,
    required String razorpayOrderId,
    required String razorpaySignature,
  });
}
