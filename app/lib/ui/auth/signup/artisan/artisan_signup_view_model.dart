import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/auth.model.dart';
import 'package:handjob_mobile/models/profession_type.model.dart';
import 'package:handjob_mobile/services/authentication.service.dart';
import 'package:handjob_mobile/ui/auth/signup/customer/customer_signup_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.dialogs.dart';
import '../../../../app/app.router.dart';
import '../../../../services/shared.service.dart';
import '../../../../utils/contants.dart';
import '../customer/customer_signup_view_model.dart';

class ArtisanSignupViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _sharedService = locator<SharedService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  String? _tosError;
  String? get tosError => _tosError;
  bool _tos = false;
  List<ProfessionType>? get professionTypes => _sharedService.professionTypes;
  // List<String?> get professionTypesName =>
  //     professionTypes!.map((e) => e.name).toList();

  bool get tos => _tos;
  bool _passwordVisibility = true;
  bool _retypePasswordVisibility = true;
  bool _confirmPasswordVisibility = true;

  String? _selectedProfession;
  String? get selectedProfession => _selectedProfession;
  bool get passwordVisibility => _passwordVisibility;
  bool get retypePasswordVisibility => _retypePasswordVisibility;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  List<String> get professions {
    if (professionTypes == null) {
      return [];
    }
    return professionTypes!.map((e) => e.name!).toList();
  }

  togglePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  toggleRetypePasswordVisibility() {
    _retypePasswordVisibility = !_retypePasswordVisibility;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }

  handleTos(bool value) {
    _tos = value;
    notifyListeners();
  }

  void handleSelectedProfession(String? value) {
    _selectedProfession = value;
    notifyListeners();
  }

  fetchProfessionTypes() async {
    runBusyFuture(fetchProfessionTypesRequest(), busyObject: PROFESSION_TYPES);
  }

  fetchProfessionTypesRequest() async {
    try {
      print('fetch profession');
      await _sharedService.getProfessionTypes();
      print('done fetching pro');
    } on DioError catch (error) {
      throw Exception(error.response!.data["message"]);
    } finally {
      notifyListeners();
    }
  }

  Future<void> register() async {
    runBusyFuture(registerRequest());
  }

  Future<void> registerRequest() async {
    String? validatePhone = validatePhoneNumber(phoneValue!);
    if (validatePhone != null) {
      _dialogService.showDialog(
          title: "Invalid phone number",
          description: "Please provide valid phone number");
      return;
    }
    try {
      setBusyForObject(DEFAULT_AUTH, true);
      var formData = {
        "email": emailValue,
        "password": passwordValue,
        "accountType": "Artisan",
        "profession": selectedProfession,
        "firstName": firstnameValue,
        "lastName": lastnameValue,
      };
      print('form data : $formData');
      await _authenticationService.createUser(formData);
      _navigationService.navigateTo(Routes.verifyEmailView,
          arguments: VerifyEmailViewArguments(email: emailValue!));
      Fluttertoast.showToast(
        msg: 'Account created!',
        toastLength: Toast.LENGTH_LONG,
      );
    } on DioError catch (error) {
      // throw Exception(error.response?.data["message"]);
      Fluttertoast.showToast(
        msg: error.response?.data["message"],
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      setBusyForObject(DEFAULT_AUTH, false);
      notifyListeners();
    }
  }

  void navigateToLogin() => _navigationService.navigateTo(Routes.authView);

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Mobile can\'t be empty';
    } else if (value.isNotEmpty) {
      //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

      bool mobileValid = RegExp(r'(^(?:[+0]9)?[0-9]{11}$)').hasMatch(value);
      return mobileValid ? null : "Invalid mobile";
    }
  }

  bool _formIsValid = false;
  bool get formIsValid => _formIsValid;

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
    String? validatePhone = validatePhoneNumber(phoneValue!);
    setPhoneValidationMessage(validatePhone);
    _formIsValid = false;
    if (hasRetypePassword) {
      if (passwordValue != retypePasswordValue) {
        setRetypePasswordValidationMessage('Password mismatch');
        _formIsValid = false;
      }
    }

    if (firstnameValue!.isNotEmpty &&
        lastnameValue!.isNotEmpty &&
        emailValue!.isNotEmpty &&
        phoneValue!.isNotEmpty &&
        passwordValue!.isNotEmpty &&
        (passwordValue == retypePasswordValue)) {
      _formIsValid = true;
      return;
    }
  }

  showTermOfServiceDialog() async {
    _dialogService.showCustomDialog(
      variant: DialogType.termOfService,
      mainButtonTitle: 'Close',
    );
  }
}
