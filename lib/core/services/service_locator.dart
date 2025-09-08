import 'package:get_it/get_it.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/auth/authentication/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/users/shortlist/index.dart';

GetIt getIt = GetIt.instance;

void initServiceLocator() {
  getIt
    ..registerLazySingleton<NetworkService>(NetworkService.new)
    ..registerLazySingleton<AppStateProvider>(AppStateProvider.new)
    ..registerFactory<ProfileDataSourceImpl>(ProfileDataSourceImpl.new)
    ..registerFactory<AuthDataSourceImpl>(AuthDataSourceImpl.new)
    ..registerFactory<ShortlistDataSourceImpl>(ShortlistDataSourceImpl.new)
    ..registerFactory<ShortlistViewModel>(ShortlistViewModel.new);
}
