import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/models/school_card_model.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/core/navigation/route_name.dart';
import 'package:tc_sa/core/utils/toast.dart';
import 'package:tc_sa/features/compare/presentation/widgets/compareWith_widgets.dart';
import 'package:tc_sa/features/home/presentation/view_model/schools_view_model.dart';
import 'package:tc_sa/features/compare/presentation/view_models/compare_view_model.dart';

import '../../../common/theme/s_colors.dart';

class CompareWith extends StatefulWidget {
  const CompareWith({super.key});

  @override
  State<CompareWith> createState() => _CompareWithState();
}

class _CompareWithState extends State<CompareWith> {
  // Local view models (no DI)
  final SchoolViewModel schoolVm = SchoolViewModel();
  final CompareViewModel compareVm = CompareViewModel();

  // Router extras
  late final String baseSchoolId;
  String? baseSchoolName; // optional: for UI display

  bool _extrasParsed = false; // ensure extras parsed once
  bool showShortlistedOnly = false;
  String searchText = '';
  bool _isComparing = false; // Track if comparison is in progress

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Parse extras once
    if (_extrasParsed) return;
    _extrasParsed = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      baseSchoolId = (extra['id'] ?? '').toString();
      baseSchoolName = extra['name'] as String?;
    } else if (extra is String) {
      baseSchoolId = extra;
    } else {
      baseSchoolId = '';
    }
  }

  @override
  void initState() {
    super.initState();
    // Load candidate schools (by state)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schoolVm.getStateSchools();
    });
  }

  List<SchoolCardModel> _filtered(
    List<SchoolCardModel> source,
    String? excludeId,
  ) {
    // TODO: Replace shortlist logic with your real one
    var list = showShortlistedOnly ? source.take(20).toList() : source;

    if ((excludeId ?? '').isNotEmpty) {
      list = list.where((s) => s.schoolId != excludeId).toList();
    }
    if (searchText.isNotEmpty) {
      final q = searchText.toLowerCase();
      list = list
          .where((s) => (s.name ?? '').toLowerCase().contains(q) || (s.location ?? '').toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: schoolVm),
        ChangeNotifierProvider.value(value: compareVm),
      ],
      child: Consumer2<SchoolViewModel, CompareViewModel>(
        builder: (context, sVm, cVm, _) {
          final isLoadingList = sVm.viewState == ViewState.busy;
          final candidates = _filtered(sVm.stateSchools, baseSchoolId);

          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: SAppBar(
                  leading: SIcon(
                    icon: Icons.keyboard_arrow_left,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  title: 'Choose School',
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Compare. Decide. Succeed.",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 4),
                      Text("Compare With",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SColor.primaryColor,
                            fontSize: 33,
                          )),
                      const SizedBox(height: 22),
                      Text("Select From Shortlisted Schools or\nSearch Other",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: SColor.primaryColor,
                          )),
                      const SizedBox(height: 14),

                      // Search + Filter row (from helper)
                      CompareWithWidgets.searchAndFilterRow(
                        searchText: searchText,
                        showShortlistedOnly: showShortlistedOnly,
                        onSearchChanged: (v) => setState(() => searchText = v),
                        onToggleShortlist: () => setState(() => showShortlistedOnly = !showShortlistedOnly),
                      ),

                      const SizedBox(height: 15),

                      if ((baseSchoolName ?? '').isNotEmpty)
                        CompareWithWidgets.basePreview(baseSchoolName!), // helper

                      if (isLoadingList)
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Center(child: SLoadingIndicator()),
                        )
                      else if (candidates.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Text(
                              "No schools found",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                          itemBuilder: (_, i) => CompareWithWidgets.schoolTile(
                            candidates[i],
                            onCompare: () async {
                              setState(() => _isComparing = true);
                              
                              // Call API
                              final failure = await cVm.compareSchools(
                                schoolId1: baseSchoolId,
                                schoolId2: candidates[i].schoolId ?? '',
                              );

                              if (!mounted) return;
                              setState(() => _isComparing = false);

                              if (failure != null) {
                                // Use custom error toast instead of SnackBar
                                Toasts.showErrorToast(
                                  context,
                                  message: failure.message ?? "Something went wrong",
                                );
                                return;
                              }

                              // Navigate to compare page
                              context.pushNamed(
                                RouteNames.compare,
                                extra: {'school1': cVm.school1, 'school2': cVm.school2},
                              );

                              // Clear VM after leave
                              Future.microtask(() {
                                if (mounted) cVm.clear();
                              });
                            },
                          ),
                          itemCount: candidates.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Loading overlay
              if (_isComparing)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: SLoadingIndicator(), // Use your custom loader here
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}