import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/core/services/secret_repo.dart';
import 'package:tc_sa/features/profile/presentation/view_models/profile_view_model.dart';

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

        body: Consumer<ProfileViewModel>(
          builder:
              (vmContext, vm, _) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
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
                            spacing: 8,
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 12,
                                children: [
                                  SText(
                                    icon: Icons.phone_outlined,
                                    iconSize: 20,
                                    title: vm.user?.contactNo ?? '-',
                                    titleTextStyles: STextStyles.s14W400,
                                  ),
                                  SText(
                                    icon: Icons.male,
                                    iconSize: 20,
                                    title: vm.user?.gender?.toCapitalise ?? '-',
                                    titleTextStyles: STextStyles.s14W400,
                                  ),
                                ],
                              ),
                              SText(
                                icon: Icons.location_on_outlined,
                                iconSize: 20,
                                title: vm.userLocation ?? '-',
                                titleTextStyles: STextStyles.s14W400,
                              ),
                              SText(
                                icon: Icons.calendar_month,
                                iconSize: 20,
                                title: vm.user?.dateOfBirth?.toDDMMYYYY ?? '-',
                                titleTextStyles: STextStyles.s14W400.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final route = vm.routes[index];
                        return route.path != null
                            ? SListTile.navigator(
                              path: route.path,
                              label: route.name,
                              isDense: true,
                            )
                            : SListTile(
                              label: route.name,
                              isDense: true,
                              noBorder: true,
                              onTap: () async {
                                if (route.name != "Logout") {
                                  Toasts.showInfoToast(
                                    context,
                                    message: 'Still in development',
                                  );
                                } else {
                                  await SecretRepo.remove('auth_token');
                                  getIt<AppStateProvider>().authModel = null;
                                  getIt<AppStateProvider>().user = null;
                                  getIt<AppStateProvider>().userPref = null;
                                  context.goNamed(RouteNames.loginRegister);
                                }
                              },
                            );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: vm.routes.length ?? 0,
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
