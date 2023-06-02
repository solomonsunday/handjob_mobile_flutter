import 'package:dio/dio.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/user.model.dart';
import 'package:handjob_mobile/services/account.service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/contact.model.dart';
import '../../../services/authentication.service.dart';
import '../../../services/contact.service.dart';
import '../../../services/shared.service.dart';
import '../../main/main_view.dart';

class ApplicantProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _accountService = locator<AccountService>();
  final _contactService = locator<ContactService>();
  final _sharedService = locator<SharedService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  User? _user;
  User? get user => _user;
  User? get currentUser => _authenticationService.currentUser;

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
      await _contactService.getAllContacts();
    } on DioError catch (e) {
    } finally {}
  }

  Contact? isContactExists(String email) => _contactService.contactList
          .where(
              (element) => element.email?.toLowerCase() == email.toLowerCase())
          .toList()
          .isNotEmpty
      ? _contactService.contactList
          .where(
              (element) => element.email?.toLowerCase() == email.toLowerCase())
          .toList()[0]
      : null;

  navigateToChat(Contact contact) async {
    //TODO: this needs optimization, we need to query an endpoint
    // instead to confirm if this user is in the contact list of the
    // logged in user...

    _navigationService.navigateToChatDetailView(contact: contact);
  }

  handleSendConnectionRequest() async {
    // send connection request
    _navigationService.navigateTo(Routes.addNewContactView);
  }
}
