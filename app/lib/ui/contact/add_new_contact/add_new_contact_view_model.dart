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

  List<Contact>? get contactList => _contactService.allContactList;

  void goBack() => _navigationService.back();

  Future<void> fetchAllContacts({String search = ''}) async {
    setBusyForObject(ALL_CONTACT_LIST_REQUEST, true);
    try {
      await _contactService.getAllContacts(search: search);
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
