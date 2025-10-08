import 'package:tc_sa/core/network/index.dart' show ResultFuture;
import 'package:tc_sa/features/detailPages/reviews/data/entities/review-model.dart';


abstract class AbstractReviewService {
  ResultFuture<List<ReviewModel>> getAcceptedReviewsBySchoolId({
    required String schoolId,
  });

  ResultFuture<ReviewModel?> addReview({
    required String schoolId,
    required String studentId, // You'll need to get this from your auth provider
    required String text,
    required double ratings,
  });
}