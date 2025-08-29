// search_page.dart
import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/features/search/presentation/view_models/search_view_model.dart';
import 'package:tc_sa/features/search/presentation/widgets/search_widgets.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SelectionController controller = SelectionController();
  final searchCtrl = TextEditingController();

  // States
  final List<String> states = [
    'Maharashtra',
    'Karnataka',
    'Delhi',
    'Kerala',
    'Gujarat',
    'Tamil Nadu'
  ];

  final List<String> streams = [
    'Engineering',
    'Management',
    'Arts',
    'Science',
    'Law',
    'Medical',
    'Design',
    'Humanities',
  ];

  // Mapping of states to their cities
  final Map<String, List<String>> stateCities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Navi Mumbai', "Nagpur"],
    'Karnataka': ['Mangaluru', "Kalaburagi", 'Bangalore', 'Udupi'],
    'Delhi': ['Jamia Nagar', 'Dwarka', 'Rohini', 'New Delhi'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kottayam', 'Palakkad'],
    'Gujarat': ['Surat', 'Ahmedabad', 'Gandhinagar', 'Anand'],
    'Tamil Nadu': ['Chennai', 'Vellore', 'Tiruchirappalli', 'Krishnankoil']
  };

  @override
  void initState() {
    super.initState();
    controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChange);
    controller.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filterSelectedColor = SColor.primaryColor;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: [
            SearchTextField(
              controller: searchCtrl,
              cursorColor: filterSelectedColor,
              onSearchPressed: () {
                // Search functionality would go here
              },
            ),

            SearchStreamSection(
              title: "Search by Streams",
              items: streams,
              selectedItems: controller.selectedStreams,
              onTap: controller.toggleStream,
              selectedColor: filterSelectedColor,
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: SearchGridSection(
                title: "Search by States",
                items: states,
                selectedItems: controller.selectedStates,
                onTap: controller.toggleStates,
                selectedColor: filterSelectedColor,
                isGreyBox: true,
              ),
            ),
            const SizedBox(height: 24),

            // Display cities only after a state is selected
            if (controller.selectedStates.isNotEmpty) 
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SearchGridSection(
                  title: "Search by Cities",
                  items: _getCitiesForSelectedStates(),
                  selectedItems: controller.selectedCities,
                  onTap: controller.toggleCities,
                  selectedColor: filterSelectedColor,
                  isGreyBox: true,
                ),
              ),
            if (controller.selectedStates.isNotEmpty) const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<String> _getCitiesForSelectedStates() {
    final cities = <String>[];
    for (String state in controller.selectedStates) {
      if (stateCities.containsKey(state)) {
        cities.addAll(stateCities[state]!);
      }
    }
    return cities.toSet().toList();
  }
}