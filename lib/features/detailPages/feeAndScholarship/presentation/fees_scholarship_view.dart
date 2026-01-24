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
    final colors = context.watch<ThemeProvider>().colors;
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
              return Center(
                child: SLoadingIndicator(color: colors.primaryColor),
              );
            }

            final feeModel = feeVm.feesAndScholarships;
            final otherModel = otherVm.otherDetails;

            if (feeModel == null && otherModel == null) {
              return Center(
                child: Text(
                  "No data found.",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: colors.primaryColor,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  /// 🟡 Fee Transparency
                  Text(
                    'Fee Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  (feeModel?.feesTransparency != null)
                      ? Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: colors.borderColor),
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
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${feeModel!.feesTransparency!.toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: colors.amberColor,
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
                                  color: colors.topTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : const Text('Fee Transparency data not available.'),

                  const SizedBox(height: 20),

                  /// 🟡 Fee Table
                /// 🟡 Fee Table
if (feeModel?.classFees.isNotEmpty ?? false)
  SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 900, // 👈 ensures no column compression
      ),
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.borderColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 Table header
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade50,
                  border: Border(
                    bottom: BorderSide(
                      color: colors.borderColor,
                      width: 1,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 120, child: Text('Class', style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Tuition', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Activity', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Transport', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Hostel', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Misc', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 120, child: Text('Total', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              // 🔹 Table body
              ...feeModel!.classFees.map((fee) {
                final tuition = fee.tuition ?? 0;
                final activity = fee.activity ?? 0;
                final transport = fee.transport ?? 0;
                final hostel = fee.hostel ?? 0;
                final misc = fee.misc ?? 0;
                final total =
                    tuition + activity + transport + hostel + misc;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colors.boxShadowColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 120, child: Text(fee.className ?? '-', style: const TextStyle(fontSize: 14))),
                      SizedBox(width: 120, child: Text('₹$tuition', textAlign: TextAlign.right)),
                      SizedBox(width: 120, child: Text('₹$activity', textAlign: TextAlign.right)),
                      SizedBox(width: 120, child: Text('₹$transport', textAlign: TextAlign.right)),
                      SizedBox(width: 120, child: Text('₹$hostel', textAlign: TextAlign.right)),
                      SizedBox(width: 120, child: Text('₹$misc', textAlign: TextAlign.right)),
                      SizedBox(
                        width: 120,
                        child: Text(
                          '₹$total',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    ),
  ),

                  const SizedBox(height: 28),

                  /// 🟡 Scholarships & Concessions
                  Text(
                    'Scholarships & Concessions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// 🟢 Scholarship Diversity
                  if (otherModel?.scholarshipDiversity != null)
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: colors.borderColor),
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
