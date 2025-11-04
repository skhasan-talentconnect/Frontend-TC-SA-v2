import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';
import 'package:tc_sa/features/application/forms/presentation/view_models/my_form_view_model.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/applied_form_model.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/view_models/overview_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/info_chip_widget.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/quick_highlight_widget.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/recruiter_chip_widget.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetailView extends StatefulWidget {
  const SchoolDetailView({
    super.key,
    required this.schoolId,
    this.distance, // ✅ add this
  });

  final String schoolId;
  final String? distance;

  @override
  State<SchoolDetailView> createState() => _SchoolDetailViewState();
}

class _SchoolDetailViewState extends State<SchoolDetailView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final OverviewViewModel _vm;

  final List<String> _tabs = const [
    "Overview",
    'academics',
    'faculty details',
    "Infrastructure",
    'techAdaption',
    "Activities",
    'safetySecurity',
    'internationalExposure',
    "Fees And Scholarship",

    'admission Timeline',
    "Amenities",

    "Aluminis",
    "Reviews",

    "Other Details",
  ];

  final MyFormViewModel myFormViewModel = MyFormViewModel();
  final ShortlistViewModel shortlistViewModel = ShortlistViewModel();
  final appStateProvider = getIt<AppStateProvider>();

  final ValueNotifier<bool> isSaved = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _vm = OverviewViewModel();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await _vm.getSchoolsById(id: widget.schoolId);
      failure?.showError(context);
      await _vm.getIsAppliedSchool(schoolId: widget.schoolId);
      isSaved.value = getIt<AppStateProvider>().isSaved(widget.schoolId);
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final name = _vm.school?.name ?? 'School';
      final id =
          widget
              .schoolId; // Using id for clarity, though not strictly needed here

      switch (_tabController.index) {
        // Index 0: "Overview" - typically not routed, handled by default

        // Index 1: 'academics'
        case 1:
          context.pushNamed(
            RouteNames.academics,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 2: 'faculty details'
        case 2:
          context.pushNamed(
            RouteNames.faculty,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 3: "Infrastructure"
        case 3:
          context.pushNamed(
            RouteNames.infrastructure,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 4: 'techAdaption'
        case 4:
          context.pushNamed(
            RouteNames.techAdaption,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 5: "Activities"
        case 5:
          // Assuming RouteNames.activity expects a map with schoolId and schoolName
          context.pushNamed(
            RouteNames.activity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 6: 'safetySecurity'
        case 6:
          context.pushNamed(
            RouteNames.safetySecurity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 7: 'internationalExposure'
        case 7:
          context.pushNamed(
            RouteNames.internationalExposure,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 8: "Fees And Scholarship"
        case 8:
          context.pushNamed(
            RouteNames.feeAndScholarship,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 9: 'admission Timeline'
        case 9:
          context.pushNamed(
            RouteNames.admissionTimeline,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 10: "Amenities"
        case 10:
          context.pushNamed(
            RouteNames.amenity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 11: "Aluminis"
        case 11:
          context.pushNamed(
            RouteNames.alumini,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 12: "Reviews"
        case 12:
          context.pushNamed(
            RouteNames.review,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        // Index 13: "Other Details"
        case 13:
          context.pushNamed(
            RouteNames.otherDetails,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;

        default:
          // Handle any unmapped or default case (like Index 0: Overview)
          break;
      }

      // This logic ensures that after pushing a new route, the tab is reset to "Overview" (Index 0).
      if (_tabController.index != 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _tabController.index = 0;
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _vm.dispose(); // because we use .value below
    super.dispose();
  }

  int calculateMatchPercentage({
    required SchoolModel school,
    required UserPref userPref,
  }) {
    int totalCriteria =
        6; // state, city, board, schoolType, schoolMode, specialist/interest
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Consumer<OverviewViewModel>(
        builder: (_, vm, __) {
          final state = vm.viewState;
          final school = vm.school;

          final size = MediaQuery.of(context).size;
          final isSmall = size.width < 600;
          final isMed = size.width >= 600 && size.width < 900;
          final bannerHeight = isSmall ? 150.0 : (isMed ? 180.0 : 200.0);
          final titleFont = isSmall ? 20.0 : (isMed ? 24.0 : 26.0);
          final infoFont = isSmall ? 16.0 : (isMed ? 18.0 : 20.0);
          final tabFont = isSmall ? 14.0 : (isMed ? 16.0 : 18.0);
          final pad = isSmall ? 6.0 : (isMed ? 8.0 : 10.0);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
              title: school?.name ?? "School",
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
                                                  schoolId:
                                                      _vm.school?.id ?? '',
                                                )
                                            : failure = await shortlistViewModel
                                                .addShortlist(
                                                  schoolId:
                                                      _vm.school?.id ?? '',
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
            body: Builder(
              builder: (_) {
                if (state == ViewState.busy) {
                  return const Center(child: SLoadingIndicator());
                }
                if (school == null) {
                  return Center(child: Text(vm.message ?? "No data found"));
                }

                final location = [
                  school.city,
                  school.state,
                ].where((e) => (e ?? '').isNotEmpty).join(", ");

                return Column(
                  children: [
                    // Header (fixed)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner
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

                                  // Location Text (Clickable)
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
                                          mode: LaunchMode.externalApplication,
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
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),

                                  // ✅ Add a small vertical divider (dot) only if distance is available
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
                                                      child: SLoadingIndicator(
                                                        color: Colors.blue,
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
                                                          if (_vm.isApplied) {
                                                            return;
                                                          }
                                                          final failure =
                                                              await myFormViewModel
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
                                                            popOnSuccess: false,
                                                            hideSuccess: true,
                                                            successCallback: () {
                                                              _vm.appliedFormModel =
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
                                                          _vm.isApplied
                                                              ? Colors.grey
                                                              : Colors.blue,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                          ),
                                                      label: '',
                                                      max: true,
                                                      text: Text(
                                                        _vm.isApplied
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
                                      (school.createdAt ?? "")
                                              .split("T")
                                              .first
                                              .isEmpty
                                          ? "-"
                                          : (school.createdAt ?? "")
                                              .split("T")
                                              .first,
                                  bottomText: "Since",
                                  fontSize: infoFont,
                                  isSmallScreen: isSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Tabs
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
                          child: TabBar(
                            isScrollable: true,

                            tabAlignment: TabAlignment.start,
                            controller: _tabController,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            indicator: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: tabFont,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: tabFont,
                            ),
                            tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
                          ),
                        ),
                      ],
                    ),

                    // Overview tab content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            _tabs.map((tab) {
                              if (tab == "Overview") {
                                return OverviewTab(school: school);
                              }
                              return Center(
                                child: Text(
                                  "Tap on '$tab' tab to view details",
                                  style: TextStyle(fontSize: infoFont),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({required this.school});
  final SchoolModel school;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    // Fee parsing
    final feeParts = (school.feeRange ?? "").split(RegExp(r'[-–]'));
    final feeLow = feeParts.isNotEmpty ? feeParts.first.trim() : '-';
    final feeHigh =
        feeParts.length > 1
            ? feeParts.last.trim()
            : (feeParts.isNotEmpty ? feeParts.first.trim() : '-');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // --- SOCIAL MEDIA PRESENCE SECTION AT TOP ---
         
          const SizedBox(height: 5),

          // Quick Highlights Section
          TitledCard(
            title: "Quick Highlights",
            icon: Icons.info,
            child: GridView.count(
              crossAxisCount: isSmall ? 2 : 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                QuickHighlights(
                  icon: Icons.school_outlined,
                  title: "School Mode",
                  value: school.schoolMode ?? "-",
                ),
                QuickHighlights(
                  icon: Icons.wc_outlined,
                  title: "Gender",
                  value: school.genderType ?? "-",
                ),
                QuickHighlights(
                  icon: Icons.directions_bus_outlined,
                  title: "Transport",
                  value: school.transportAvailable ?? "-",
                ),
                QuickHighlights(
                  icon: Icons.translate_outlined,
                  title: "Medium",
                  value: school.languageMedium?.join(", ") ?? "-",
                ),
                QuickHighlights(
                  icon: Icons.access_time_outlined,
                  title: "Shifts",
                  value: school.shifts?.join(", ") ?? "-",
                ),
                QuickHighlights(
                  icon: Icons.label_outline,
                  title: "Type",
                  value: school.tags?.join(", ") ?? "---",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- SIMPLIFIED FEE RANGE DISPLAY ---
          FeeRangeDisplay(
            feeLow: feeLow,
            feeHigh: feeHigh,
            feeRange: school.feeRange ?? "-",
          ),
          const SizedBox(height: 20),

          // Top Amenities Section
          TitledCard(
            title: "Top Tags",
            icon: Icons.widgets_outlined,
            iconColor: Colors.amber,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  (school.tags?.isNotEmpty == true
                          ? school.tags!
                          : (school.specialist?.isNotEmpty == true
                              ? school.specialist!
                              : const [
                                "E-Library",
                                "Science Lab",
                                "Computer Lab",
                              ]))
                      .map(
                        (e) => RecruiterChip(label: e, isSmallScreen: isSmall),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}



class FeeRangeDisplay extends StatelessWidget {
  final String feeLow;
  final String feeHigh;
  final String feeRange;

  const FeeRangeDisplay({
    super.key,
    required this.feeLow,
    required this.feeHigh,
    required this.feeRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade100.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Full Range text
          Text(
            'Full Range: $feeRange',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),

          // Min/Max section
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'MINIMUM',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      feeLow,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 32,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'MAXIMUM',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.yellow.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      feeHigh,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const TitledCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade100.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.yellow.shade800, size: 18),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
