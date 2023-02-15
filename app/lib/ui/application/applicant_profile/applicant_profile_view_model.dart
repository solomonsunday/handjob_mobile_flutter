import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/contact.service.dart';

class ApplicantProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _accountService = locator<AccountService>();
  final _contactService = locator<ContactService>();

  User? _user;
  User? get user => _user;

  int? get contactListCount => _contactService.contactListCount;

  void goBack() => _navigationService.back();

  Future<void> getAccount(String id) async {
    print('applicant id: $id');
    try {
      _user = await _accountService.getAccount(id);
      print('applicant profile: ${user?.toJson()}');
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchContactsCount() async {
    try {
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {}
  }
}
