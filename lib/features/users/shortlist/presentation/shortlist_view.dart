import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';

class ShortlistedSchoolsPage extends StatefulWidget {
  const ShortlistedSchoolsPage({super.key});

  @override
  State<ShortlistedSchoolsPage> createState() =>
      _ShortlistedCollegesPageState();
}

class _ShortlistedCollegesPageState extends State<ShortlistedSchoolsPage> {
  ShortlistViewModel shortlistViewModel = ShortlistViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await shortlistViewModel.getShortlist();
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    shortlistViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: shortlistViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<ShortlistViewModel>(
            builder:
                (vmContext, vm, _) =>
                    vm.isLoading
                        ? Center(child: SLoadingIndicator())
                        : RefreshIndicator(
                          onRefresh: () async {
                            final failure =
                                await shortlistViewModel.getShortlist();
                            failure?.showError(context);
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  "Shortlisted Colleges (${shortlistViewModel.schools.length})",
                                  style: STextStyles.s26W600.copyWith(
                                    color: SColor.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Explore the colleges you've saved for future reference.",
                                  style: STextStyles.s15W400.copyWith(
                                    color: SColor.primaryColor,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 12),

                                vm.schools.isNotEmpty
                                    ? ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      separatorBuilder:
                                          (_, index) =>
                                              const SizedBox(height: 16),
                                      itemBuilder: (context, index) {
                                        return SchoolCard(
                                          school: vm.schools[index],
                                        );
                                      },
                                      itemCount: vm.schools.length,
                                      shrinkWrap: true,
                                    )
                                    : _buildEmptyState(),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        Icon(Icons.bookmark_border, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          "No Colleges Shortlisted",
          style: STextStyles.s18W400.copyWith(color: SColor.secTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Start exploring colleges and save your favorites to see them here.",
          textAlign: TextAlign.center,
          style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
        ),
      ],
    );
  }
}
