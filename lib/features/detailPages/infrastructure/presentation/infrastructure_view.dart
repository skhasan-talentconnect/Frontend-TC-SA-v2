import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/chip_list_card.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/detail_tile.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/view_models/infrastructure_view_model.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/special_needs_card.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/view_models/otherDetails_view_model.dart';

class InfrastructureView extends StatefulWidget {
  const InfrastructureView({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<InfrastructureView> createState() => _InfrastructureViewState();
}

class _InfrastructureViewState extends State<InfrastructureView> {
  final InfrastructureViewModel _infraVm = InfrastructureViewModel();
  final OtherDetailsViewModel _otherVm = OtherDetailsViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _infraVm.getInfrastructureBySchoolId(schoolId: widget.schoolId);
      _otherVm.getOtherDetailsBySchoolId(schoolId: widget.schoolId);
    });
  }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await Future.wait([
        _infraVm.getInfrastructureBySchoolId(schoolId: widget.schoolId),
        _otherVm.getOtherDetailsBySchoolId(schoolId: widget.schoolId),
      ]);
    }
  }

  @override
  void dispose() {
    _infraVm.dispose();
    _otherVm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
            final colors = context.watch<ThemeProvider>().colors;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _infraVm),
        ChangeNotifierProvider.value(value: _otherVm),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer2<InfrastructureViewModel, OtherDetailsViewModel>(
          builder: (context, infraVm, otherVm, _) {
            if (infraVm.viewState == ViewState.busy ||
                otherVm.viewState == ViewState.busy) {
              return  Center(
                  child: SLoadingIndicator(color: colors.amberColor));
            }

            final infraModel = infraVm.infrastructure;
            final otherModel = otherVm.otherDetails;

            if (widget.schoolId.isEmpty) {
              return const Center(child: Text("School ID was not provided."));
            }

            if (infraModel == null && otherModel == null) {
              return const Center(child: Text("No data available."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              color: colors.amberColor,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Center(
                    child: Text(
                      'Infrastructure',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // --- Infrastructure Facilities ---
                  if (infraModel != null)
                    TitledCard(
                      title: "Facilities",
                      icon: Icons.business_outlined,
                      iconColor: colors.amberDarkColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            DetailTile(
                              icon: Icons.menu_book_outlined,
                              title: 'Library Books',
                              value: infraModel.libraryBooks?.toString() ?? 'N/A',
                            ),
                            DetailTile(
                              icon: Icons.smart_screen_outlined,
                              title: 'Smart Classrooms',
                              value:
                                  infraModel.smartClassrooms?.toString() ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  if (infraModel?.labs != null)
                    ChipListCard(
                      title: 'Laboratories',
                      icon: Icons.science_outlined,
                      items: infraModel!.labs,
                      chipColor: colors.amberLightColor,
                      iconColor: colors.amberDarkColor,
                    ),

                  const SizedBox(height: 20),

                  if (infraModel?.sportsGrounds != null)
                    ChipListCard(
                      title: 'Sports Grounds',
                      icon: Icons.sports_soccer_outlined,
                      items: infraModel!.sportsGrounds,
                      chipColor: colors.amberLightColor,
                      iconColor: colors.amberDarkColor,
                    ),

                  const SizedBox(height: 20),

                  // --- Special Needs Section from OtherDetails Model ---
                  if (otherModel?.specialNeedsSupport != null)
                    SpecialNeedsCard(
                      supportData: otherModel!.specialNeedsSupport!,
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
