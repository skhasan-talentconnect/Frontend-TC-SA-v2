import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/view_models/feeAndScholarship_view_model.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/widgets/scholarship_available.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/widgets/scholarship_card.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/view_models/otherDetails_view_model.dart';

class FeesAndScholarshipsView extends StatefulWidget {
  const FeesAndScholarshipsView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<FeesAndScholarshipsView> createState() =>
      _FeesAndScholarshipsViewState();
}

class _FeesAndScholarshipsViewState extends State<FeesAndScholarshipsView> {
  final FeesAndScholarshipsViewModel _feesVm = FeesAndScholarshipsViewModel();
  final OtherDetailsViewModel _otherVm = OtherDetailsViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        _feesVm.getFeesAndScholarshipsBySchoolId(schoolId: widget.schoolId),
        _otherVm.getOtherDetailsBySchoolId(schoolId: widget.schoolId),
      ]);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await Future.wait([
        _feesVm.getFeesAndScholarshipsBySchoolId(schoolId: widget.schoolId),
        _otherVm.getOtherDetailsBySchoolId(schoolId: widget.schoolId),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _feesVm),
        ChangeNotifierProvider.value(value: _otherVm),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer2<FeesAndScholarshipsViewModel, OtherDetailsViewModel>(
          builder: (context, feeVm, otherVm, _) {
            if (feeVm.viewState == ViewState.busy ||
                otherVm.viewState == ViewState.busy) {
              return const Center(
                child: SLoadingIndicator(color: Colors.yellow),
              );
            }

            final feeModel = feeVm.feesAndScholarships;
            final otherModel = otherVm.otherDetails;

            if (feeModel == null && otherModel == null) {
              return Center(
                child: Text(
                  "No data found.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey.shade600),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.yellow,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  /// 🟡 Fee Transparency
                  Text(
                    'Fee Details',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  (feeModel?.feesTransparency != null)
                      ? Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.yellow.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Fee Transparency Score',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${feeModel!.feesTransparency!.toStringAsFixed(0)}%',
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
                                    value: feeModel.feesTransparency! / 100,
                                    minHeight: 12,
                                    backgroundColor: Colors.yellow.shade100,
                                    color: Colors.yellow.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const Text('Fee Transparency data not available.'),

                  const SizedBox(height: 20),

                  /// 🟡 Fee Table
                  if (feeModel?.classFees.isNotEmpty ?? false)
Card(
  color: Colors.white,
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.yellow.shade200),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Table header
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade50,
              border: Border(
                bottom: BorderSide(color: Colors.yellow.shade200, width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Tuition',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Table body
          Column(
            children: feeModel!.classFees.map((fee) {
              final total = (fee.tuition ?? 0) +
                  (fee.activity ?? 0) +
                  (fee.transport ?? 0) +
                  (fee.misc ?? 0);
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.yellow.shade100, width: 1),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          fee.className ?? '-',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹${fee.tuition ?? 0}',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '₹$total',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  ),
),
               const SizedBox(height: 28),

                  /// 🟡 Scholarships & Concessions
                  Text(
                    'Scholarships & Concessions',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  if (feeModel?.scholarships.isEmpty ?? true)
                    const Text('No scholarships listed for this school.')
                  else
                    // ✅ FIXED: Removed outer Card to avoid double border/shadow
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: feeModel!.scholarships.length,
                      itemBuilder: (context, index) {
                        return ScholarshipCard(
                          scholarship: feeModel.scholarships[index],
                        );
                      },
                    ),

                  const SizedBox(height: 2),
 Text(
                    'Scholarship Diversity',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  /// 🟢 Scholarship Diversity
                  if (otherModel?.scholarshipDiversity != null)
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.yellow.shade200),
                      ),
                      elevation: 3,
                      child: ScholarshipDiversityCard(
                        diversityData: otherModel!.scholarshipDiversity!,
                      ),
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
