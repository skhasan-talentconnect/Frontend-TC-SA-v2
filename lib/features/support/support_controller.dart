import 'package:tc_sa/core/common/view_state_controller.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/support/support_service.dart';

class SupportController extends ViewStateController {
  final SupportService _supportService = SupportService();

  Future<Failure?> addSupport({
    required String category,
    required String title,
    required String description,
    required String studId,
  }) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _supportService.addSupport(
      category: category,
      title: title,
      description: description,
      studId: studId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getSupportByStudId({required String studId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _supportService.getSupportByStudId(studId: studId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> getSupportBySupportId({required String supportId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _supportService.getSupportBySupportId(
      supportId: supportId,
    );

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }

  Future<Failure?> deleteSupport({required String supportId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _supportService.deleteSupport(supportId: supportId);

    result.fold((exception) {
      failure = APIFailure.fromException(exception: exception);
    }, (res) {});

    setViewState(ViewState.complete);
    return failure;
  }
}
