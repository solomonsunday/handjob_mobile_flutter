import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/contact.model.dart';
import '../../../services/contact.service.dart';

const String ALL_CONTACT_LIST_REQUEST = "ALL_CONTACT_LIST_REQUEST";
const String SEND_CONNECTION_REQUEST = "SEND_CONNECTION_REQUEST";

class AddNewContactViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _contactService = locator<ContactService>();
  final _dialogService = locator<DialogService>();

  List<Contact>? get contactList => _contactService.allContactList;

  void goBack() => _navigationService.back();

  Future<void> fetchAllContacts({String search = ''}) async {
    setBusyForObject(ALL_CONTACT_LIST_REQUEST, true);
    try {
      var res = await _contactService.getAllContacts(search: search);
      print('contact loaded: $res');
      setBusyForObject(ALL_CONTACT_LIST_REQUEST, false);
    } on DioError catch (err) {
      print('error: ${err.response?.data}');
      _dialogService.showDialog(
        title: 'An error occured',
        description: 'An unexpected error has occured',
      );
      setBusyForObject(ALL_CONTACT_LIST_REQUEST, false);
    } finally {
      setBusyForObject(ALL_CONTACT_LIST_REQUEST, false);
    }
  }

  handleSearch(String value) {
    runBusyFuture(fetchAllContacts(search: value));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactService];
}
