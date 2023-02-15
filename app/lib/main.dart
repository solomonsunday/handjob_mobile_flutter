import 'package:flutter/material.dart';
import 'package:handjob_mobile/app/app.locator.dart';
import 'package:handjob_mobile/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'services/chat.service.dart';
import 'utils/setup_bottom_sheet_ui.dart';
import 'utils/setup_dialog_ui.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  setupBottomSheetUi();
  setupDialogUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.nonReactive(
      viewModelBuilder: () => AppViewModel(),
      onModelReady: (model) {
        model.initializeView();
      },
      onDispose: (model) {
        model.dispose();
      },
      builder: (context, model, _) {
        return MaterialApp(
          title: 'HandJobs Mobile',
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}

class AppViewModel extends BaseViewModel {
  final _chatService = locator<ChatService>();

  IO.Socket get chatSocket => _chatService.chatSocket;

  initializeView() {
    _chatService.initSocket();
  }

  @override
  void dispose() {
    chatSocket.disconnect();
    chatSocket.dispose();
    super.dispose();
  }
}
