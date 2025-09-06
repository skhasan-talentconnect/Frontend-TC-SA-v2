import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isSaved.value = getIt<AppStateProvider>().isSaved(widget.school.schoolId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

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
            width: size.width * widget.width,
            height: 420,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: SColor.primaryColor),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Icon(
                        Icons.image,
                        color: Colors.grey.shade700,
                        size: 48,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.school.name ?? 'College Name',
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    i < (widget.school.ratings ?? 0)
                                        ? Icons.star
                                        : Icons.star_outline,
                                    color: SColor.primaryColor,
                                    size: 16,
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
                                        'Boards Offered',
                                        style: STextStyles.s14W400.copyWith(
                                          color: SColor.secTextColor,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Text(
                                        widget.school.board ?? '-',
                                        style: STextStyles.s14W600.copyWith(
                                          color: SColor.secTextColor,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                        widget.school.feeRange ?? '-',
                                        style: STextStyles.s14W600.copyWith(
                                          color: SColor.secTextColor,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: SColor.secTextColor,
                                  size: 20,
                                ),
                                Text(
                                  widget.school.location ?? '-',
                                  style: STextStyles.s12W600.copyWith(
                                    color: SColor.secTextColor,
                                    overflow: TextOverflow.visible,
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
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child:
                                  vm.isLoading
                                      ? Center(
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
                                          final failure;
                                          vIsSaved
                                              ? failure = await vm
                                                  .removeShortlist(
                                                    schoolId:
                                                        widget
                                                            .school
                                                            .schoolId ??
                                                        '',
                                                  )
                                              : failure = await vm.addShortlist(
                                                schoolId:
                                                    widget.school.schoolId ??
                                                    '',
                                              );
                                          if (failure == null) {
                                            isSaved.value = !vIsSaved;
                                            Toasts.showSuccessToast(
                                              context,
                                              message:
                                                  '${!vIsSaved ? 'Added to' : 'Removed from'} Shortlist',
                                            );
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
