// features/detailPages/alumini/presentation/alumini_view.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/theme_provider.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/view_models/alumini_view_model.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/widgets/alumni_item_widget.dart';

class AlumniView extends StatefulWidget {
  const AlumniView({super.key, required this.schoolId, this.schoolName});

  final String schoolId;
  final String? schoolName;

  @override
  State<AlumniView> createState() => _AlumniViewState();
}

class _AlumniViewState extends State<AlumniView> {
  AlumniViewModel vm = AlumniViewModel();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.getAlumniBySchool(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh(BuildContext context) async {
    await context.read<AlumniViewModel>().getAlumniBySchool(
      schoolId: widget.schoolId,
    );
  }

  @override
  Widget build(BuildContext context) {
     final colors = context.watch<ThemeProvider>().colors;
    return ChangeNotifierProvider.value(
      value: vm,
      child: Scaffold(
        // --- 1. THEME UPDATE ---
        backgroundColor: Colors.white,
        // appBar: SAppBar(
        //   leading: SIcon(
        //     icon: Icons.keyboard_arrow_left,
        //     // --- 2. NAVIGATION FIX ---
        //     onTap: () => context.pop(),
        //   ),
        //   title: "School Alumni",
        // ),
        body: Consumer<AlumniViewModel>(
          builder: (vmContext, vm, _) {
            if(vm.isLoading) return Center(child: SLoadingIndicator(),);
   
            final model = vm.alumni;


          
            final famous = model?.famousAlumnies ?? const [];
            final top = model?.topAlumnis ?? const [];
            final others = model?.alumnis ?? const [];
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              // --- 3. THEME UPDATE ---
              color: colors.amberColor,
              child: Builder(
                builder: (_) {
                  if (vm.isLoading) {
                    return  Center(
                      child: SLoadingIndicator(color: colors.amberColor),
                    );
                  }
                  if (model == null) {
                    return ListView(
                      children: [
                        const SizedBox(height: 120),
                        Center(
                          child: Text(vm.message ?? "No alumni data found."),
                        ),
                      ],
                    );
                  }

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                     
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              const SizedBox(height: 10),

                              // Famous Alumni
                              if (famous.isNotEmpty) ...[
                                const Text(
                                  "Famous Alumni",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...famous.map(
                                  (fa) => AlumniItemWidget(
                                    name: fa.name ?? "-",
                                    profession: fa.profession,
                                    // --- 6. THEME UPDATE ---
                                  
                                  ),
                                ),
                                const SizedBox(height: 22),
                              ],

                              // Top Alumni
                              if (top.isNotEmpty) ...[
                                const Text(
                                  "Top Alumni",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...top.map(
                                  (ta) => AlumniItemWidget(
                                    name: ta.name ?? "-",
                                    percentage:
                                        ta.percentage == null
                                            ? null
                                            : "${ta.percentage!.toStringAsFixed(1)}%",
                                    // --- 6. THEME UPDATE ---
                                   
                                  ),
                                ),
                                const SizedBox(height: 22),
                              ],

                              // Other Alumni
                              if (others.isNotEmpty) ...[
                                const Text(
                                  "Other Alumni",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...others.map(
                                  (al) => AlumniItemWidget(
                                    name: al.name ?? "-",
                                    percentage:
                                        al.percentage == null
                                            ? null
                                            : "${al.percentage!.toStringAsFixed(1)}%",
                                    // --- 6. THEME UPDATE ---
                                   
                                  ),
                                ),
                              ],

                              if (famous.isEmpty &&
                                  top.isEmpty &&
                                  others.isEmpty)
                                const Center(
                                  child: Text("No alumni items to display."),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
