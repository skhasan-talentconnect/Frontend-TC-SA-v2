import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/models/photo.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/view_models/amenity_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/recruiter_chip_widget.dart';

class AmenitiesView extends StatefulWidget {
  const AmenitiesView({super.key, required this.schoolId, required this.photos});
  final String schoolId;
  final List<Photo> photos;

  @override
  State<AmenitiesView> createState() => _AmenitiesViewState();
}

class _AmenitiesViewState extends State<AmenitiesView> {
  final AmenitiesViewModel _vm = AmenitiesViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAmenitiesBySchoolId(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isEmpty) return;
    await _vm.getAmenitiesBySchoolId(schoolId: widget.schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Consumer<AmenitiesViewModel>(
        builder: (context, vm, _) {
          final state = vm.viewState;
          final model = vm.amenities;
          final isSmallScreen = MediaQuery.of(context).size.width < 600;

          const String schoolInfo =
              "Sacred Heart Boys School provides excellent facilities and a supportive learning environment for students. Our campus features modern amenities, spacious classrooms, and dedicated staff who prioritize student development and well-being. We offer a comprehensive education with a focus on academic excellence, character building, and extracurricular activities.";

          final List<String> amenityChips = {
            ...(model?.predefinedAmenities ?? <String>[]),
            ...(model?.customAmenities ?? <String>[]),
          }.toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

          return Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.amber,
              child: Builder(
                builder: (_) {
                  if (widget.schoolId.isEmpty) {
                    return const Center(child: Text('Missing school context'));
                  }

                  if (state == ViewState.busy) {
                    return const Center(child: SLoadingIndicator(color: Colors.amber));
                  }

                  if (model == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.layers_clear, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            vm.message ?? "No amenities found",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        _TitledCard(
                          title: "School Amenities",
                          icon: Icons.widgets_outlined,
                          iconColor: Colors.amber.shade700,
                          child: (amenityChips.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    vm.message ?? "No amenities found for this school.",
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: amenityChips
                                        .map((a) => RecruiterChip(
                                              label: a,
                                              isSmallScreen: isSmallScreen,
                                            ))
                                        .toList(),
                                  ),
                                ),
                        ),

                        const SizedBox(height: 24),

                        _TitledCard(
                          title: "School Information",
                          icon: Icons.info_outline,
                          iconColor: Colors.amber.shade700,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              schoolInfo,
                              style: TextStyle(fontSize: 16, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- LOCAL HELPER WIDGET ---
class _TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const _TitledCard({
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
