import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/forgot_password/forgot_password_view.form.dart';
import 'package:handjob_mobile/ui/auth/reset_password/reset_password_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.dialogs.dart';
import '../../dialogs/account_type.dialog.dart';

const String GOOGLE_AUTH = 'GOOGLE_AUTH';

class AuthViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  navigateToForgotPassword() =>
      _navigationService.navigateTo(Routes.forgotPasswordView);

  // String? _email;
  // String? _password;
  bool _visibility = true;
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool get visibility => _visibility;

  toggleVisibility() {
    _visibility = !_visibility;
    notifyListeners();
  }

  login() async {
    runBusyFuture(loginTask());
    // _navigationService.replaceWith(Routes.mainView);
  }

  Future<void> loginTask() async {
    var formData = {
      "email": emailValue,
      "password": passwordValue,
      "app": "Artisan",
    };
    setBusy(true);
    notifyListeners();

    try {
      await _authenticationService.login(formData);
      await _authenticationService.getCurrentBaseUser();
      //subscribe to topics

      _navigationService.replaceWith(Routes.mainView);
      Fluttertoast.showToast(
        msg: 'login successfully!',
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    } on DioError {
      _errorMessage = "please enter a valid credential";
      _dialogService.showDialog(
        title: "Invalid Credential",
        description: _errorMessage,
      );
      // throw HttpException("An error occured: please enter a valid credential");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  handleFacebookAuth() async {
    // final LoginResult result = await FacebookAuth.instance
    //     .login(); // by default we request the email and the public profile
    // if (result.status == LoginStatus.success) {
    //   // you are logged
    //   final AccessToken accessToken = result.accessToken!;
    //   print('access token: $accessToken');
    // } else {
    //   print(result.status);
    //   print(result.message);
    // }
  }

  handleGoogleAuth() async {
    var dialogResponse =
        await _dialogService.showCustomDialog(variant: DialogType.accountType);
    if (dialogResponse!.confirmed && dialogResponse.data != null) {
      print(
          'dialog response: ${dialogResponse.data} is confirmed: ${dialogResponse.confirmed}');
      setBusyForObject(GOOGLE_AUTH, true);

      // String clientId =
      //     "264830098872-9mejlefrr69e4k2p4ooaabkm75ti2gk6.apps.googleusercontent.com";
      String clientId =
          "264830098872-9mejlefrr69e4k2p4ooaabkm75ti2gk6.apps.googleusercontent.com";
      //google
      GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId: clientId,
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      print('Google auth is called');
      try {
        if (await _googleSignIn.isSignedIn()) {
          await _googleSignIn.signOut();
        }
        GoogleSignInAccount? account = await _googleSignIn.signIn();
        print('about to confirm if account is ready');
        if (account != null) {
          var payload = {
            "email": account.email,
            "name": account.displayName,
            "accountType": dialogResponse.data,
            "imageUrl": account.photoUrl,
            "type": "Mobile",
            "socialType": "Google",
            "socialId": account.id,
            "firstName": account.displayName!.split(' ').isNotEmpty
                ? account.displayName?.split(' ')[0]
                : account.displayName,
            "lastName": account.displayName!.split(' ').isNotEmpty
                ? account.displayName?.split(' ')[1]
                : null,
          };
          print('google account payload: $payload');
          await _authenticationService.createSocialUser(payload);
          await _authenticationService.getCurrentBaseUser();
          //subscribe to topics
          print('everything should look good from here');
          _navigationService.replaceWith(Routes.mainView);
          Fluttertoast.showToast(
            msg: 'Successfully authenticated!',
            toastLength: Toast.LENGTH_LONG,
          );
          return;
        }
        print('something not cool with account being ready');
      } on PlatformException catch (e) {
//The following lines are never printed and nothing is being executed.
        print('\n\n\n\n\n AN ERROR OCCURED \n\n\n\n\n');
        print('error message: ${e.message}');
        print(e.code);
        switch (e.code) {
          case 'sign_in_canceled':
            print('what was expected was printed');
            return;
        }
      } finally {
        setBusyForObject(GOOGLE_AUTH, false);
        notifyListeners();
      }
    }
  }

  //show dialog
  showDialog() async {
    var response =
        await _dialogService.showCustomDialog(variant: DialogType.accountType);
    if (response!.confirmed) {
      switch (response.data) {
        case CUSTOMER:
          // do a customer job
          _navigationService.navigateToCustomerSignupView();
          break;
        case ARTISAN:
          // do an artisan job
          _navigationService.navigateToArtisanSignupView();
          break;
        default:
        //
      }
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
