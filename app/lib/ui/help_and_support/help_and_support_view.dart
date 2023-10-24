import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/help_and_support/help_and_support_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:ui_package/ui_package.dart';

import 'help_and_support_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'title'),
  FormTextField(name: 'message'),
])
class HelpAndSupportView extends StatelessWidget with $HelpAndSupportView {
  const HelpAndSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpAndSupportViewModel>.reactive(
      viewModelBuilder: () => HelpAndSupportViewModel(),
      onViewModelReady: (model) {
        syncFormWithViewModel(model);
      },
      builder: (_, model, child) => Scaffold(
        appBar: Navbar(
          title: 'Help and support',
          leadingIcon: GestureDetector(
            onTap: model.goBack,
            child: const Icon(
              Icons.arrow_back,
              color: ColorManager.kDarkColor,
            ),
          ),
          titleStyle: getBoldStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s16,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p24),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'How can we help you?',
                      style: getBoldStyle(
                        color: ColorManager.kDarkColor,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    const SizedBox(height: AppSize.s32),
                    Text(
                      'This feature is optimized to help you with any issue you might be having. You will be redirected to send an email  to our supports team when you click the button below.',
                      style: getRegularStyle(
                        color: ColorManager.kDarkColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                    const SizedBox(height: AppSize.s24),
                    InputField(
                      label: 'Enter email',
                      hintText: 'e.g example@gmail.com',
                      keyBoardType: TextInputType.emailAddress,
                      controller: titleController,
                      focusnode: titleFocusNode,
                    ),
                    const SizedBox(height: AppSize.s40),
                    Textarea(
                      label: 'Message',
                      hintText: 'Enter your message here...',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: ColorManager.kDarkColor,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: ColorManager.kGrey1,
                        ),
                      ),
                      controller: messageController,
                      focusnode: messageFocusNode,
                      maxLength: 1500,
                      formError: messageFocusNode.hasFocus &&
                              model.hasMessageValidationMessage
                          ? model.messageValidationMessage
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: AppSize.s40),
                    DefaultButton(
                      onPressed: model.sendMessage,
                      title: 'Send',
                      disabled: model.isBusy,
                      busy: model.isBusy,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
