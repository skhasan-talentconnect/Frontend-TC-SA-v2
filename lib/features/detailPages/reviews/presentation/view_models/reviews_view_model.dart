import 'package:flutter/material.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/network/app_failure.dart';
import 'package:tc_sa/features/detailPages/reviews/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/detailPages/reviews/data/entities/review-model.dart';


class ReviewViewModel extends ViewStateProvider {
  final ReviewService _svc = ReviewService();

  List<ReviewModel> _reviews = [];
  List<ReviewModel> get reviews => _reviews;

  String? _message;
  String? get message => _message;

  double get averageRating {
    if (_reviews.isEmpty) return 0.0;
    final sum = _reviews.fold<double>(0, (prev, element) => prev + (element.ratings ?? 0));
    return sum / _reviews.length;
  }

  List<double> get ratingPercentages {
    if (_reviews.isEmpty) return [0, 0, 0, 0, 0];
    
    int five = 0, four = 0, three = 0, two = 0, one = 0;
    for (var review in _reviews) {
      final rating = review.ratings?.round() ?? 0;
      if (rating == 5) five++;
      if (rating == 4) four++;
      if (rating == 3) three++;
      if (rating == 2) two++;
      if (rating == 1) one++;
    }

    final total = _reviews.length;
    return [
      (five / total) * 100,
      (four / total) * 100,
      (three / total) * 100,
      (two / total) * 100,
      (one / total) * 100,
    ];
  }

  Future<Failure?> getReviews({required String schoolId}) async {
    Failure? failure;
    setViewState(ViewState.busy);

    final result = await _svc.getAcceptedReviewsBySchoolId(schoolId: schoolId);
    result.fold(
      (exception) {
        failure = APIFailure.fromException(exception: exception);
        _message = failure?.message;
        _reviews = [];
      },
      (res) {
        _reviews = res;
        _message = null;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  Future<bool> addReview({
    required String schoolId,
    required String studentId,
    required String text,
    required double rating,
  }) async {
    setViewState(ViewState.busy);
    final result = await _svc.addReview(
      schoolId: schoolId,
      studentId: studentId,
      text: text,
      ratings: rating,
    );
    setViewState(ViewState.complete);
    
    return result.isRight();
  }
}