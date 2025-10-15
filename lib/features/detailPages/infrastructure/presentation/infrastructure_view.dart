import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

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
    // This ensures the logic runs only once
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;

    // Correctly parse the map you are passing
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Infrastructure';
    }

    if (_schoolId.isNotEmpty) {
      // Fetch data after the UI is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getInfrastructureBySchoolId(schoolId: _schoolId);
      });
    } else {
      // If no ID was passed, update the state to show an error message
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
        appBar: SAppBar(
          title: _schoolName, // Uses the name passed via 'extra'
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
        ),
        body: Consumer<InfrastructureViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            if (_schoolId.isEmpty) {
              return const Center(child: Text("School ID was not provided."));
            }

            final model = vm.infrastructure;

            if (model == null) {
              return Center(
                child: Text(vm.message ?? "No infrastructure data available."),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [

                  Center(
                    child: Text(
                      'Infrastructure',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(0, 1),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
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
                    chipColor: Colors.blue.shade100,
                    iconColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20),
                  ChipListCard(
                    title: 'Sports Grounds',
                    icon: Icons.sports_soccer_outlined,
                    items: model.sportsGrounds,
                    chipColor: Colors.green.shade100,
                    iconColor: Colors.green,
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
