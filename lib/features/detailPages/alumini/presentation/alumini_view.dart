// features/detailPages/alumini/presentation/alumini_view.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
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

            const String bannerFallback = "https://example.com/college.jpg";

            final displayName =
                model?.schoolName ?? widget.schoolName ?? "School";
            final location = [
              model?.schoolCity,
              model?.schoolState,
            ].where((e) => (e ?? '').isNotEmpty).join(", ");
            final displayAddress = location.isEmpty ? "—" : location;

            final famous = model?.famousAlumnies ?? const [];
            final top = model?.topAlumnis ?? const [];
            final others = model?.alumnis ?? const [];
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              // --- 3. THEME UPDATE ---
              color: Colors.amber,
              child: Builder(
                builder: (_) {
                  if (vm.isLoading) {
                    return const Center(
                      child: SLoadingIndicator(color: Colors.amber),
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
                        // Banner
                        Container(
                          height: 150,
                          // --- 4. THEME UPDATE ---
                          color: Colors.amber.shade100,
                          child: Center(
                            child: Image.network(
                              bannerFallback,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  // --- 4. THEME UPDATE ---
                                  color: Colors.amber.shade50,
                                  child: Icon(
                                    Icons.school,
                                    size: 50,
                                    color: Colors.amber.shade800,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Info section
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on, size: 18),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      displayAddress,
                                      style: const TextStyle(
                                        // --- 5. THEME UPDATE (using a different color for links) ---
                                        color: Colors.blue,
                                        fontSize: 15,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const SizedBox(height: 22),

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
                                    backgroundGradient: const [
                                      Color(0xFFFFF8E1), // yellow-50
                                      Color(0xFFFFFFFF), // white
                                    ],
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
                                    backgroundGradient: const [
                                      Color(0xFFFFF3E0), // orange-50
                                      Color(0xFFFFFFFF),
                                    ],
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
                                    backgroundColor:
                                        Colors.white, // Plain white
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
