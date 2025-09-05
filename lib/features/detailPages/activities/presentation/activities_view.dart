import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/widgets/activity_highlight_widget.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/view_models/activities_view_model.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/widgets/icon_mapper.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ActivitiesViewModel>();
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
      body: Builder(
        builder: (_) {
          if (state == ViewState.busy) {
            return const Center(child: CircularProgressIndicator());
          }
          if (model == null) {
            return Center(child: Text(vm.message ?? "No activities found"));
          }

          final activities = model.activities ?? const <String>[];

          return SingleChildScrollView(
            child: Column(
              children: [
                // Banner (optional, static or from parent if you pass props)
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
                        const Text("No activities configured for this school.")
                      else
                        GridView.count(
                          crossAxisCount: cross,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.2,
                          children:
                              activities.map((title) {
                                return ActivityHighlightWidget(
                                  icon: ActivityIconMapper.getIconFor(title),
                                  title: title,
                                );
                              }).toList(),
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
    );
  }
}
