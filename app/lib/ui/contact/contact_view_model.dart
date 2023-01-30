import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/contact.model.dart';
import '../../services/contact.service.dart';

const String CONTACT_COUNT_REQUEST = "CONTACT_COUNT_REQUEST";
const String CONTACT_LIST_REQUEST = "CONTACT_LIST_REQUEST";
const String TOP_SUGGESTION_CONTACT_LIST_REQUEST =
    "TOP_SUGGESTION_CONTACT_LIST_REQUEST";
const String CONNECTION_REQUEST = "CONNECTION_REQUEST";

const String AUDIO_CALL = "AUDIO_CALL";
const String VIDEO_CALL = "VIDEO_CALL";
const String CHAT = "CHAT";
const String DELETE = "DELETE";

class ContactViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _contactService = locator<ContactService>();

  int? get contactListCount => _contactService.contactListCount;
  List<Contact>? get contactList => _contactService.contactList;
  List<Contact>? get topSuggestionContactList =>
      _contactService.topSuggestionContactList;
  List<Contact>? get connectionRequestList =>
      _contactService.connectionRequestList;

  handleSearch(String p1) {}

  void goBack() => _navigationService.back();

  Future<void> fetchContacts() async {
    setBusyForObject(CONTACT_LIST_REQUEST, true);
    try {
      await _contactService.getContacts();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONTACT_LIST_REQUEST, false);
    }
  }

  Future<void> fetchContactsCount() async {
    setBusyForObject(CONTACT_COUNT_REQUEST, true);
    try {
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONTACT_COUNT_REQUEST, false);
    }
  }

  Future<void> fetchTopSuggestionContacts() async {
    setBusyForObject(TOP_SUGGESTION_CONTACT_LIST_REQUEST, true);
    try {
      await _contactService.getTopSuggestions();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(TOP_SUGGESTION_CONTACT_LIST_REQUEST, false);
    }
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

  Future<void> acceptContact(String contactId) async {
    var formData = {"contactId": contactId};

    try {
      await _contactService.acceptContact(formData);
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
    }
  }

  Future<void> rejectContact(String accountId) async {
    try {
      await _contactService.rejectContact(accountId);
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_contactService];

  handleDeleteContact(String id) async {
    try {
      await _contactService.deleteContact(id);
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
    }
  }
}
