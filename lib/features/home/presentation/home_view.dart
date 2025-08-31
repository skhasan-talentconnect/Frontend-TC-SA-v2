import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await getIt<AppStateProvider>().getUserDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar.home(),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Divider(),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SListTile.navigator(
                  path: RouteNames.splash,
                  label: 'Knocking Bird',
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: 3,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
