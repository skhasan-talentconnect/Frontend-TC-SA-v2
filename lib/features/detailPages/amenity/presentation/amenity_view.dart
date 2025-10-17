import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/common/widgets/s_loading_indicator.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';

import 'package:tc_sa/features/detailPages/amenity/presentation/view_models/amenity_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/recruiter_chip_widget.dart';

class AmenitiesView extends StatefulWidget {
  const AmenitiesView({super.key});

  @override
  State<AmenitiesView> createState() => _AmenitiesViewState();
}

class _AmenitiesViewState extends State<AmenitiesView> {
  final AmenitiesViewModel _vm = AmenitiesViewModel();
  String _schoolId = '';
  String _schoolName = 'School';
  bool _parsed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_parsed) return;
    _parsed = true;

    final state = GoRouterState.of(context);
    final extra = state.extra;
    
    if (extra is Map) {
      final id = (extra['schoolId'] ?? '').toString();
      final name = (extra['schoolName'] ?? '').toString();
      if (id.isNotEmpty) _schoolId = id;
      if (name.trim().isNotEmpty) _schoolName = name.trim();
    } else if (extra is String && extra.trim().isNotEmpty) {
      _schoolId = extra.trim();
      _schoolName = 'Amenities';
    }

    if (_schoolId.isEmpty) {
      _schoolId = (state.pathParameters['id'] ?? '').toString();
    }
    if (_schoolId.isEmpty) {
      _schoolId = (state.uri.queryParameters['id'] ?? '').toString();
    }
    
    if (_schoolName == 'School' || _schoolName == 'Amenities') {
       final qpName = (state.uri.queryParameters['name'] ?? '').toString();
       if (qpName.trim().isNotEmpty) _schoolName = qpName.trim();
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getAmenitiesBySchoolId(schoolId: _schoolId);
      });
    } else {
      _vm.setViewState(ViewState.complete);
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isEmpty) return;
    await _vm.getAmenitiesBySchoolId(schoolId: _schoolId);
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
      child: Consumer<AmenitiesViewModel>(
        builder: (context, vm, _) {
          final state = vm.viewState;
          final model = vm.amenities;
          final isSmallScreen = MediaQuery.of(context).size.width < 600;

          final List<String> photos = [
            "https://example.com/photo1.jpg",
            "https://example.com/photo2.jpg",
          ];
          const String schoolInfo =
              "Sacred Heart Boys School provides excellent facilities and a supportive learning environment for students. Our campus features modern amenities, spacious classrooms, and dedicated staff who prioritize student development and well-being. We offer a comprehensive education with a focus on academic excellence, character building, and extracurricular activities.";

          final List<String> amenityChips = {
            ...(model?.predefinedAmenities ?? <String>[]),
            ...(model?.customAmenities ?? <String>[]),
          }.toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
              title: _schoolName, // Use the dynamic school name
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              // --- THEME UPDATE ---
              color: Colors.amber,
              child: Builder(
                builder: (_) {
                  if (_schoolId.isEmpty) {
                    return const Center(child: Text('Missing school context'));
                  }

                  if (state == ViewState.busy) {
                    return const Center(child: SLoadingIndicator(color: Colors.amber));
                  }
                  
                  if (model == null) {
                    // --- UI POLISH: More modern 'Not Found' message ---
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.layers_clear, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            vm.message ?? "No amenities found",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
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
                        if (photos.isNotEmpty)
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: photos.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    photos[index],
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 300,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 300,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        
                        const SizedBox(height: 24),

                        _TitledCard(
                          title: "School Amenities",
                          icon: Icons.widgets_outlined,
                          // --- THEME UPDATE ---
                          iconColor: Colors.amber.shade700,
                          child: (amenityChips.isEmpty)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(vm.message ?? "No amenities found for this school."),
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
                          iconColor: Colors.blueGrey,
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // --- THEME UPDATE ---
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.1),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          
            child,
          ],
        ),
      ),
    );
  }
}