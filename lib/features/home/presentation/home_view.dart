import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/home/presentation/widgets/s_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.navigationShell, super.key});

  final Widget navigationShell;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final appStateProvider = getIt<AppStateProvider>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(appStateProvider.isGuest);
      print(appStateProvider.user?.toJson());
      if (!appStateProvider.isGuest) {
        final failure = await appStateProvider.getUserDetails();
        failure?.showError(context);
      }
    });
    super.initState();
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/blogs')) return 1;
    if (location.startsWith('/preferences')) return 2;
    if (location.startsWith('/shortlist')) return 3;
    if (location.startsWith('/my-forms')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);
    return Scaffold(
      key: _scaffoldKey,

      appBar: SAppBar.home(
        leading: SIcon(
          icon: Icons.menu,
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      drawer: SDrawer(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteNames.chatbot);
        },
        backgroundColor: Colors.orange.shade300,
        child: Icon(Icons.chat, color: Colors.black),
      ),

      body: Padding(
        padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 0),
        child: widget.navigationShell,
      ),

      bottomNavigationBar: SBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
              break;
            case 1:
              context.goNamed(RouteNames.blogs);
              break;
            case 2:
              context.goNamed(
                RouteNames.preferences,
                extra: appStateProvider.userPref != null,
              );
              break;
            case 3:
              if (appStateProvider.isGuest) {
                Toasts.showInfoToast(context, message: 'Please Login first');
              } else {
                context.goNamed(RouteNames.shortlist);
              }
              break;
            case 4:
              if (appStateProvider.isGuest) {
                Toasts.showInfoToast(context, message: 'Please Login first');
              } else {
                context.goNamed(RouteNames.myForms);
              }
              break;
          }
        },
      ),
    );
  }
}
