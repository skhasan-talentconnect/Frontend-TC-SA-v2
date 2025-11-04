import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';
import 'view_models/academics_view_model.dart';

class AcademicsView extends StatefulWidget {
  const AcademicsView({required this.schoolId, super.key});
  final String schoolId;

  @override
  State<AcademicsView> createState() => _AcademicsViewState();
}

class _AcademicsViewState extends State<AcademicsView> {
  final AcademicsViewModel _vm = AcademicsViewModel();
  String _schoolName = 'Academics';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAcademicsBySchoolId(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getAcademicsBySchoolId(schoolId: widget.schoolId);
    }
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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AcademicsViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.academics;
            if (model == null) {
              return Center(
                child: Text(vm.message ?? "No academic data found."),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildBoardResultsCard(
                    context,
                    model.averageClass10Result,
                    model.averageClass12Result,
                  ),
                  const SizedBox(height: 20),
                  _buildOverallMarksCard(context, model.averageSchoolMarks),
                  const SizedBox(height: 20),
                  _buildChipListCard(
                    context,
                    'Special Exam Training',
                    Icons.model_training,
                    model.specialExamsTraining,
                    Colors.amber,
                  ),
                  const SizedBox(height: 20),
                  _buildChipListCard(
                    context,
                    'Extra-Curricular Activities',
                    Icons.palette_outlined,
                    model.extraCurricularActivities,
                    Colors.amber,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBoardResultsCard(
    BuildContext context,
    double? class10,
    double? class12,
  ) {
    return TitledCard(
      title: 'Average Board Results',
      icon: Icons.leaderboard,
      iconColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (class10 != null)
              _buildResultIndicator('Class 10', class10, Colors.amber.shade700),
            if (class12 != null)
              _buildResultIndicator('Class 12', class12, Colors.amber),
            if (class10 == null && class12 == null)
              const Text('No board result data available.'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultIndicator(String title, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          width: 90,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 9,
                backgroundColor: color.withOpacity(0.15),
                color: color,
              ),
              Center(
                child: Text(
                  '${value.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildOverallMarksCard(BuildContext context, double? marks) {
    return TitledCard(
      title: 'Overall School Average',
      icon: Icons.workspace_premium,
      iconColor: Colors.amber,
      child: (marks == null)
          ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Data not available.'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Standards',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${marks.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: marks / 100,
                      minHeight: 12,
                      backgroundColor: Colors.amber.shade100,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildChipListCard(
    BuildContext context,
    String title,
    IconData icon,
    List<String> items,
    Color color,
  ) {
    return TitledCard(
      title: title,
      icon: icon,
      iconColor: color,
      child: (items.isEmpty)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text('No data available for this section.'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: items
                    .map(
                      (item) => Chip(
                        label: Text(item),
                        backgroundColor: color.withOpacity(0.1),
                        side: BorderSide(color: color.withOpacity(0.3)),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
