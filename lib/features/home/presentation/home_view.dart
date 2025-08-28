import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
