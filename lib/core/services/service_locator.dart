import 'package:get_it/get_it.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/data/data_source/data_source_impl.dart';

GetIt getIt = GetIt.instance;

void initServiceLocator() {
  getIt
    ..registerLazySingleton<NetworkService>(NetworkService.new)
    ..registerLazySingleton<AppStateProvider>(AppStateProvider.new)
    ..registerFactory<ProfileDataSourceImpl>(ProfileDataSourceImpl.new);
}
