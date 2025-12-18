import 'package:tc_sa/core/common/index.dart';
import 'package:tc_sa/features/payments/data/datasource/payment_data_source_impl.dart';

import '../../../../core/network/app_failure.dart';
import '../../../../core/services/service_locator.dart';
import '../../../application/forms/presentation/view_models/my_form_view_model.dart';
import '../../data/entities/payment_info.dart';

class PaymentViewModel extends ViewStateProvider {
  PaymentInfo? _paymentInfo;

  PaymentInfo? get paymentInfo => _paymentInfo;

  set paymentInfo(PaymentInfo? info) {
    _paymentInfo = info;
    notifyListeners();
  }

  final PaymentDataSourceImpl paymentService = PaymentDataSourceImpl();

  Future<Failure?> createOrder() async {
    Failure? failure;

    setViewState(ViewState.busy);

    final formId = getIt<MyFormViewModel>().form?.sId;

    if (formId == null || formId.isEmpty) {
      return failure = APIFailure(
        message: 'Form Id not found',
        statusCode: 404,
      );
    }

    final result = await paymentService.createPayment(formId: formId);

    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
      },
      (res) {
        paymentInfo = res;
      },
    );

    setViewState(ViewState.complete);

    return failure;
  }

  Future<Failure?> verifyOrder({
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    Failure? failure;

    setViewState(ViewState.busy);

    final formId = getIt<MyFormViewModel>().form?.sId;

    if (formId == null || formId.isEmpty) {
      return failure = APIFailure(
        message: 'Form Id not found',
        statusCode: 404,
      );
    }

    final result = await paymentService.verifyPayment(
      formId: formId,
      razorpayPaymentId: razorpayPaymentId,
      razorpayOrderId: paymentInfo?.id ?? '',
      razorpaySignature: razorpaySignature,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);

    return failure;
  }
}
