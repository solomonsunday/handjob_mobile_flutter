// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i27;
import 'package:flutter/material.dart';
import 'package:handjob_mobile/dialogs/account_created.dialog.dart' as _i7;
import 'package:handjob_mobile/models/applicant.model.dart' as _i32;
import 'package:handjob_mobile/models/contact.model.dart' as _i30;
import 'package:handjob_mobile/models/instant_job.model.dart' as _i31;
import 'package:handjob_mobile/models/post.model.dart' as _i29;
import 'package:handjob_mobile/models/user.model.dart' as _i33;
import 'package:handjob_mobile/ui/application/applicant_profile/applicant_profile_view.dart'
    as _i24;
import 'package:handjob_mobile/ui/application/application_view.dart' as _i21;
import 'package:handjob_mobile/ui/application/rate_review/rate_review_view.dart'
    as _i22;
import 'package:handjob_mobile/ui/auth/auth_view.dart' as _i4;
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.dart'
    as _i9;
import 'package:handjob_mobile/ui/auth/reset_password/reset_password_view.dart'
    as _i10;
import 'package:handjob_mobile/ui/auth/signup/artisan/artisan_signup_view.dart'
    as _i5;
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.dart'
    as _i6;
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.dart'
    as _i8;
import 'package:handjob_mobile/ui/contact/add_new_contact/add_new_contact_view.dart'
    as _i23;
import 'package:handjob_mobile/ui/contact/contact_view.dart' as _i18;
import 'package:handjob_mobile/ui/faq/faq_view.dart' as _i17;
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view.dart'
    as _i16;
import 'package:handjob_mobile/ui/main/chat/chat_detail/chat_detail_view.dart'
    as _i15;
import 'package:handjob_mobile/ui/main/home/post_detail/post_detail_view.dart'
    as _i13;
import 'package:handjob_mobile/ui/main/jobs/job_detail/job_detail_view.dart'
    as _i25;
import 'package:handjob_mobile/ui/main/main_view.dart' as _i11;
import 'package:handjob_mobile/ui/notification/notification_job_detail/notification_job_detail_view.dart'
    as _i26;
import 'package:handjob_mobile/ui/notification/notification_view.dart' as _i14;
import 'package:handjob_mobile/ui/onboarding/onboarding_view.dart' as _i3;
import 'package:handjob_mobile/ui/profile/profile_view.dart' as _i12;
import 'package:handjob_mobile/ui/settings/change_password/change_password_view.dart'
    as _i20;
import 'package:handjob_mobile/ui/settings/setting_view.dart' as _i19;
import 'package:handjob_mobile/ui/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i28;

class Routes {
  static const splashView = '/';

  static const onboardView = '/onboard-view';

  static const authView = '/auth-view';

  static const artisanSignupView = '/artisan-signup-view';

  static const customerSignupView = '/customer-signup-view';

  static const accountCreatedDialog = '/account-created-dialog';

  static const verifyEmailView = '/verify-email-view';

  static const forgotPasswordView = '/forgot-password-view';

  static const resetPasswordView = '/reset-password-view';

  static const mainView = '/main-view';

  static const profileView = '/profile-view';

  static const postDetailView = '/post-detail-view';

  static const notificationView = '/notification-view';

  static const chatDetailView = '/chat-detail-view';

  static const helpAndSupportView = '/help-and-support-view';

  static const fAQsView = '/f-aqs-view';

  static const contactView = '/contact-view';

  static const settingView = '/setting-view';

  static const changePasswordView = '/change-password-view';

  static const applicationView = '/application-view';

  static const rateReviewView = '/rate-review-view';

  static const addNewContactView = '/add-new-contact-view';

  static const applicantProfileView = '/applicant-profile-view';

  static const jobDetailView = '/job-detail-view';

  static const notificationJobDetailView = '/notification-job-detail-view';

