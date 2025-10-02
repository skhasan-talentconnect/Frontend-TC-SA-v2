import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';


abstract class AbstractOtherDetailsService {
  ResultFuture<OtherDetailsModel?> getOtherDetailsBySchoolId({
    required String schoolId,
  });
}