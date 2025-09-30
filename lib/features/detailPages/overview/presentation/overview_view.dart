import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/presentation/view_models/my_form_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/view_models/overview_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/info_chip_widget.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/quick_highlight_widget.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/recruiter_chip_widget.dart';
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
    "Activities",
    "Aluminis",
    "Reviews",
  ];

  final MyFormViewModel myFormViewModel = MyFormViewModel();

  @override
  void initState() {
    super.initState();
    _vm = OverviewViewModel();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await _vm.getSchoolsById(id: widget.schoolId);
      failure?.showError(context);
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 1:
          final name = _vm.school?.name ?? 'School';
          context.pushNamed(
            RouteNames.amenity,
            extra: {'schoolId': widget.schoolId, 'schoolName': name},
          );
          break;
        case 2:
          context.pushNamed(RouteNames.activity, extra: widget.schoolId);
          break;
        case 3:
          context.pushNamed(
            RouteNames.alumini,
            extra: {
              'schoolId': widget.schoolId,
              'schoolName': _vm.school?.name ?? 'School',
            },
          );
          break;
        case 4:
          context.pushNamed(RouteNames.review);
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
                                                        final failure =
                                                            await myFormViewModel
                                                                .submitForm(
                                                                  applicationId:
                                                                      '',
                                                                  schoolId:
                                                                      widget
                                                                          .schoolId,
                                                                );
                                                        failure?.showError(
                                                          context,
                                                        );
                                                      },
                                                      backgroundColor:
                                                          Colors.blue,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                          ),
                                                      label: '',
                                                      max: true,
                                                      text: Text(
                                                        "Apply",
                                                        style: TextStyle(
                                                          fontSize: infoFont,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
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
                                      bottomText: "Matched",
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
                                  topText: school.createdAt?.toYYYYY ?? "-",
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

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.school});
  final SchoolModel school;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;
    final isMed = size.width >= 600 && size.width < 900;
    final cross = isSmall ? 2 : (isMed ? 3 : 4);
    final infoFont = isSmall ? 16.0 : (isMed ? 18.0 : 20.0);
    final pad = isSmall ? 8.0 : (isMed ? 12.0 : 16.0);

    final feeHi = (school.feeRange ?? "")
        .split(RegExp(r'[-–]'))
        .last
        .trim()
        .replaceAll(RegExp(r'[^\d]'), '');

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Highlights
          Text(
            "Quick Highlights",
            style: TextStyle(
              fontSize: infoFont + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: cross,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              QuickHighlights(
                title: "School Mode",
                value: school.schoolMode ?? "-",
              ),
              QuickHighlights(
                title: "Gender Allowed",
                value: school.genderType ?? "-",
              ),
              QuickHighlights(
                title: "Transport",
                value: (school.transportAvailable ?? "-"),
              ),
              QuickHighlights(
                title: "Medium",
                value: (school.languageMedium?.join(", ") ?? "-"),
              ),
              QuickHighlights(
                title: "Shifts",
                value: (school.shifts?.join(", ") ?? "-"),
              ),
              QuickHighlights(
                title: "Type",
                value: (school.tags?.join(", ") ?? (school.description ?? "-")),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Fee Range
          Text(
            "Fee Range",
            style: TextStyle(
              fontSize: infoFont + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Highest Fee",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: infoFont,
                ),
              ),
              Text(
                feeHi.isEmpty ? (school.feeRange ?? "-") : feeHi,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: infoFont - 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Average Fee",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: infoFont,
                ),
              ),
              Text(
                school.feeRange ?? "-",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: infoFont - 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Top Amenities (using tags/specialist as placeholders if amenities not present)
          Text(
            "Top Amenities",
            style: TextStyle(
              fontSize: infoFont + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
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
                    .map((e) => RecruiterChip(label: e, isSmallScreen: isSmall))
                    .toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
