import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'
    show SchoolCard, SAppBar, SIcon, SLoadingIndicator;
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';
import 'package:tc_sa/features/search/presentation/view_models/search_result_view_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({required this.searchQuery, super.key});
  final SearchQuery searchQuery;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  SearchResultViewModel searchResultViewModel = SearchResultViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await searchResultViewModel.searchSchools(
        query: widget.searchQuery,
        notify: true,
      );
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: searchResultViewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: SAppBar(
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => Navigator.of(context).pop(),
          ),
          title: "Result Schools",
        ),
        body: Consumer<SearchResultViewModel>(
          builder:
              (vmContext, vm, _) =>
                  vm.isLoading
                      ? Center(child: SLoadingIndicator())
                      : Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                          top: 16,
                          bottom: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // School cards list
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final school = vm.schools[index];
                                  return VisibilityDetector(
                                    key: Key(
                                      school.schoolId ?? UniqueKey().toString(),
                                    ),
                                    onVisibilityChanged: (info) {
                                      var visibilityPercentage =
                                          info.visibleFraction;
                                      bool lastIndex =
                                          (index == vm.schools.length - 1);

                                      if (lastIndex &&
                                          visibilityPercentage == 1) {
                                        bool shouldMakeAPICall =
                                            vm.isMoreSchoolsAvailable;
                                        if (!shouldMakeAPICall) {
                                          vm.searchSchools(
                                            query: widget.searchQuery,
                                          );
                                        }
                                      }
                                    },
                                    child: SchoolCard(
                                      school: vm.schools[index],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (_, index) => const SizedBox(height: 16),
                                itemCount: vm.schools.length,
                                shrinkWrap: true,
                              ),
                            ),
                            if (vm.isLoadingSchools)
                              Center(child: SLoadingIndicator()),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
        ),
      ),
    );
  }
}
