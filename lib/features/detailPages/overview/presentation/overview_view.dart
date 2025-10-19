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
  const SchoolDetailView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<SchoolDetailView> createState() => _SchoolDetailViewState();
}

class _SchoolDetailViewState extends State<SchoolDetailView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final OverviewViewModel _vm;

  final List<String> _tabs = const [
    "Overview",
    "Amenities",
    "Infrastructure",
    "Other Details",
    "Fees And Scholarship",
    "Activities",
    "Aluminis",
    "Reviews",
    'academics',
    'techAdaption',
    'safetySecurity',
    'internationalExposure',
    'admission Timeline',
    'faculty details',
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
      final id = widget.schoolId;
      switch (_tabController.index) {
        case 1:
          context.pushNamed(
            RouteNames.amenity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 2: // New case for Infrastructure
          context.pushNamed(
            RouteNames.infrastructure,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 3: // New case for Other Details
          context.pushNamed(
            RouteNames.otherDetails,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 4: // New case for Fees & Scholarship
          context.pushNamed(
            RouteNames.feeAndScholarship,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 5:
          context.pushNamed(RouteNames.activity, extra: widget.schoolId);
          break;
        case 6:
          context.pushNamed(
            RouteNames.alumini,
            extra: {
              'schoolId': widget.schoolId,
              'schoolName': _vm.school?.name ?? 'School',
            },
          );
          break;
        case 7:
          context.pushNamed(
            RouteNames.review,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 8:
          context.pushNamed(
            RouteNames.academics,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
        case 9:
          context.pushNamed(
            RouteNames.techAdaption,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 10:
          context.pushNamed(
            RouteNames.safetySecurity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 11:
          context.pushNamed(
            RouteNames.internationalExposure,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 12:
          context.pushNamed(
            RouteNames.admissionTimeline,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 13:
          context.pushNamed(
            RouteNames.faculty,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        default:
      }
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
                                        decoration:
                                            TextDecoration
                                                .underline, // makes it look clickable
                                      ),
                                    ),
                                  ),
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
                                return _OverviewTab(school: school);
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

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.school});
  final SchoolModel school;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    // Improved fee parsing
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
                  value: school.tags?.join(", ") ?? "-",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Fee Range Section
          _TitledCard(
            title: "Fee Structure",
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the full fee range text
                Text(
                  school.feeRange ?? "Not Available",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Annual Fee Range",
                  style: TextStyle(color: Colors.amber, fontSize: 14),
                ),
                const SizedBox(height: 16),

                // Visual bar for the range
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.amber],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Low and High labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lowest: $feeLow",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Highest: $feeHigh",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Top Amenities Section
          _TitledCard(
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
        ],
      ),
    );
  }
}

// --- Local Helper Widgets for this View ---

class _TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const _TitledCard({
    required this.title,
    required this.icon,
    required this.child,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            child,
          ],
        ),
      ),
    );
  }
}
