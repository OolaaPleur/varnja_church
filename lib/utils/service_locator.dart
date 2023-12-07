import 'package:get_it/get_it.dart';

import '../data/repositories/settings_repository.dart';

/// Function, where we setup GetIt service locators.
void setUpServicesLocator() {
  final getIt = GetIt.instance;
  getIt
    // Settings and Authentication related services.
    ..registerLazySingleton<SettingsRepository>(SettingsRepository.new);
}
