import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';
import 'package:ui_package/widgets/button/button.dart';

class TermOfServiceDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const TermOfServiceDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermOfServiceDialogViewModel>.reactive(
      viewModelBuilder: () => TermOfServiceDialogViewModel(),
      onViewModelReady: (model) => model.loadTextFromHtml(),
      builder: (context, model, child) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s24),
            child: Container(
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        // child: WebViewWidget(
                        //   controller: model.webViewController,
                        // ),
                        child: Html(data: model.termsText),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultButton(
                          paddingHeight: 8,
                          paddingWidth: 8,
                          buttonType: ButtonType.text,
                          buttonTextColor: ColorManager.kDarkColor,
                          onPressed: () =>
                              completer(DialogResponse(confirmed: true)),
                          title: 'Close')
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TermOfServiceDialogViewModel extends BaseViewModel {
  String _termsText = '';
  String get termsText => _termsText;

  loadTextFromHtml() async {
    String content =
        await rootBundle.loadString('assets/terms_and_condition.html');
    print('content: $content');
    _termsText = content;
    notifyListeners();
  }
}
