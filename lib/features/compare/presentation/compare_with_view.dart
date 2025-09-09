import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/navigation/route_name.dart';
import 'package:tc_sa/features/compare/presentation/widgets/compareWith_widgets.dart';
import 'package:tc_sa/features/home/presentation/view_model/schools_view_model.dart';

class CompareWith extends StatefulWidget {
  const CompareWith({
    required this.schoolId,
    required this.schoolName,
    super.key,
  });
  final String schoolId;
  final String schoolName;

  @override
  State<CompareWith> createState() => _CompareWithState();
}

class _CompareWithState extends State<CompareWith> {
  // Local view models (no DI)
  final SchoolViewModel schoolVm = SchoolViewModel();

  bool showShortlistedOnly = false;
  String searchText = '';
  bool _isComparing = false; // Track if comparison is in progress

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
    var list = showShortlistedOnly ? source.take(20).toList() : source;

    if ((excludeId ?? '').isNotEmpty) {
      list = list.where((s) => s.schoolId != excludeId).toList();
    }
    if (searchText.isNotEmpty) {
      final q = searchText.toLowerCase();
      list =
          list
              .where(
                (s) =>
                    (s.name ?? '').toLowerCase().contains(q) ||
                    (s.location ?? '').toLowerCase().contains(q),
              )
              .toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: schoolVm,
      child: Consumer<SchoolViewModel>(
        builder: (context, sVm, _) {
          final candidates = _filtered(sVm.stateSchools, widget.schoolId);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => Navigator.of(context).pop(),
              ),
              title: 'Choose School',
            ),

            body:
                sVm.isLoading
                    ? Center(child: SLoadingIndicator())
                    : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Compare. Decide. Succeed.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Compare With",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SColor.primaryColor,
                              fontSize: 33,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Select From Shortlisted Schools or\nSearch Other",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: SColor.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 14),
                          CompareWithWidgets.searchAndFilterRow(
                            searchText: searchText,
                            showShortlistedOnly: showShortlistedOnly,
                            onSearchChanged:
                                (v) => setState(() => searchText = v),
                            onToggleShortlist:
                                () => setState(
                                  () =>
                                      showShortlistedOnly =
                                          !showShortlistedOnly,
                                ),
                          ),

                          const SizedBox(height: 15),

                          if ((widget.schoolName).isNotEmpty)
                            CompareWithWidgets.basePreview(widget.schoolName),

                          if (candidates.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Center(
                                child: Text(
                                  "No schools found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          else
                            ListView.separated(
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemBuilder:
                                  (_, i) => CompareWithWidgets.schoolTile(
                                    candidates[i],
                                    onCompare: (id) async {
                                      context.pushNamed(
                                        RouteNames.compare,
                                        extra: {
                                          'school1': widget.schoolId,
                                          'school2': id,
                                        },
                                      );
                                    },
                                  ),
                              itemCount: candidates.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                        ],
                      ),
                    ),
          );
        },
      ),
    );
  }
}
