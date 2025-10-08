import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/internationalExposure/data/entities/international-model.dart';


abstract class AbstractInternationalExposureService {
  ResultFuture<InternationalExposureModel?> getInternationalExposureBySchoolId({
    required String schoolId,
  });
}