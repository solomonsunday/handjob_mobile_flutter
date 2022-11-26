import 'package:handjob_mobile/client/dio_client.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/login/login_view.dart';
import 'package:handjob_mobile/ui/auth/signup/signup_view.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:handjob_mobile/ui/onboarding/onboarding_view.dart';
import 'package:handjob_mobile/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashView, initial: true),
  AdaptiveRoute(page: OnboardView),
  AdaptiveRoute(page: LoginView),
  AdaptiveRoute(page: SignupView),
  AdaptiveRoute(page: MainView),
], dependencies: [
  LazySingleton(classType: NavigationService),
  // LazySingleton(classType: DialogService),
  // LazySingleton(classType: SnackbarService),
  LazySingleton(classType: DioClient),
  LazySingleton(classType: AuthenticationService)
], logger: StackedLogger())
class App {}
