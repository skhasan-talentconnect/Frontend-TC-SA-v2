import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles;
import 'package:tc_sa/common/widgets/s_icon.dart';
import 'package:tc_sa/core/index.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar({
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
    super.key,
  }) : _isHome = false;

  const SAppBar.home({
    this.leading,
    this.title,
    this.backgroundColor,
    this.actions,
    super.key,
  }) : _isHome = true;

  final bool _isHome;
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      titleSpacing: leading != null ? 0 : 24,
      title: Text(
        _isHome ? 'RawRecruit' : title ?? '',
        style:
            _isHome
                ? STextStyles.s18W600.copyWith(color: SColor.secTextColor)
                : STextStyles.s14W600.copyWith(color: SColor.secTextColor),
      ),
      backgroundColor: backgroundColor ?? SColor.backgroundColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.2),
        child: Container(
          color: SColor.secTextColor.withOpacity(0.2),
          width: double.maxFinite,
          height: 0.2,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child:
              _isHome
                  ? Row(
                    spacing: 16,
                    children: [
                      SIcon.navigator(
                        path: RouteNames.search,
                        icon: Icons.search,
                      ),
                      SIcon.navigator(
                        path: RouteNames.notification,
                        icon: Icons.notifications,
                      ),
                      SIcon.navigator(
                        path: RouteNames.profile,
                        image: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: SColor.secTextColor,
                              width: 1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 20,
                              color: SColor.secTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        actions ??
                        [
                          if (getIt<AppStateProvider>().authModel == null) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: SColor.secTextColor,
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: STextStyles.s12W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                            ),
                          ],
                        ],
                  ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
