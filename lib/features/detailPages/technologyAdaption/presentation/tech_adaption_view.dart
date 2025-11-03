
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/presentation/view_models/techAdaption_view_model.dart';


class TechnologyAdoptionView extends StatefulWidget {
  const TechnologyAdoptionView({super.key,required this.schoolId});
final String schoolId;
  @override
  State<TechnologyAdoptionView> createState() => _TechnologyAdoptionViewState();
}

class _TechnologyAdoptionViewState extends State<TechnologyAdoptionView> {
  final TechnologyAdoptionViewModel _vm = TechnologyAdoptionViewModel();
  // String _schoolId = '';
  // String _schoolName = 'Technology Adoption';
  // bool _isInitialized = false;


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInitialized) return;
  //   _isInitialized = true;

  //   final extra = GoRouterState.of(context).extra;
  //   if (extra is Map) {
  //     _schoolId = extra['schoolId'] as String? ?? '';
  //     _schoolName = extra['schoolName'] as String? ?? 'Technology Adoption';
  //   }

  //   if (_schoolId.isNotEmpty) {
     
  //   }
  // }

    @override
    void initState(){
    super.initState();
 WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getTechnologyAdoptionBySchoolId(schoolId: widget.schoolId);
      });
    }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getTechnologyAdoptionBySchoolId(schoolId: widget.schoolId);
    }
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
      child: Scaffold(
        // --- 1. THEME UPDATE ---
        backgroundColor: Colors.white,
        // appBar: SAppBar(
        //   title: _schoolName,
        //   leading: SIcon(
        //     icon: Icons.keyboard_arrow_left,
        //     onTap: () => context.pop(),
        //   ),
        // ),
        body: Consumer<TechnologyAdoptionViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              // --- 2. THEME UPDATE ---
              return const Center(child: SLoadingIndicator(color: Colors.amber));
            }

            final model = vm.techAdoption;

            if (model == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.computer_outlined, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      vm.message ?? "No technology data found.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                )
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              // --- 3. THEME UPDATE ---
              color: Colors.amber,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildPercentageCard(context, model.smartClassroomsPercentage),
                  const SizedBox(height: 20),
                  _buildChipListCard(context, model.eLearningPlatforms),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPercentageCard(BuildContext context, double? percentage) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Colors.amber)),
      // --- 4. THEME UPDATE ---
      color: Colors.white,
      shadowColor: Colors.amber.shade400.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Smart Classrooms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                if (percentage != null)
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // --- 5. THEME UPDATE ---
                      color: Colors.amber.shade800
                    ),
                  )
                else
                  const Text('N/A', style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            if (percentage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 12,
                  // --- 6. THEME UPDATE ---
                  backgroundColor: Colors.amber.shade100,
                  color: Colors.amber.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChipListCard(BuildContext context, List<String> platforms) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Colors.amber)),
      // --- 7. THEME UPDATE ---
      color: Colors.white,
      shadowColor: Colors.amber.shade400.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // --- 8. THEME UPDATE ---
                Icon(Icons.cast_for_education, color: Colors.amber.shade800, size: 28),
                const SizedBox(width: 10),
                Text('E-learning Platforms', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          
            if (platforms.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No platforms listed.'),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: platforms.map((platform) => Chip(
                    label: Text(platform),
                    // --- 9. THEME UPDATE ---
                    backgroundColor: Colors.amber.withOpacity(0.1),
                    side: BorderSide(color: Colors.amber.withOpacity(0.3)),
                    labelStyle: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.w500),
                  )).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}