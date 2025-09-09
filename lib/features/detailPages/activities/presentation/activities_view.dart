// features/detailPages/activities/presentation/activity_view.dart
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
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  // local VM instance (we'll wrap with ChangeNotifierProvider.value)
  final ActivitiesViewModel _vm = ActivitiesViewModel();

  // parsed once
  String _schoolId = '';
  bool _parsed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_parsed) return;
    _parsed = true;

    final state = GoRouterState.of(context);

    // 1) prefer extras (since Overview pushes extra as String)
    final extra = state.extra;
    if (extra is String && extra.trim().isNotEmpty) {
      _schoolId = extra.trim();
    }

    // 2) optional path param fallback if you ever switch to /activity/:id
    if (_schoolId.isEmpty) {
      _schoolId = (state.pathParameters['id'] ?? '').toString();
    }

    // 3) optional query fallback ?id=...
    if (_schoolId.isEmpty) {
      _schoolId = (state.uri.queryParameters['id'] ?? '').toString();
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getActivitiesBySchoolId(schoolId: _schoolId);
      });
    } else {
      // nothing to load, set to complete so the UI can show a friendly message
      _vm.setViewState(ViewState.complete);
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isEmpty) return;
    await _vm.getActivitiesBySchoolId(schoolId: _schoolId);
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
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
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => Navigator.of(context).pop(),
              ),
              title: "School Activities",
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.blue,
              child: Builder(
                builder: (_) {
                  if (_schoolId.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Missing school context')),
                      ],
                    );
                  }

                  if (state == ViewState.busy) {
                    return const Center(child: SLoadingIndicator());
                  }

                  if (model == null) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text("No activities found")),
                      ],
                    );
                  }

                  final activities = model.activities ?? const <String>[];

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Banner (static placeholder)
                        Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: const Icon(Icons.event_available, size: 64),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Activity Focus Areas",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                          icon:
                                              ActivityIconMapper.getIconFor(title),
                                          title: title,
                                        ),
                                      )
                                      .toList(),
                                ),
                              const SizedBox(height: 24),
                              const Divider(color: Colors.grey, thickness: 0.5),
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
