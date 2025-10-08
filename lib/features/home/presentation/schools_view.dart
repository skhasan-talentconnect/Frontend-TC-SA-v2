

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/home/presentation/view_model/schools_view_model.dart';
import 'package:tc_sa/features/home/presentation/widgets/index.dart';

class SchoolsView extends StatefulWidget {
  const SchoolsView({super.key});

  @override
  State<SchoolsView> createState() => _SchoolsViewState();
}

class _SchoolsViewState extends State<SchoolsView> {
  SchoolViewModel schoolViewModel = SchoolViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await schoolViewModel.getStateSchools();
      failure?.showError(context);
      final failure2 = await schoolViewModel.getCitySchools();
      failure2?.showError(context);
      final failure3 = await schoolViewModel.getBoardsSchools();
      failure3?.showError(context);
      final failureNearby = await schoolViewModel.getNearbySchools();
      if (mounted) failureNearby?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: schoolViewModel,
      child: Scaffold(
        body: Selector<SchoolViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder:
              (_, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : RefreshIndicator(
                        color: SColor.primaryColor,
                        onRefresh: () async {
                          
                          final failure =
                              await schoolViewModel.getStateSchools();
                          if(mounted) failure?.showError(context);
                          final failure2 =
                              await schoolViewModel.getCitySchools();
                          failure2?.showError(context);
                          final failure3 =
                              await schoolViewModel.getBoardsSchools();
                          failure3?.showError(context);
                           final failure4 = 
                           await schoolViewModel.getNearbySchools();
                          failure4?.showError(context);
                        },
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            spacing: 16,
                            children: [
                              Selector<SchoolViewModel, List<SchoolCardModel>>(
                                selector: (_, vm) => vm.boardSchools,
                                builder:
                                    (vmContext, schools, _) =>
                                        SchoolListSection(
                                          title: 'Schools Based on Board',
                                          schools: schools,
                                        ),
                              ),
                              NavigatorCard(
                                title: 'Which colleges match your preferences?',
                                buttonText: 'Predict Now',
                                onPressed: () {
                                  context.pushNamed(RouteNames.services);
                                },
                              ),
                               Selector<SchoolViewModel, List<SchoolCardModel>>(
                          selector: (_, vm) => vm.nearbySchools,
                          builder: (vmContext, schools, _) =>
                              SchoolListSection(
                            title: 'Schools Near You',
                            schools: schools,
                          ),),
                              Selector<SchoolViewModel, List<SchoolCardModel>>(
                                selector: (_, vm) => vm.stateSchools,
                                builder:
                                    (vmContext, schools, _) =>
                                        SchoolListSection(
                                          title: 'Schools Based on State',
                                          schools: schools,
                                        ),
                              ),
                              NavigatorCard(
                                title: 'Want the latest insights on colleges?',
                                buttonText: 'Read Now',
                                onPressed: () {
                                  context.goNamed(RouteNames.blogs);
                                },
                              ),
                              Selector<SchoolViewModel, List<SchoolCardModel>>(
                                selector: (_, vm) => vm.citySchools,
                                builder:
                                    (vmContext, schools, _) =>
                                        SchoolListSection(
                                          title: 'Schools Based on City',
                                          schools: schools,
                                        ),
                              ),
                              NavigatorCard(
                                title:
                                    'Want colleges based on your references?',
                                buttonText: 'Edit Now',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
        ),
      ),
    );
  }
}