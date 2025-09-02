import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/home/presentation/widgets/s_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await getIt<AppStateProvider>().getUserDetails();
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

      body: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 8, bottom: 0),
        child: widget.navigationShell,
      ),

      bottomNavigationBar: SBottomBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
              break;
            case 1:
              context.goNamed(RouteNames.blogs);
              break;
            case 2:
              context.goNamed(RouteNames.services);
              break;
            case 3:
              context.goNamed(RouteNames.shortlist);
              break;
          }
        },
      ),
    );
  }
}
