import 'package:handjob_mobile/client/dio_client.dart';
import 'package:handjob_mobile/dialogs/account_created.dialog.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/services/chat.service.dart';
import 'package:handjob_mobile/services/comment.service.dart';
import 'package:handjob_mobile/services/contact.service.dart';
import 'package:handjob_mobile/services/education.service.dart';
import 'package:handjob_mobile/services/experience.service.dart';
import 'package:handjob_mobile/services/instant_job.service.dart';
import 'package:handjob_mobile/services/notification.service.dart';
import 'package:handjob_mobile/services/post.service.dart';
import 'package:handjob_mobile/services/shared.service.dart';
import 'package:handjob_mobile/services/video-call.service.dart';
import 'package:handjob_mobile/ui/application/applicant_profile/applicant_profile_view.dart';
import 'package:handjob_mobile/ui/application/rate_review/rate_review_view.dart';
import 'package:handjob_mobile/ui/auth/auth_view.dart';
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.dart';
import 'package:handjob_mobile/ui/auth/reset_password/reset_password_view.dart';
import 'package:handjob_mobile/ui/auth/signup/artisan/artisan_signup_view.dart';
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.dart';
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.dart';
import 'package:handjob_mobile/ui/contact/add_new_contact/add_new_contact_view.dart';
import 'package:handjob_mobile/ui/contact/contact_view.dart';
import 'package:handjob_mobile/ui/faq/faq_view.dart';
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view.dart';
import 'package:handjob_mobile/ui/main/home/post_detail/post_detail_view.dart';
import 'package:handjob_mobile/ui/main/jobs/job_detail/job_detail_view.dart';
import 'package:handjob_mobile/ui/main/main_view.dart';
import 'package:handjob_mobile/ui/notification/notification_view.dart';
import 'package:handjob_mobile/ui/onboarding/onboarding_view.dart';
import 'package:handjob_mobile/ui/profile/profile_view.dart';
import 'package:handjob_mobile/ui/settings/setting_view.dart';
import 'package:handjob_mobile/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/location.service.dart';
import '../services/account.service.dart';
import '../ui/application/application_view.dart';
import '../ui/main/chat/chat_detail/chat_detail_view.dart';
import '../ui/notification/notification_job_detail/notification_job_detail_view.dart';
import '../ui/settings/change_password/change_password_view.dart';
import '../ui/settings/term_of_service/term_of_service_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    AdaptiveRoute(page: SplashView, initial: true),
    AdaptiveRoute(page: OnboardView),
    AdaptiveRoute(page: AuthView),
    AdaptiveRoute(page: ArtisanSignupView),
    AdaptiveRoute(page: CustomerSignupView),
    AdaptiveRoute(page: AccountCreatedDialog),
    AdaptiveRoute(page: VerifyEmailView),
    AdaptiveRoute(page: ForgotPasswordView),
    AdaptiveRoute(page: ResetPasswordView),
    AdaptiveRoute(page: MainView),
    AdaptiveRoute(page: ProfileView),
    AdaptiveRoute(page: PostDetailView),
    AdaptiveRoute(page: NotificationView),
    AdaptiveRoute(page: ChatDetailView),
    AdaptiveRoute(page: HelpAndSupportView),
    AdaptiveRoute(page: FAQsView),
    AdaptiveRoute(page: ContactView),
    AdaptiveRoute(page: SettingView),
    AdaptiveRoute(page: ChangePasswordView),
    AdaptiveRoute(page: ApplicationView),
    AdaptiveRoute(page: RateReviewView),
    AdaptiveRoute(page: AddNewContactView),
    AdaptiveRoute(page: ApplicantProfileView),
    AdaptiveRoute(page: JobDetailView),
    AdaptiveRoute(page: NotificationJobDetailView),
    AdaptiveRoute(page: TermOfServiceView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DioClient),
    LazySingleton(classType: AuthenticationService),
    FactoryWithParam(classType: LocationService),
    LazySingleton(classType: InstantJobService),
    LazySingleton(classType: SharedService),
    LazySingleton(classType: AccountService),
    LazySingleton(classType: ExperienceService),
    LazySingleton(classType: EducationService),
    LazySingleton(classType: PostService),
    LazySingleton(classType: ContactService),
    LazySingleton(classType: CommentService),
    LazySingleton(classType: ChatService),
    LazySingleton(classType: VideoCallService),
    LazySingleton(classType: NotificationService),
    // @stacked-service
  ],
  logger: StackedLogger(),
  // bottomsheets: [
  //   // @stacked-bottom-sheet
  // ],
  // dialogs: [
  //   // @stacked-dialog
  // ],
)
class App {}
