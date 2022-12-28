// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i19;
import 'package:flutter/material.dart';
import 'package:handjob_mobile/dialogs/account_created.dialog.dart' as _i7;
import 'package:handjob_mobile/ui/auth/auth_view.dart' as _i4;
import 'package:handjob_mobile/ui/auth/signup/artisan/artisan_signup_view.dart'
    as _i5;
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.dart'
    as _i6;
import 'package:handjob_mobile/ui/auth/verify_email/verify_email_view.dart'
    as _i8;
import 'package:handjob_mobile/ui/contact/contact_view.dart' as _i16;
import 'package:handjob_mobile/ui/faq/faq_view.dart' as _i15;
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view.dart'
    as _i14;
import 'package:handjob_mobile/ui/main/chat/chat_detail/chat_detail_view.dart'
    as _i13;
import 'package:handjob_mobile/ui/main/home/post_detail/post_detail_view.dart'
    as _i11;
import 'package:handjob_mobile/ui/main/main_view.dart' as _i9;
import 'package:handjob_mobile/ui/notification/notification_view.dart' as _i12;
import 'package:handjob_mobile/ui/onboarding/onboarding_view.dart' as _i3;
import 'package:handjob_mobile/ui/profile/profile_view.dart' as _i10;
import 'package:handjob_mobile/ui/settings/change_password/change_password_view.dart'
    as _i18;
import 'package:handjob_mobile/ui/settings/setting_view.dart' as _i17;
import 'package:handjob_mobile/ui/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i20;

class Routes {
  static const splashView = '/';

  static const onboardView = '/onboard-view';

  static const authView = '/auth-view';

  static const artisanSignupView = '/artisan-signup-view';

  static const customerSignupView = '/customer-signup-view';

  static const accountCreatedDialog = '/account-created-dialog';

  static const verifyEmailView = '/verify-email-view';

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

  static const all = <String>{
    splashView,
    onboardView,
    authView,
    artisanSignupView,
    customerSignupView,
    accountCreatedDialog,
    verifyEmailView,
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
      Routes.mainView,
      page: _i9.MainView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i10.ProfileView,
    ),
    _i1.RouteDef(
      Routes.postDetailView,
      page: _i11.PostDetailView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i12.NotificationView,
    ),
    _i1.RouteDef(
      Routes.chatDetailView,
      page: _i13.ChatDetailView,
    ),
    _i1.RouteDef(
      Routes.helpAndSupportView,
      page: _i14.HelpAndSupportView,
    ),
    _i1.RouteDef(
      Routes.fAQsView,
      page: _i15.FAQsView,
    ),
    _i1.RouteDef(
      Routes.contactView,
      page: _i16.ContactView,
    ),
    _i1.RouteDef(
      Routes.settingView,
      page: _i17.SettingView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i18.ChangePasswordView,
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
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i4.AuthView(),
        settings: data,
      );
    },
    _i5.ArtisanSignupView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i5.ArtisanSignupView(),
        settings: data,
      );
    },
    _i6.CustomerSignupView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i6.CustomerSignupView(),
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
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i8.VerifyEmailView(),
        settings: data,
      );
    },
    _i9.MainView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i9.MainView(),
        settings: data,
      );
    },
    _i10.ProfileView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i10.ProfileView(),
        settings: data,
      );
    },
    _i11.PostDetailView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i11.PostDetailView(),
        settings: data,
      );
    },
    _i12.NotificationView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i12.NotificationView(),
        settings: data,
      );
    },
    _i13.ChatDetailView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i13.ChatDetailView(),
        settings: data,
      );
    },
    _i14.HelpAndSupportView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i14.HelpAndSupportView(),
        settings: data,
      );
    },
    _i15.FAQsView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i15.FAQsView(),
        settings: data,
      );
    },
    _i16.ContactView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i16.ContactView(),
        settings: data,
      );
    },
    _i17.SettingView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i17.SettingView(),
        settings: data,
      );
    },
    _i18.ChangePasswordView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i18.ChangePasswordView(),
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

  final _i19.Key? key;
}

class AccountCreatedDialogArguments {
  const AccountCreatedDialogArguments({
    this.key,
    required this.request,
    required this.completer,
  });

  final _i19.Key? key;

  final _i20.DialogRequest<dynamic> request;

  final dynamic Function(_i20.DialogResponse<dynamic>) completer;
}

extension NavigatorStateExtension on _i20.NavigationService {
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
    _i19.Key? key,
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

  Future<dynamic> navigateToAuthView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToArtisanSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.artisanSignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerSignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountCreatedDialog({
    _i19.Key? key,
    required _i20.DialogRequest<dynamic> request,
    required dynamic Function(_i20.DialogResponse<dynamic>) completer,
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

  Future<dynamic> navigateToVerifyEmailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.verifyEmailView,
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

  Future<dynamic> navigateToPostDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.postDetailView,
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

  Future<dynamic> navigateToChatDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chatDetailView,
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

  Future<dynamic> navigateToContactView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.contactView,
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

  Future<dynamic> navigateToChangePasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
