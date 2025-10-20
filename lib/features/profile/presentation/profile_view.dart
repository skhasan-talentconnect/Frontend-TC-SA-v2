import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/core/services/secret_repo.dart';
import 'package:tc_sa/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:tc_sa/features/profile/presentation/widgets/profile_list_item.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel profileViewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: profileViewModel,
      child: Scaffold(
        appBar: SAppBar(
          title: 'My Profile',
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              context.pop();
            },
          ),
          actions: [
            SIcon(
              icon: Icons.edit,
              size: 20,
              onTap: () {
                context.pushNamed(RouteNames.addEditProfile, extra: true);
              },
            ),
          ],
        ),

        backgroundColor: Color(0xffeeeeee),

        body: Consumer<ProfileViewModel>(
          builder:
              (vmContext, vm, _) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        spacing: 16,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: SColor.secTextColor),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 24,
                                color: SColor.secTextColor,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 6,
                            children: [
                              Text(
                                vm.user?.name ?? '-',
                                style: STextStyles.s16W600,
                              ),
                              SText(
                                icon: Icons.email_outlined,
                                iconSize: 20,
                                title: vm.user?.email ?? '-',
                                titleTextStyles: STextStyles.s14W400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(16),
                    //   child: Row(
                    //     spacing: 16,
                    //     children: [
                    //       Container(
                    //         height: 60,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: SColor.secTextColor),
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Center(
                    //           child: Icon(
                    //             Icons.person,
                    //             size: 24,
                    //             color: SColor.secTextColor,
                    //           ),
                    //         ),
                    //       ),
                    //       Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         spacing: 8,
                    //         children: [
                    //           Text(
                    //             vm.user?.name ?? '-',
                    //             style: STextStyles.s16W600,
                    //           ),
                    //           SText(
                    //             icon: Icons.email_outlined,
                    //             iconSize: 20,
                    //             title: vm.user?.email ?? '-',
                    //             titleTextStyles: STextStyles.s14W400,
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             spacing: 12,
                    //             children: [
                    //               SText(
                    //                 icon: Icons.phone_outlined,
                    //                 iconSize: 20,
                    //                 title: vm.user?.contactNo ?? '-',
                    //                 titleTextStyles: STextStyles.s14W400,
                    //               ),
                    //               SText(
                    //                 icon: Icons.male,
                    //                 iconSize: 20,
                    //                 title: vm.user?.gender?.toCapitalise ?? '-',
                    //                 titleTextStyles: STextStyles.s14W400,
                    //               ),
                    //             ],
                    //           ),
                    //           SText(
                    //             icon: Icons.location_on_outlined,
                    //             iconSize: 20,
                    //             title: vm.userLocation ?? '-',
                    //             titleTextStyles: STextStyles.s14W400,
                    //           ),
                    //           SText(
                    //             icon: Icons.calendar_month,
                    //             iconSize: 20,
                    //             title: vm.user?.dateOfBirth?.toDDMMYYYY ?? '-',
                    //             titleTextStyles: STextStyles.s14W400.copyWith(
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Divider(),
                    SizedBox(height: 12),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final route = vm.routes[index];
                          return route.path != null
                              ? ProfileListItem.navigator(
                                leading: route.icon,
                                path: route.path,
                                label: route.name,
                              )
                              : SizedBox.shrink();
                        },
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: 3,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        children: [
                          ProfileListItem(
                            label: vm.routes[3].name,
                            leading: vm.routes[3].icon,
                          ),
                          Divider(),
                          ProfileListItem(
                            label: vm.routes[4].name,
                            leading: vm.routes[4].icon,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        children: [
                          ProfileListItem(
                            label: vm.routes[5].name,
                            leading: vm.routes[5].icon,
                            onTap: () async {
                              await SecretRepo.remove('auth_token');
                              getIt<AppStateProvider>().authModel = null;
                              getIt<AppStateProvider>().user = null;
                              getIt<AppStateProvider>().userPref = null;
                              context.goNamed(RouteNames.landing);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
