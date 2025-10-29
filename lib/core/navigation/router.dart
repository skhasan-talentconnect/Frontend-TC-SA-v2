// lib/core/navigation/app_router.dart
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/core/navigation/not_found_view.dart';
import 'package:tc_sa/features/application/applications/presentation/application_view.dart';
import 'package:tc_sa/features/application/forms/index.dart';
import 'package:tc_sa/features/application/forms/presentation/form_details_view.dart';
import 'package:tc_sa/features/application/pdfModule/presentation/pdf_view.dart';
import 'package:tc_sa/features/auth/authentication/index.dart';
import 'package:tc_sa/features/auth/mobileOtp/presentation/views/number_view.dart';
import 'package:tc_sa/features/auth/mobileOtp/presentation/views/otp_view.dart';
import 'package:tc_sa/features/blogs/index.dart';
import 'package:tc_sa/features/chatbot/presentation/chatbot_view.dart';
import 'package:tc_sa/features/compare/presentation/compare_school_view.dart';
import 'package:tc_sa/features/compare/presentation/compare_with_view.dart';
import 'package:tc_sa/features/detailPages/academics/presentation/academics_view.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/activities_view.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/admission_timeline_view.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/alumini_view.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/view_models/alumini_view_model.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/amenity_view.dart';
import 'package:tc_sa/features/detailPages/faculty/presentation/faculty_view.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/fees_scholarship_view.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/infrastructure_view.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/presentation/international_view.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/other_details_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/overview_view.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/reviews_view.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/presentation/safetySecurity_view.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/presentation/tech_adaption_view.dart';
import 'package:tc_sa/features/home/index.dart';
import 'package:tc_sa/features/home/presentation/landing_page.dart';
import 'package:tc_sa/features/notifications/presentation/notification_view.dart';
import 'package:tc_sa/features/predictor/index.dart';
import 'package:tc_sa/features/predictor/presentation/view_models/predictor_view_model.dart';
import 'package:tc_sa/features/preferences/presentation/pref_view.dart';
import 'package:tc_sa/features/profile/presentation/add_edit_profile_view.dart';
import 'package:tc_sa/features/profile/presentation/profile_view.dart';
import 'package:tc_sa/features/registerSchool/register_school_view.dart';
import 'package:tc_sa/features/search/data/entities/search_query.dart';
import 'package:tc_sa/features/search/presentation/search_result_view.dart';
import 'package:tc_sa/features/search/presentation/search_view.dart';
import 'package:tc_sa/features/support/contact_us_view.dart';
import 'package:tc_sa/features/support/support_view.dart';
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

      ShellRoute(
        builder: (context, state, navigationShell) {
          return HomeView(navigationShell: navigationShell);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: RouteNames.home,
            builder: (context, state) => SchoolsView(),
          ),
          GoRoute(
            path: '/blogs',
            name: RouteNames.blogs,
            builder: (context, state) => BlogPage(),
          ),
          GoRoute(
            path: '/preferences',
            name: RouteNames.preferences,
            builder: (context, state) {
              final isEdit = state.extra as bool;
              return PrefView(isEdit: isEdit);
            },
          ),
          GoRoute(
            path: '/shortlist',
            name: RouteNames.shortlist,
            builder: (context, state) => ShortlistedSchoolsPage(),
          ),
          GoRoute(
            path: '/my-forms',
            name: RouteNames.myForms,
            // builder: (context, state) => MyFormViews(),
            builder: (context, state) => const MyFormViews(),
          ),
        ],
      ),
      GoRoute(
        path: '/landing',
        name: RouteNames.landing,
        builder: (context, state) => LandingPage(),
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
      GoRoute(
        path: '/add-edit-preferences',
        name: RouteNames.addEditPreferences,
        builder: (context, state) {
          final isEdit = state.extra as bool;
          return PrefView(isEdit: isEdit);
        },
      ),
      GoRoute(
        path: '/search',
        name: RouteNames.search,
        builder: (context, state) => SearchPage(),
      ),

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
        path: '/services',
        name: RouteNames.services,
        builder: (context, state) => SchoolResultsPage(),
      ),
      // GoRoute(
      //   path: '/predictor-result',
      //   name: RouteNames.predictorResult,
      //   builder: (context, state) {
      //     final predictedSchools = state.extra as List<SchoolModel>? ?? [];
      //     return SchoolResultsPage(predictedSchools: predictedSchools);
      //   },
      // ),
      // ✅ School details
