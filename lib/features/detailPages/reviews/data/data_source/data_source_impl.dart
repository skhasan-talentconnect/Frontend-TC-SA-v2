import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/network/index.dart';
import 'package:tc_sa/features/detailPages/reviews/data/entities/review-model.dart';

import 'data_source.dart';

class ReviewService implements AbstractReviewService {
  final NetworkService _networkService = NetworkService();

  @override
  ResultFuture<List<ReviewModel>> getAcceptedReviewsBySchoolId({
    required String schoolId,
  }) async {
    // Corresponds to your GET /admin/:schoolId route
    final endpoint = "${Endpoints.reviewsBySchoolAdmin}/$schoolId";
    
    Request r = Request(method: RequestMethod.get, endpoint: endpoint);

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty && response['data'] is List) {
        final List<ReviewModel> reviews = (response['data'] as List)
            .map((item) => ReviewModel.fromJson(item))
            .toList();
        return Right(reviews);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right([]);
  }

  @override
  ResultFuture<ReviewModel?> addReview({
    required String schoolId,
    required String studentId,
    required String text,
    required double ratings,
  }) async {
    // Corresponds to your POST / route
    Request r = Request(
      method: RequestMethod.post,
      endpoint: '${Endpoints.reviewsBySchoolAdmin}/',
      body: {
        "schoolId": schoolId,
        "studentId": studentId,
        "text": text,
        "ratings": ratings,
      },
    );

    try {
      final result = await _networkService.request(r);
      final response = result.data as Map<String, dynamic>;
      if (response.isNotEmpty && response['data'] != null) {
        final model = ReviewModel.fromJson(response['data']);
        return Right(model);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }
    return const Right(null);
  }
}