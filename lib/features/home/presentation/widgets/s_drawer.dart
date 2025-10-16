import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

class SDrawer extends StatefulWidget {
  const SDrawer({super.key});

  @override
  State<SDrawer> createState() => _SDrawerState();
}

class _SDrawerState extends State<SDrawer> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: SColor.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://s3.us-east-1.amazonaws.com/cdn.designcrowd.com/blog/25-famous-app-logos-to-keep-you-amused/Snapchat.png',
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'SmartSchoolFinder',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  children: [
                    SListTile(
                      leading: Icon(Icons.home),
                      label: 'Home',
                      onTap: () {
                        navigateTo(RouteNames.home);
                      },
                    ),
                    SListTile(
                      leading: Icon(Icons.insights),
                      label: 'Insights',
                      onTap: () {
                        navigateTo(RouteNames.blogs);
                      },
                    ),
                    SListTile(
                      leading: Icon(Icons.bookmark),
                      label: 'Shortlisted',
                      trailing: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: SColor.primaryColor,
                        ),
                        child: Text(
                          '${getIt<AppStateProvider>().shortlistSchools.length}',
                          style: STextStyles.s12W600.copyWith(
                            color: SColor.textColor,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (getIt<AppStateProvider>().isGuest) {
                          Toasts.showInfoToast(context, message: 'Please Login');
                        } else {
                          navigateTo(RouteNames.shortlist);
                        }
                      },
                    ),
                    SListTile(
                      leading: Icon(Icons.support_agent),
                      label: 'Support',
                      onTap: () {
                        navigateTo(RouteNames.blogs);
                      },
                    ),
                    SListTile(
                      leading: Icon(Icons.settings),
                      label: 'Settings',
                      onTap: () {
                        navigateTo(RouteNames.blogs);
                      },
                    ),
                  ],
                ),
              ),
              SListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: SColor.secTextColor),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 22,
                      color: SColor.secTextColor,
                    ),
                  ),
                ),
                title: Text(
                  getIt<AppStateProvider>().user?.name ?? 'Please Login',
                ),
                subtitle: Text(
                  getIt<AppStateProvider>().userEmail.isEmpty
                      ? 'Login to explore more features'
                      : getIt<AppStateProvider>().userEmail,
                  overflow: TextOverflow.ellipsis,
                ),
                border: Border(
                  top: BorderSide(color: SColor.secTextColor, width: 0.25),
                  bottom: BorderSide(color: SColor.secTextColor, width: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(String path) {
    context.goNamed(path);
    context.pop();
  }
}
