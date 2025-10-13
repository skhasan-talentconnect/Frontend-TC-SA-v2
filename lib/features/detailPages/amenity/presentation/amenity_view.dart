// features/detailPages/amenity/presentation/amenity_view.dart
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
  // local VM (we’ll wrap with ChangeNotifierProvider.value)
  final AmenitiesViewModel _vm = AmenitiesViewModel();

  // parsed once
  String _schoolId = '';
  String _schoolName = 'School';
  bool _parsed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_parsed) return;
    _parsed = true;

    final state = GoRouterState.of(context);

    // Prefer extras (we usually push as: extra: {'schoolId': '...', 'schoolName': '...'})
    final extra = state.extra;
    if (extra is Map) {
      final id = (extra['schoolId'] ?? '').toString();
      final name = (extra['schoolName'] ?? '').toString();
      if (id.isNotEmpty) _schoolId = id;
      if (name.trim().isNotEmpty) _schoolName = name.trim();
    }

    // Optional fallbacks if you ever switch styles later:
    // path param: /amenity/:id[?name=...]
    if (_schoolId.isEmpty) {
      _schoolId = (state.pathParameters['id'] ?? '').toString();
    }
    // query: /amenity?id=...&name=...
    if (_schoolId.isEmpty) {
      _schoolId = (state.uri.queryParameters['id'] ?? '').toString();
    }
    final qpName = (state.uri.queryParameters['name'] ?? '').toString();
    if (qpName.trim().isNotEmpty) _schoolName = qpName.trim();

    // fire API if we have an id
    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getAmenitiesBySchoolId(schoolId: _schoolId);
      });
    } else {
      _vm.setViewState(ViewState.complete); // show friendly “missing context”
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

          final screenWidth = MediaQuery.of(context).size.width;
          final isSmallScreen = screenWidth < 600;

          // Static (predefined; keep as-is)
          final List<String> photos = [
            "https://example.com/photo1.jpg",
            "https://example.com/photo2.jpg",
          ];

          const String schoolInfo =
              "Sacred Heart Boys School provides excellent facilities and a supportive learning environment for students. Our campus features modern amenities, spacious classrooms, and dedicated staff who prioritize student development and well-being. We offer a comprehensive education with a focus on academic excellence, character building, and extracurricular activities.";

          // Merge predefined + custom (dedupe + sort)
          final List<String> amenityChips = (() {
            final pre = model?.predefinedAmenities ?? const <String>[];
            final cus = model?.customAmenities ?? const <String>[];
            final set = {...pre, ...cus};
            final list = set.toList()
              ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
            return list;
          })();

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
              title: "School Amenities",
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.blue,
              child: Builder(
                builder: (_) {
                  if (_schoolId.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Missing school context')),
                      ],
                    );
                  }

                  if (state == ViewState.busy) {
                    return const Center(child: SLoadingIndicator());
                  }

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photos (static for now)
                        if (photos.isNotEmpty)
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: photos.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return Image.network(
                                  photos[index],
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 300,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 300,
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 16),

                        // School Name
                        Text(
                          _schoolName,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                       
                        const SizedBox(height: 22),

                        // Amenities chips (predefined + custom)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue.shade50, Colors.white],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "School Amenities",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (amenityChips.isEmpty)
                                Text(
                                  vm.message ?? "No amenities found for this school.",
                                )
                              else
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: amenityChips
                                      .map(
                                        (a) => RecruiterChip(
                                          label: a,
                                          isSmallScreen: isSmallScreen,
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 22),

                        // School Information (static)
                        const Text(
                          "School Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          schoolInfo,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
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
