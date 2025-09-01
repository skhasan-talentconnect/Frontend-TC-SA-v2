import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/common/index.dart';

class SchoolViewModel extends ViewStateProvider {
  List<SchoolCardModel> _stateSchools = [];
  List<SchoolCardModel> get stateSchools => _stateSchools;
  set stateSchools(List<SchoolCardModel> value) {
    _stateSchools = value;
    notifyListeners();
  }

  List<SchoolCardModel> _citySchools = [];
  List<SchoolCardModel> get citySchools => _citySchools;
  set citySchools(List<SchoolCardModel> value) {
    _citySchools = value;
    notifyListeners();
  }
}
