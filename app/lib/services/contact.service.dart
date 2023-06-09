import 'package:dio/dio.dart';
import 'package:handjob_mobile/utils/http_exception.dart';
import 'package:stacked/stacked.dart';

import '../app/app.locator.dart';
import '../client/dio_client.dart';
import '../models/contact.model.dart';
import '../models/meta.model.dart';

class ContactService with ListenableServiceMixin {
  Dio dioClient = locator<DioClient>().dio;

  ContactService() {
    listenToReactiveValues([
      contactList,
      topSuggestionContactList,
      connectionRequestList,
      contactListCount,
      contactMeta,
      pendingApprovalList
    ]);
  }

  final ReactiveValue<List<Contact>> _contactList = ReactiveValue([]);
  final ReactiveValue<List<Contact>> _topSuggestionContactList =
      ReactiveValue([]);
  final ReactiveValue<List<Contact>> _connectionRequestList = ReactiveValue([]);
  final ReactiveValue<List<Contact>> _allContactList = ReactiveValue([]);
  final ReactiveValue<int> _contactListCount = ReactiveValue<int>(0);
  Set<String> _pendingApprovalList = <String>{};

  List<Contact> get contactList => _contactList.value;
  List<Contact> get allContactList => _allContactList.value;
  List<Contact> get topSuggestionContactList => _topSuggestionContactList.value;
  List<Contact> get connectionRequestList => _connectionRequestList.value;
  int get contactListCount => _contactListCount.value;
  List<String> get pendingApprovalList => _pendingApprovalList.toList();

  Meta? _contactMeta;
  Meta? get contactMeta => _contactMeta;

  Future<List<Contact>> getAllContacts(
      {int page = 1, int limit = 10, String? search, String? sort}) async {
    var response = await dioClient.get(
      '/contact/free?page=$page&limit=$limit&search=${search ?? ""}&sort=${sort ?? ""}',
    );
    _contactMeta = Meta.fromJson(response.data["meta"]);
    List<Contact> list = (response.data["data"] as List<dynamic>)
        .map((e) => Contact.fromJson(e))
        .toList();
    _allContactList.value = list;
    notifyListeners();
    return list;
  }

  Future<List<Contact>> getContacts(
      {int page = 1, int limit = 10, String? search, String? sort}) async {
    try {
      var response = await dioClient.get(
        '/contact?page=$page&limit=$limit&search=${search ?? ""}&sort=${sort ?? ""}',
      );
      _contactMeta = Meta.fromJson(response.data["meta"]);
      List<Contact> list = (response.data["data"] as List<dynamic>)
          .map((e) => Contact.fromJson(e))
          .toList();
      _contactList.value = list;
      notifyListeners();
      return list;
    } on DioError catch (e) {
      throw HttpException(e.response?.data ?? "");
    }
  }

  Future<void> getContactsCount() async {
    var response = await dioClient.get(
      '/contact/count',
    );
    print('contact count: ${response.data['data']}');
    _contactListCount.value = response.data['data'];
  }

  Future<List<Contact>> getTopSuggestions(
      {int page = 1, int limit = 10, String? search, String? sort}) async {
    var response = await dioClient.get(
      '/contact?page=$page&limit=$limit&search=${search ?? ""}&sort=${sort ?? ""}',
    );
    _contactMeta = Meta.fromJson(response.data["meta"]);
    print('response.data["data"] ${response.data["data"]}');
    List<Contact> list = (response.data["data"] as List<dynamic>)
        .map((e) => Contact.fromJson(e))
        .toList();
    _topSuggestionContactList.value = list;
    print('contact list $list');
    notifyListeners();
    return list;
  }

  Future<List<Contact>> getConnectionRequests(
      {int page = 1, int limit = 20, String? search, String? sort}) async {
    var response = await dioClient.get(
      '/contact/request/pending?page=$page&limit=$limit',
    );
    _contactMeta = Meta.fromJson(response.data["meta"]);
    print('response.data["data"] ${response.data["data"]}');
    List<Contact> list = (response.data["data"] as List<dynamic>)
        .map((e) => Contact.fromJson(e))
        .toList();
    _connectionRequestList.value = list;
    print('contact list $list');
    notifyListeners();
    return list;
  }

  Future<bool> sendConnectionRequest(Map formData) async {
    var response = await dioClient.post(
      '/contact',
      data: formData,
    );

    return true;
  }

  Future<bool> acceptContact(Map formData) async {
    var response = await dioClient.post(
      '/contact/accept',
      data: formData,
    );
    print('accept contact respone data: ${response.data}');
    return true;
  }

  Future<Contact> rejectContact(String accountId) async {
    var response = await dioClient.delete(
      '/contact/cancel-request/$accountId',
    );

    return Contact.fromJson(response.data);
  }

  Future deleteContact(String contactId) async {
    var response = await dioClient.delete(
      "/contact/$contactId",
    );
    print('response to delete ${response.data}');
    return true;
  }

  void addContactIdToPendingApprovalList(String userId) {
    _pendingApprovalList = {..._pendingApprovalList, userId};
    notifyListeners();
  }
}
