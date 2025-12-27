import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Add this import
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/common/shortlist_notification_provider.dart'; // 2. Import your provider
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // This part is for fetching data, which is correct in initState
      final failure = await shortlistViewModel.getShortlist();
      if (mounted) failure?.showError(context);
    });
  }

  @override
  void dispose() {
    shortlistViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. Add the clearing logic here, inside the build method
    // This runs every time the page becomes visible. The callback ensures it's safe.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShortlistNotificationProvider>(context, listen: false)
          .clearNotification();
    });

    return ChangeNotifierProvider.value(
      value: shortlistViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<ShortlistViewModel>(
            builder: (vmContext, vm, _) => vm.isLoading
                ? Center(child: SLoadingIndicator())
                : RefreshIndicator(
                    onRefresh: () async {
                      final failure = await shortlistViewModel.getShortlist();
                      if (mounted) failure?.showError(context);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            "Shortlisted Schools (${vm.schools.length})", // Use vm.schools here
                            style: STextStyles.s26W600.copyWith(
                              color: SColor.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Explore the Schools you've saved for future reference.",
                            style: STextStyles.s15W400.copyWith(
                              color: SColor.primaryColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 12),
                          vm.schools.isNotEmpty
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (_, index) =>
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
          "No Schools Shortlisted",
          style: STextStyles.s18W400.copyWith(color: SColor.secTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Start exploring Schools and save your favorites to see them here.",
          textAlign: TextAlign.center,
          style: STextStyles.s14W400.copyWith(color: SColor.secTextColor),
        ),
      ],
    );
  }
}