  static const all = <String>{
    splashView,
    onboardView,
    authView,
    artisanSignupView,
    customerSignupView,
    accountCreatedDialog,
    verifyEmailView,
    forgotPasswordView,
    resetPasswordView,
    mainView,
    profileView,
    postDetailView,
    notificationView,
    chatDetailView,
    helpAndSupportView,
    fAQsView,
    contactView,
    settingView,
    changePasswordView,
    applicationView,
    rateReviewView,
    addNewContactView,
    applicantProfileView,
    jobDetailView,
    notificationJobDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.onboardView,
      page: _i3.OnboardView,
    ),
    _i1.RouteDef(
      Routes.authView,
      page: _i4.AuthView,
    ),
    _i1.RouteDef(
      Routes.artisanSignupView,
      page: _i5.ArtisanSignupView,
    ),
    _i1.RouteDef(
      Routes.customerSignupView,
      page: _i6.CustomerSignupView,
    ),
    _i1.RouteDef(
      Routes.accountCreatedDialog,
      page: _i7.AccountCreatedDialog,
    ),
    _i1.RouteDef(
      Routes.verifyEmailView,
      page: _i8.VerifyEmailView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordView,
      page: _i9.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.resetPasswordView,
      page: _i10.ResetPasswordView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i11.MainView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i12.ProfileView,
    ),
    _i1.RouteDef(
      Routes.postDetailView,
      page: _i13.PostDetailView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i14.NotificationView,
    ),
    _i1.RouteDef(
      Routes.chatDetailView,
      page: _i15.ChatDetailView,
    ),
    _i1.RouteDef(
      Routes.helpAndSupportView,
      page: _i16.HelpAndSupportView,
    ),
    _i1.RouteDef(
      Routes.fAQsView,
      page: _i17.FAQsView,
    ),
    _i1.RouteDef(
      Routes.contactView,
      page: _i18.ContactView,
    ),
    _i1.RouteDef(
      Routes.settingView,
      page: _i19.SettingView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i20.ChangePasswordView,
    ),
    _i1.RouteDef(
      Routes.applicationView,
      page: _i21.ApplicationView,
    ),
    _i1.RouteDef(
      Routes.rateReviewView,
      page: _i22.RateReviewView,
    ),
    _i1.RouteDef(
      Routes.addNewContactView,
      page: _i23.AddNewContactView,
    ),
    _i1.RouteDef(
      Routes.applicantProfileView,
      page: _i24.ApplicantProfileView,
    ),
    _i1.RouteDef(
      Routes.jobDetailView,
      page: _i25.JobDetailView,
    ),
    _i1.RouteDef(
      Routes.notificationJobDetailView,
      page: _i26.NotificationJobDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.OnboardView: (data) {
      final args = data.getArgs<OnboardViewArguments>(
        orElse: () => const OnboardViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i3.OnboardView(key: args.key),
        settings: data,
      );
    },
    _i4.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i4.AuthView(key: args.key),
        settings: data,
      );
    },
    _i5.ArtisanSignupView: (data) {
      final args = data.getArgs<ArtisanSignupViewArguments>(
        orElse: () => const ArtisanSignupViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i5.ArtisanSignupView(key: args.key),
        settings: data,
      );
    },
    _i6.CustomerSignupView: (data) {
      final args = data.getArgs<CustomerSignupViewArguments>(
        orElse: () => const CustomerSignupViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i6.CustomerSignupView(key: args.key),
        settings: data,
      );
    },
    _i7.AccountCreatedDialog: (data) {
      final args = data.getArgs<AccountCreatedDialogArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i7.AccountCreatedDialog(
            key: args.key, request: args.request, completer: args.completer),
        settings: data,
      );
    },
    _i8.VerifyEmailView: (data) {
      final args = data.getArgs<VerifyEmailViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) =>
            _i8.VerifyEmailView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i9.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i9.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i10.ResetPasswordView: (data) {
      final args = data.getArgs<ResetPasswordViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) =>
            _i10.ResetPasswordView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i11.MainView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i11.MainView(),
        settings: data,
      );
    },
    _i12.ProfileView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i12.ProfileView(),
        settings: data,
      );
    },
    _i13.PostDetailView: (data) {
      final args = data.getArgs<PostDetailViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i13.PostDetailView(
            key: args.key, post: args.post, postIndex: args.postIndex),
        settings: data,
      );
    },
    _i14.NotificationView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i14.NotificationView(),
        settings: data,
      );
    },
    _i15.ChatDetailView: (data) {
      final args = data.getArgs<ChatDetailViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) =>
            _i15.ChatDetailView(key: args.key, contact: args.contact),
        settings: data,
      );
    },
    _i16.HelpAndSupportView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i16.HelpAndSupportView(),
        settings: data,
      );
    },
    _i17.FAQsView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i17.FAQsView(),
        settings: data,
      );
    },
    _i18.ContactView: (data) {
      final args = data.getArgs<ContactViewArguments>(
        orElse: () => const ContactViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) =>
            _i18.ContactView(key: args.key, activeTab: args.activeTab),
        settings: data,
      );
    },
    _i19.SettingView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i19.SettingView(),
        settings: data,
      );
    },
    _i20.ChangePasswordView: (data) {
      final args = data.getArgs<ChangePasswordViewArguments>(
        orElse: () => const ChangePasswordViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i20.ChangePasswordView(key: args.key),
        settings: data,
      );
    },
    _i21.ApplicationView: (data) {
      final args = data.getArgs<ApplicationViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i21.ApplicationView(
            key: args.key, instantJobId: args.instantJobId),
        settings: data,
      );
    },
    _i22.RateReviewView: (data) {
      final args = data.getArgs<RateReviewViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i22.RateReviewView(
            key: args.key,
            instantJob: args.instantJob,
            applicant: args.applicant),
        settings: data,
      );
    },
    _i23.AddNewContactView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i23.AddNewContactView(),
        settings: data,
      );
    },
    _i24.ApplicantProfileView: (data) {
      final args = data.getArgs<ApplicantProfileViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i24.ApplicantProfileView(
            key: args.key, applicantId: args.applicantId),
        settings: data,
      );
    },
    _i25.JobDetailView: (data) {
      final args = data.getArgs<JobDetailViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i25.JobDetailView(
            key: args.key, instantJob: args.instantJob, user: args.user),
        settings: data,
      );
    },
    _i26.NotificationJobDetailView: (data) {
      final args =
          data.getArgs<NotificationJobDetailViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i26.NotificationJobDetailView(
            key: args.key, instantJobId: args.instantJobId, user: args.user),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OnboardViewArguments {
  const OnboardViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class AuthViewArguments {
  const AuthViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class ArtisanSignupViewArguments {
  const ArtisanSignupViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class CustomerSignupViewArguments {
  const CustomerSignupViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class AccountCreatedDialogArguments {
  const AccountCreatedDialogArguments({
    this.key,
    required this.request,
    required this.completer,
  });

  final _i27.Key? key;

  final _i28.DialogRequest<dynamic> request;

  final dynamic Function(_i28.DialogResponse<dynamic>) completer;

  @override
  String toString() {
    return '{"key": "$key", "request": "$request", "completer": "$completer"}';
  }
}

class VerifyEmailViewArguments {
  const VerifyEmailViewArguments({
    this.key,
    required this.email,
  });

  final _i27.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class ResetPasswordViewArguments {
  const ResetPasswordViewArguments({
    this.key,
    required this.email,
  });

  final _i27.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }
}

class PostDetailViewArguments {
  const PostDetailViewArguments({
    this.key,
    required this.post,
    required this.postIndex,
  });

  final _i27.Key? key;

  final _i29.Post post;

  final int postIndex;

  @override
  String toString() {
    return '{"key": "$key", "post": "$post", "postIndex": "$postIndex"}';
  }
}

class ChatDetailViewArguments {
  const ChatDetailViewArguments({
    this.key,
    required this.contact,
  });

  final _i27.Key? key;

  final _i30.Contact contact;

  @override
  String toString() {
    return '{"key": "$key", "contact": "$contact"}';
  }
}

class ContactViewArguments {
  const ContactViewArguments({
    this.key,
    this.activeTab = 0,
  });

  final _i27.Key? key;

  final int activeTab;

  @override
  String toString() {
    return '{"key": "$key", "activeTab": "$activeTab"}';
  }
}

class ChangePasswordViewArguments {
  const ChangePasswordViewArguments({this.key});

  final _i27.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class ApplicationViewArguments {
  const ApplicationViewArguments({
    this.key,
    required this.instantJobId,
  });

  final _i27.Key? key;

  final String instantJobId;

  @override
  String toString() {
    return '{"key": "$key", "instantJobId": "$instantJobId"}';
  }
}

class RateReviewViewArguments {
  const RateReviewViewArguments({
    this.key,
    required this.instantJob,
    required this.applicant,
  });

  final _i27.Key? key;

  final _i31.InstantJob instantJob;

  final _i32.Applicant applicant;

  @override
  String toString() {
    return '{"key": "$key", "instantJob": "$instantJob", "applicant": "$applicant"}';
  }
}

class ApplicantProfileViewArguments {
  const ApplicantProfileViewArguments({
    this.key,
    required this.applicantId,
  });

  final _i27.Key? key;

  final String applicantId;

  @override
  String toString() {
    return '{"key": "$key", "applicantId": "$applicantId"}';
  }
}

class JobDetailViewArguments {
  const JobDetailViewArguments({
    this.key,
    required this.instantJob,
    required this.user,
  });

  final _i27.Key? key;

  final _i31.InstantJob instantJob;

  final _i33.User user;

  @override
  String toString() {
    return '{"key": "$key", "instantJob": "$instantJob", "user": "$user"}';
  }
}

class NotificationJobDetailViewArguments {
  const NotificationJobDetailViewArguments({
    this.key,
    required this.instantJobId,
    required this.user,
  });

  final _i27.Key? key;

  final String instantJobId;

  final _i33.User user;

  @override
  String toString() {
    return '{"key": "$key", "instantJobId": "$instantJobId", "user": "$user"}';
  }
}

extension NavigatorStateExtension on _i28.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.onboardView,
        arguments: OnboardViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authView,
        arguments: AuthViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToArtisanSignupView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.artisanSignupView,
        arguments: ArtisanSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerSignupView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.customerSignupView,
        arguments: CustomerSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountCreatedDialog({
    _i27.Key? key,
    required _i28.DialogRequest<dynamic> request,
    required dynamic Function(_i28.DialogResponse<dynamic>) completer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accountCreatedDialog,
        arguments: AccountCreatedDialogArguments(
            key: key, request: request, completer: completer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyEmailView({
    _i27.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.verifyEmailView,
        arguments: VerifyEmailViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgotPasswordView,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToResetPasswordView({
    _i27.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.resetPasswordView,
        arguments: ResetPasswordViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPostDetailView({
    _i27.Key? key,
    required _i29.Post post,
    required int postIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.postDetailView,
        arguments:
            PostDetailViewArguments(key: key, post: post, postIndex: postIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatDetailView({
    _i27.Key? key,
    required _i30.Contact contact,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatDetailView,
        arguments: ChatDetailViewArguments(key: key, contact: contact),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHelpAndSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.helpAndSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFAQsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.fAQsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToContactView({
    _i27.Key? key,
    int activeTab = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.contactView,
        arguments: ContactViewArguments(key: key, activeTab: activeTab),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        arguments: ChangePasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplicationView({
    _i27.Key? key,
    required String instantJobId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.applicationView,
        arguments:
            ApplicationViewArguments(key: key, instantJobId: instantJobId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRateReviewView({
    _i27.Key? key,
    required _i31.InstantJob instantJob,
    required _i32.Applicant applicant,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.rateReviewView,
        arguments: RateReviewViewArguments(
            key: key, instantJob: instantJob, applicant: applicant),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddNewContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addNewContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToApplicantProfileView({
    _i27.Key? key,
    required String applicantId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.applicantProfileView,
        arguments:
            ApplicantProfileViewArguments(key: key, applicantId: applicantId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToJobDetailView({
    _i27.Key? key,
    required _i31.InstantJob instantJob,
    required _i33.User user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.jobDetailView,
        arguments: JobDetailViewArguments(
            key: key, instantJob: instantJob, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationJobDetailView({
    _i27.Key? key,
    required String instantJobId,
    required _i33.User user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.notificationJobDetailView,
        arguments: NotificationJobDetailViewArguments(
            key: key, instantJobId: instantJobId, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.onboardView,
        arguments: OnboardViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authView,
        arguments: AuthViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithArtisanSignupView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.artisanSignupView,
        arguments: ArtisanSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerSignupView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.customerSignupView,
        arguments: CustomerSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountCreatedDialog({
    _i27.Key? key,
    required _i28.DialogRequest<dynamic> request,
    required dynamic Function(_i28.DialogResponse<dynamic>) completer,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accountCreatedDialog,
        arguments: AccountCreatedDialogArguments(
            key: key, request: request, completer: completer),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerifyEmailView({
    _i27.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.verifyEmailView,
        arguments: VerifyEmailViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgotPasswordView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.forgotPasswordView,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithResetPasswordView({
    _i27.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.resetPasswordView,
        arguments: ResetPasswordViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPostDetailView({
    _i27.Key? key,
    required _i29.Post post,
    required int postIndex,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.postDetailView,
        arguments:
            PostDetailViewArguments(key: key, post: post, postIndex: postIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatDetailView({
    _i27.Key? key,
    required _i30.Contact contact,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatDetailView,
        arguments: ChatDetailViewArguments(key: key, contact: contact),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHelpAndSupportView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.helpAndSupportView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFAQsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.fAQsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithContactView({
    _i27.Key? key,
    int activeTab = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.contactView,
        arguments: ContactViewArguments(key: key, activeTab: activeTab),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordView({
    _i27.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.changePasswordView,
        arguments: ChangePasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplicationView({
    _i27.Key? key,
    required String instantJobId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.applicationView,
        arguments:
            ApplicationViewArguments(key: key, instantJobId: instantJobId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRateReviewView({
    _i27.Key? key,
    required _i31.InstantJob instantJob,
    required _i32.Applicant applicant,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.rateReviewView,
        arguments: RateReviewViewArguments(
            key: key, instantJob: instantJob, applicant: applicant),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddNewContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addNewContactView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithApplicantProfileView({
    _i27.Key? key,
    required String applicantId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.applicantProfileView,
        arguments:
            ApplicantProfileViewArguments(key: key, applicantId: applicantId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithJobDetailView({
    _i27.Key? key,
    required _i31.InstantJob instantJob,
    required _i33.User user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.jobDetailView,
        arguments: JobDetailViewArguments(
            key: key, instantJob: instantJob, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationJobDetailView({
    _i27.Key? key,
    required String instantJobId,
    required _i33.User user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.notificationJobDetailView,
        arguments: NotificationJobDetailViewArguments(
            key: key, instantJobId: instantJobId, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
