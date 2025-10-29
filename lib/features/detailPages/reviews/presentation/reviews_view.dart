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
  // String _schoolId = '';
  // String _schoolName = 'Reviews';
  // bool _isInitialized = false;

  // Get the global AppStateProvider instance
  final appStateProvider = getIt<AppStateProvider>();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInitialized) return;
  //   _isInitialized = true;

  //   final extra = GoRouterState.of(context).extra;
  //   if (extra is Map) {
  //     _schoolId = extra['schoolId'] as String? ?? '';
  //     _schoolName = extra['schoolName'] as String? ?? 'Reviews';
  //   }

  //   if (_schoolId.isNotEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _vm.getReviews(schoolId: _schoolId);
  //     });
  //   }
  // }
  @override
void initState(){
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
              Navigator.of(context).pop(); // Close the bottom sheet
              
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
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        // appBar: SAppBar(
        //   title: _schoolName,
        //   leading: SIcon(icon: Icons.keyboard_arrow_left, onTap: () => context.pop()),
        // ),
        body: Consumer<ReviewViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy && vm.reviews.isEmpty) {
              return const Center(child: SLoadingIndicator());
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildHeader(context, vm.averageRating),
                  const SizedBox(height: 24),
                  if(vm.reviews.isNotEmpty)
                    _buildRatingDistribution(context, vm.ratingPercentages),
                  const SizedBox(height: 24),
                  const Divider(),
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
                  index < avgRating.round() ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 24,
                );
              }),
            )
          ],
        ),
        const Spacer(),
        if (!appStateProvider.isGuest)
          ElevatedButton.icon(
            onPressed: _showWriteReviewForm,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Write a Review'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
      ],
    );
  }

  Widget _buildRatingDistribution(BuildContext context, List<double> percentages) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(5, (index) {
            final star = 5 - index;
            final percent = percentages[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Text('$star star'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: percent / 100,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${percent.toStringAsFixed(0)}%'),
                ],
              ),
            );
          }),
        ),
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
              Icon(Icons.rate_review_outlined, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                vm.message ?? 'Be the first to review this school!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
    
    return Column(
      children: vm.reviews.map((review) {
        final time = review.createdAt != null ? timeago.format(review.createdAt!) : '...';
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