import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';

abstract class AbstractAdmissionTimelineService {
  ResultFuture<AdmissionTimelineModel?> getAdmissionTimelineBySchoolId({
    required String schoolId,
  });
}