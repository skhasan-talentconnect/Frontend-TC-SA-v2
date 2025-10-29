import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/core/navigation/not_found_view.dart';
import 'package:tc_sa/features/detailPages/academics/presentation/academics_view.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/activities_view.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/admission_timeline_view.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/alumini_view.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/amenity_view.dart';
import 'package:tc_sa/features/detailPages/faculty/presentation/faculty_view.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/fees_scholarship_view.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/infrastructure_view.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/presentation/international_view.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/other_details_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/overview_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/view_models/overview_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/custom_tab.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/info_chip_widget.dart';
import 'package:tc_sa/features/detailPages/overview/utils/enums.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/reviews_view.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/presentation/safetySecurity_view.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/presentation/tech_adaption_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/models/user_pref.dart';
import '../../../../common/theme/s_colors.dart';
import '../../../../common/widgets/s_app_bar.dart';
import '../../../../common/widgets/s_button.dart';
import '../../../../common/widgets/s_icon.dart';
import '../../../../common/widgets/s_loading_indicator.dart';
import '../../../../core/common/app_state_provider.dart';
import '../../../../core/navigation/route_name.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/toast.dart';
import '../../../application/forms/presentation/view_models/my_form_view_model.dart';
import '../../../application/forms/utils/enums.dart';
import '../../../users/shortlist/presentation/view_models/shortlist_view_model.dart';
import '../data/entities/applied_form_model.dart';
import '../data/entities/overview_model.dart';

class SchoolDetailView2 extends StatefulWidget {
  const SchoolDetailView2({super.key, required this.schoolId, this.distance});

  final String schoolId;
  final String? distance;

  @override
  State<SchoolDetailView2> createState() => _SchoolDetailViewState();
}

class _SchoolDetailViewState extends State<SchoolDetailView2> {
  final OverviewViewModel overviewViewModel = OverviewViewModel();
  final MyFormViewModel myFormViewModel = MyFormViewModel();
  final ShortlistViewModel shortlistViewModel = ShortlistViewModel();
  final appStateProvider = getIt<AppStateProvider>();

  final PageController pageController = PageController();

  final ScrollController _tabScrollController = ScrollController();
late List<GlobalKey> _tabKeys;

