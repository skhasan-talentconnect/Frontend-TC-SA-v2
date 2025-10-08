import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/safetySecurity/data/entities/safety-security-model.dart';


abstract class AbstractSafetyAndSecurityService {
  ResultFuture<SafetyAndSecurityModel?> getSafetyAndSecurityBySchoolId({
    required String schoolId,
  });
}