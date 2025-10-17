import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      titleSpacing: leading != null ? -10 : 24,
      title: Text(
        _isHome ? 'Synzy' : title ?? '',
        style:
            _isHome
                ? STextStyles.s18W600.copyWith(color: SColor.secTextColor)
                : STextStyles.s14W600.copyWith(color: SColor.secTextColor),
      ),
      backgroundColor: backgroundColor ?? SColor.backgroundColor,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.25),
        child: Container(
          color: SColor.secTextColor.withOpacity(0.25),
          width: double.maxFinite,
          height: 0.25,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child:
              _isHome
                  ? getIt<AppStateProvider>().isGuest
                      ? GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteNames.loginRegister);
                        },
                        child: Container(
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
                      )
                      : Row(
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
                          if (getIt<AppStateProvider>().isGuest) ...[
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