  final ValueNotifier<bool> isSaved = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await overviewViewModel.getSchoolsById(
        id: widget.schoolId,
      );
      failure?.showError(context);
      await overviewViewModel.getIsAppliedSchool(schoolId: widget.schoolId);
      isSaved.value = getIt<AppStateProvider>().isSaved(widget.schoolId);
    });
     _tabKeys = List.generate(DetailTabEnum.values.length, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OverviewViewModel>.value(
      value: overviewViewModel,
      child: Consumer<OverviewViewModel>(
        builder: (vmContext, vm, _) {
          final school = vm.school;

          final size = MediaQuery.of(context).size;
          final isSmall = size.width < 600;
          final isMed = size.width >= 600 && size.width < 900;
          final bannerHeight = isSmall ? 150.0 : (isMed ? 180.0 : 200.0);
          final titleFont = isSmall ? 20.0 : (isMed ? 24.0 : 26.0);
          final infoFont = isSmall ? 16.0 : (isMed ? 18.0 : 20.0);
          final tabFont = isSmall ? 14.0 : (isMed ? 16.0 : 18.0);
          final pad = isSmall ? 6.0 : (isMed ? 8.0 : 10.0);

          if (vm.isLoading) {
            return Scaffold(body: Center(child: SLoadingIndicator()));
          }

          if (school == null) {
            return NotFoundView(isSchool: true);
          }

          final location = [
            school.city,
            school.state,
          ].where((e) => (e ?? '').isNotEmpty).join(", ");

          return Scaffold(
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
              title: school.name ?? "School",
              actions:
                  !getIt<AppStateProvider>().isGuest
                      ? [
                        ChangeNotifierProvider.value(
                          value: shortlistViewModel,
                          child: Selector<ShortlistViewModel, bool>(
                            selector: (_, vm) => vm.isLoading,
                            builder: (vmContext, isSaving, _) {
                              if (isSaving) {
                                return SLoadingIndicator(
                                  size: 24,
                                  thickness: 3,
                                );
                              }

                              return ValueListenableBuilder(
                                valueListenable: isSaved,
                                builder:
                                    (_, vIsSaved, __) => SIcon(
                                      icon:
                                          !vIsSaved
                                              ? Icons.bookmark_outline
                                              : Icons.bookmark,
                                      color: SColor.secTextColor,
                                      size: 28,
                                      onTap: () async {
                                        final failure;
                                        vIsSaved
                                            ? failure = await shortlistViewModel
                                                .removeShortlist(
                                                  schoolId: widget.schoolId,
                                                )
                                            : failure = await shortlistViewModel
                                                .addShortlist(
                                                  schoolId: widget.schoolId,
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
                              );
                            },
                          ),
                        ),
                      ]
                      : [],
            ),

            body: NestedScrollView(
              headerSliverBuilder:
                  (_, __) => [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: bannerHeight,
                            width: double.infinity,
                            color: Colors.blue[100],
                            child: const Center(
                              child: Icon(
                                Icons.school,
                                size: 80,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          // Title + location + buttons
                          Padding(
                            padding: EdgeInsets.all(pad),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  school.name ?? "-",
                                  style: TextStyle(
                                    fontSize: titleFont,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 18),
                                    const SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: () async {
                                        if (location.isNotEmpty) {
                                          final query = Uri.encodeComponent(
                                            location,
                                          );
                                          final url = Uri.parse(
                                            "https://www.google.com/maps/search/?api=1&query=${school.name?.split(' ').join('+')}+$query",
                                          );

                                          if (!await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          )) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Could not open Maps",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        location.isEmpty ? "-" : location,
                                        style: TextStyle(
                                          fontSize: infoFont,
                                          color: Colors.blue,
                                          decoration:
                                              TextDecoration
                                                  .underline, // makes it look clickable
                                        ),
                                      ),
                                    ),

                                    if (widget.distance != null) ...[
                                      const SizedBox(width: 8),

                                      const SizedBox(width: 6),

                                      // ✅ Distance Text
                                      Text(
                                        "${widget.distance!} km away",
                                        style: TextStyle(
                                          fontSize: infoFont - 2,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context.pushNamed(
                                            RouteNames.compareWith,
                                            extra: {
                                              'id':
                                                  school.id?.toString() ??
                                                  widget.schoolId,
                                              'name': school.name ?? 'School',
                                            },
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.green,
                                          ),
                                        ),
                                        child: Text(
                                          "Compare",
                                          style: TextStyle(
                                            fontSize: infoFont,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ChangeNotifierProvider.value(
                                        value: myFormViewModel,
                                        child: Selector<MyFormViewModel, bool>(
                                          selector: (_, vm) => vm.isLoading,
                                          builder:
                                              (_, isLoading, __) =>
                                                  isLoading
                                                      ? Center(
                                                        child:
                                                            SLoadingIndicator(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                      )
                                                      : SButton(
                                                        onPressed: () async {
                                                          if (appStateProvider
                                                              .isGuest) {
                                                            Toasts.showInfoToast(
                                                              context,
                                                              message:
                                                                  'Please log in to apply',
                                                            );
                                                          } else {
                                                            if (vm.isApplied) {
                                                              return;
                                                            }
                                                            final failure = await myFormViewModel
                                                                .submitForm(
                                                                  applicationId:
                                                                      '', // You may need to provide a valid ID here
                                                                  schoolId:
                                                                      widget
                                                                          .schoolId,
                                                                );
                                                            Toasts.showSuccessOrFailureToast(
                                                              context,
                                                              failure: failure,
                                                              popOnSuccess:
                                                                  false,
                                                              hideSuccess: true,
                                                              successCallback: () {
                                                                vm.appliedFormModel =
                                                                    AppliedFormModel(
                                                                      status:
                                                                          FormStatus
                                                                              .pending,
                                                                      isApplied:
                                                                          true,
                                                                    );
                                                              },
                                                            );
                                                          }
                                                        }, // <-- This brace closes the onPressed callback
                                                        backgroundColor:
                                                            vm.isApplied
                                                                ? Colors.grey
                                                                : Colors.blue,
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 14,
                                                            ),
                                                        label: '',
                                                        max: true,
                                                        text: Text(
                                                          vm.isApplied
                                                              ? 'Applied'
                                                              : "Apply",
                                                          style: TextStyle(
                                                            fontSize: infoFont,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ), // <-- This parenthesis closes the SButton widget
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Chips
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: pad,
                              vertical: 6,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (_) {
                                      final userPref =
                                          getIt<AppStateProvider>().userPref;
                                      int matchPercentage = 0;
                                      if (userPref != null) {
                                        matchPercentage =
                                            calculateMatchPercentage(
                                              school: school,
                                              userPref: userPref,
                                            );
                                      }
                                      return InfoChip(
                                        topText: "$matchPercentage%",
                                        bottomText: "Match %",
                                        fontSize: infoFont,
                                        isSmallScreen: isSmall,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InfoChip(
                                    topText: school.board ?? "-",
                                    bottomText: "Board",
                                    fontSize: infoFont,
                                    isSmallScreen: isSmall,
                                  ),
                                ),
                                Expanded(
                                  child: InfoChip(
                                    topText:
                                        school.createdAt?.split('-').first ??
                                        '-',
                                    bottomText: "Since",
                                    fontSize: infoFont,
                                    isSmallScreen: isSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.4),
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.4,
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              scrollDirection: Axis.horizontal,
                              controller: _tabScrollController,

                              child: Row(
                                children: [
                                  ...DetailTabEnum.values.map((tab) {
                                    return GestureDetector(
                                              key: _tabKeys[tab.index], // 👈 Assign GlobalKey here

                                      onTap: () {
                                        vm.currentPageIndex = tab.index;
                                        pageController.animateToPage(
                                          tab.index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                                           _scrollToTab(tab.index);

                                      },
                                      child: CustomTab(
                                        tabName: tab.label,
                                        isSelected:
                                            tab.index == vm.currentPageIndex,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

              body: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  vm.currentPageIndex = index;
                    _scrollToTab(index);
                },
                children: [
                  OverviewTab(school: vm.school as SchoolModel),
                  AcademicsView(schoolId: widget.schoolId),
                  FacultyView(schoolId: widget.schoolId),
                  InfrastructureView(schoolId: widget.schoolId),
                  TechnologyAdoptionView(schoolId: widget.schoolId),
                  ActivityView(schoolId: widget.schoolId),
                  SafetyAndSecurityView(schoolId: widget.schoolId),
                  InternationalExposureView(schoolId: widget.schoolId),
                  FeesAndScholarshipsView(schoolId: widget.schoolId),
                  AdmissionTimelineView(schoolId: widget.schoolId),
                  AmenitiesView(schoolId: widget.schoolId),
                  AlumniView(schoolId: widget.schoolId),
                  ReviewsView(schoolId: widget.schoolId),
                  OtherDetailsView(schoolId: widget.schoolId),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
void _scrollToTab(int index) {
  final keyContext = _tabKeys[index].currentContext;
  if (keyContext == null) return;

  // Get the RenderBox for the tab
  final box = keyContext.findRenderObject() as RenderBox?;
  if (box == null) return;

  // ✅ Correct way: use RenderObject of the scroll view as ancestor
  final scrollBox = _tabScrollController.position.context.notificationContext
      ?.findRenderObject() as RenderBox?;

  if (scrollBox == null) return;

  // Get tab’s position relative to the scrollable area
  final position = box.localToGlobal(Offset.zero, ancestor: scrollBox);

  final tabLeft = position.dx;
  final tabRight = tabLeft + box.size.width;
  final viewportWidth = scrollBox.size.width;

  double targetOffset = _tabScrollController.offset;

  // Scroll left if hidden on the left
  if (tabLeft < 0) {
    targetOffset += tabLeft - 16;
  }
  // Scroll right if hidden on the right
  else if (tabRight > viewportWidth) {
    targetOffset += (tabRight - viewportWidth) + 16;
  }

  _tabScrollController.animateTo(
    targetOffset.clamp(
      _tabScrollController.position.minScrollExtent,
      _tabScrollController.position.maxScrollExtent,
    ),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}

  int calculateMatchPercentage({
    required SchoolModel school,
    required UserPref userPref,
  }) {
    int totalCriteria = 6;
    int matched = 0;

    // 1. State
    if (userPref.state != null &&
        userPref.state!.isNotEmpty &&
        school.state != null &&
        school.state!.isNotEmpty) {
      if (userPref.state!.toLowerCase() == school.state!.toLowerCase()) {
        matched++;
      }
    }

    // 2. City
    if (userPref.city != null &&
        userPref.city!.isNotEmpty &&
        school.city != null &&
        school.city!.isNotEmpty) {
      if (userPref.city!.toLowerCase() == school.city!.toLowerCase()) {
        matched++;
      }
    }

    // 3. Board
    if (userPref.boards != null &&
        userPref.boards!.isNotEmpty &&
        school.board != null &&
        school.board!.isNotEmpty) {
      if (userPref.boards!.toLowerCase() == school.board!.toLowerCase()) {
        matched++;
      }
    }

    // 4. School Type (UserPref) vs School Tags (SchoolModel)
    if (userPref.schoolType != null &&
        userPref.schoolType!.isNotEmpty &&
        school.tags != null &&
        school.tags!.isNotEmpty) {
      if (school.tags!
          .map((e) => e.toLowerCase())
          .contains(userPref.schoolType!.toLowerCase())) {
        matched++;
      }
    }

    // 5. School Mode / Shift
    if (userPref.shift != null &&
        userPref.shift!.isNotEmpty &&
        school.shifts != null &&
        school.shifts!.isNotEmpty) {
      if (school.shifts!
          .map((e) => e.toLowerCase())
          .contains(userPref.shift!.toLowerCase())) {
        matched++;
      }
    }

    // 6. Specialist vs Interest
    if (userPref.interests != null &&
        userPref.interests!.isNotEmpty &&
        school.specialist != null &&
        school.specialist!.isNotEmpty) {
      if (school.specialist!
          .map((e) => e.toLowerCase())
          .contains(userPref.interests!.toLowerCase())) {
        matched++;
      }
    }

    return ((matched / totalCriteria) * 100).round();
  }
}
