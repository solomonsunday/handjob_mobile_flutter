import 'package:flutter/material.dart';
import 'package:handjob_mobile/dialogs/account_created.dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../dialogs/account_type.dialog.dart';
import '../enums/dialog.enum.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.ACCOUNT_TYPE: (context, sheetRequest, completer) =>
        AccountTypeDialog(request: sheetRequest, completer: completer),
    DialogType.ACCOUNT_CREATED: (context, sheetRequest, completer) =>
        AccountCreatedDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
