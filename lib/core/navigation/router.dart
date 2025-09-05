// lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/models/school_card_model.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';
import 'package:tc_sa/features/blogs/index.dart';
import 'package:tc_sa/features/compare/presentation/compare_school_view.dart';
import 'package:tc_sa/features/compare/presentation/compare_with_view.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/activities_view.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/view_models/activities_view_model.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/alumini_view.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/view_models/alumini_view_model.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/amenity_view.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/view_models/amenity_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/overview_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/view_models/overview_view_model.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/reviews_view.dart';
import 'package:tc_sa/features/home/index.dart';
import 'package:tc_sa/features/notifications/presentation/notification_view.dart';
import 'package:tc_sa/features/predictor/index.dart';
import 'package:tc_sa/features/predictor/presentation/view_models/predictor_view_model.dart';
import 'package:tc_sa/features/profile/presentation/add_edit_profile_view.dart';
import 'package:tc_sa/features/profile/presentation/profile_view.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';
import 'package:tc_sa/features/search/presentation/search_result_view.dart';
import 'package:tc_sa/features/search/presentation/search_view.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),

      // ✅ Main shell (no provider wrapping needed)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (context, state) => SchoolsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/blogs',
                name: RouteNames.blogs,
                builder: (context, state) => BlogPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/services',
                name: RouteNames.services,
                builder: (context, state) => SearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shortlist',
                name: RouteNames.shortlist,
                builder: (context, state) => const ShortlistedSchoolsPage(),
              ),
            ],
          ),
        ],
      ),

      // ✅ Auth routes
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
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: '/add-edit-profile',
        name: RouteNames.addEditProfile,
        builder: (context, state) {
          final isEdit = state.extra as bool;
          return AddEditProfileView(isEdit: isEdit);
        },
      ),

      // ✅ Search Results
      GoRoute(
        path: '/search-res',
        name: RouteNames.searchRes,
        builder: (context, state) {
          final extras = state.extra as SearchQuery;
          return SearchResultsPage(searchQuery: extras);
        },
      ),

      // ✅ Predictor
      GoRoute(
  path: '/predictor',
  name: RouteNames.predictor,
  pageBuilder: (context, state) {
    return MaterialPage(
      child: ChangeNotifierProvider(
        create: (context) => PrefViewModel(),
        child: const PredictorPage(),
      ),
    );
  },
),
     GoRoute(
  path: '/predictor-result',
  name: RouteNames.predictorResult,
  builder: (context, state) {
    final predictedSchools = state.extra as List<SchoolModel>? ?? [];
    return SchoolResultsPage(predictedSchools: predictedSchools);
  },
),
      // ✅ School details
      GoRoute(
        path: '/overview',
        name: RouteNames.overview,
        builder: (context, state) {
          final schoolId = state.extra as String;
          return ChangeNotifierProvider(
            create: (_) => OverviewViewModel()..getSchoolsById(id: schoolId),
            child: SchoolDetailView(schoolId: schoolId),
          );
        },
      ),
      GoRoute(
        path: '/alumini',
        name: RouteNames.alumini,
        builder: (context, state) {
          final args = (state.extra ?? const <String, dynamic>{})
              as Map<String, dynamic>;
          final schoolId = args['schoolId'] as String?;
          final schoolName = args['schoolName'] as String?;

          if (schoolId == null) {
            return const Scaffold(
              body: Center(child: Text('Missing school context')),
            );
          }

          return ChangeNotifierProvider(
            create: (_) =>
                AlumniViewModel()..getAlumniBySchool(schoolId: schoolId),
            child: AlumniView(schoolId: schoolId, schoolName: schoolName),
          );
        },
      ),
      GoRoute(
        path: '/activity',
        name: RouteNames.activity,
        builder: (context, state) {
          final schoolId = state.extra as String;
          return ChangeNotifierProvider(
            create: (_) =>
                ActivitiesViewModel()..getActivitiesBySchoolId(schoolId: schoolId),
            child: ActivityView(schoolId: schoolId),
          );
        },
      ),
      GoRoute(
        path: '/amenity',
        name: RouteNames.amenity,
        builder: (context, state) {
          final args = (state.extra ?? const <String, dynamic>{})
              as Map<String, dynamic>;
          final schoolId = args['schoolId'] as String?;
          final schoolName = (args['schoolName'] as String?) ?? 'School';

          if (schoolId == null) {
            return const Scaffold(
              body: Center(child: Text('Missing school context')),
            );
          }

          return ChangeNotifierProvider(
            create: (_) =>
                AmenitiesViewModel()..getAmenitiesBySchoolId(schoolId: schoolId),
            child: AmenitiesView(
              schoolId: schoolId,
              schoolName: schoolName,
            ),
          );
        },
      ),

      // ✅ Reviews
      GoRoute(
        path: '/review',
        name: RouteNames.review,
        builder: (context, state) => ReviewsView(),
      ),

      // ✅ Compare
   GoRoute(
  path: '/compare',
  name: RouteNames.compare,
  builder: (context, state) {
    final args = state.extra as Map<String, dynamic>;
    return CompareSchools(
      firstSchool: args['firstSchool'] as SchoolCardModel,
      secondSchool: args['secondSchool'] as SchoolCardModel,
    );
  },
),
GoRoute(
  path: '/compare-with',
  name: RouteNames.compareWith,
  builder: (context, state) {
    return CompareWith(school: state.extra as SchoolCardModel);
  },
),
      // ✅ Blogs
      GoRoute(
        path: '/blog-result',
        name: RouteNames.blogResult,
        builder: (context, state) {
          final blog = state.extra as BlogModel;
          return BlogPageDetail(blog: blog);
        },
      ),
      GoRoute(
        path: '/notification',
        name: RouteNames.notification,
        builder: (context, state) {
          return NotificationView();
        },
      ),
    ],
  );
}
