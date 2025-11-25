import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/view_models/reviews_view_model.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/widgets/review_form.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/widgets/reviews_card.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  final ReviewViewModel _vm = ReviewViewModel();
  final appStateProvider = getIt<AppStateProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getReviews(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getReviews(schoolId: widget.schoolId);
    }
  }

  void _showWriteReviewForm() {
    if (appStateProvider.isGuest) {
      Toasts.showInfoToast(context, message: 'Please log in to write a review.');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: WriteReviewForm(
          onSubmit: (rating, text) async {
            final studentId = appStateProvider.userPref?.sId;

            if (studentId == null || studentId.isEmpty) {
              if (mounted) {
                Toasts.showErrorToast(context, message: 'Could not identify user. Please log in again.');
              }
              return;
            }

            final success = await _vm.addReview(
              schoolId: widget.schoolId,
              studentId: studentId,
              rating: rating,
              text: text,
            );

            if (mounted) {
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                content: Text(success
                    ? 'Review submitted! It will appear after approval.'
                    : 'Failed to submit review. You may have already reviewed this school.'),
                backgroundColor: success ? Colors.green : Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
                final colors = context.watch<ThemeProvider>().colors;

    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ReviewViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy && vm.reviews.isEmpty) {
              return Center(child: SLoadingIndicator(color: colors.amberColor));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: colors.topTextColor,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildHeader(context, vm.averageRating),
                  const SizedBox(height: 24),
                  if (vm.reviews.isNotEmpty)
                    _buildRatingDistribution(context, vm.ratingPercentages),
                  const SizedBox(height: 24),
                  const Divider(thickness: 1, color: Color(0xFFEFEFEF)),
                  const SizedBox(height: 24),
                  _buildReviewList(context, vm),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double avgRating) {
                final colors = context.watch<ThemeProvider>().colors;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              avgRating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < avgRating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: colors.topTextColor,
                  size: 24,
                );
              }),
            ),
          ],
        ),
        const Spacer(),
        if (!appStateProvider.isGuest)
          ElevatedButton.icon(
            onPressed: _showWriteReviewForm,
            icon: const Icon(Icons.edit_outlined),
            label:  Text('Write a Review'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.topTextColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildRatingDistribution(BuildContext context, List<double> percentages) {
                final colors = context.watch<ThemeProvider>().colors;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colors.borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(5, (index) {
          final star = 5 - index;
          final percent = percentages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              children: [
                Text('$star ★', style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: percent / 100,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      color: colors.topTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('${percent.toStringAsFixed(0)}%',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildReviewList(BuildContext context, ReviewViewModel vm) {
    if (vm.reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0),
          child: Column(
            children: [
              Icon(Icons.rate_review_outlined,
                  size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                vm.message ?? 'Be the first to review this school!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: vm.reviews.map((review) {
        final time =
            review.createdAt != null ? timeago.format(review.createdAt!) : '...';
        return ReviewCard(
          name: review.student?.name ?? 'Anonymous',
          reviewText: review.text ?? '',
          rating: review.ratings ?? 0,
          timeAgo: time,
          likes: review.likes ?? 0,
        );
      }).toList(),
    );
  }
}
