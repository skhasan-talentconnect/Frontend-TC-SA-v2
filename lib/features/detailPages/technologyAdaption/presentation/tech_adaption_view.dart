import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/presentation/view_models/techAdaption_view_model.dart';

class TechnologyAdoptionView extends StatefulWidget {
  const TechnologyAdoptionView({super.key});

  @override
  State<TechnologyAdoptionView> createState() => _TechnologyAdoptionViewState();
}

class _TechnologyAdoptionViewState extends State<TechnologyAdoptionView> {
  final TechnologyAdoptionViewModel _vm = TechnologyAdoptionViewModel();
  String _schoolId = '';
  String _schoolName = 'Technology Adoption';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Technology Adoption';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getTechnologyAdoptionBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getTechnologyAdoptionBySchoolId(schoolId: _schoolId);
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
        body: Consumer<TechnologyAdoptionViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.techAdoption;

            if (model == null) {
              return Center(child: Text(vm.message ?? "No technology data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildPercentageCard(context, model.smartClassroomsPercentage),
                  const SizedBox(height: 20),
                  _buildChipListCard(context, model.eLearningPlatforms),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPercentageCard(BuildContext context, double? percentage) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Smart Classrooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                if (percentage != null)
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo),
                  )
                else
                  const Text('N/A', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            if (percentage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 12,
                  backgroundColor: Colors.indigo.shade100,
                  color: Colors.indigo,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChipListCard(BuildContext context, List<String> platforms) {
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
                const Icon(Icons.cast_for_education, color: Colors.indigo, size: 28),
                const SizedBox(width: 10),
                Text('E-learning Platforms', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            if (platforms.isEmpty)
              const Text('No platforms listed.')
            else
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: platforms.map((platform) => Chip(
                  label: Text(platform),
                  backgroundColor: Colors.indigo.withOpacity(0.1),
                  side: BorderSide(color: Colors.indigo.withOpacity(0.3)),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }
}