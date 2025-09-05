class Endpoints {
  static const String baseUrl = 'https://backend-tc-sa-v2.onrender.com/api/';

  //Authentication Endpoints
  static const String auth = 'auth';
  static const String authLogin = 'auth/login';
  static const String authRegister = 'auth/register';
  static const String authForgotPasswordSendOtp =
      'auth/forgot-password/send-otp';
  static const String authForgotPasswordVerifyOtp =
      'auth/forgot-password/verify-otp';
  static const String authResetPassword = 'auth/reset-password';
  static const String authGoogle = 'auth/google';
  static const String authVerifyEmail = 'auth/verify-email';

  //User Endpoints
  static const String usersPreferences = 'users/preferences';
  static const String users = 'users';
  static const String usersShortlist = 'users/shortlist';

  //School Endpoints
  static const String adminSchools = 'admin/schools';
  static const String adminSchoolsStatus = 'admin/schools/status';

  //School Amenities
  static const String adminSchoolsAmenities = 'admin/schools/amenities';

  //School Activities
  static const String adminSchoolsActivities = 'admin/schools/activities';
  static const String adminSchoolsAlumnus= 'admin/alumnus';

  static const String adminBlogs = 'admin/blogs';

  //Support Page
  static const String adminSupport = 'admin/support';
  static const String adminSupportId = 'admin/support-id';

  //Filter By Fee & Shift
  static const String adminFilterFeeRange = 'admin/filter-feeRange';
  static const String adminFilterShift = 'admin/filter-Shift';

  //predictor
  static const String adminPredictSchools = 'admin/predict-schools';
  static const String adminSearch = 'admin/search';
  static const String notifications = 'notifications';

  //Reviews Endpoints
  static const String reviews = 'reviews';
  static const String reviewsAdmin = 'reviews/admin';
  static const String reviewsUsers = 'reviews/users';
  static const String reviewsLike = 'reviews/like';
}
