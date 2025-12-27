class Endpoints {
  // static const String baseUrl = 'https://backend-tc-sa-v2.onrender.com/api/';
  static const String baseUrl = 'https://api.synzy.in/api/';

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

  static const String authSendOtp = 'otp/send-otp';
  static const String authVerifyOtp = 'otp/verify-otp';

  //User Endpoints
  static const String usersPreferences = 'users/preferences';
  static const String users = 'users';
  static const String usersShortlist = 'users/shortlist';

  //School Endpoints
  static const String adminSchools = 'admin/schools';
  static const String adminSchoolsStatus = 'admin/schools/status';
  static const String nearbySchools = 'admin/schools/nearby';
  //School Amenities
  static const String adminSchoolsAmenities = 'admin/schools/amenities';
  static const String studentApplications = 'applications';

  //Chatbot
  static const chatbotBase = '/chatbot';

  //School Activities
  static const String adminSchoolsActivities = 'admin/schools/activities';
  static const String adminSchoolsAlumnus = 'admin/alumnus';
  static const String adminInfrastructure = 'admin/schools/infrastructure';
  static const String adminfeeAndScholarship =
      'admin/schools/fees-scholarships';
  static const String adminOtherDetails = 'admin/schools/other-details';
  static const String adminAcademics = 'admin/schools/academics';
  static const String adminTechAdoption = 'admin/schools/technology-adoption';
  static const String adminSafetyAndSecurity = 'admin/schools/safety-security';
  static const String adminInternationalExposure =
      'admin/schools/international-exposure';
  static const String adminFaculty = 'admin/schools/faculty';

  static const String adminAdmissionTimeline =
      'admin/schools/admission-timeline';
  static const String reviewsBySchoolAdmin = 'reviews';

  static const String adminBlogs = 'admin/blogs';
  static const String adminCompare = 'admin/compare';

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

  //Applications
  static const String formStudent = 'form/student';
  static const String formTrack = 'form/track';
  static const String formIsApplied = 'form/is-applied';
  static const String form = 'form';

  //payments
  static const String paymentCreateOrder = 'payments/create-order';
  static const String paymentVerify = 'payments/verify';
}
