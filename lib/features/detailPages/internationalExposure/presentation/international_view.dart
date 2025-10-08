import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/data/entities/international-model.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/presentation/view_models/international_view_model.dart';


class InternationalExposureView extends StatefulWidget {
  const InternationalExposureView({super.key});

  @override
  State<InternationalExposureView> createState() => _InternationalExposureViewState();
}

class _InternationalExposureViewState extends State<InternationalExposureView> {
  final InternationalExposureViewModel _vm = InternationalExposureViewModel();
  String _schoolId = '';
  String _schoolName = 'International Exposure';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'International Exposure';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getInternationalExposureBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getInternationalExposureBySchoolId(schoolId: _schoolId);
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
        body: Consumer<InternationalExposureViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.exposure;
            final hasPrograms = model?.exchangePrograms.isNotEmpty ?? false;
            final hasTieUps = model?.globalTieUps.isNotEmpty ?? false;

            if (model == null || (!hasPrograms && !hasTieUps)) {
              return Center(child: Text(vm.message ?? "No international exposure data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (hasPrograms) ...[
                    Text('Exchange Programs', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ...model.exchangePrograms.map((program) => _ExchangeProgramCard(program: program)),
                    const SizedBox(height: 24),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 24),
                  ],
                  if (hasTieUps) ...[
                    Text('Global Tie-ups', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ...model.globalTieUps.map((tieUp) => _GlobalTieUpCard(tieUp: tieUp)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


// --- Local Helper Widgets for this View ---

class _ExchangeProgramCard extends StatelessWidget {
  final ExchangeProgramModel program;
  const _ExchangeProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(program.partnerSchool ?? 'N/A', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Chip(label: Text(program.programType ?? 'N/A')),
            const Divider(height: 24),
            _InfoRow(icon: Icons.access_time, title: 'Duration', value: program.duration),
            _InfoRow(icon: Icons.people_outline, title: 'Students Participated', value: program.studentsParticipated?.toString()),
            _InfoRow(icon: Icons.calendar_today_outlined, title: 'Active Since', value: program.activeSince?.toString()),
          ],
        ),
      ),
    );
  }
}

class _GlobalTieUpCard extends StatelessWidget {
  final GlobalTieUpModel tieUp;
  const _GlobalTieUpCard({required this.tieUp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tieUp.partnerName ?? 'N/A', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Chip(label: Text(tieUp.natureOfTieUp ?? 'N/A')),
            const Divider(height: 24),
            _InfoRow(icon: Icons.calendar_today_outlined, title: 'Active Since', value: tieUp.activeSince?.toString()),
            const SizedBox(height: 12),
            if(tieUp.description != null && tieUp.description!.isNotEmpty)
            Text(tieUp.description!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  const _InfoRow({required this.icon, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text('$title: ', style: const TextStyle(fontSize: 15)),
          Text(value ?? 'N/A', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}