import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';

import 'package:tc_sa/features/detailPages/activities/presentation/view_models/activities_view_model.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/widgets/activity_highlight_widget.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/widgets/icon_mapper.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key, required this.schoolId});
  final String schoolId;
  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final ActivitiesViewModel _vm = ActivitiesViewModel();
  // String _schoolId = '';
  // bool _parsed = false;
  @override
void initState(){
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getActivitiesBySchoolId(schoolId: widget.schoolId);
      });
}
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_parsed) return;
  //   _parsed = true;

  //   final state = GoRouterState.of(context);
  //   final extra = state.extra;

  //   // --- NAVIGATION BUG FIX ---
  //   // Handle both Map (from OverviewView) and String (if pushed directly)
  //   if (extra is Map) {
  //     _schoolId = extra['schoolId'] as String? ?? '';
  //   } else if (extra is String && extra.trim().isNotEmpty) {
  //     _schoolId = extra.trim();
  //   }
  //   // --- END FIX ---

  //   if (_schoolId.isEmpty) {
  //     _schoolId = (state.pathParameters['id'] ?? '').toString();
  //   }
  //   if (_schoolId.isEmpty) {
  //     _schoolId = (state.uri.queryParameters['id'] ?? '').toString();
  //   }

  //   if (_schoolId.isNotEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _vm.getActivitiesBySchoolId(schoolId: _schoolId);
  //     });
  //   } else {
  //     _vm.setViewState(ViewState.complete);
  //   }
  // }

  Future<void> _refresh() async {
    if (widget.schoolId.isEmpty) return;
    await _vm.getActivitiesBySchoolId(schoolId: widget.schoolId);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Consumer<ActivitiesViewModel>(
        builder: (context, vm, _) {
          final state = vm.viewState;
          final model = vm.activitiesModel;
          final size = MediaQuery.of(context).size;
          final isSmall = size.width < 600;
          final cross = isSmall ? 2 : 3;

          return Scaffold(
            backgroundColor: Colors.white,
            // appBar: SAppBar(
            //   leading: SIcon(
            //     icon: Icons.keyboard_arrow_left,
            //     // --- NAVIGATION FIX ---
            //     onTap: () => context.pop(),
            //   ),
            //   title: "School Activities",
            // ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              // --- THEME UPDATE ---
              color: Colors.amber, 
              child: Builder(
                builder: (_) {
                  if (widget.schoolId.isEmpty) {
                    return const Center(child: Text('Missing school context'));
                  }
                  if (state == ViewState.busy) {
                    return const Center(child: SLoadingIndicator());
                  }

                  if (model == null) {
                    // --- UI POLISH: More modern 'Not Found' message ---
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.layers_clear, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            vm.message ?? "No activities found",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  final activities = model.activities ?? const <String>[];

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // --- THEME UPDATE: Banner color and icon color ---
                        Container(
                          height: 150,
                          color: Colors.amber.shade100,
                          alignment: Alignment.center,
                          child: Icon(Icons.event_available, size: 64, color: Colors.amber.shade800),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- UI POLISH: Title styling ---
                              Text(
                                "Activity Focus Areas",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              if (activities.isEmpty)
                                const Text(
                                  "No activities configured for this school.",
                                )
                              else
                                GridView.count(
                                  crossAxisCount: cross,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.2,
                                  children: activities
                                      .map(
                                        (title) => ActivityHighlightWidget(
                                          icon: ActivityIconMapper.getIconFor(title),
                                          title: title,
                                        ),
                                      )
                                      .toList(),
                                ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}