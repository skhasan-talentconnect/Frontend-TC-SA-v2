import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/data/entities/international-model.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/presentation/view_models/international_view_model.dart';

class InternationalExposureView extends StatefulWidget {
  const InternationalExposureView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<InternationalExposureView> createState() => _InternationalExposureViewState();
}

class _InternationalExposureViewState extends State<InternationalExposureView> {
  final InternationalExposureViewModel _vm = InternationalExposureViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getInternationalExposureBySchoolId(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getInternationalExposureBySchoolId(schoolId: widget.schoolId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<InternationalExposureViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator(color: Colors.amber));
            }

            final model = vm.exposure;
            final exchangePrograms = model?.exchangePrograms ?? [];
            final globalTieUps = model?.globalTieUps ?? [];
            final bool hasData = exchangePrograms.isNotEmpty || globalTieUps.isNotEmpty;

            if (!hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.public_off_outlined, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      vm.message ?? "No international exposure data found.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.amber,
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: (exchangePrograms.isNotEmpty ? 1 : 0) +
                    exchangePrograms.length +
                    (globalTieUps.isNotEmpty ? 1 : 0) +
                    globalTieUps.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  if (exchangePrograms.isNotEmpty) {
                    if (index == 0) {
                      return Text(
                        'Exchange Programs',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      );
                    }
                    if (index <= exchangePrograms.length) {
                      return _ExchangeProgramCard(program: exchangePrograms[index - 1]);
                    }
                  }

                  int tieUpStartIndex =
                      exchangePrograms.isNotEmpty ? exchangePrograms.length + 1 : 0;

                  if (index == tieUpStartIndex) {
                    return Text(
                      'Global Tie-ups',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    );
                  }

                  int tieUpIndex = index - tieUpStartIndex - 1;
                  return _GlobalTieUpCard(tieUp: globalTieUps[tieUpIndex]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ExchangeProgramCard extends StatelessWidget {
  final ExchangeProgramModel program;
  const _ExchangeProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.grey,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            program.partnerSchool ?? 'N/A',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (program.programType != null)
            Chip(
              label: Text(program.programType!),
              backgroundColor: Colors.amber.shade50,
              side: BorderSide(color: Colors.amber.shade200),
              labelStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.w500),
            ),
          const SizedBox(height: 5),
          _InfoRow(icon: Icons.access_time, title: 'Duration', value: program.duration),
          _InfoRow(
              icon: Icons.people_outline,
              title: 'Students',
              value: program.studentsParticipated?.toString()),
          _InfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Active Since',
              value: program.activeSince?.toString()),
        ],
      ),
    );
  }
}

class _GlobalTieUpCard extends StatelessWidget {
  final GlobalTieUpModel tieUp;
  const _GlobalTieUpCard({required this.tieUp});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 3),
            color: Colors.grey,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tieUp.partnerName ?? 'N/A',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (tieUp.natureOfTieUp != null)
            Chip(
              label: Text(tieUp.natureOfTieUp!),
              backgroundColor: Colors.orange.shade50,
              side: BorderSide(color: Colors.orange.shade200),
              labelStyle: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
            ),
          const SizedBox(height: 10),
          _InfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Active Since',
              value: tieUp.activeSince?.toString()),
          const SizedBox(height: 12),
          if (tieUp.description != null && tieUp.description!.isNotEmpty)
            Text(
              tieUp.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey.shade700, height: 1.4),
            ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.amber.shade800),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
