import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/features/compare/presentation/view_models/compare_view_model.dart';
import 'package:tc_sa/features/compare/presentation/widgets/compare_widgets.dart';

class CompareSchools extends StatefulWidget {
  const CompareSchools({
    required this.schoolId1,
    required this.schoolId2,
    super.key,
  });

  final String schoolId1;
  final String schoolId2;

  @override
  State<CompareSchools> createState() => _CompareSchoolsState();
}

class _CompareSchoolsState extends State<CompareSchools> {
  final CompareViewModel compareViewModel = CompareViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await compareViewModel.compareSchools(
        schoolId1: widget.schoolId1,
        schoolId2: widget.schoolId2,
      );
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: compareViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: SAppBar(
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
          title: 'School Comparison',
        ),

        body: Consumer<CompareViewModel>(
          builder: (vmContext, vm, _) {
            if (vm.isLoading) {
              return const Center(child: SLoadingIndicator());
            }

            if (vm.school1 == null && vm.school2 == null) {
              return const Center(
                child: Text("No comparison data. Please select schools again."),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompareSchoolsWidgets.headerBlock(),

                  CompareSchoolsWidgets.sectionTitle('Compare Schools'),
                  const SizedBox(height: 4),
                  CompareSchoolsWidgets.sectionSubtitle(
                    'Side-by-side comparison to find your best fit.',
                  ),
                  const SizedBox(height: 20),

                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CompareSchoolsWidgets.simpleCard(
                            CompareSchoolsWidgets.fmtStr(vm.school1?.name),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CompareSchoolsWidgets.simpleCard(
                            CompareSchoolsWidgets.fmtStr(vm.school2?.name),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  CompareSchoolsWidgets.dataRow('Board', [
                    CompareSchoolsWidgets.fmtStr(vm.school1?.board),
                    CompareSchoolsWidgets.fmtStr(vm.school2?.board),
                  ]),
                  CompareSchoolsWidgets.dataRow('Fee Range', [
                    CompareSchoolsWidgets.fmtStr(vm.school1?.feeRange),
                    CompareSchoolsWidgets.fmtStr(vm.school2?.feeRange),
                  ]),
                  CompareSchoolsWidgets.dataRow('School Mode', [
                    CompareSchoolsWidgets.fmtStr(vm.school1?.schoolMode),
                    CompareSchoolsWidgets.fmtStr(vm.school2?.schoolMode),
                  ]),
                  CompareSchoolsWidgets.dataRow('Shifts', [
                    CompareSchoolsWidgets.fmtJoin(vm.school1?.shifts),
                    CompareSchoolsWidgets.fmtJoin(vm.school2?.shifts),
                  ]),
                  CompareSchoolsWidgets.dataRow('Top Amenities', [
                    CompareSchoolsWidgets.fmtJoin(
                      vm.school1?.predefinedAmenities,
                    ),
                    CompareSchoolsWidgets.fmtJoin(
                      vm.school2?.predefinedAmenities,
                    ),
                  ]),
                  CompareSchoolsWidgets.dataRow('Activities', [
                    CompareSchoolsWidgets.fmtJoin(vm.school1?.activities),
                    CompareSchoolsWidgets.fmtJoin(vm.school2?.activities),
                  ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
