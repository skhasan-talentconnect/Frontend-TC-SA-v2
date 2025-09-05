import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
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
  Future<void> _refresh(BuildContext context) async {
    await context.read<AlumniViewModel>().getAlumniBySchool(
      schoolId: widget.schoolId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AlumniViewModel>();
    final state = vm.viewState;
    final model = vm.alumni;

    const String bannerFallback = "https://example.com/college.jpg";

    final displayName = model?.schoolName ?? widget.schoolName ?? "School";
    final location = [
      model?.schoolCity,
      model?.schoolState,
    ].where((e) => (e ?? '').isNotEmpty).join(", ");
    final displayAddress = location.isEmpty ? "—" : location;

    final famous = model?.famousAlumnies ?? const [];
    final top = model?.topAlumnis ?? const [];
    final others = model?.alumnis ?? const [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SAppBar(
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => Navigator.of(context).pop(),
        ),
        title: "School Alumni",
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Builder(
          builder: (_) {
            if (state == ViewState.busy) {
              return const Center(child: CircularProgressIndicator());
            }
            if (model == null) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(vm.message ?? "No alumni data found.")),
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
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Image.network(
                        bannerFallback,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.school, size: 50),
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
                                  color: Colors.blue,
                                  fontSize: 15,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.grey, thickness: 0.5),
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
                              backgroundGradient: const [
                                Color(0xFFE3F2FD), // blue-50/100
                                Color(0xFFFFFFFF),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Divider(color: Colors.grey, thickness: 0.5),
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
                              backgroundGradient: const [
                                Color(0xFFE8F5E9), // green-50/100
                                Color(0xFFFFFFFF),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Divider(color: Colors.grey, thickness: 0.5),
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
                              backgroundGradient: const [Color(0xFFF3E8FF), Color(0xFFFFFFFF)],
                            ),
                          ),
                        ],

                        if (famous.isEmpty && top.isEmpty && others.isEmpty)
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
      ),
    );
  }
}
