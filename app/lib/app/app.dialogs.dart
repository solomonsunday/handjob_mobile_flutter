// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../dialogs/account_created.dialog.dart';
import '../dialogs/account_type.dialog.dart';
import '../dialogs/term_of_service.dialog.dart';

enum DialogType {
  termOfService,
  accountCreated,
  accountType,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.termOfService: (context, request, completer) =>
        TermOfServiceDialog(request: request, completer: completer),
    DialogType.accountCreated: (context, request, completer) =>
        AccountCreatedDialog(request: request, completer: completer),
    DialogType.accountType: (context, request, completer) =>
        AccountTypeDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
