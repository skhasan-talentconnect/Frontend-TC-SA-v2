import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/widgets/s_app_bar.dart';
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/core/common/view_state_provider.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/view_models/amenity_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/recruiter_chip_widget.dart';


class AmenitiesView extends StatelessWidget {
  const AmenitiesView({
    super.key,
    required this.schoolId,
    required this.schoolName,
  });

  final String schoolId;
  final String schoolName;


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AmenitiesViewModel>();
    final state = vm.viewState;
    final model = vm.amenities;

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    // Static (predefined for now) — you said to keep this as-is
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
      final list = set.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      return list;
    })();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SAppBar(
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => Navigator.of(context).pop(),
        ),
        title: "School Amenities",
      ),
      body: Builder(
        builder: (_) {
          if (state == ViewState.busy) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
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
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Image.network(
                          photos[index],
                          fit: BoxFit.cover,
                          height: 200,
                          width: 300,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 300,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 16),

                // School Name (static)
            Text(
                  schoolName,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey, thickness: 0.5),
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
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      if (amenityChips.isEmpty)
                        Text(vm.message ?? "No amenities found for this school.")
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: amenityChips
                              .map((a) => RecruiterChip(label: a, isSmallScreen: isSmallScreen))
                              .toList(),
                        ),
                    ],
                  ),
                ),

                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 22),

                // School Information (static)
                const Text("School Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
    );
  }
}
