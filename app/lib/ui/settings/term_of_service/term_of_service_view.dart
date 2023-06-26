import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/settings/term_of_service/term_of_service_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class TermOfServiceView extends StatelessWidget {
  const TermOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermOfServiceViewModel>.reactive(
      viewModelBuilder: () => TermOfServiceViewModel(),
      onViewModelReady: (model) => model.loadTextFromDocs(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: Navbar(
            title: 'Terms & Condition',
            leadingIcon: GestureDetector(
              onTap: model.goBack,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                model.termsText,
                style: getRegularStyle(
                  color: ColorManager.kDarkCharcoal,
                  fontSize: FontSize.s14,
                ),
                softWrap: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
