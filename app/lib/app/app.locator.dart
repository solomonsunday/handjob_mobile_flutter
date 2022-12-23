// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';

import '../client/dio_client.dart';
import '../services/authentication.service.dart';
import '../services/instant_job.service.dart';
import '../services/location.service.dart';
import '../services/shared.service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DioClient());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerFactoryParam<LocationService, String?, dynamic>(
      (param1, param2) => LocationService(param1));
  locator.registerLazySingleton(() => InstantJobService());
  locator.registerLazySingleton(() => SharedService());
}
