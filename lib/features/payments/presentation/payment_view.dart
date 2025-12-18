import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/payments/presentation/view_model/payment_view_model.dart';

import '../data/entities/payment_info.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Razorpay _razorpay;

  final PaymentViewModel vm = getIt<PaymentViewModel>();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    if (vm.paymentInfo != null) {
      openCheckout(vm.paymentInfo!);
    } else {
      Toasts.showErrorToast(context, message: "Failed to create payment order");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: Scaffold(
        body: Selector<PaymentViewModel, bool>(
          builder:
              (_, isLoading, _) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SizedBox.shrink(),
          selector: (_, vm) => vm.isLoading,
        ),
      ),
    );
  }

  void openCheckout(PaymentInfo order) {
    final options = {
      'key': 'rzp_test_RiiXs9QA4WW4ia',
      'amount': order.amount,
      'order_id': order.id,
      'name': "Synzy",
    };

    _razorpay.open(options);
  }

  Future<void> _handleSuccess(PaymentSuccessResponse response) async {
    final failure = await vm.verifyOrder(
      razorpayPaymentId: response.paymentId!,
      razorpaySignature: response.signature!,
    );

    Toasts.showSuccessOrFailureToast(
      context,
      failure: failure,
      popOnSuccess: true,
      successMsg: 'Transaction Successful',
    );
  }

  void _handleError(PaymentFailureResponse response) {
    Toasts.showErrorToast(context, message: response.message ?? '');
  }
}
