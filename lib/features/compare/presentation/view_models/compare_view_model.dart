import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/compare/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/compare/data/entities/school_compare_model.dart';

class CompareViewModel extends ViewStateProvider {
  final CompareDataSourceImpl _dataSource = CompareDataSourceImpl();

  // optional: hold base school locally (for preview on CompareWith)
  SchoolCardModel? _baseSchool;
  SchoolCardModel? get baseSchool => _baseSchool;
  void setBaseSchool(SchoolCardModel s) {
    _baseSchool = s;
    notifyListeners();
  }

  SchoolCompareModel? _school1;
  SchoolCompareModel? _school2;

  SchoolCompareModel? get school1 => _school1;
  SchoolCompareModel? get school2 => _school2;

  Future<Failure?> compareSchools({
    required String schoolId1,
    required String schoolId2,
  }) async {
    setViewState(ViewState.busy);
    Failure? failure;

    final result = await _dataSource.compareSchools(
      schoolId1: schoolId1,
      schoolId2: schoolId2,
    );

    result.fold((ex) => failure = APIFailure.fromException(exception: ex), (
      res,
    ) {
      _school1 = res?['school1'];
      _school2 = res?['school2'];
    });

    setViewState(ViewState.complete);
    return failure;
  }
}
