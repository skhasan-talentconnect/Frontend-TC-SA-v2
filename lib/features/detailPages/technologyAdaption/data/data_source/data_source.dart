import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/technologyAdaption/data/entities/techAdaption.dart';


abstract class AbstractTechnologyAdoptionService {
  ResultFuture<TechnologyAdoptionModel?> getTechnologyAdoptionBySchoolId({
    required String schoolId,
  });
}