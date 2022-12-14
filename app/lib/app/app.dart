import 'package:handjob_mobile/client/dio_client.dart';
import 'package:handjob_mobile/dialogs/account_created.dialog.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/login/login_view.dart';
import 'package:handjob_mobile/ui/auth/signup/artisan/artisan_signup_view.dart';
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.dart';
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:handjob_mobile/ui/onboarding/onboarding_view.dart';
import 'package:handjob_mobile/ui/profile/profile_view.dart';
import 'package:handjob_mobile/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  AdaptiveRoute(page: SplashView),
  AdaptiveRoute(page: OnboardView),
  AdaptiveRoute(page: LoginView, initial: true),
  AdaptiveRoute(page: ArtisanSignupView),
  AdaptiveRoute(page: CustomerSignupView),
  AdaptiveRoute(page: AccountCreatedDialog),
  AdaptiveRoute(page: VerifyEmailView),
  AdaptiveRoute(page: MainView),
  AdaptiveRoute(page: ProfileView),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  // LazySingleton(classType: SnackbarService),
  LazySingleton(classType: DioClient),
  LazySingleton(classType: AuthenticationService)
], logger: StackedLogger())
class App {}
