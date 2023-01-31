import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/main/instant_hire/instant_hire_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/suggestion.model.dart';
import '../../../utils/contants.dart';

class InstantHireView extends StatelessWidget {
  const InstantHireView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InstantHireViewModel>.nonReactive(
      viewModelBuilder: () => InstantHireViewModel(),
      onModelReady: (model) async {
        await model.fetchProfessionTypes();
      },
      builder: (context, model, child) {
        print('back is clicked: ${model.currentIndex}');
        return Scaffold(
          appBar: Navbar(
            leadingIcon: Icon(
              Icons.arrow_back,
              color: ColorManager.kDarkColor,
            ),
            onTap: model.navigateBack,
            title: AppString.requestInstantServiceTitle,
            fontsize: FontSize.s16,
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.kSecondary100Color,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: AppSize.s8),
                  RequestInstantHireFormView(),
                  SizedBox(height: AppSize.s40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RequestInstantHireFormView extends ViewModelWidget<InstantHireViewModel> {
  const RequestInstantHireFormView({Key? key}) : super(key: key);

  static String _displayStringForOption(Suggestion option) =>
      option.description;

  @override
  Widget build(BuildContext context, InstantHireViewModel model) {
    return Container(
      padding: const EdgeInsets.only(
        left: AppPadding.p16,
        right: AppPadding.p16,
        top: AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InputField(
          //   label: 'Type of service needed',
          //   controller: model.serviceNeedController,
          //   fillColor: ColorManager.kWhiteColor,
          // ),
          DefaultDropDownField(
            label: 'Type of service needed',
            hint: 'choose service',
            value: model.selectedProfession,
            dropdownItems: model.professions,
            onChanged: model.handleSelectedProfession,
            buttonDecoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: ColorManager.kDarkColor,
              ),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            buttonWidth: MediaQuery.of(context).size.width,
            dropdownWidth: MediaQuery.of(context).size.width,
            buttonHeight: AppSize.s48,
          ),
          if (model.busy(PROFESSION_TYPES))
            const LinearProgressIndicator(
              color: ColorManager.kPrimaryColor,
            ),
          const SizedBox(height: AppSize.s12),
          Autocomplete<Suggestion>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text == '') {
                return const Iterable<Suggestion>.empty();
              }
              await model.handleSuggestion(textEditingValue.text);

              return model.suggestions.where((Suggestion option) {
                return option.description
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (Suggestion selection) async {
              debugPrint(
                  'You just selected ${_displayStringForOption(selection)}');
              model.updateLocation(_displayStringForOption(selection));
              await model.updateCoordinate(selection.placeId);
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) =>
                    InputField(
              label: 'Service Location *',
              controller: textEditingController,
              focusnode: focusNode,
              onTap: onFieldSubmitted,
              fillColor: ColorManager.kWhiteColor,
            ),
          ),
          SizedBox(height: AppSize.s12),
          Row(
            children: [
              Expanded(
                child: Autocomplete<Suggestion>(
                  displayStringForOption: _displayStringForOption,
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                    if (textEditingValue.text == '') {
                      return const Iterable<Suggestion>.empty();
                    }
                    await model.handleSuggestion(textEditingValue.text);

                    return model.suggestions.where((Suggestion option) {
                      return option.description
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (Suggestion selection) {
                    debugPrint(
                        'You just selected ${_displayStringForOption(selection)}');
                    model.updateMeetupLocation(
                        _displayStringForOption(selection));
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                          onFieldSubmitted) =>
                      InputField(
                    label:
                        'Meet up location (if different from service location)',
                    controller: textEditingController,
                    focusnode: focusNode,
                    onTap: onFieldSubmitted,
                    fillColor: ColorManager.kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          Row(
            children: [
              Expanded(
                child: DefaultDropDownField(
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonHeight: 50,
                  hint: 'Select',
                  label: 'State*',
                  value: model.selectedStateValue,
                  dropdownItems:
                      (model.stateNames ?? []).map((e) => e!).toList(),
                  onChanged: (String? value) {
                    model.setSelectedState(value);
                  },
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(
                      width: 1,
                      color: ColorManager.kDarkColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSize.s12),
              Expanded(
                child: DefaultDropDownField(
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonHeight: 50,
                  hint: 'Select',
                  label: 'LGA*',
                  value: model.selectedLgaValue,
                  dropdownItems: model.lgaNames?.map((e) => e).toList() ?? [],
                  onChanged: (String? value) {
                    model.setSelectedLGA(value);
                  },
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(
                      width: 1,
                      color: ColorManager.kDarkColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          Row(
            children: [
              Expanded(
                child: DatePicker(
                  label: 'Start date *',
                  controller: model.startDateController,
                  onSelected: model.handleStartDate,
                ),
              ),
              SizedBox(width: AppPadding.p10),
              Expanded(
                child: DatePicker(
                  label: 'End date *',
                  controller: model.endDateController,
                  onSelected: model.handleEndDate,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s8),
          SizedBox(height: AppSize.s8),
          Text(
            'Describe service needed *',
            style: getRegularStyle(
              color: ColorManager.kDarkCharcoal,
              fontSize: FontSize.s12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Textarea(
                  controller: model.describeServiceController,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    borderSide: BorderSide(color: ColorManager.kDarkColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    borderSide: BorderSide(color: ColorManager.kNavDarkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    borderSide: BorderSide(color: ColorManager.kNavDarkColor),
                  ),
                  fillColor: ColorManager.kWhiteColor,
                ),
              )
            ],
          ),
          const SizedBox(height: AppSize.s40),
          if (model.hasError)
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(AppSize.s8),
              margin: EdgeInsets.only(bottom: AppSize.s12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ColorManager.kRed,
                ),
              ),
              child: Text(
                '${model.modelError}',
                style: getMediumStyle(
                  color: ColorManager.kRed,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
          DefaultButton(
            onPressed: model.isBusy ? () {} : model.requestInstantService,
            title: 'Submit',
            busy: model.isBusy,
            disabled: model.isBusy,
          ),
        ],
      ),
    );
  }
}
