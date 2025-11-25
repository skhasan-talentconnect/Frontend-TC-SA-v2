import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/index.dart';

import '../../core/common/theme_provider.dart';
import '../../features/profile/presentation/widgets/profile_list_item.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        leading: SIcon(onTap: context.pop, icon: Icons.keyboard_arrow_left),
        title: 'Select Theme',
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView.separated(
          itemCount: 4,
          shrinkWrap: true,
          separatorBuilder: (_, _) => Divider(),
          itemBuilder: (_, index) {
            final theme = AppTheme.values[index];
            return ProfileListItem(
              label: theme.label.toCapitalise,
              onTap: () async {
                context.read<ThemeProvider>().setTheme(theme);
              },
            );
          },
        ),
      ),
    );
  }
}
