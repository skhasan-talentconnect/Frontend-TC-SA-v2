import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'view_models/academics_view_model.dart';

class AcademicsView extends StatefulWidget {
  const AcademicsView({super.key});

  @override
  State<AcademicsView> createState() => _AcademicsViewState();
}

class _AcademicsViewState extends State<AcademicsView> {
  final AcademicsViewModel _vm = AcademicsViewModel();
  String _schoolId = '';
  String _schoolName = 'Academics';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Academics';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getAcademicsBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getAcademicsBySchoolId(schoolId: _schoolId);
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
        appBar: SAppBar(
          title: _schoolName,
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
        ),
        body: Consumer<AcademicsViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.academics;

            if (model == null) {
              return Center(child: Text(vm.message ?? "No academic data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildBoardResultsCard(context, model.averageClass10Result, model.averageClass12Result),
                  const SizedBox(height: 20),
                  _buildOverallMarksCard(context, model.averageSchoolMarks),
                  const SizedBox(height: 20),
                  _buildChipListCard(context, 'Special Exam Training', Icons.model_training, model.specialExamsTraining, Colors.purple),
                  const SizedBox(height: 20),
                  _buildChipListCard(context, 'Extra-Curricular Activities', Icons.palette_outlined, model.extraCurricularActivities, Colors.orange),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBoardResultsCard(BuildContext context, double? class10, double? class12) {
    return _TitledCard(
      title: 'Average Board Results',
      icon: Icons.assessment_outlined,
      iconColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (class10 != null) _buildResultIndicator('Class 10', class10, Colors.blue),
            if (class12 != null) _buildResultIndicator('Class 12', class12, Colors.green),
            if (class10 == null && class12 == null) const Text('No board result data available.'),
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
                child: Text('${value.toStringAsFixed(1)}%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildOverallMarksCard(BuildContext context, double? marks) {
    return _TitledCard(
      title: 'Overall School Average',
      icon: Icons.star_border_rounded,
      iconColor: Colors.amber,
      child: (marks == null)
          ? const Padding(padding: EdgeInsets.all(16.0), child: Text('Data not available.'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('All Standards', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('${marks.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber)),
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

  Widget _buildChipListCard(BuildContext context, String title, IconData icon, List<String> items, Color color) {
    return _TitledCard(
      title: title,
      icon: icon,
      iconColor: color,
      child: (items.isEmpty)
          ? const Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Text('No data available for this section.'))
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: items.map((item) => Chip(
                  label: Text(item),
                  backgroundColor: color.withOpacity(0.1),
                  side: BorderSide(color: color.withOpacity(0.3)),
                )).toList(),
              ),
            ),
    );
  }
}

// A local, private widget for consistent card styling on this page
class _TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const _TitledCard({required this.title, required this.icon, required this.child, required this.iconColor});

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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            child,
          ],
        ),
      ),
    );
  }
}