GoRoute(
  path: '/overview',
  name: RouteNames.overview,
  builder: (context, state) {
    final extras = state.extra as Map<String, dynamic>?;
    final schoolId = extras?['schoolId'] as String?;
   final distance = extras?['distance'] as String?;

    if (schoolId == null) {
      return NotFoundView(isSchool: true);
    }

    print('<------>ID: $schoolId | Distance: $distance');

    return SchoolDetailView(
      schoolId: schoolId,
      distance: distance,
    );
  },
),



      GoRoute(
        path: '/alumini',
        name: RouteNames.alumini,
        builder: (context, state) {
          final args =
              (state.extra ?? const <String, dynamic>{})
                  as Map<String, dynamic>;
          final schoolId = args['schoolId'] as String?;
          final schoolName = args['schoolName'] as String?;

          if (schoolId == null) {
            return const Scaffold(
              body: Center(child: Text('Missing school context')),
            );
          }

          return ChangeNotifierProvider(
            create:
                (_) => AlumniViewModel()..getAlumniBySchool(schoolId: schoolId),
            child: AlumniView(schoolId: schoolId, schoolName: schoolName),
          );
        },
      ),
      GoRoute(
        path: '/activity',
        name: RouteNames.activity,
        builder: (context, state) => const ActivityView(),
      ),
      GoRoute(
        path: '/amenity',
        name: RouteNames.amenity,
        builder: (context, state) => const AmenitiesView(),
      ),
         GoRoute(
        path: '/support',
        name: RouteNames.support,
        builder: (context, state) => SupportView(),
      ),
         GoRoute(
        path: '/contactUs',
        name: RouteNames.contactUs,
        builder: (context, state) =>ContactUsView(),
      ),
GoRoute(
  path: '/infrastructure',
  name: RouteNames.infrastructure, // Make sure to define RouteNames.infrastructure
  builder: (context, state) => const InfrastructureView(),
),
// Add routes for OtherDetails and FeesScholarship here as well
GoRoute(
  path: '/other-details',
  name: RouteNames.otherDetails,
  builder: (context, state) => const OtherDetailsView(),
),
GoRoute(
  path: '/academics',
  name: RouteNames.academics, 
  builder: (context, state) => const AcademicsView(),
),
GoRoute(
  path: '/faculty',
  name: RouteNames.faculty, // Add this to your RouteNames class
  builder: (context, state) => const FacultyView(),
),
GoRoute(
  path: '/technology-adoption',
  name: RouteNames.techAdaption, // Add this to your RouteNames class
  builder: (context, state) => const TechnologyAdoptionView(),
),GoRoute(
  path: '/safety-security',
  name: RouteNames.safetySecurity, // Add this to your RouteNames class
  builder: (context, state) => const SafetyAndSecurityView(),
),
GoRoute(
  path: '/fees-scholarship',
  name: RouteNames.feeAndScholarship,
  builder: (context, state) => const FeesAndScholarshipsView(),
),
      // ✅ Reviews
      GoRoute(
        path: '/review',
        name: RouteNames.review,
        builder: (context, state) => ReviewsView(),
      ),
      GoRoute(
  path: '/international-exposure',
  name: RouteNames.internationalExposure, 
  builder: (context, state) => const InternationalExposureView(),
),
GoRoute(
  path: '/admission-timeline',
  name: RouteNames.admissionTimeline, // Add this to your RouteNames class
  builder: (context, state) => const AdmissionTimelineView(),
),
      GoRoute(
        path: '/compare-with',
        name: RouteNames.compareWith,
        builder: (context, state) {
          final schoolDetails = state.extra as Map<String, String>;
          return CompareWith(
            schoolId: schoolDetails['id'] ?? '',
            schoolName: schoolDetails['name'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/compare',
        name: RouteNames.compare,
        builder: (context, state) {
          final schoolIds = state.extra as Map<String, String>;
          return CompareSchools(
            schoolId1: schoolIds['school1'] ?? '',
            schoolId2: schoolIds['school2'] ?? '',
          );
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
        path: '/chatbot',
        name: RouteNames.chatbot,
        builder: (context, state) => const ChatbotView(),
      ),

      GoRoute(
        path: '/notification',
        name: RouteNames.notification,
        builder: (context, state) {
          return NotificationView();
        },
      ),
      GoRoute(
        path: '/form-details',
        name: RouteNames.formDetails,
        builder: (context, state) {
          final formId = state.extra as String;
          return FormDetailsView(formId: formId);
        },
      ),
      GoRoute(
        path: '/addApplication',
        name: RouteNames.addApplication,
        builder: (context, state) => const ApplicationFormView(),
      ),
      GoRoute(
        path: '/application-pdf',
        name: RouteNames.applicationPdf,
        builder: (context, state) => const StudentPdfScreen(),
      ),
      GoRoute(
        path: '/registerSchool',
        name: RouteNames.registerSchool,
        builder: (context, state) => const SchoolRegistrationInfoPage(),
      ),
      GoRoute(
        name: RouteNames.addNumber,
        path: '/register/number',
        builder: (context, state) => const AddPhoneView(),
      ),
      GoRoute(
        name: RouteNames.addOtp,
        path: '/register/otp',
        builder:
            (context, state) => VerifyOtpView(phone: state.extra as String),
      ),
    ],
    errorBuilder: (_, __) => NotFoundView(),
  );
}

/*

*/
