import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

const String SEND_PROFILE_CONNECTION_REQUEST =
    'SEND_PROFILE_CONNECTION_REQUEST';
const String ACCEPT_PROFILE_CONNECTION = 'ACCEPT_PROFILE_CONNECTION';
const String CONNECTION_REQUEST = 'CONNECTION_REQUEST';

class ApplicantProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _accountService = locator<AccountService>();
  final _contactService = locator<ContactService>();
  final _sharedService = locator<SharedService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  User? _user;
  User? get user => _user;
  User? get currentUser => _authenticationService.currentUser;
  List<String> get pendingApprovalList => _contactService.pendingApprovalList;

  bool _isRequestSent = false;
  bool get isRequestSent => _isRequestSent;
  bool _accepted = false;
  bool get accepted => _accepted;

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

  Future<void> fetchConnectionRequests() async {
    setBusyForObject(CONNECTION_REQUEST, true);
    try {
      await _contactService.getConnectionRequests();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
    }
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
  Contact? isPendingAcceptConnection(String email) => _contactService
          .connectionRequestList
          .where(
              (element) => element.email?.toLowerCase() == email.toLowerCase())
          .toList()
          .isNotEmpty
      ? _contactService.connectionRequestList
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

  handleSendConnectionRequest(String userId) async {
    // send connection request
    var formData = {"contactId": userId};
    setBusyForObject(SEND_PROFILE_CONNECTION_REQUEST, true);
    try {
      await _contactService.sendConnectionRequest(formData);
      // await _contactService.getContacts();

      _contactService.addContactIdToPendingApprovalList(userId);
      _isRequestSent = true;
      Fluttertoast.showToast(
        msg: 'Connection request sent!',
        toastLength: Toast.LENGTH_LONG,
      );
    } on DioError catch (e) {
      _isRequestSent = false;
      if (e.response?.statusCode == 400) {
        _contactService.addContactIdToPendingApprovalList(userId);

        Fluttertoast.showToast(
          msg: e.response?.data['message'],
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } finally {
      setBusyForObject(SEND_PROFILE_CONNECTION_REQUEST, false);
      notifyListeners();
    }
  }

  Future<void> acceptContact(String contactId) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Do you really want accept the connection?",
    );
    if (!response!.confirmed) return;
    var formData = {"contactId": contactId};
    setBusyForObject(ACCEPT_PROFILE_CONNECTION, true);
    try {
      await _contactService.acceptContact(formData);
      _accepted = true;
      Fluttertoast.showToast(
        msg: 'Connection accepted successfully!',
        toastLength: Toast.LENGTH_LONG,
      );
      await _contactService.getConnectionRequests();
      await _contactService.getContacts();
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(ACCEPT_PROFILE_CONNECTION, false);

      notifyListeners();
    }
  }

  sendEmail(String? email) async {
    await _sharedService.sendEmail(email ?? "");
  }

  makePhoneCall(String? phone) async {
    await _sharedService.makePhoneCall(phone ?? "");
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactService];
}
