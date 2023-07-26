
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/managers/call_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app.locator.dart';
import '../../main.dart';
import '../../models/contact.model.dart';
import '../../services/contact.service.dart';
import '../../services/video-call.service.dart';

const int CONTACT_TAB = 0;
const int CONNECTION_REQUEST_TAB = 1;
const String CONTACT_COUNT_REQUEST = "CONTACT_COUNT_REQUEST";
const String CONTACT_LIST_REQUEST = "CONTACT_LIST_REQUEST";
const String TOP_SUGGESTION_CONTACT_LIST_REQUEST =
    "TOP_SUGGESTION_CONTACT_LIST_REQUEST";
const String CONNECTION_REQUEST = "CONNECTION_REQUEST";
const String DELETE_CONTACT = "DELETE_CONTACT";

const String AUDIO_CALL = "AUDIO_CALL";
const String VIDEO_CALL = "VIDEO_CALL";
const String CHAT = "CHAT";
const String DELETE = "DELETE";

class ContactViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _contactService = locator<ContactService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  final _videoCallService = locator<VideoCallService>();

  int? get contactListCount => _contactService.contactListCount;
  List<Contact>? get contactList => _contactService.contactList;
  List<Contact>? get topSuggestionContactList =>
      _contactService.topSuggestionContactList;
  List<Contact>? get connectionRequestList =>
      _contactService.connectionRequestList;
  void goBack() => _navigationService.back();

  handleSearch(String value) {
    runBusyFuture(fetchContacts(search: value));
  }

  Future<void> fetchContacts({String search = ''}) async {
    setBusyForObject(CONTACT_LIST_REQUEST, true);
    try {
      await _contactService.getContacts(search: search);
    } finally {
      setBusyForObject(CONTACT_LIST_REQUEST, false);
    }
  }

  Future<void> fetchContactsCount() async {
    setBusyForObject(CONTACT_COUNT_REQUEST, true);
    try {
      await _contactService.getContactsCount();
    } finally {
      setBusyForObject(CONTACT_COUNT_REQUEST, false);
    }
  }

  Future<void> fetchTopSuggestionContacts() async {
    setBusyForObject(TOP_SUGGESTION_CONTACT_LIST_REQUEST, true);
    try {
      await _contactService.getTopSuggestions();
    } finally {
      setBusyForObject(TOP_SUGGESTION_CONTACT_LIST_REQUEST, false);
    }
  }

  Future<void> fetchConnectionRequests() async {
    setBusyForObject(CONNECTION_REQUEST, true);
    try {
      await _contactService.getConnectionRequests();
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_contactService];

  handleDeleteContact(String id) async {
    var response = await _dialogService.showConfirmationDialog(
      title: "Confirmation",
      description: "Are you sure you want delete this contact?",
    );
    if (!response!.confirmed) return;

    setBusyForObject(DELETE_CONTACT, true);
    try {
      await _contactService.deleteContact(id);
      await _contactService.getContacts();
      Fluttertoast.showToast(
        msg: 'Contact removed successfully!',
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      setBusyForObject(DELETE_CONTACT, false);
    }
  }

  navigateToAddNewContact() {
    _navigationService.navigateTo(Routes.addNewContactView);
    print('navigate ');
  }

  handleChat(Contact contact) {
    _navigationService.navigateTo(
      Routes.chatDetailView,
      arguments: ChatDetailViewArguments(contact: contact),
    );
  }

  handleAudioCall(Contact contact) {
    _makePhoneCall(contact.phoneNumber!);
  }

  _makePhoneCall(String phoneNumber) async {
    await launchUrl(
      Uri(
        scheme: 'tel',
        path: phoneNumber,
      ),
    );
  }

  // handleVideoCall(Contact contact) async  {
  //   try {

  //   } catch (e) {
  //     // print('Error: ' + e.toString());
  //     Fluttertoast.showToast(
  //       msg: e.toString(),
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: ColorManager.kDarkColor,
  //       textColor: ColorManager.kWhiteColor,
  //     );
  //   }
  // }

  //handle video call
  // handleVideoCall(BuildContext context, Contact contact, {required String id, required String name}) async {
  //   await startCall(ZegoCallType.video, context: context, id: id, name: name);
  //   // _bottomSheetService.showCustomSheet(
  //   //   variant: BottomSheetType.outgoing_call,
  //   //   title: "Outgoing Video Call",
  //   //   data: {"type": "video", "contact": contact},
  //   //   isScrollControlled: true,
  //   // );
  // }

  int _activeTab = 0;
  int get activeTab => _activeTab;

  void updateActiveTab(int index) {
    _activeTab = index;
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    await fetchContacts();
    await fetchConnectionRequests();
    await fetchTopSuggestionContacts();
    await fetchContactsCount();
    setBusy(false);
  }

  handleViewContactProfile(Contact contact) => _navigationService
      .navigateToApplicantProfileView(applicantId: contact.id!);

  void showUserNotAvailableDialog(Contact contact) {
    _dialogService.showDialog(
      title: "User not available",
      description: "${contact.firstName} ${contact.lastName} is not online at the moment",
    );
  }

  Future<void> initiateVideoCall(Set<int> callIds) async {
    P2PClient callClient = P2PClient.instance;
    // callClient.init(); // starts listening of incoming calls
    // callClient.destroy(); // stops listening incoming calls and clears callbacks

    int callType = CallType.VIDEO_CALL; // or CallType.AUDIO_CALL
    P2PSession callSession = callClient.createCallSession(callType, callIds);
    try {
      await callSession.startCall();
      print('call initiated');
    } catch (e) {
      print('Error: $e');
    }
  }


//Zego cloud

//  Future<void> startCall(ZegoCallType callType, {required BuildContext context, required String id, required String name}) async {
//     final extendedData = jsonEncode({
//       'type': callType.index,
//       'inviterName': name,
//     });

//     final ZegoSendInvitationResult result = await ZEGOSDKManager.instance.zimService.sendInvitation(
//       invitees: [id],
//       callType: callType,
//       extendedData: extendedData,
//     );

//     if (result.error == null || result.error?.code == '0') {
//       if (result.errorInvitees.containsKey(id)) {
//         ZegoCallStateManager.instance.clearCallData();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('user is not online: $result')),
//         );
//       } else {
//         pushToCallWaitingPage();
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('send call invitation failed: $result')),
//       );
//     }
//   }

  //   void pushToCallWaitingPage() {
  //     print('ZegoCallStateManager.instance.callData: ${ZegoCallStateManager.instance.callData}');
  //     _bottomSheetService.showCustomSheet(variant: BottomSheetType.outgoing_call, data: ZegoCallStateManager.instance.callData,
  //       ignoreSafeArea: true,
  //       isScrollControlled: true,
  //     );
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     fullscreenDialog: true,
  //   //     builder: (context) => CallWaitingPage(callData: ZegoCallStateManager.instance.callData!),
  //   //   ),
  //   // );
  // }
}
