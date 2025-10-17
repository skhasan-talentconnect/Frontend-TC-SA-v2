import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';

import 'view_models/infrastructure_view_model.dart';
import 'widgets/chip_list_card.dart';
import 'widgets/detail_tile.dart';


class InfrastructureView extends StatefulWidget {
  const InfrastructureView({super.key});

  @override
  State<InfrastructureView> createState() => _InfrastructureViewState();
}

class _InfrastructureViewState extends State<InfrastructureView> {
  final InfrastructureViewModel _vm = InfrastructureViewModel();
  String _schoolId = '';
  String _schoolName = 'Infrastructure'; // Default title
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Infrastructure';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getInfrastructureBySchoolId(schoolId: _schoolId);
      });
    } else {
      _vm.setViewState(ViewState.complete);
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getInfrastructureBySchoolId(schoolId: _schoolId);
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
        backgroundColor: Colors.white, // Set background to white
        appBar: SAppBar(
          title: _schoolName,
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
        ),
        body: Consumer<InfrastructureViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator(color: Colors.amber));
            }
            if (_schoolId.isEmpty) {
              return const Center(child: Text("School ID was not provided."));
            }
            final model = vm.infrastructure;
            if (model == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.layers_clear, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      vm.message ?? "No infrastructure data available.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                )
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: Colors.amber, // Set refresh color
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Center(
                    child: Text(
                      'Infrastructure',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Use the new TitledCard for a consistent look
                  TitledCard(
                    title: "Facilities",
                    icon: Icons.business_outlined,
                    iconColor: Colors.amber.shade700,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          DetailTile(
                            icon: Icons.menu_book_outlined,
                            title: 'Library Books',
                            value: model.libraryBooks?.toString() ?? 'N/A',
                          ),
                  
                          DetailTile(
                            icon: Icons.smart_screen_outlined,
                            title: 'Smart Classrooms',
                            value: model.smartClassrooms?.toString() ?? 'N/A',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ChipListCard(
                    title: 'Laboratories',
                    icon: Icons.science_outlined,
                    items: model.labs,
                    chipColor: Colors.amber.shade100, // Updated color
                    iconColor: Colors.amber.shade800, // Updated color
                  ),
                  const SizedBox(height: 20),
                  ChipListCard(
                    title: 'Sports Grounds',
                    icon: Icons.sports_soccer_outlined,
                    items: model.sportsGrounds,
                      chipColor: Colors.amber.shade100, // Updated color
                    iconColor: Colors.amber.shade800, // Kept green for sports
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