import 'package:get_it/get_it.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/applications/data/data_source/index.dart';
import 'package:tc_sa/features/application/forms/data/data_source/form_data_source_impl.dart';
import 'package:tc_sa/features/application/forms/presentation/view_models/my_form_view_model.dart';
import 'package:tc_sa/features/application/pdfModule/data/data_source/pdf_data_source_impl.dart';
import 'package:tc_sa/features/application/pdfModule/presentation/view_models/pdf_view_model.dart'; // <-- ADDED
import 'package:tc_sa/features/auth/authentication/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/auth/mobileOtp/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/auth/mobileOtp/presentation/view_model/otp_view_model.dart';
import 'package:tc_sa/features/payments/presentation/view_model/payment_view_model.dart';
import 'package:tc_sa/features/preferences/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';

GetIt getIt = GetIt.instance;

void initServiceLocator() {
  getIt
    ..registerLazySingleton<NetworkService>(NetworkService.new)
    ..registerLazySingleton<ConnectivityProvider>(ConnectivityProvider.new)
    ..registerLazySingleton<ThemeProvider>(ThemeProvider.new)
    ..registerLazySingleton<AppStateProvider>(AppStateProvider.new)
    ..registerFactory<ProfileDataSourceImpl>(ProfileDataSourceImpl.new)
    ..registerFactory<PrefDataSourceImpl>(PrefDataSourceImpl.new)
    ..registerFactory<AuthDataSourceImpl>(AuthDataSourceImpl.new)
    ..registerFactory<OtpDataSourceImpl>(OtpDataSourceImpl.new)
    ..registerFactory<OtpViewModel>(OtpViewModel.new)
    ..registerFactory<ShortlistDataSourceImpl>(ShortlistDataSourceImpl.new)
    ..registerFactory<FormDataSourceImpl>(FormDataSourceImpl.new)
    ..registerLazySingleton<MyFormViewModel>(MyFormViewModel.new)
    ..registerLazySingleton<PaymentViewModel>(PaymentViewModel.new)
    ..registerFactory<ShortlistViewModel>(ShortlistViewModel.new)
    ..registerFactory<StudentPdfDataSourceImpl>(StudentPdfDataSourceImpl.new)
    ..registerFactory<ApplicationDataSourceImpl>(ApplicationDataSourceImpl.new)
    // Register PDF view model as a lazy singleton so getIt<StudentPdfViewModel>() works
    ..registerLazySingleton<StudentPdfViewModel>(() => StudentPdfViewModel());
}
