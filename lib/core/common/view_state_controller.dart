import 'package:flutter/cupertino.dart';

enum ViewState { idle, busy, complete }
//
// class ViewStateController extends GetxController {
//   final _viewState = ViewState.idle.obs;
//
//   ViewState get viewState => _viewState.value;
//   bool get isLoading => _viewState.value == ViewState.busy;
//
//   void setViewState(ViewState state, {bool notify = true}) {
//     _viewState.value = state;
//     if (notify) {
//       update();
//     }
//   }
// }

class ViewStateProvider extends ChangeNotifier {
  ViewState _viewState = ViewState.complete;
  ViewState get viewState => _viewState;

  bool get isLoading => _viewState == ViewState.busy;

  void setViewState(ViewState state, {bool notify = true}) {
    _viewState = state;
    if (notify) {
      notifyListeners();
    }
  }
}
