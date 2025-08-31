import 'package:go_router/go_router.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';
import 'package:tc_sa/features/home/index.dart';
import 'package:tc_sa/features/profile/presentation/add_edit_profile_view.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => HomeView(),
      ),
      // ShellRoute(
      //   routes: [
      //     GoRoute(path: '/home', name: RouteNames.home),
      //     GoRoute(path: '/blogs', name: RouteNames.blogs),
      //     GoRoute(path: '/services', name: RouteNames.services),
      //     GoRoute(path: '/shortlist', name: RouteNames.shortlist),
      //   ],
      // ),
      GoRoute(
        path: '/login-register',
        name: RouteNames.loginRegister,
        builder: (context, state) => AuthView(),
      ),
      GoRoute(
        path: '/reset-password',
        name: RouteNames.resetPassword,
        builder: (context, state) => ResetPasswordView(),
      ),
      GoRoute(
        path: '/forget-password',
        name: RouteNames.forgetPassword,
        builder: (context, state) => ForgotPasswordView(),
      ),
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => ForgotPasswordView(),
      ),
      GoRoute(
        path: '/add-edit-profile',
        name: RouteNames.addEditProfile,
        builder: (context, state) {
          final isEdit = state.extra as bool;
          return AddEditProfileView(isEdit: isEdit);
        },
      ),
    ],
  );
}
