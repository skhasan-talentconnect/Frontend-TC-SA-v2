import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/predictor/presentation/view_models/predictor_view_model.dart';

class SchoolResultsPage extends StatefulWidget {
  const SchoolResultsPage({super.key});

  @override
  State<SchoolResultsPage> createState() => _SchoolResultPageState();
}

class _SchoolResultPageState extends State<SchoolResultsPage> {
  final PrefViewModel prefViewModel = PrefViewModel();
  late AppStateProvider appStateProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      appStateProvider = getIt();

      final failure = await prefViewModel.predictSchools(
        filters: {
          'board': appStateProvider.userPref?.boards,
          'schoolMode': appStateProvider.userPref?.schoolType,
          'genderType': appStateProvider.user?.gender,
        },
      );
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: prefViewModel,
      child: Scaffold(
        // appBar: SAppBar(
        //   title: 'Predicted Schools',
        //   leading: SIcon(
        //     icon: Icons.keyboard_arrow_left,
        //     onTap: () {
        //       context.pop();
        //     },
        //   ),
        // ),
        body: SafeArea(
          child: Consumer<PrefViewModel>(
            builder:
                (vmContext, vm, child) =>
                    vm.isLoading
                        ? Center(child: SLoadingIndicator())
                        : SingleChildScrollView(
                          // padding: const EdgeInsets.symmetric(
                          //   horizontal: 20,
                          //   vertical: 12,
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Predict Your Rank. Find Your School.",
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "School Predictor",
                                style: STextStyles.s28W800.copyWith(
                                  color: SColor.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Your personalized School recommendations based on your preferences.",
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Show results
                              if (vm.predictedSchools.isEmpty)
                                Center(
                                  child: Text(
                                    "No schools found matching your criteria",
                                    style: STextStyles.s16W400.copyWith(
                                      color: SColor.secTextColor,
                                    ),
                                  ),
                                )
                              else
                                // School cards list
                                ListView.separated(
                                  itemBuilder: (context, index) {
                                    final school = vm.predictedSchools[index];
                                    return SchoolCard(
                                      school: SchoolCardModel(
                                        schoolId: school.id,

                                        name: school.name ?? 'School Name',
                                        feeRange:
                                            school.feeRange ?? 'Not specified',
                                        location:
                                            '${school.city ?? ''}, ${school.state ?? ''}',
                                        board: school.board ?? 'Not specified',
                                        genderType:
                                            school.genderType ??
                                            'Not specified',
                                        shifts: school.shifts ?? [],
                                        schoolMode:
                                            school.schoolMode ??
                                            'Not specified',
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (context, index) =>
                                          const SizedBox(height: 16),
                                  itemCount: vm.predictedSchools.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),

                              const SizedBox(height: 28),

                              // Edit Preferences button
                              Center(
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.pushNamed(
                                        RouteNames.preferences,
                                        extra: true,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        "Edit Preferences",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
          ),
        ),
      ),
    );
  }
}
