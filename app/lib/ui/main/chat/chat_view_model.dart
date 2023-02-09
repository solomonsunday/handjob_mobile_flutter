import 'package:handjob_mobile/app/app.router.dart';
import 'package:handjob_mobile/models/conversation.model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../app/app.locator.dart';
import '../../../models/contact.model.dart';
import '../../../models/user.model.dart';
import '../../../services/authentication.service.dart';
import '../../../services/chat.service.dart';
import '../../../services/contact.service.dart';

class ChatViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _chatService = locator<ChatService>();
  final _authenticationService = locator<AuthenticationService>();
  final _contactService = locator<ContactService>();

  List<String> chats = [];
  void navigateBack() => _navigationService.back();

  User? get user => _authenticationService.currentUser;
  List<Contact>? get contacts => _contactService.contactList;
  List<Conversation> get conversations => _chatService.conversationList;

  handleSearch(String p1) {}

  void navigateToChatDetail(Conversation conversation) {
    Contact? foundContact = contacts
        ?.where((element) => element.id == conversation.partner?.id)
        .first;
    if (foundContact == null) {
      return;
    }
    _navigationService.navigateTo(
      Routes.chatDetailView,
      arguments: ChatDetailViewArguments(
        contact: foundContact,
      ),
    );
  }

  void initializeView() async {
    await _contactService.getContacts();
    // await _chatService.getChats();
    print('initialize view');
  }

  void getConversationList() async {
    setBusy(true);
    try {
      await _chatService.getConversationList();
    } catch (e) {
    } finally {
      setBusy(false);
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_chatService];
}
