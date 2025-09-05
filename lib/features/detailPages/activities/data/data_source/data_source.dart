
import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/activities/data/entities/activities_model.dart';

abstract class AbstractActivitiesService {
  ResultFuture<ActivitiesModel?> addActivities({
    required String schoolId,
    required List<String> activities,
  });

  ResultFuture<ActivitiesModel?> updateActivities({
    required String schoolId,
    required List<String> activities,
  });

  ResultFuture<ActivitiesModel?> getActivitiesBySchoolId({
    required String schoolId,
  });
}