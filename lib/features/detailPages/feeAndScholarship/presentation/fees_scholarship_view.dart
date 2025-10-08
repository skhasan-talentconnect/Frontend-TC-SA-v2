import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/view_models/feeAndScholarship_view_model.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/widgets/scholarship_card.dart';

class FeesAndScholarshipsView extends StatefulWidget {
  const FeesAndScholarshipsView({super.key});

  @override
  State<FeesAndScholarshipsView> createState() => _FeesAndScholarshipsViewState();
}

class _FeesAndScholarshipsViewState extends State<FeesAndScholarshipsView> {
  final FeesAndScholarshipsViewModel _vm = FeesAndScholarshipsViewModel();
  String _schoolId = '';
  String _schoolName = 'Fees & Scholarships';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Fees & Scholarships';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getFeesAndScholarshipsBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getFeesAndScholarshipsBySchoolId(schoolId: _schoolId);
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
        body: Consumer<FeesAndScholarshipsViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.feesAndScholarships;

            if (model == null) {
              return Center(child: Text(vm.message ?? "No data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Fee Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // --- UPDATED WIDGET FOR FEE TRANSPARENCY ---
                  // This now handles the 'null' case with an 'else'
                  (model.feesTransparency != null)
                      ? Card(
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
                                    const Text('Fee Transparency Score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                    Text(
                                      '${model.feesTransparency!.toStringAsFixed(0)}%',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.teal),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: model.feesTransparency! / 100,
                                    minHeight: 12,
                                    backgroundColor: Colors.teal.shade100,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.grey.shade100,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Fee Transparency Score', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                Text('Not Available', style: TextStyle(fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  // --- END OF UPDATED WIDGET ---

                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.teal.shade50),
                        columns: const [
                          DataColumn(label: Text('Class', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Tuition', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                          DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                        ],
                        rows: model.classFees.map((fee) {
                          final total = (fee.tuition ?? 0) + (fee.activity ?? 0) + (fee.transport ?? 0) + (fee.misc ?? 0);
                          return DataRow(cells: [
                            DataCell(Text(fee.className ?? '-')),
                            DataCell(Text('₹${fee.tuition ?? 0}')),
                            DataCell(Text('₹$total', style: const TextStyle(fontWeight: FontWeight.bold))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 24),

                  Text(
                    'Scholarships & Concessions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (model.scholarships.isEmpty)
                    const Text('No scholarships listed for this school.')
                  else
                    Column(
                      children: model.scholarships.map((scholarship) {
                        return ScholarshipCard(scholarship: scholarship);
                      }).toList(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}