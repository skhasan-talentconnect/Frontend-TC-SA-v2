import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/common/shortlist_notification_provider.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/presentation/location_fetching.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';

class SchoolCard extends StatefulWidget {
  const SchoolCard({required this.school, this.width = 0.8, super.key});

  final SchoolCardModel school;
  final double width;

  @override
  State<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  final ValueNotifier<bool> isSaved = ValueNotifier(false);
  ShortlistViewModel shortlistViewModel = getIt<ShortlistViewModel>();

  /*  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSaved.value = getIt<AppStateProvider>().isSaved(widget.school.schoolId);
    });
    super.initState();
  }*/
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = getIt<AppStateProvider>();
      isSaved.value = appState.isSaved(widget.school.schoolId);

      // 🔄 Keep in sync with provider changes
      appState.addListener(() {
        final newState = appState.isSaved(widget.school.schoolId);
        if (newState != isSaved.value) {
          isSaved.value = newState;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final appStateProvider = getIt<AppStateProvider>();

    return ChangeNotifierProvider.value(
      value: shortlistViewModel,
      child: GestureDetector(
        onTap:
            () => context.pushNamed(
              RouteNames.overview,
              extra: widget.school.schoolId,
            ),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: size.width * widget.width,
            height: 420,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: SColor.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      clipBehavior: Clip.none,
                      width: double.infinity,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey.shade700,
                        size: 48,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.school.name ?? 'College Name',
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: SColor.secTextColor,
                                  size: 16,
                                ),
                                Text(
                                  widget.school.location ?? '-',
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  LocationUtils.getDistanceFromUser(
                                    widget.school.latitude,
                                    widget.school.longitude,
                                  ),
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 4,
                                    children: [
                                      Text(
                                        'Fee Range',
                                        style: STextStyles.s14W400.copyWith(
                                          color: SColor.secTextColor,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Text(
                                        widget.school.feeRange?.toCardFess ??
                                            '-',
                                        style: STextStyles.s14W600.copyWith(
                                          color: SColor.secTextColor,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     spacing: 4,
                                //     children: [
                                //       Text(
                                //         'Ratings',
                                //         style: STextStyles.s14W400.copyWith(
                                //           color: SColor.secTextColor,
                                //           overflow: TextOverflow.visible,
                                //         ),
                                //       ),
                                //       Text(
                                //         widget.school.ratings != null
                                //             ? '${widget.school.ratings} / 5'
                                //             : '-',
                                //         style: STextStyles.s14W600.copyWith(
                                //           color: SColor.secTextColor,
                                //           overflow: TextOverflow.visible,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                if ((widget.school.score?.toInt() ?? 0) >
                                    0) ...[
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4,
                                      children: [
                                        Text(
                                          'Score',
                                          style: STextStyles.s14W400.copyWith(
                                            color: SColor.secTextColor,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Text(
                                          widget.school.score
                                                  ?.toInt()
                                                  .toString() ??
                                              '-',
                                          style: STextStyles.s14W600.copyWith(
                                            color: SColor.secTextColor,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.red.shade100,
                                  ),
                                  child: Text(
                                    widget.school.board ?? '',
                                    style: STextStyles.s10W600,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.green.shade100,
                                  ),
                                  child: Text(
                                    widget.school.schoolMode?.toCapitalise ??
                                        '',
                                    style: STextStyles.s10W600,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.orange.shade100,
                                  ),
                                  child: Text(
                                    widget.school.genderType?.toCapitalise ??
                                        '',
                                    style: STextStyles.s10W600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              spacing: 4,
                              children: [
                                if (widget.school.amenities != null &&
                                    widget.school.amenities!.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 0.5),
                                    ),
                                    child: Text(
                                      widget.school.amenities![0],
                                      style: STextStyles.s10W600,
                                    ),
                                  ),

                                // Safely display the SECOND amenity, if it exists
                                if (widget.school.amenities != null &&
                                    widget.school.amenities!.length > 1)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 0.5),
                                    ),
                                    child: Text(
                                      widget.school.amenities![1],
                                      style: STextStyles.s10W600,
                                    ),
                                  ),

                                if (widget.school.amenities != null &&
                                    widget.school.amenities!.length > 2)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 0.5),
                                    ),
                                    child: Text(
                                      widget.school.amenities![2],
                                      style: STextStyles.s10W600,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Consumer<ShortlistViewModel>(
                    builder: (_, vm, __) {
                      return ValueListenableBuilder(
                        valueListenable: isSaved,
                        builder:
                            (_, vIsSaved, __) => Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child:
                                  vm.isLoading
                                      ? const Center(
                                        child: SLoadingIndicator(
                                          size: 22,
                                          thickness: 3,
                                        ),
                                      )
                                      : SIcon(
                                        icon:
                                            vIsSaved
                                                ? Icons.bookmark
                                                : Icons.bookmark_outline,
                                        color: Colors.black,
                                        onTap: () async {
                                          if (appStateProvider.isGuest) {
                                            // ✅ FIX: Corrected toast message
                                            Toasts.showInfoToast(
                                              context,
                                              message:
                                                  'Please log in to save schools',
                                            );
                                          } else {
                                            final bool isAdding = !vIsSaved;

                                            final failure =
                                                vIsSaved
                                                    ? await vm.removeShortlist(
                                                      schoolId:
                                                          widget
                                                              .school
                                                              .schoolId ??
                                                          '',
                                                    )
                                                    : await vm.addShortlist(
                                                      schoolId:
                                                          widget
                                                              .school
                                                              .schoolId ??
                                                          '',
                                                    );

                                            if (failure == null &&
                                                context.mounted) {
                                              isSaved.value = !vIsSaved;
                                              Toasts.showSuccessToast(
                                                context,
                                                message:
                                                    '${isAdding ? 'Added to' : 'Removed from'} Shortlist',
                                              );

                                              // This logic is already correct
                                              if (isAdding) {
                                                Provider.of<
                                                  ShortlistNotificationProvider
                                                >(
                                                  context,
                                                  listen: false,
                                                ).notifyNewShortlist();
                                              }
                                            }
                                          }
                                        },
                                      ),
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
